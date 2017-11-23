<%-- 
    Document   : modificarLibro
    Created on : 9/11/2017, 10:39:34 AM
    Author     : Greye
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bases de datos y MySQL - Inicio</title>
        <link href="css/comun.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
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
        <div id="encabezado">
            <h1>Bases de datos y MySQL - Inicio</h1>
        </div>
        <div id="menu">
            <ul>
                <li><a href="usuarios.jsp">P&aacute;gina inicial</a></li>
            </ul>
        </div>
        <div id="contenido">
            <form action="modificarLibro.jsp" method="get">
                 <p>Escriba los datos del nuevo libro:</p>
                 <table>
                     <tbody>
                         <tr>
                             <td>ISBN: </td>
                             <td>
                                 <input type="text" name="isbn" size="40" maxlength="10"/>
                             </td>
                             <td>Titulo:</td>
                             <td>
                                 <input type="text" name="titulo" size="40" maxlength="40" />
                             </td>
                         </tr>
                         <tr>
                             <td>Autor:</td>
                             <td>
                                 <input type="text" name="autor" size="40" maxlength="60" />
                             </td>
                             <td>Disponible:</td>
                             <td>
                                 <label for="disponible">Si</label>
                                 <input type="radio" name="disponible" value="1"/>
                                 <label for="disponible">No</label>
                                 <input type="radio" name="disponible" value="0"/>
                             </td>
                         </tr>
                     </tbody>
                 </table>
                 <p>
                     <input type="submit" value="modificar"/>
                 </p>
             </form>
             <%
                // Paso 2 A través del objeto request se obtiene el valor pasado por el formulario
                String isbn = request.getParameter("isbn");
                String titulo = request.getParameter("titulo");
                String autor = request.getParameter("autor");
                String disponible = request.getParameter("disponible");

                if (isbn != null && titulo != null && autor != null && disponible != null) {

                    /* Paso 3) Crear query; */
                    query = "update libros set ";
                    query += " titulo= '" + titulo + "'";
                    query += " autor= '" + autor + "'";
                    query += ", disponible=" + disponible+ " where isbn=" + isbn ;
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
