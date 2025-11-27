<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire Test</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Formulaire de Test</h1>
        
        <div class="form">
            <h2>Envoi de message (POST)</h2>
            <form action="submit" method="post" accept-charset="UTF-8">
                <label for="nom">Nom :</label>
                <input type="text" id="nom" name="nom" required>
                
                <label for="email">Email :</label>
                <input type="email" id="email" name="email" required>
                
                <label for="message">Message :</label>
                <textarea id="message" name="message" required></textarea>
                
                <button type="submit">Envoyer via POST</button>
            </form>
        </div>

        <div class="form">
            <h2>Test avec paramètres GET</h2>
            <form action="hello" method="get">
                <label for="name">Nom :</label>
                <input type="text" id="name" name="name" value="John">
                
                <label for="age">Âge :</label>
                <input type="number" id="age" name="age" value="25">
                
                <button type="submit">Envoyer via GET</button>
            </form>
            
            <p>Ou testez directement : <a href="hello?name=Marie&age=30">hello?name=Marie&age=30</a></p>
        </div>
        
        <div class="back-link">
            <a href="index.html">← Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>
