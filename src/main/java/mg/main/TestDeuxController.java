package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;
import com.monframework.core.util.Annotation.RequestParam;
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
}
