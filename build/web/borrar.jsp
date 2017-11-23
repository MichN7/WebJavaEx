<%-- 
    Document   : borrar
    Created on : 19-oct-2017, 19:10:49
    Author     : cerpas
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
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

    <body><div id="encabezado">
            <h1>Bases de datos y MySQL - Inicio</h1>
        </div>
        <div id="menu">
            <ul>
                <li><a href="usuarios.jsp">P&aacute;gina inicial</a></li>
            </ul>
        </div>
        <%!
            /* Paso 1) Inicializar variables */
            String result = "Base de datos actualizada...";
            String query = "";
            String dburl = "jdbc:mysql://localhost/biblio";
            String usuario = "root";
            String password = "123456";
            String dbdriver = "com.mysql.jdbc.Driver";
            Connection dbconn = null;

            public String conecta() {
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
                    result += " <br/>" + e.toString();
                }
                return result;
            }
        %>
        <div id="contenido">

            <form action="borrar.jsp" method="get">
                <p>Escriba los datos del registro a borrar:</p>
                <table>
                    <tbody>
                        <tr>
                            <td>Clave:</td>
                            <td>
                                <input type="text" name="clave" size="40" maxlength="10" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p>
                    <input type="submit" value="borrar" />
                </p>
            </form>


            <%
                // Paso 2 A través del objeto request se obtiene el valor pasado por el formulario
                String clave = request.getParameter("clave");

                if (clave != null) {

                    /* Paso 3) Crear query; */
                    query = "delete from usuarios where clave=" + clave;
                    // out.println(query);

                    /* Paso4) Conexión a la base de datos */
                    conecta();
                    if (dbconn != null) {
                        //paso 5 Creación de SQL Statement
                        try {
                            Statement statement = dbconn.createStatement();
                            /* Ejecución de SQL Statement */
                            statement.executeUpdate(query);
                            /* Cerramos */
                        } catch (SQLException e) {
                            result = " Error procesando el SQL!";
                            result += " <br/>" + e.toString();
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
                }
            %>
        </div>
        <div id="pie">
            <h2>Todos los derechos reservados</h2>
        </div>
    </body>
</html>
