<%-- 
    Document   : listar
    Created on : 19-oct-2017, 17:41:32
    Author     : cerpas
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Bases de datos y MySQL - Inicio</title>
        <link href="css/comun.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <div id="encabezado">
            <h1>Bases de datos y MySQL - Inicio</h1>
        </div>
        <div id="menu">
            <ul>
                <li><a href="usuarios.jsp">P&aacute;gina inicial</a></li>
            </ul>
        </div>
        <div id="contenido">
            <%!
                /* Paso 1) Inicializar variables */
                String result = "Base de datos actualizada...";
                String query = "";
                String dburl = "jdbc:mysql://localhost/biblio";
                String usuario = "root";
                String password = "123456";
                String dbdriver = "com.mysql.jdbc.Driver";
                Connection dbconn = null;

                public void conecta() {
                    try {
                        Class.forName(dbdriver);
                        // Se obtiene una conexión con la base de datos. Hay que
                        // cambiar el usuario "root" y la clave "la_clave" por las
                        // adecuadas a la base de datos que estemos usando.
                        dbconn = DriverManager.getConnection(dburl, //servidor
                                usuario, //usuario
                                password);  //password
                    } catch (Exception e) {
                        result = " Error procesando el SQL!";
                        result += " <br/>";
                    }
                }
            %>
            <%


                /* Paso 3) Crear query; */
                query = " select * from usuarios";

                // out.println(query);
                conecta();
                /* Paso4) Conexión a la base de datos */
                if (dbconn != null) {
                    //paso 5 Creación de SQL Statement
                    try {
                        Statement statement = dbconn.createStatement();
                        /* Ejecución de SQL Statement */
                        ResultSet rs = statement.executeQuery(query);
                        out.println("<table border='1'>");
                        out.println("<tr>");
                        out.println("<th>Clave </th>");
                        out.println("<th>Nombre </th>");
                        out.println("<th>Descripcion </th>");
                        out.println("<th>Telefono </th>");
                        out.println("</tr>");

                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("clave") + "</td>");
                            out.println("<td>" + rs.getString("nombre") + "</td>");
                            out.println("<td>" + rs.getString("dir") + "</td>");
                            out.println("<td>" + rs.getString("telefono") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                        /* Cerramos */
                    } catch (SQLException e) {
                        //result = " Error procesando el SQL!";
                        //result += " <br/>" + e.toString();
                    } finally {
                        try {
                            if (dbconn != null) {
                                dbconn.close();
                            }
                        } catch (SQLException e) {
                            result = "Error al cerrar la conexión.";
                            result += " <br/>" + e.toString();
                        }
                    }
                    out.println(result);
                } else {
                    out.println("Error al conectar");
                }

            %>
        </div>
        <div id="pie">
            <h2>Todos los derechos reservados</h2>
        </div>
    </body>
</html>
