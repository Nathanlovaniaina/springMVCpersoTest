package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;
import com.monframework.core.util.Annotation.PostRequest;
import com.monframework.core.util.Annotation.Session;
import com.monframework.core.util.Annotation.RequestParam;
import com.monframework.core.util.Mapper.ModelView;

import java.util.Map;

/**
 * Contrôleur pour tester la gestion de session avec l'annotation @Session.
 * Démontre l'ajout, la récupération, la modification et la suppression de variables de session.
 */
@ControleurAnnotation(value = "session")
public class SessionTestController {
    
    /**
     * Page d'accueil pour la gestion de session.
     * Affiche toutes les variables de session actuelles.
     */
    @HandleURL("test")
    public ModelView sessionHome(@Session Map<String, Object> session) {
        ModelView mv = new ModelView("/session-test.jsp");
        mv.setValue("sessionKeys", session.keySet());
        mv.setValue("sessionData", session);
        return mv;
    }
    
    /**
     * Ajouter une nouvelle variable dans la session.
     */
    @PostRequest("add")
    public ModelView addToSession(
            @Session Map<String, Object> session,
            @RequestParam("key") String key,
            @RequestParam("value") String value) {

        ModelView mv = new ModelView("/session-test.jsp");
        if (key != null && !key.trim().isEmpty()) {
            session.put(key, value);
            mv.setValue("message", "Variable '" + key + "' ajoutée avec succès !");
            mv.setValue("messageType", "success");
        } else {
            mv.setValue("message", "La clé ne peut pas être vide !");
            mv.setValue("messageType", "error");
        }

        mv.setValue("sessionKeys", session.keySet());
        mv.setValue("sessionData", session);
        return mv;
    }
    
    /**
     * Récupérer une valeur de la session.
     */
    @HandleURL("get")
    public ModelView getFromSession(
            @Session Map<String, Object> session,
            @RequestParam("key") String key) {

        ModelView mv = new ModelView("/session-test.jsp");
        if (key != null && !key.trim().isEmpty()) {
            Object value = session.get(key);
            if (value != null) {
                mv.setValue("message", "Valeur de '" + key + "': " + value);
                mv.setValue("messageType", "info");
                mv.setValue("retrievedKey", key);
                mv.setValue("retrievedValue", value);
            } else {
                mv.setValue("message", "Aucune variable '" + key + "' trouvée dans la session !");
                mv.setValue("messageType", "error");
            }
        }

        mv.setValue("sessionKeys", session.keySet());
        mv.setValue("sessionData", session);
        return mv;
    }
    
    /**
     * Modifier une valeur existante dans la session.
     */
    @PostRequest("update")
    public ModelView updateSession(
            @Session Map<String, Object> session,
            @RequestParam("key") String key,
            @RequestParam("value") String value) {

        ModelView mv = new ModelView("/session-test.jsp");
        if (key != null && !key.trim().isEmpty()) {
            if (session.containsKey(key)) {
                Object oldValue = session.get(key);
                session.put(key, value);
                mv.setValue("message", "Variable '" + key + "' modifiée de '" + oldValue + "' à '" + value + "' !");
                mv.setValue("messageType", "success");
            } else {
                mv.setValue("message", "La variable '" + key + "' n'existe pas dans la session !");
                mv.setValue("messageType", "error");
            }
        } else {
            mv.setValue("message", "La clé ne peut pas être vide !");
            mv.setValue("messageType", "error");
        }

        mv.setValue("sessionKeys", session.keySet());
        mv.setValue("sessionData", session);
        return mv;
    }
    
    /**
     * Supprimer une variable de la session.
     */
        @PostRequest("remove")
        public ModelView removeFromSession(
            @Session Map<String, Object> session,
            @RequestParam("key") String key) {

        ModelView mv = new ModelView("/session-test.jsp");
        
        if (key != null && !key.trim().isEmpty()) {
            if (session.containsKey(key)) {
                Object oldValue = session.remove(key);
                mv.setValue("message", "Variable '" + key + "' (valeur: '" + oldValue + "') supprimée !");
                mv.setValue("messageType", "success");
            } else {
                mv.setValue("message", "La variable '" + key + "' n'existe pas dans la session !");
                mv.setValue("messageType", "error");
            }
        } else {
            mv.setValue("message", "La clé ne peut pas être vide !");
            mv.setValue("messageType", "error");
        }
        
        mv.setValue("sessionKeys", session.keySet());
        mv.setValue("sessionData", session);
        return mv;
    }
    
    /**
     * Vider toute la session.
     */
    @PostRequest("clear")
    public ModelView clearSession(@Session Map<String, Object> session) {
        ModelView mv = new ModelView("/session-test.jsp");
        session.clear();
        mv.setValue("message", "Toutes les variables de session ont été supprimées !");
        mv.setValue("messageType", "success");
        mv.setValue("sessionKeys", session.keySet());
        mv.setValue("sessionData", session);
        return mv;
    }

    /**
     * Exemple d'utilisation avancée : compteur de visites.
     */
    @HandleURL("counter")
    public ModelView visitCounter(@Session Map<String, Object> session) {
        // Récupérer le compteur ou initialiser à 0
        Integer counter = (Integer) session.get("visitCount");
        if (counter == null) {
            counter = 0;
        }

        // Incrémenter le compteur
        counter++;
        session.put("visitCount", counter);
        ModelView mv = new ModelView("/session-test.jsp");
        mv.setValue("message", "Vous avez visité cette page " + counter + " fois !");
        mv.setValue("messageType", "info");
        mv.setValue("sessionKeys", session.keySet());
        mv.setValue("sessionData", session);
        return mv;
    }
}
