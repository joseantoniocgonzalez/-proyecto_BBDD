reate table sede 
(
numerodesede int(4) primary key,
direccion varchar(20),
nombrecordinador  varchar(9)
);

#En la tabla Sede crear la columna localidad

alter table sede add column localidad varchar(10); 

#En la tabla sede la localidad solo podran ser Madrid,Barcelona, Valencia y Malaga

alter table sede ADD CONSTRAINT ch_sed CHECK ( localidad LIKE "Madrid" or localidad LIKE "Barcelona" or localidad LIKE "Valencia" or localidad LIKE "Malaga");




#en la tabla sede el nombre del cordinador no se puede repetir


ALTER TABLE sede ADD CONSTRAINT nombrecordinado_pk UNIQUE (nombrecordinador);

Insert into  sede ( numerodesede, direccion, nombrecordinador, localidad ) values ('0001', 'Paseo de Mestalla', 'Juanma','Valencia');
Insert into  sede ( numerodesede, direccion, nombrecordinador, localidad ) values ('0002', 'Avenida de Cadiz', 'Maritoñi','Malaga');
Insert into  sede ( numerodesede, direccion, nombrecordinador, localidad ) values ('0003', 'Paseo de Gracia', 'Luisa','Barcelona');
Insert into  sede ( numerodesede, direccion, nombrecordinador, localidad ) values ('0004', 'Calle Japon', 'Toni','Valencia');
Insert into  sede ( numerodesede, direccion, nombrecordinador, localidad ) values ('0005', 'Puerta de toledo', 'Sergio','Madrid');


Insert into  sede ( numerodesede, direccion, nombrecordinador, localidad ) values ('0006', 'Paseo de Mestalla', 'Juanma','Sevilla');


create table proveedor
(
cifproveedor varchar(9) primary key,
nombreproveedor varchar(12),
fax int(10),
direccion varchar(20),
contrato varchar(6)
);

#en la tabla provedor el nombre del proveedor no se puede repetir


ALTER TABLE proveedor ADD CONSTRAINT proveedor_unico UNIQUE (nombreproveedor);

#en la tabla proveedor eliminamos la columna fax

alter table proveedor drop column fax;

#el cifdelproveedor tendra el formato cif con una empresion regular

alter table proveedor add constraint cifprofedor_expresion CHECK ( cifproveedor RLIKE '[ABCDEFGHKLMNPQS]{1}[0-9]{7}.');


#borramos la tabla columna proveedor para darle mas longuitud
ALTER TABLE proveedor
DROP COLUMN contrato;

alter table proveedor
add contrato varchar(9);

#El contrato sera o exlusivo o normal 

ALTER TABLE proveedor ADD CONSTRAINT contrato_check CHECK ( contrato LIKE "exclusivo" OR contrato LIKE "normal"); 



Insert into  proveedor ( cifproveedor, nombreproveedor, direccion, contrato ) values ('A46210334', 'Eutimio', 'Calle Pelota 3 cadiz','exclusivo');
Insert into  proveedor ( cifproveedor, nombreproveedor, direccion, contrato ) values ('A46210567', 'Trajeson', 'Gavia 3 Granada','exclusivo');
Insert into  proveedor ( cifproveedor, nombreproveedor, direccion, contrato ) values ('A46210355', 'Napoli', 'calle iris 3 Madrid','exclusivo');
Insert into  proveedor ( cifproveedor, nombreproveedor, direccion, contrato ) values ('A46214334', 'Tucci', 'Calle Ceuta Vigo','normal');
Insert into  proveedor ( cifproveedor, nombreproveedor, direccion, contrato ) values ('A46210734', 'lalola', 'Calle Real 3 Jerez','normal');



create table trajes
(
codigotraje int(6)primary key,
material varchar(10),
color varchar(6),
disenador varchar(8),
numerodesede int(4),
cifproveedor varchar(9),
constraint fk_cifproveedor foreign key (cifproveedor) references proveedor (cifproveedor),
constraint fk_numerodesede foreign key (numerodesede) references sede (numerodesede)
);
#en la tabla traje añadimos la columna temporada

alter table trajes add temporada  varchar(9);

#en la columna temporada solo podra ser, primavera,verano,otoño,invierno
ALTER TABLE trajes ADD CONSTRAINT trajess_check CHECK ( temporada LIKE "primavera" OR temporada LIKE "verano" OR temporada LIKE "invierno" OR temporada LIKE "otoño"); 


#en la columna diseñador el nombre del diseñador empezara por mayuscula


alter table trajes add constraint diseadornombre1_check check ( disenador not regexp binary '(^| )[[:lower:]]' );

#en la columna color no se puede quedar en blanco
ALTER TABLE trajes ADD CONSTRAINT trajes_notnull CHECK (color IS NOT NULL);

#en la columna color los colores solo podran ser azul,blanco,gris o negro

ALTER TABLE trajes ADD CONSTRAINT trajcolors_check CHECK ( color LIKE "azul" OR color LIKE "blanco" OR color LIKE "gris" OR color LIKE "negro"); 




Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('100012', 'lino', 'blanco','Napoli','0001','A46210334','primavera');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('100011', 'lino', 'azul','Napoli','0001','A46210334','primavera');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('100013', 'lino', 'negro','Napoli','0001','A46210334','primavera');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('200011', 'raso', 'gris','Eutimio','0002','A46210355','verano');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('200012', 'raso', 'blanco','Eutimio','0002','A46210355','verano');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('200013', 'raso', 'azul','Lalola','0003','A46210355','verano');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('220013', 'terciopelo', 'negro','Tucci','0004','A46210355','otoño');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('260013', 'terciopelo', 'gris','Lalola','0005','A46210734','invierno');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('280013', 'algodon', 'blanco','Tucci','0004','A46210355','invierno');
Insert into  trajes ( codigotraje,material,color,disenador,numerodesede,cifproveedor,temporada ) values ('267013', 'sarga', 'negro','Lalola','0005','A46210734','invierno');
