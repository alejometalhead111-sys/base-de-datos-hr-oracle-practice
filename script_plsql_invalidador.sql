-- Prueba de inserción INVÁLIDA (Rompiendo el tipo de dato del salario con letras)
INSERT INTO dept_xml_validado VALUES (
XMLType('
<departamento id="10">
  <nombre_departamento>Administration</nombre_departamento>
  <empleados>
    <empleado id_empleado="200">
      <nombre>Jennifer</nombre>
      <apellido>Whalen</apellido>
      <email>JWHALEN</email>
      <salario>ESTO_ES_UN_ERROR</salario>
    </empleado>
  </empleados>
</departamento>
')
);