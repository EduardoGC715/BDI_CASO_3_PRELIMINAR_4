import tkinter as tk
from tkinter import *
from PIL import ImageTk, Image
from tkinter import ttk
import pyodbc

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Connecting to the db 
try:
    connection= pyodbc.connect('DRIVER={SQL SERVER};SERVER=THISISNOTAPC;DATABASE={Esencial Verde};Trusted_Connection=yes')
    cursor = connection.cursor()
except Exception as ex:
    print(ex)

#Sale GUI variables
#buyer name variable
buyer =  "" 
# Create an empty dictionary to hold the products
products = {}
# Create a dictionary to hold the cart items
cart = {}
# Create total cost to hold cost of the cart items
total_cost = 0.000

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Functions
# Define the function to add a product to the cart
def add_to_cart():
    product = product_var.get()
    quantity = int(quantity_var.get())
    if product in cart:
        cart[product] += quantity
        if cart[product] <= 0:
            remove_from_cart(product)
    else:
        cart[product] = quantity
    update_cart()
    update_total_cost()
    print(cart)

# Define the function to remove a product from the cart
def remove_from_cart(product):
    del cart[product]
    update_cart()
    update_total_cost()

# Define the function to update the cart display
def update_cart():
    # Clear the listbox
    cart_listbox.delete(0, tk.END)
    # Populate the listbox with the cart items
    for product, quantity in cart.items():
        available_quantity, product_cost = products[product]
        cart_listbox.insert(tk.END, f"{product} - Quantity: {quantity} - Cost: {product_cost}")

# Define the function to update the total cost display
def update_total_cost():
    global total_cost
    # Calculate the total cost of all items in the cart
    total_cost = sum(cart[product] * products[product][1] for product in cart)
    # Update the total cost display on the canvas
    canvas.itemconfig(total_cost_text, text=str(total_cost))

def clear_cart():
    global cart 
    cart = {}
    update_cart()
    
    
def clear_sale_info():
    clear_cart()
    update_total_cost()
    name_input.delete(0, tk.END)
    quantity_entry.delete(0, tk.END)
    

def complete_transaction():

    print("adios")
    # Get the information from the Tkinter components
    channel = channel_var.get()
    buyer = name_input.get()
    payment_method = payment_var.get()
    currency = currency_var.get()

    # Create the lists for the product sale and payment info data
    product_sales = []
    for product in cart.items():
        product_sales.append((product[0], int(product[1]))) 
    payment_info = [channel, buyer, payment_method, currency]
    
    sql_query = """
        DECLARE @new_product_sales productSaleType;
        DECLARE @new_payment_info paymentInfoType;
        {}
        INSERT INTO @new_payment_info (channel, buyer, payment_method, currency) VALUES (?, ?, ?, ?);
        EXEC product_sale_SP @product_sales = @new_product_sales, @payment_info = @new_payment_info;
    """

    # Define the values clause with parameterized placeholders
    values_clause = ", ".join(["(?, ?)"] * len(product_sales))
    # Construct the full SQL query with parameterized placeholders
    sql_query = sql_query.format(f"INSERT INTO @new_product_sales (name, quantity) VALUES {values_clause};")
    # Flatten the product_sales list of tuples into a flat list of values
    product_sales_flat = [val for tpl in product_sales for val in tpl]
    
    # Execute the SQL query with the flattened product_sales and payment_info lists as parameters
    try:
        cursor.execute(sql_query, product_sales_flat + payment_info)
        cursor.commit()
        print("Transaction completed successfully")
    except Exception as e:
        cursor.rollback()
        print("Transaction failed. Error message: ", e)
    clear_sale_info()
    
    
#GUI COMPOENENTS
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#initialize gui
root = Tk()
root.title('Esencial Verde App')
root.geometry('1080x1080')
root.resizable(False, False)

#Visual Elements
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#bg
bg_image = PhotoImage(file= "C:/Users/em000/Documents/School/School/2023_TEC/Bases_de_datos_I/Casos/Caso3/BDI_CASO_3_PRELIMINAR_4/UI_sp/UI_imgs/background3.png")
#buttons
bg_color = "#cca4a3"
fg_color = "#fbf0cb"

#set canvas 
canvas = Canvas(root, width = 1000, height = 998)
canvas.pack(fill="both", expand = TRUE)

