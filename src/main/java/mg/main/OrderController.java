package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.GetRequest;
import com.monframework.core.util.Annotation.PostRequest;
import com.monframework.core.util.Mapper.ModelView;
import java.util.Map;

@ControleurAnnotation(value = "")
public class OrderController {
    
    /**
     * Affiche le formulaire de commande (GET)
     */
    @GetRequest(value = "order")
    public ModelView getOrderForm() {
        ModelView model = new ModelView("/order-form.jsp");
        model.setValue("title", "Formulaire de Commande");
        model.setValue("message", "Remplissez le formulaire pour créer une commande");
        return model;
    }
    
    /**
     * Traite la soumission du formulaire de commande (POST)
     * Les valeurs du formulaire sont automatiquement injectées dans le Map
     */
    @PostRequest(value = "order")
    public ModelView createOrder(Map<String, Object> formValues) {
        ModelView model = new ModelView("/order-form.jsp");
        
        // Passer directement le Map au modèle pour l'affichage dans le tableau
        model.setValue("formData", formValues);
        
        return model;
    }
}
