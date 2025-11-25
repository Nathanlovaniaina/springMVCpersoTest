package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;
import com.monframework.core.util.Mapper.ModelView;
import jakarta.servlet.http.HttpServletRequest;

@ControleurAnnotation(value = "test2")
public class TestDeuxController {
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

    // Test: path variable avec ModelView
    @HandleURL(value = "view/{id}")
    public ModelView viewById(Long id){
        ModelView model = new ModelView("/contact.jsp");
        model.setValue("title", "Contact avec ID - " + id);
        model.setValue("message", "Vous avez demandé la page avec l'ID: " + id);
        return model;
    }
}
