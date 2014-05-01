<%@ page contentType="text/html" language="java" %>
<%@ page import = "java.io.*" import = "java.sql.*" import = "javax.servlet.*" import = "javax.servlet.http.*" %>

<%
	String selectedCategory = request.getParameter("selectedCategory");
	
	session = request.getSession();
	String jSessionID = session.getId();
		
	//eingegebene Daten des Login-Feldes (auf Folgenden Seiten:
	//home.jsp, shop.jsp, product.jsp, cart.jsp, account.jsp, updateAccount.jsp,
	//product.jsp, boughtProduct.jsp, logout.jsp, removeFromCart.jsp)
	String name = request.getParameter("benutzer");
	String pwd = request.getParameter("passwort");
		
	if (session.getAttribute("benutzer") == null) {
		session.setAttribute("benutzer", name);
		session.setAttribute("passwort", pwd);
	}
	
	String jName = (String) session.getAttribute("benutzer");
	String jPwd = (String) session.getAttribute("passwort");
	
	try
	{
		Class.forName("org.gjt.mm.mysql.Driver");	//Da sind die Treiber
	} catch (ClassNotFoundException e) {
		out.println("DB-Treiber nicht da!");
	}
%>

<html>
	<head>
		<title>Home</title>
		<link rel="stylesheet" type="text/css" href="button.css">
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<!--"border=1" vor Release entfernen-->
		<table width=1024 align="center"><!-- border=1-->
			<tr height=256>
				<td id="login" colspan=5 align="right" background="headerNeu.jpg">
					<%
						//Connection zum DB-Server eroeffnen
						try {
							Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/max1", "max1", "FJp=");

							//Jetzt einen SQLBefehl vorbereiten
							Statement st = con.createStatement();	//(noch) leeres Statement / leerer SQL-Befehl
		
							//ResultSet mit Cursor bearbeiten und ausgeben
							ResultSet rs = st.executeQuery("select * from logindaten where benutzername = '" + jName + "'");

							String dbName = "";
							String dbPwd = "";
							
							if(rs.next()) {
								dbName = rs.getString("benutzername");
								dbPwd = rs.getString("passwort");
							}

							//korrekter Benutzername und das dazu gehoerende Passwort wurden eingegeben
							//Login-Feld wird nicht generiert
							if(!dbName.equals("") && jPwd.equals(dbPwd)){
							%>
								Willkommen, <%=jName%>
								<br>
								<a href="account.jsp"><button type=button>Account</button></a>
								<br>
								<a href="cart.jsp"><button type=button>Warenkorb</button></a>
								<br>
								<br>
								<FORM method="post" action="logout.jsp">
									<button type="submit" name="logout">Abmelden</button>
								</FORM>
					<%
							//Benutzername oder Passwort ist falsch
							//Login-Feld wird generiert
							} else {
					%>
								<FORM method="post" action="home.jsp">
								Name: <INPUT type=text name=benutzer value=""> <br>
								Passwort: <INPUT type=password name=passwort> <br>
								<button type="submit" name="login" value="Login">Anmelden</button> <br>
								<a href="register.html"><button type=button>Registrieren</button></a> <br>
								</FORM>
					<%
							}
							
							st.close();
							con.close();
						} catch (Exception e) {
							out.println(" MYSQL Exception: " + e.getMessage());
						}
					%>
				</td>
			</tr>
			<tr id="navigation" height=40>
				<FORM method="get" action="shop.jsp">
					<td><button type="submit" name="selectedCategory" value="Alle">Alle Produkte</button></td>
					<td><button type="submit" name="selectedCategory" value="Motorrad">Motorr&aumlder</button></td>
					<td><button type="submit" name="selectedCategory" value="Motorroller">Motorroller</button></td>
				</FORM>
					<td><button>Nav3</button></td>
					<td><button>Nav4</button></td>
			</tr>
					<%
					//Connection zum DB-Server eroeffnen
					try {
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/max1", "max1", "FJp=");

						//Jetzt einen SQLBefehl vorbereiten
						Statement st = con.createStatement();	//(noch) leeres Statement / leerer SQL-Befehl
	
						//ResultSet mit Cursor bearbeiten und ausgeben
						//Findet alle Artikel der ausgewaehlten Kategorie
						ResultSet rs;
						if (selectedCategory.equalsIgnoreCase("alle")) {
							rs = st.executeQuery("select * from artikel");
						} else {
							rs = st.executeQuery("select * from artikel natural join kategorie where kategorie = '" + selectedCategory + "'");
						}
	
						//Hier die Cursor-Schleife
						//Gibt alle Artikel in eigenen Tabellenzeilen aus
						while (rs.next()) {
							String artikelName = rs.getString("name");
							String preis = rs.getString("preis");
							String img = rs.getString("img");
							String anzahl = rs.getString("anzahl");
					%>
			<tr>
				<td align="center"><img src=<%=img%> width='160' height='160'></img></td>
				<td colspan=4 align="right"><br>
					<%=artikelName%><br>
					<%=preis%> Euro<br>
					<%
					if(anzahl.equals("0")) {
					%>
						<font color="#FF0000">Ausverkauft</font>
					<%
					} else {
					%>
						Anzahl: <%=anzahl%>
					<%
					}
					%>
				</td>
				<br>
			</tr>
			<tr>
				<td colspan=5 align="right">
					<FORM method="get" action="product.jsp">
						<button type=submit name="artikelName" value=<%=artikelName%>>Ansehen</button>
					</FORM>
				</td>
			</tr>
			<tr>
				<td colspan=5><hr></td>
			</tr>
					<%
						}
						st.close();
						con.close();
					} catch (Exception e) {
						out.println(" MYSQL Exception: " + e.getMessage());
					}
					%>
		</table>
	</body>
</html>