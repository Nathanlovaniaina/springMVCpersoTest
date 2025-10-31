package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;

@ControleurAnnotation(value = "Test1")
public class TestUnController {

    @HandleURL(value = "test1url1")
    public void url1(){

    }
}
