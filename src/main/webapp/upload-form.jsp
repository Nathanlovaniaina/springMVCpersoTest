<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload de Fichiers</title>
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
            max-width: 600px;
            width: 100%;
        }
        
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 10px;
            font-size: 28px;
        }
        
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }
        
        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }
        
        .file-input-wrapper input[type=file] {
            position: absolute;
            left: -9999px;
        }
        
        .file-input-label {
            display: block;
            padding: 15px 20px;
            background: #f8f9fa;
            border: 2px dashed #667eea;
            border-radius: 8px;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s ease;
            color: #667eea;
            font-weight: 500;
        }
        
        .file-input-label:hover {
            background: #e7eaf6;
            border-color: #764ba2;
            color: #764ba2;
        }
        
        .file-input-label i {
            font-size: 24px;
            display: block;
            margin-bottom: 10px;
        }
        
        #file-names {
            margin-top: 10px;
            padding: 10px;
            background: #f0f0f0;
            border-radius: 5px;
            font-size: 13px;
            color: #555;
            min-height: 40px;
            display: none;
        }
        
        #file-names.active {
            display: block;
        }
        
        .file-item {
            padding: 5px 0;
            border-bottom: 1px solid #ddd;
        }
        
        .file-item:last-child {
            border-bottom: none;
        }
        
        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
            font-family: inherit;
        }
        
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .btn-submit {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }
        
        .btn-submit:active {
            transform: translateY(0);
        }
        
        .info-box {
            background: #e7f3ff;
            border-left: 4px solid #2196F3;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 5px;
        }
        
        .info-box p {
            margin: 5px 0;
            color: #1565C0;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📤 Upload de Fichiers</h1>
        <p class="subtitle">Sélectionnez un ou plusieurs fichiers à uploader</p>
        
        <div class="info-box">
            <p><strong>ℹ️ Informations:</strong></p>
            <p>• Taille maximale par fichier: 10 MB</p>
            <p>• Taille maximale totale: 50 MB</p>
            <p>• Vous pouvez sélectionner plusieurs fichiers</p>
        </div>
        
        <form action="${pageContext.request.contextPath}/upload/submit" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="files">Fichier(s) à uploader *</label>
                <div class="file-input-wrapper">
                    <input type="file" id="files" name="files" multiple required onchange="displayFileNames()">
                    <label for="files" class="file-input-label">
                        <span style="font-size: 40px;">📁</span>
                        <div>Cliquez pour choisir des fichiers</div>
                        <small>ou glissez-déposez ici</small>
                    </label>
                </div>
                <div id="file-names"></div>
            </div>
            
            <div class="form-group">
                <label for="destination">Destination (chemin du dossier)</label>
                <input type="text" 
                       id="destination" 
                       name="destination" 
                       value="C:/uploads"
                       placeholder="Ex: C:/uploads ou /var/www/uploads">
                <small style="color: #666; font-size: 12px;">Le dossier sera créé automatiquement s'il n'existe pas</small>
            </div>
            
            <div class="form-group">
                <label for="description">Description (optionnelle)</label>
                <textarea id="description" 
                          name="description" 
                          placeholder="Ajoutez une description pour ces fichiers..."></textarea>
            </div>
            
            <button type="submit" class="btn-submit">
                ⬆️ Envoyer les fichiers
            </button>
        </form>
    </div>
    
    <script>
        function displayFileNames() {
            const input = document.getElementById('files');
            const display = document.getElementById('file-names');
            
            if (input.files.length > 0) {
                let html = '<strong>Fichiers sélectionnés:</strong><br>';
                let totalSize = 0;
                
                for (let i = 0; i < input.files.length; i++) {
                    const file = input.files[i];
                    const size = formatFileSize(file.size);
                    totalSize += file.size;
                    html += '<div class="file-item">📄 ' + file.name + ' (' + size + ')</div>';
                }
                
                html += '<div style="margin-top: 10px; font-weight: bold; color: #667eea;">Total: ' + 
                        input.files.length + ' fichier(s) - ' + formatFileSize(totalSize) + '</div>';
                
                display.innerHTML = html;
                display.classList.add('active');
            } else {
                display.classList.remove('active');
            }
        }
        
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return Math.round((bytes / Math.pow(k, i)) * 100) / 100 + ' ' + sizes[i];
        }
        
        // Drag and drop support
        const fileInputLabel = document.querySelector('.file-input-label');
        const fileInput = document.getElementById('files');
        
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            fileInputLabel.addEventListener(eventName, preventDefaults, false);
        });
        
        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }
        
        ['dragenter', 'dragover'].forEach(eventName => {
            fileInputLabel.addEventListener(eventName, () => {
                fileInputLabel.style.background = '#e7eaf6';
                fileInputLabel.style.borderColor = '#764ba2';
            });
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            fileInputLabel.addEventListener(eventName, () => {
                fileInputLabel.style.background = '#f8f9fa';
                fileInputLabel.style.borderColor = '#667eea';
            });
        });
        
        fileInputLabel.addEventListener('drop', (e) => {
            const dt = e.dataTransfer;
            const files = dt.files;
            fileInput.files = files;
            displayFileNames();
        });
    </script>
</body>
</html>
