import mysql.connector
from funciones import *

# Configurar los detalles de la conexión
try:
    db = mysql.connector.connect(
        user='raul',
        password='raul',
        host='localhost',
        database='trajes'
    )
except mysql.connector.Error as err:
    print(f"Error de conexión: {err}")
    exit(1)

# Crear cursor
cursor = db.cursor()

# Menú
salir = False
while not salir:
    print("1. Listar todos los proveedores")
    print("2. Buscar una sede por localidad")
    print("3. Buscar trajes por material")
    print("4. Insertar una nueva sede")
    print("5. Borrar un traje")
    print("6. actualizar sede ")
    print("0.salir del programa ")

    opcion = input("Ingrese una opción: ")

    if opcion == "1":
        proveedores = listar_proveedores(db)

        if proveedores:
            for proveedor in proveedores:
                print(proveedor)
        else:
            print("No hay proveedores registrados en la base de datos")



    elif opcion == "2":
        localidad = input("Ingrese la localidad de la sede que desea buscar: ")
        sede = buscar_sede(db, localidad)

        if sede:
            print("Nombre del coordinador:", sede[0])
            print("Dirección:", sede[1])
        else:
            print("No se encontró ninguna sede en la localidad especificada")

    elif opcion == "3":
        material = input("Ingrese el material del traje: ")
        print("")
        print("Resultados:")
        query = "SELECT trajes.*, sede.direccion, proveedor.nombreproveedor FROM trajes JOIN sede ON trajes.numerodesede = sede.numerodesede JOIN proveedor ON trajes.cifproveedor = proveedor.cifproveedor WHERE trajes.material = %s"
        cursor.execute(query, (material,))
        trajes = cursor.fetchall()

        if trajes:
            for traje in trajes:
                print(f"Código: {traje[0]}")
                print(f"Material: {traje[1]}")
                print(f"Color: {traje[2]}")
                print(f"Diseñador: {traje[3]}")
                print(f"Sede: {traje[7]}")
                print(f"Proveedor: {traje[8]}")
                print(f"Temporada: {traje[6]}")
                print("")
        else:
            print("No se encontraron trajes con el material especificado.")


    elif opcion == "4":
        numerodesede = input("Ingrese el número de sede: ")
        nombrecordinador = input("Ingrese el nombre del coordinador de la nueva sede: ")
        direccion = input("Ingrese la dirección de la nueva sede: ")
        localidad = input("Ingrese la localidad de la nueva sede: ")
        insertar_sede(db, numerodesede, nombrecordinador, direccion, localidad)





    elif opcion == "5":
        codigo = input("Ingrese el código del traje que desea borrar: ")
        borrar_traje(db, codigo)
        db.commit()

    elif opcion == "6":
        localidad = input("Ingrese la localidad de la sede que desea actualizar: ")
        nuevo_coordinador = input("Ingrese el nombre del nuevo coordinador: ")
        actualizar_sede(db, localidad, nuevo_coordinador)
        db.commit()

    elif opcion == "0":
        salir = True
        print("")
        print("¡HASTA PRONTO!")

    else:
        print("Opción inválida. Ingrese un número del 0 al 6.")