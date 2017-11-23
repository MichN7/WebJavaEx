<%-- 
    Document   : buscarLibro
    Created on : 9/11/2017, 10:39:55 AM
    Author     : Greye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Base de datos y MySQL - Inicio</title>
         <link href="css/comun.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="encabezado">
            <h1>Bases de datos y MySQL - Inicio</h1>
        </div>
        <div id="menu">
            <ul>
                <li><a href="libros.jsp">P&aacute;gina inicial</a></li>
            </ul>
        </div>
        <div id="contenido">
            <form action="buscarLibro.jsp">
                <label for="isbnLibro" />
                <input type="text" name="isbnLibro"/>
                <input type="submit" value="buscar"/>
            </form>
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
                String isbn = request.getParameter("isbnLibro");
                
                query = "select * from libros where isbn="+isbn;
                
                conecta();
                if(dbconn != null){
                    try{
                        Statement statement = dbconn.createStatement();
                        
                        ResultSet rs = statement.executeQuery(query);
                        out.println("<table border='1>'");
                        out.println("<tr>");
                        out.println("<th>ISBN </th>");
                        out.println("<th>Titulo </th>");
                        out.println("<th>Nombre</th>");
                        out.println("<th>Disponible</th>");
                        out.println("</tr>");
                        
                        while(rs.next()){
                            out.println("<tr>");
                            out.println("<td>"+ rs.getInt("isbn")+"</td>");
                            out.println("<td>"+ rs.getString("titulo")+"</td>");
                            out.println("<td>" + rs.getString("autor")+"</td>");
                            int disp = 0;
                            if(rs.getInt("disponible")== 1){
                                out.println("<td>Si</td>");
                            }else{
                                out.println("<td>No</td>");
                            }
                            
                        }
                        out.println("</table>");
                        
                    }catch(SQLException e){
                    
                    }finally{
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
                    }else{
                        out.println("Error al conectar");
                    }
            %> 
        </div>
        </div>
        <div id="pie">
            <h2>Todos los derechos reservados</h2>
        </div>
    </body>
</html>
