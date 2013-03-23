<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java"
	  contentType="text/html; charset=utf-8"
	 pageEncoding="utf-8"%>
<%
String ruta = request.getContextPath();
String mensaje = request.getParameter("mensaje");
%>
<%@page import="com.clase.dao.UsuarioDao"%>
<%@page import="com.clase.models.Usuario"%>
<%@page import="com.clase.dao.ProyectosDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.clase.models.Proyecto "%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head lang="es">
	<meta charset="utf-8">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="">
	<meta name="description" content="">
    <meta name="viewport" content="width=device-width">
	<title>Cheques | ProjectManager</title>
<%
ArrayList<Proyecto> ListProy= new ArrayList<Proyecto>(); 
ProyectosDao ServiceProy= new ProyectosDao();
Proyecto proy = new Proyecto();
ListProy = ServiceProy.getLista();

Usuario user = new Usuario();
user = (Usuario) session.getAttribute("usuario");

if (user == null) {
	response.sendRedirect(ruta + "/login.jsp");
	return;
}
UsuarioDao permission = new UsuarioDao();
String name = "";
if (request instanceof HttpServletRequest) {
	name = ((HttpServletRequest) request).getRequestURI();
}
config.getServletContext().log(
		"Ruta: " + name);

//ELIMINA EL CONTEXTO DE LA APLICACIÓN Y EL
//EL NOMBRE DEL RECURSO COINCIDA CON LA RUTA ESCRITA EN LA TABLA
name = name.substring(13, name.length());

if(!permission.getUsuarioPermiso(user.getNlogin() , name)){
	response.sendRedirect(ruta + "/inicio/home.jsp?mensaje=Permiso no establecido");
	return;
}

%>
	<link href="<%= ruta %>/assets/css/bootstrap.css" rel="stylesheet">
    <link href="<%= ruta %>/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="<%= ruta %>/assets/css/todc-bootstrap.css" rel="stylesheet">
    <link href="<%= ruta %>/assets/css/style.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="<%= ruta %>/assets/js/modernizr.js"></script>
    <![endif]-->
</head>
<body>
	<div class="container-narrow">
      <div class="masthead">
        <ul class="nav nav-pills pull-right">
        <jsp:include page="../include/menu.jsp">
          <jsp:param name="ruta" value="<%=ruta %>"></jsp:param>
        </jsp:include>
        </ul>
        <h3 class="muted">Project Manager</h3>
      </div>
      <hr>
      <div class="row-fluid">
      	<div class="span9">
      		<h3 class="no-margin">Cheques</h3>
      	</div>
      	<div class="span3 align-right">
      		<%-- <a href="<%=ruta %>/procesos/AddProyecto.jsp?show=1" class="btn btn-primary">Nuevo Proyecto</a> --%>
      	</div>
      </div>
      
      <br />
      
      <div>
      <form class="form-horizontal" action="">
      	<div class="control-group">
		    <label class="control-label" for="estado">Proyecto</label>
		    <div class="controls">
		      <select name="projects">
					<option value="">Selecione Aquí..</option>
					<%
						for (int i = 0; i < ListProy.size(); i++) {
					%> 
					<option value="<%=ListProy.get(i).getIdProyecto() %>"><%=ListProy.get(i).getNombre()%></option>
					
					<%				}
					%>
			  </select>
		    </div>
		  </div>
	  </form>
	  </div>
	  
	  <div id="txtHint">Visualizar los proyectos</div>
	  
      <jsp:include page="../include/footer.jsp">
      	<jsp:param name="ruta" value="<%=ruta%>"></jsp:param>
      </jsp:include>

    </div> <!-- /container -->
    
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%= ruta %>/assets/js/jquery.js"></script>
    <script src="<%= ruta %>/assets/js/bootstrap.js"></script>
    <script type="text/javascript">
	$(document).ready(function () {
		$("select[name=projects]").change(function () {
			if ( $(this).val() > 0 ) {
				$("#txtHint").load("<%= ruta %>/procesos/ListaProyectos.jsp?idProy=" + $(this).val()+"&show=0");
			} else {
				$("#txtHint").html("Visualizar los proyectos");
			}
		});
	});
	</script>
    <% /* %>
<div id="container">
<div id="header">
			<h1>
				Usuario:
				<%=user.getNombre()%>
			</h1>
		</div>
		<div id="navigation">
			<a style="color:#fff; text-decoration:none;padding-left:4px;padding-top:4px; display:block;float:left;" href="<%=ruta%>/login.do?cierre=si">Cerrar Sesión</a>
				</div>
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody>
			<tr>
			<td id="leftcontent" nowrap="nowrap" valign="top" width="190">
					<div class="bar">
						<img src="<%=ruta%>/images/hr_dots1.gif" alt="" height="3" width="150" />
					</div> <!-- ** Menu Start ** //--> <jsp:include
						page="../include/menu.jsp"><jsp:param name="ruta" value="<%=ruta %>"></jsp:param></jsp:include> <!-- ** Menu End ** //-->

				</td>
			
			<!-- <div id="content-container"> -->

<!-- <div id="content"> -->
<td valign="top" width="100%">
<br />
<% if(mensaje!=null) {%>
	<p style="color: red;"><%=mensaje %></p>
	<%} %>
	
<form action="">
		<select name="customers" onchange="showCustomer(this.value)">
			<option value="">Selecione Aquí..</option>
			<%
				for (int i = 0; i < ListProy.size(); i++) {
			%> 
			<option value="<%=ListProy.get(i).getIdProyecto() %>"><%=ListProy.get(i).getNombre()%></option>
			
			<%				}
			%>
		</select>
	</form>
	<br/>
		<div id="txtHint">Visualizar los proyectos</div>
		
		<br/>
		<br/>
		<br/>
		<div>
	<!-- 	<form action="AddProyecto.jsp">
		<input type="submit" value="Nuevo Proyecto" />
		</form> -->
				</div>
				<br/>
		<br/>
		</td>
		</tr>
		<tr>
		<td>
		
		</td>
		</tr>
		
			</tbody>
			</table>
			
		<div id="footer">
			<jsp:include page="../include/footer.jsp"><jsp:param
			name="ruta" value="<%=ruta%>"></jsp:param></jsp:include>
			</div>
		</div>
	<% */ %>
</body>
</html>