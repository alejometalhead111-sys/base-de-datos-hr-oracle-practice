SELECT XMLELEMENT("departamento",
         XMLATTRIBUTES(d.department_id AS "id"),
         XMLELEMENT("nombre_departamento", d.department_name), -- o XMLELEMENT
         XMLELEMENT("empleados",
           (SELECT XMLAGG(
                     XMLELEMENT("empleado",
                       XMLATTRIBUTES(e.employee_id AS "id_empleado"),
                       XMLFOREST(
                         e.first_name AS "nombre",
                         e.last_name AS "apellido",
                         e.email AS "email",
                         e.salary AS "salario"
                       )
                     )
                   )
            FROM employees e
            WHERE e.department_id = d.department_id)
         )
       ).getCLOBval() AS xml_texto
FROM departments d
WHERE d.department_id IN (10, 20, 60);