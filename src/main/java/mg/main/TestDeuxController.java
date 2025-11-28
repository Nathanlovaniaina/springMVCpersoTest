package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;
import com.monframework.core.util.Annotation.RequestParam;
import com.monframework.core.util.Annotation.PathVariable;
import com.monframework.core.util.Annotation.GetRequest;
import com.monframework.core.util.Annotation.PostRequest;
import com.monframework.core.util.Mapper.ModelView;
import jakarta.servlet.http.HttpServletRequest;

@ControleurAnnotation(value = "test2")
public class TestDeuxController {
    @HandleURL(value = "test2url1")
    public String url1(){
        return "Bonjour de TestDeuxController!\nCette méthode retourne un message de test.";
    }

    // Test: passage de données en utilisant request.setAttribute + retour String
    @HandleURL(value = "view")
    public String view(HttpServletRequest request){
        request.setAttribute("title", "Contact depuis Controller");
        request.setAttribute("message", "Bonjour, ceci est un message envoyé au JSP.");
        return "/contact.jsp";
    }

    // Test: nouveau format avec ModelView retourné directement
    @HandleURL(value = "view3")
    public ModelView view3(){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Contact depuis Controller (view3 - ModelView)");
        model.setValue("message", "Ceci est un test du nouveau format retournant ModelView directement.");
        return model;
    }

    // Test: formulaire GET - afficher le formulaire
    @HandleURL(value = "form")
    public ModelView showForm(){
        return new ModelView("/form.jsp");
    }

    // Test: traitement GET avec request param et @RequestParam
    @HandleURL(value = "hello")
    public ModelView sayHello(
            @RequestParam(value = "name", defaultValue = "inconnu") String name, 
            @RequestParam(value = "age", defaultValue = "0") Integer age2){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Bonjour " + name);
        model.setValue("message", "Vous avez " + age2 + " ans.");
        return model;
    }

    // Test: traitement POST formulaire avec request params
    @HandleURL(value = "submit")
    public ModelView submitForm(String nom, String email, String message){
        ModelView mv = new ModelView("/contact.jsp");
        mv.setValue("title", "Formulaire soumis !");
        mv.setValue("message", "Merci " + nom + " (" + email + "). Votre message: " + message);
        return mv;
    }

    // Test: @RequestParam avec nom de variable différent et valeur par défaut
    @HandleURL(value = "greet")
    public ModelView greetWithAnnotation(
            @RequestParam(value = "user_name", defaultValue = "Visiteur") String nom,
            @RequestParam(value = "user_age", defaultValue = "18") Integer age){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Salut " + nom + " !");
        model.setValue("message", "Tu as " + age + " ans. (Annotation @RequestParam avec defaultValue)");
        return model;
    }

    // Test: @PathVariable avec nom de variable différent
    @HandleURL(value = "user/{userId}")
    public ModelView viewUser(@PathVariable(value = "userId") Long id){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Profil Utilisateur");
        model.setValue("message", "Affichage de l'utilisateur avec l'ID: " + id);
        return model;
    }

    // Test: Combinaison @PathVariable et @RequestParam
    @HandleURL(value = "product/{productId}/review")
    public ModelView reviewProduct(
            @PathVariable(value = "productId") Long prodId,
            @RequestParam(value = "rating", defaultValue = "5") Integer note,
            @RequestParam(value = "comment", defaultValue = "Aucun commentaire") String commentaire){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Avis sur le produit #" + prodId);
        model.setValue("message", "Note: " + note + "/10 - Commentaire: " + commentaire);
        return model;
    }

    // Test: Même URL mais méthode GET
    @GetRequest(value = "order")
    public ModelView getOrder(){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Affichage Commande (GET)");
        model.setValue("message", "Vous consultez les commandes existantes.");
        return model;
    }

    // Test: Même URL mais méthode POST
    @PostRequest(value = "order")
    public ModelView createOrder(
            @RequestParam(value = "product", defaultValue = "inconnu") String product,
            @RequestParam(value = "quantity", defaultValue = "1") Integer quantity){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Création Commande (POST)");
        model.setValue("message", "Commande créée : " + quantity + "x " + product);
        return model;
    }

    // Test: Page de test pour GET vs POST
    @GetRequest(value = "test-methods")
    public ModelView showTestMethodsPage(){
        return new ModelView("/test-method.jsp");
    }
}