#set bg 
canvas.create_image(0,0, image = bg_image, anchor="nw")

#Cart title#
canvas.create_text(550, 100, text="Carrito", font=("Georgia", 25), fill="white")

# Define the available products
cursor.execute("""
    SELECT traduction,
		available_quantity,
		sale_cost
	FROM traductions trd
		INNER JOIN products prd ON prd.control_word_id = trd.control_word_id
		INNER JOIN products_inventories prdinv ON prdinv.product_id = prd.product_id
	ORDER BY trd.control_word_id, prdinv.available_quantity, prd.product_id;
""")

results = cursor.fetchall()
# Loop through the query results and add each product to the dictionary
for row in results:
    product_name = row[0]
    available_quantity = row[1]
    product_cost = row[2]
    products[product_name] = (available_quantity, product_cost)

# Create the product dropdown menu
product_var = tk.StringVar(root)
product_dropdown = ttk.Combobox(root, textvariable=product_var, values=list(products.keys()))
product_dropdown_window = canvas.create_window(550,340, anchor="center",window=product_dropdown)

# Create the quantity entry box
canvas.create_text(420, 395, text="Quantity", font=("Georgia", 14), fill="white", anchor="center")
quantity_var = tk.StringVar(root)
quantity_entry = tk.Entry(root, textvariable=quantity_var)
quantity_entry_window = canvas.create_window(550,395, anchor="center",window=quantity_entry)

# Create the add to cart button
add_to_cart_button = tk.Button(root, text="Add to Cart", command= add_to_cart)
add_to_cart_button_window = canvas.create_window(675,395, anchor="center",window=add_to_cart_button)

#Create text with the total quantity to pay for all the products:
canvas.create_text(405, 450, text="Total", font=("Georgia", 14), fill="white", anchor="center")
total_cost_text = canvas.create_text(650, 450, text=str(total_cost), font=("Georgia", 14), fill="white", anchor="center")

# Create the cart listbox
cart_listbox = tk.Listbox(root)
cart__window = canvas.create_window(550,250, anchor="center",window=cart_listbox, height=100, width=300)

# create the curency drop-down menu
cursor.execute("SELECT abreviation FROM currencies;")
results = cursor.fetchall()
currencies = [result[0] for result in results]
currency_var = StringVar(root)
currency_var.set(currencies[0])
currency_menu = OptionMenu(canvas, currency_var, *currencies)
canvas.create_text(420, 660, text="Moneda", font=("Georgia", 14), fill="white", anchor="center")
currency_menu_window = canvas.create_window(580, 660, anchor="w", window=currency_menu)

# create label and entry widget for name input
canvas.create_text(460, 500, text="Nombre completo", font=("Georgia", 14), fill="white", anchor="center")
name_input = Entry(root)
name_input_window = canvas.create_window(640,500, anchor="center",window=name_input)
name_input.focus()

#create complete transaction button
complete_transaction_bt = tk.Button(root, text="Complete Transaction", bg=bg_color, fg=fg_color, relief="groove", font=("Georgia", 14), command= lambda: complete_transaction())
complete_transaction_bt_window= canvas.create_window(550,740, anchor="center",window=complete_transaction_bt)

# create the payment method drop-down menu
cursor.execute("SELECT name FROM payment_methods")
results = cursor.fetchall()
payment_methods = [result[0] for result in results]
payment_var = StringVar(root)
payment_var.set(payment_methods[0])
payment_menu = OptionMenu(canvas, payment_var, *payment_methods)
canvas.create_text(453, 550, text="Método de pago", font=("Georgia", 14), fill="white", anchor="center")
payment_menu_window = canvas.create_window(580, 550, anchor="w", window=payment_menu)

# create the channels drop-down menu
cursor.execute("SELECT channel_name FROM channels;")
results = cursor.fetchall()
channels = [result[0] for result in results]
channel_var = StringVar(root)
channel_var.set(channels[0])
channel_menu = OptionMenu(canvas, channel_var, *channels)
canvas.create_text(412, 600, text="Canal", font=("Georgia", 14), fill="white", anchor="center")
channel_menu_window = canvas.create_window(580, 600, anchor="w", window=channel_menu)

#Run window
root.mainloop()






