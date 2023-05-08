const config = {
    user: 'DBUSER',
    password: '123456789',
    server: 'localhost\\MSSQLSERVER',
    database: 'Esencial Verde',
    options: {
        trustedconnection: true,
        enableArithAort: true,
        encrypt: false,
        instanceName: 'DESKTOP-SV277U6'
    },
    port: 1433
}

module.exports = config;