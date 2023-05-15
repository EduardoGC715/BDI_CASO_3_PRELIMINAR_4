import pyodbc


try:
    connection=pyodbc.connect('DRIVER={SQL SERVER};SERVER=THISISNOTAPC;DATABASE={Esencial Verde};Trusted_Connection=yes')
    print("conexion exitosa")
    cursor=connection.cursor()
    cursor.execute('SELECT @@VERSION;')
    row = cursor.fetchone()
    print(row)
except Exception as ex:
    print(ex)
