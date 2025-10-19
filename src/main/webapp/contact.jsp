<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - Test Framework</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Page Contact (JSP)</h1>
        <p>Cette page est générée par une JSP pour tester le framework.</p>
        
        <div class="jsp-info">
            <h2>Informations JSP :</h2>
            <ul>
                <li>Date du serveur : <%= new java.util.Date() %></li>
                <li>Session ID : <%= session.getId() %></li>
                <li>Context Path : <%= request.getContextPath() %></li>
                <li>Server Info : <%= application.getServerInfo() %></li>
            </ul>
        </div>
        
        <div class="form">
            <h2>Formulaire de Contact :</h2>
            <form action="nonexistant" method="post">
                <label for="nom">Nom :</label>
                <input type="text" id="nom" name="nom" required>
                
                <label for="email">Email :</label>
                <input type="email" id="email" name="email" required>
                
                <label for="message">Message :</label>
                <textarea id="message" name="message" required></textarea>
                
                <button type="submit">Envoyer (vers framework)</button>
            </form>
        </div>
        
        <div class="back-link">
            <a href="index.html">← Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>