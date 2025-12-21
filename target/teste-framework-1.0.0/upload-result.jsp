<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Résultat de l'Upload</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            max-width: 700px;
            width: 100%;
        }
        
        .success {
            background: #d4edda;
            border-left: 5px solid #28a745;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .error {
            background: #f8d7da;
            border-left: 5px solid #dc3545;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .success h2 {
            color: #155724;
            margin-bottom: 15px;
            font-size: 24px;
        }
        
        .error h2 {
            color: #721c24;
            margin-bottom: 15px;
            font-size: 24px;
        }
        
        .success .icon {
            font-size: 48px;
            text-align: center;
            margin-bottom: 15px;
        }
        
        .error .icon {
            font-size: 48px;
            text-align: center;
            margin-bottom: 15px;
        }
        
        .message {
            color: #333;
            line-height: 1.8;
            white-space: pre-line;
            background: white;
            padding: 15px;
            border-radius: 5px;
            margin-top: 15px;
            font-family: 'Courier New', monospace;
            font-size: 13px;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        
        .stat-card h3 {
            font-size: 14px;
            margin-bottom: 10px;
            opacity: 0.9;
        }
        
        .stat-card p {
            font-size: 24px;
            font-weight: bold;
        }
        
        .buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        
        .btn:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <div class="container">
        <% 
            Boolean success = (Boolean) request.getAttribute("success");
            String message = (String) request.getAttribute("message");
            Integer fileCount = (Integer) request.getAttribute("fileCount");
            String totalSize = (String) request.getAttribute("totalSize");
            String destination = (String) request.getAttribute("destination");
            
            if (success != null && success) {
        %>
            <div class="success">
                <div class="icon">✅</div>
                <h2>Upload réussi !</h2>
                <div class="message"><%= message != null ? message : "Les fichiers ont été uploadés avec succès." %></div>
            </div>
            
            <% if (fileCount != null && totalSize != null) { %>
            <div class="stats">
                <div class="stat-card">
                    <h3>📁 Nombre de fichiers</h3>
                    <p><%= fileCount %></p>
                </div>
                <div class="stat-card">
                    <h3>💾 Taille totale</h3>
                    <p><%= totalSize %></p>
                </div>
                <% if (destination != null) { %>
                <div class="stat-card" style="grid-column: 1 / -1;">
                    <h3>📍 Destination</h3>
                    <p style="font-size: 16px; word-break: break-all;"><%= destination %></p>
                </div>
                <% } %>
            </div>
            <% } %>
        <% } else { %>
            <div class="error">
                <div class="icon">❌</div>
                <h2>Erreur lors de l'upload</h2>
                <div class="message"><%= message != null ? message : "Une erreur s'est produite lors de l'upload des fichiers." %></div>
            </div>
        <% } %>
        
        <div class="buttons">
            <a href="${pageContext.request.contextPath}/upload/form" class="btn btn-primary">
                ⬆️ Uploader d'autres fichiers
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                🏠 Retour à l'accueil
            </a>
        </div>
    </div>
</body>
</html>
