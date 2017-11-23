<%-- 
    Document   : insertarLibro
    Created on : 9/11/2017, 10:37:59 AM
    Author     : Greye
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
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
            String result = "Base de datos actualizada...";
            String query = "";
            String dburl = "jdbc:mysql://localhost/biblio";
            String usuario = "root";
            String password = "123456";
            String dbdriver = "com.mysql.jdbc.Driver";
            Connection dbconn = null;
            
            public void conecta(){
                try{
                    Class.forName(dbdriver);
                    dbconn = DriverManager.getConnection(dburl,
                             usuario,
                             password);

                }catch(Exception e){
                    result = "Error procesando el SQL!";
                    result += "<br/>" + e.toString();
                }
            }
         %>
         <div id="encabezado">
             <h1>Base de datos y MySQL - Inicio</h1>
         </div>
         <div id="menu">
             <ul>
                 <li><a href="libros.jsp">P&aacute;gina inicial</a></li>
             </ul>
         </div>
         
         <div id="contenido">
             <form action="insertarLibro.jsp" method="get">
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
                     <input type="submit" value="A&#241;adir"/>
                 </p>
             </form>
             <% 
                String isbn = request.getParameter("isbn");
                String titulo = request.getParameter("titulo");
                String autor = request.getParameter("autor");
                String disponible = request.getParameter("disponible");
                
                
                
                if(isbn !=null && titulo != null && autor!=null && disponible!= null){
                    query = "insert into libros (isbn,titulo,autor,disponible)";
                    query += "values ("+isbn+",";
                    query += "'" + titulo + "',";
                    query += "'" + autor + "',";
                    query += "" + disponible +")";
                    out.println(query);
                    
                    conecta();
                    if(dbconn != null){
                        
                        try{
                            Statement statement = dbconn.createStatement();
                            statement.executeUpdate(query);
                        }catch(SQLException e){
                            result = "Error procesando el SQL";
                            result += "</br>" + e.toString();
                        } finally{
                            try{
                                if(dbconn != null){
                                    dbconn.close();
                                }
                            }catch(SQLException e){
                                result = "Error al cerrar conexión.";
                                result += "</br>" + e.toString();
                            }
                        }
                        out.println(result);
                    }else{
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
