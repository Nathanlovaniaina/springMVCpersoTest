package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.HandleURL;

@ControleurAnnotation(value = "test2")
public class TestDeuxController {
    @HandleURL(value = "test2url1")
    public void url1(){

    }
}
