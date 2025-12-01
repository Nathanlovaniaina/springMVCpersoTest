<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire de Commande</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"],
        input[type="number"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .checkbox-group {
            margin-left: 20px;
        }
        .checkbox-group label {
            display: inline-block;
            font-weight: normal;
            margin-right: 15px;
        }
        .checkbox-group input[type="checkbox"] {
            margin-right: 5px;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
        }
        .result-section {
            margin-top: 30px;
            padding: 20px;
            background-color: #e8f5e9;
            border-radius: 5px;
            border-left: 4px solid #4CAF50;
        }
        .result-section h2 {
            color: #2e7d32;
            margin-top: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        tr:last-child td {
            border-bottom: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📦 Formulaire de Commande</h1>
        
        <form action="order" method="post">
            <div class="form-group">
                <label for="product">Produit:</label>
                <input type="text" id="product" name="product" value="Laptop Dell XPS 15" required>
            </div>
            
            <div class="form-group">
                <label for="quantity">Quantité:</label>
                <input type="number" id="quantity" name="quantity" value="2" min="1" required>
            </div>
            
            <div class="form-group">
                <label for="customerName">Nom du client:</label>
                <input type="text" id="customerName" name="customerName" value="Jean Dupont" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="jean.dupont@example.com" required>
            </div>
            
            <div class="form-group">
                <label>Options supplémentaires:</label>
                <div class="checkbox-group">
                    <label>
                        <input type="checkbox" name="options" value="Garantie étendue" checked>
                        Garantie étendue
                    </label>
                    <label>
                        <input type="checkbox" name="options" value="Assurance" checked>
                        Assurance
                    </label>
                    <label>
                        <input type="checkbox" name="options" value="Livraison express">
                        Livraison express
                    </label>
                    <label>
                        <input type="checkbox" name="options" value="Emballage cadeau">
                        Emballage cadeau
                    </label>
                </div>
            </div>
            
            <div class="form-group">
                <label for="notes">Notes de commande:</label>
                <textarea id="notes" name="notes" rows="4" placeholder="Informations supplémentaires...">Livrer avant 18h</textarea>
            </div>
            
            <button type="submit">🚀 Créer la commande</button>
        </form>
        
        <% if (request.getAttribute("formData") != null) { %>
        <div class="result-section">
            <h2>✅ Commande créée avec succès!</h2>
            <table>
                <thead>
                    <tr>
                        <th>Paramètre</th>
                        <th>Valeur</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        @SuppressWarnings("unchecked")
                        java.util.Map<String, Object> formData = (java.util.Map<String, Object>) request.getAttribute("formData");
                        for (java.util.Map.Entry<String, Object> entry : formData.entrySet()) {
                            String key = entry.getKey();
                            Object value = entry.getValue();
                            String displayValue;
                            
                            if (value instanceof String[]) {
                                displayValue = java.util.Arrays.toString((String[]) value);
                            } else {
                                displayValue = String.valueOf(value);
                            }
                    %>
                    <tr>
                        <td><strong><%= key %></strong></td>
                        <td><%= displayValue %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
</body>
</html>
