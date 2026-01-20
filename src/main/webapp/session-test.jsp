<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test de Gestion de Session</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        h1 {
            text-align: center;
            color: white;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .card h2 {
            color: #667eea;
            margin-bottom: 20px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 10px;
        }
        
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .message.success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .message.error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .message.info {
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            margin-right: 10px;
            margin-bottom: 10px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(56, 239, 125, 0.4);
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
        
        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(250, 112, 154, 0.4);
        }
        
        .btn-info {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }
        
        .btn-info:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }
        
        .session-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .session-table th,
        .session-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .session-table th {
            background-color: #667eea;
            color: white;
            font-weight: 600;
        }
        
        .session-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .empty-session {
            text-align: center;
            padding: 30px;
            color: #999;
            font-style: italic;
        }
        
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        
        @media (max-width: 768px) {
            .grid {
                grid-template-columns: 1fr;
            }
            
            h1 {
                font-size: 1.8em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔐 Test de Gestion de Session</h1>
        
        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null && messageType != null) {
        %>
            <div class="message <%= messageType %>">
                <%= message %>
            </div>
        <%
            }
        %>
        
        <div class="grid">
            <!-- Ajouter une variable -->
            <div class="card">
                <h2>➕ Ajouter une Variable</h2>
                <form action="<%= request.getContextPath() %>/session/add" method="post">
                    <div class="form-group">
                        <label for="addKey">Clé :</label>
                        <input type="text" id="addKey" name="key" placeholder="Ex: username" required>
                    </div>
                    <div class="form-group">
                        <label for="addValue">Valeur :</label>
                        <input type="text" id="addValue" name="value" placeholder="Ex: John Doe" required>
                    </div>
                    <button type="submit" class="btn btn-success">Ajouter</button>
                </form>
            </div>
            
            <!-- Récupérer une variable -->
            <div class="card">
                <h2>🔍 Récupérer une Variable</h2>
                <form action="<%= request.getContextPath() %>/session/get" method="get">
                    <div class="form-group">
                        <label for="getKey">Clé :</label>
                        <input type="text" id="getKey" name="key" placeholder="Ex: username" required>
                    </div>
                    <button type="submit" class="btn btn-info">Récupérer</button>
                </form>
                <%
                    String retrievedKey = (String) request.getAttribute("retrievedKey");
                    Object retrievedValue = request.getAttribute("retrievedValue");
                    if (retrievedKey != null && retrievedValue != null) {
                %>
                    <div style="margin-top: 15px; padding: 10px; background: #e7f3ff; border-radius: 5px;">
                        <strong><%= retrievedKey %></strong> = <%= retrievedValue %>
                    </div>
                <%
                    }
                %>
            </div>
            
            <!-- Modifier une variable -->
            <div class="card">
                <h2>✏️ Modifier une Variable</h2>
                <form action="<%= request.getContextPath() %>/session/update" method="post">
                    <div class="form-group">
                        <label for="updateKey">Clé :</label>
                        <input type="text" id="updateKey" name="key" placeholder="Ex: username" required>
                    </div>
                    <div class="form-group">
                        <label for="updateValue">Nouvelle Valeur :</label>
                        <input type="text" id="updateValue" name="value" placeholder="Ex: Jane Doe" required>
                    </div>
                    <button type="submit" class="btn btn-warning">Modifier</button>
                </form>
            </div>
            
            <!-- Supprimer une variable -->
            <div class="card">
                <h2>🗑️ Supprimer une Variable</h2>
                <form action="<%= request.getContextPath() %>/session/remove" method="post">
                    <div class="form-group">
                        <label for="removeKey">Clé :</label>
                        <input type="text" id="removeKey" name="key" placeholder="Ex: username" required>
                    </div>
                    <button type="submit" class="btn btn-danger">Supprimer</button>
                </form>
            </div>
        </div>
        
        <!-- Actions rapides -->
        <div class="card">
            <h2>⚡ Actions Rapides</h2>
            <a href="<%= request.getContextPath() %>/session/counter" class="btn btn-info">
                Compteur de Visites
            </a>
            <form action="<%= request.getContextPath() %>/session/clear" method="post" style="display: inline;"
                  onsubmit="return confirm('Êtes-vous sûr de vouloir vider toute la session ?');">
                <button type="submit" class="btn btn-danger">Vider la Session</button>
            </form>
        </div>
        
        <!-- Affichage des variables de session -->
        <div class="card">
            <h2>📋 Variables de Session Actuelles</h2>
            <%
                @SuppressWarnings("unchecked")
                Map<String, Object> sessionData = (Map<String, Object>) request.getAttribute("sessionData");
                if (sessionData != null && !sessionData.isEmpty()) {
            %>
                <table class="session-table">
                    <thead>
                        <tr>
                            <th>Clé</th>
                            <th>Valeur</th>
                            <th>Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Map.Entry<String, Object> entry : sessionData.entrySet()) {
                                String key = entry.getKey();
                                Object value = entry.getValue();
                                String type = value != null ? value.getClass().getSimpleName() : "null";
                        %>
                            <tr>
                                <td><strong><%= key %></strong></td>
                                <td><%= value %></td>
                                <td><em><%= type %></em></td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                } else {
            %>
                <div class="empty-session">
                    Aucune variable dans la session. Ajoutez-en une pour commencer ! 🎯
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
