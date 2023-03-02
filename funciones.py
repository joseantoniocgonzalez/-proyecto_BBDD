import sys
import mysql.connector

def conectar_BD(host, usuario, password):
    try:
        db = mysql.connector.connect(
            host=host,
            user=usuario,
            password=password
        )

        return db
    except mysql.connector.Error as e:
        print("No puedo conectar a la base de datos:", e)
        sys.exit(1)

def listar_proveedores(db):
    cursor = db.cursor()
    query = "SELECT * FROM proveedor"
    cursor.execute(query)
    proveedores = cursor.fetchall()
    cursor.close()
    return proveedores


def buscar_sede(db, localidad):
    cursor = db.cursor()
    query = "SELECT nombrecordinador, direccion FROM sede WHERE localidad = %s"
    cursor.execute(query, (localidad,))
    result = cursor.fetchone()
    if result is not None:
        return result
    else:
        cursor.close()
    return None


def buscar_trajes(db, material):
    cursor = db.cursor()
    query = "SELECT * FROM trajes WHERE material = %s"
    cursor.execute(query, (material,))
    trajes = cursor.fetchall()

    if trajes:
        for traje in trajes:
            query_sede = "SELECT direccion FROM sede WHERE numerodesede = %s"
            cursor.execute(query_sede, (traje[4],))
            sede = cursor.fetchone()[0]

            query_prov = "SELECT nombre FROM proveedor WHERE idproveedor = %s"
            cursor.execute(query_prov, (traje[5],))
            proveedor = cursor.fetchone()[0]

            print(f"Código: {traje[0]}")
            print(f"Material: {traje[1]}")
            print(f"Color: {traje[2]}")
            print(f"Diseñador: {traje[3]}")
            print(f"Sede: {sede}")
            print(f"Proveedor: {proveedor}")
            print(f"Temporada: {traje[6]}")
            print("")

    cursor.close()

def insertar_sede(db, numerodesede, nombrecordinador, direccion, localidad):
    cursor = db.cursor()
    query = "INSERT INTO sede (numerodesede, nombrecordinador, direccion, localidad) VALUES (%s, %s, %s, %s)"
    values = (numerodesede, nombrecordinador, direccion, localidad)
    cursor.execute(query, values)
    db.commit()
    cursor.close()
    print("Sede insertada correctamente")





def borrar_traje(db, codigo):
    cursor = db.cursor()
    try:
        # Buscamos si existe un traje con el código dado
        cursor.execute("SELECT * FROM trajes WHERE codigo=%s", (codigo,))
        traje = cursor.fetchone()

        if traje:
            # Si existe el traje, lo borramos de la base de datos
            cursor.execute("DELETE FROM trajes WHERE codigo=%s", (codigo,))
            db.commit()
            print(f"Se eliminó el traje con código {codigo}")
        else:
            print(f"No se encontró ningún traje con código {codigo}")
    except mysql.connector.Error:
        print("Error al borrar el traje")
        db.rollback()
    cursor.close()

def actualizar_sede(db, localidad, nuevo_coordinador):
    cursor = db.cursor()
    query = "UPDATE sedes SET coordinador = %s WHERE localidad = %s"
    try:
        cursor.execute(query, (nuevo_coordinador, localidad))
        db.commit()
        print(f"Se actualizó la información de la sede en {localidad}")
    except:
        print(f"Error al actualizar la información de la sede en {localidad}")
        db.rollback()
    cursor.close()



def cerrar_conexion(db):
    db.close()
    print("Conexión cerrada correctamente")




#sede (numerodesede, direccion, nombrecordinador, localidad)
#trajes (codigotraje, material, color, disenador, numerodesede, cifproveedor,temporada)
#proveedor (cifproveedor, nombreproveedor, direccion, contrato)