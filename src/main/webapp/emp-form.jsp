<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page d'Accueil - Test Framework</title>
</head>
<body>
<form action="emp" method="post">
  <label>Id</label><input name="emptest.id" value="1"/><br/>
  <label>Nom</label><input name="emptest.nom" value="Alice"/><br/>
  <label>Nombre membres</label><input name="emptest.nombre_membre" value="3"/><br/>
  
  <!-- Hobbies indexés pour test de binding de List<Hobbi> -->
  <h3>Hobbies</h3>
  <label>Hobby 1 - Nom</label><input name="emptest.hobbies[0].nom" value="Football"/><br/>
  <label>Hobby 1 - Durée</label><input name="emptest.hobbies[0].dureer" value="5"/><br/>
  <label>Hobby 2 - Nom</label><input name="emptest.hobbies[1].nom" value="Chess"/><br/>
  <label>Hobby 2 - Durée</label><input name="emptest.hobbies[1].dureer" value="2"/><br/>
  <button type="submit">Envoyer</button>
</form>

<%@ page import="mg.model.Emp" %>
<%@ page import="java.util.Map" %>

<!-- DÉBOGAGE: Affichage de tous les paramètres reçus -->
<div style="border: 2px solid red; padding: 10px; margin: 10px 0; background-color: #ffe6e6;">
  <h3>🔍 DEBUG - Paramètres reçus:</h3>
  <pre>
  <%
    Map<String, String[]> params = request.getParameterMap();
    for (Map.Entry<String, String[]> entry : params.entrySet()) {
      out.println(entry.getKey() + " = " + String.join(", ", entry.getValue()));
    }
  %>
  </pre>
</div>

<% Emp e = (Emp) request.getAttribute("emptest");
   if (e != null) { %>
  
  <!-- DÉBOGAGE: Informations sur l'objet Emp -->
  <div style="border: 2px solid orange; padding: 10px; margin: 10px 0; background-color: #fff4e6;">
    <h3>🔍 DEBUG - Objet Emp reçu:</h3>
    <p><strong>ID:</strong> <%= e.getId() %></p>
    <p><strong>Nom:</strong> <%= e.getNom() %></p>
    <p><strong>Nombre membres:</strong> <%= e.getNombre_membre() %></p>
    <p><strong>Hobbies null?</strong> <%= (e.getHobbies() == null ? "OUI (NULL)" : "NON") %></p>
    <p><strong>Hobbies vide?</strong> <%= (e.getHobbies() != null ? (e.getHobbies().isEmpty() ? "OUI (VIDE)" : "NON") : "N/A") %></p>
    <p><strong>Nombre de hobbies:</strong> <%= (e.getHobbies() != null ? e.getHobbies().size() : "N/A") %></p>
  </div>

  <table>
    <tr><th>id</th><th>nom</th><th>nombre_membre</th></tr>
    <tr><td><%= e.getId() %></td><td><%= e.getNom() %></td><td><%= e.getNombre_membre() %></td></tr>
  </table>
   
   <% if (e.getHobbies() != null && !e.getHobbies().isEmpty()) { %>
     <h3>Hobbies reçus</h3>
     <table>
       <tr><th>Nom</th><th>Durée</th></tr>
       <% for (mg.model.Hobbi h : e.getHobbies()) { %>
         <tr><td><%= h.getNom() %></td><td><%= h.getDureer() %></td></tr>
       <% } %>
     </table>
   <% } else { %>
     <div style="border: 2px solid red; padding: 10px; margin: 10px 0; background-color: #ffe6e6;">
       <h3>⚠️ PROBLÈME: Aucun hobby trouvé!</h3>
       <p>La liste des hobbies est <%= (e.getHobbies() == null ? "NULL" : "VIDE") %></p>
     </div>
   <% } %>
<% } else { %>
  <div style="border: 2px solid red; padding: 10px; margin: 10px 0; background-color: #ffe6e6;">
    <h3>⚠️ ERREUR: Objet 'emptest' est NULL!</h3>
  </div>
<% } %>
</body>
</html>