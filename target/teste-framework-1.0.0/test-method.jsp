<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test GET vs POST</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Test GET vs POST sur même URL</h1>
    
    <div style="margin: 20px; padding: 20px; border: 2px solid #4CAF50; background-color: #f0f0f0;">
        <h2>Test 1: GET - Consulter les commandes</h2>
        <p>Cliquez sur ce lien pour effectuer une requête GET sur /test2/order</p>
        <a href="order" style="padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">
            Voir les commandes (GET)
        </a>
    </div>
    
    <div style="margin: 20px; padding: 20px; border: 2px solid #2196F3; background-color: #f0f0f0;">
        <h2>Test 2: POST - Créer une commande</h2>
        <p>Soumettez ce formulaire pour effectuer une requête POST sur /test2/order</p>
        <form action="order" method="post">
            <label for="product">Produit:</label><br>
            <input type="text" id="product" name="product" value="Laptop" style="padding: 5px; margin: 5px 0;"><br>
            
            <label for="quantity">Quantité:</label><br>
            <input type="number" id="quantity" name="quantity" value="2" style="padding: 5px; margin: 5px 0;"><br><br>
            
            <button type="submit" style="padding: 10px 20px; background-color: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer;">
                Créer la commande (POST)
            </button>
        </form>
    </div>
    
    <div style="margin: 20px; padding: 20px; background-color: #fff3cd;">
        <h3>Explication</h3>
        <p>Les deux actions utilisent la même URL (<code>/test2/order</code>) mais:</p>
        <ul>
            <li><strong>@GetRequest</strong> : Méthode <code>getOrder()</code> - Affiche les commandes</li>
            <li><strong>@PostRequest</strong> : Méthode <code>createOrder()</code> - Crée une nouvelle commande</li>
        </ul>
        <p>Le framework différencie automatiquement les deux méthodes grâce aux annotations.</p>
    </div>
    
    <br>
    <a href="form" style="color: #666;">← Retour au formulaire principal</a>
</body>
</html>
