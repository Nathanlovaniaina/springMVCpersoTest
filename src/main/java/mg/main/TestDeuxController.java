package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;

@ControleurAnnotation(value = "test2")
public class TestDeuxController {
    @HandleURL(value = "test2url1")
    public String url1(){
        return "Bonjour de TestDeuxController!\nCette méthode retourne un message de test.";
    }
}
