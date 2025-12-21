package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;
import com.monframework.core.util.Annotation.PostRequest;
import com.monframework.core.util.Annotation.RequestParam;
import com.monframework.core.util.Mapper.ModelView;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

@ControleurAnnotation(value = "upload")
public class FileUploadController {
    
    /**
     * Affiche le formulaire d'upload de fichiers
     */
    @HandleURL(value = "form")
    public ModelView showUploadForm() {
        return new ModelView("/upload-form.jsp");
    }
    
    /**
     * Traite l'upload de fichiers.
     * Reçoit une Map<String, byte[]> contenant les fichiers uploadés
     * où la clé est le nom du fichier et la valeur est son contenu.
     */
    @PostRequest(value = "submit")
    public ModelView handleFileUpload(
            Map<String, byte[]> files,
            @RequestParam(value = "destination", defaultValue = "C:/uploads") String destinationPath,
            @RequestParam(value = "description", defaultValue = "") String description) {
        
        ModelView model = new ModelView("/upload-result.jsp");
        
        // Vérifier si des fichiers ont été uploadés
        if (files == null || files.isEmpty()) {
            model.setValue("success", false);
            model.setValue("message", "Aucun fichier n'a été uploadé.");
            return model;
        }
        
        try {
            // Créer le dossier de destination s'il n'existe pas
            File destDir = new File(destinationPath);
            if (!destDir.exists()) {
                destDir.mkdirs();
            }
            
            StringBuilder successMessage = new StringBuilder();
            successMessage.append("Fichier(s) uploadé(s) avec succès:\n\n");
            
            int fileCount = 0;
            long totalSize = 0;
            
            // Sauvegarder chaque fichier
            for (Map.Entry<String, byte[]> entry : files.entrySet()) {
                String fileName = entry.getKey();
                byte[] fileContent = entry.getValue();
                
                // Construire le chemin complet du fichier
                File outputFile = new File(destDir, fileName);
                
                // Écrire le fichier
                try (FileOutputStream fos = new FileOutputStream(outputFile)) {
                    fos.write(fileContent);
                }
                
                fileCount++;
                totalSize += fileContent.length;
                
                successMessage.append("- ").append(fileName)
                             .append(" (").append(formatFileSize(fileContent.length)).append(")\n");
                successMessage.append("  Enregistré dans: ").append(outputFile.getAbsolutePath()).append("\n\n");
            }
            
            successMessage.append("\nTotal: ").append(fileCount).append(" fichier(s), ")
                         .append(formatFileSize(totalSize));
            
            if (description != null && !description.trim().isEmpty()) {
                successMessage.append("\n\nDescription: ").append(description);
            }
            
            model.setValue("success", true);
            model.setValue("message", successMessage.toString());
            model.setValue("fileCount", fileCount);
            model.setValue("totalSize", formatFileSize(totalSize));
            model.setValue("destination", destinationPath);
            
        } catch (IOException e) {
            model.setValue("success", false);
            model.setValue("message", "Erreur lors de la sauvegarde des fichiers: " + e.getMessage());
            e.printStackTrace();
        }
        
        return model;
    }
    
    /**
     * Formate la taille du fichier en format lisible
     */
    private String formatFileSize(long size) {
        if (size < 1024) {
            return size + " bytes";
        } else if (size < 1024 * 1024) {
            return String.format("%.2f KB", size / 1024.0);
        } else if (size < 1024 * 1024 * 1024) {
            return String.format("%.2f MB", size / (1024.0 * 1024.0));
        } else {
            return String.format("%.2f GB", size / (1024.0 * 1024.0 * 1024.0));
        }
    }
}
