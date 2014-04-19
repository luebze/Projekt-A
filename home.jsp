<%@ page contentType="text/html" language="java" %>
<%@ page import = "java.io.*" import = "java.sql.*" import = "javax.servlet.*" import = "javax.servlet.http.*" %>

<html>
	<head>
		<title>Home</title>
		<link rel="stylesheet" type="text/css" href="button.css">
	</head>
	<body bgcolor="#520000">
		<!--"border=1" vor Release entfernen-->
		<table width=1024 align="center" bgcolor="#FFFFFF" border=1>
			<tr height=256>
				<td id="login" colspan=5 align="right" background="headerNeu.jpg">
					<FORM action="post" method="home.jsp">
						Benutzername: <INPUT type=text name=benutzer> <br>
						Passwort: <INPUT type=password name=passwort> <br>
						<button type="submit" name="login" value="Login">Anmelden</button><br>
						<a href="register.html"><button type=button>Registrieren</button></a>
					</FORM>
				</td>
			<tr>
			<tr id="navigation" height=40>
				<td><button>Nav1</button></td>
				<td><button>Nav2</button></td>
				<td><button>Nav3</button></td>
				<td><button>Nav4</button></td>
				<td><button>Nav5</button></td>
			</tr>
		</table>
	</body>
</html>