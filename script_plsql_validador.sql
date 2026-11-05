-- 1. Registrar el esquema XSD en la base de datos
BEGIN
  DBMS_XMLSCHEMA.registerSchema(
    schemaURL => 'http://localhost/esquema_departamentos.xsd',
    schemaDoc => '<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="departamento">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="nombre_departamento" type="xs:string"/>
        <xs:element name="empleados">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="empleado" maxOccurs="unbounded">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name="nombre" type="xs:string"/>
                    <xs:element name="apellido" type="xs:string"/>
                    <xs:element name="email" type="xs:string"/>
                    <xs:element name="salario" type="xs:decimal"/>
                  </xs:sequence>
                  <xs:attribute name="id_empleado" type="xs:integer" use="required"/>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
      <xs:attribute name="id" type="xs:integer" use="required"/>
    </xs:complexType>
  </xs:element>
</xs:schema>'
  );
END;
/

-- 2. Crear la tabla basada en el esquema XML
CREATE TABLE dept_xml_validado OF XMLType
XMLSCHEMA "http://localhost/esquema_departamentos.xsd"
ELEMENT "departamento";

-- 3. Prueba de inserción VÁLIDA
INSERT INTO dept_xml_validado VALUES (
XMLType('
<departamento id="10">
  <nombre_departamento>Administration</nombre_departamento>
  <empleados>
    <empleado id_empleado="200">
      <nombre>Jennifer</nombre>
      <apellido>Whalen</apellido>
      <email>JWHALEN</email>
      <salario>4400</salario>
    </empleado>
  </empleados>
</departamento>
')
);
COMMIT;

-- 4. Prueba de inserción INVÁLIDA (Falta el atributo id_empleado obligatorio)
INSERT INTO dept_xml_validado VALUES (
XMLType('
<departamento id="10">
  <nombre_departamento>Administration</nombre_departamento>
  <empleados>
    <empleado>
      <nombre>Prueba</nombre>
      <apellido>Error</apellido>
      <email>TEST</email>
      <salario>1000</salario>
    </empleado>
  </empleados>
</departamento>
')
);