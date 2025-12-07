package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.PostRequest;
import com.monframework.core.util.Annotation.GetRequest;
import com.monframework.core.util.Mapper.ModelView;

import mg.model.*;

@ControleurAnnotation("")
public class EmpController {

    @GetRequest("emp")
    public ModelView form() {
        ModelView mv = new ModelView("/emp-form.jsp");
        return mv;
    }

    @PostRequest("emp")
    public ModelView saveEmp(Emp emptest) {
        ModelView mv = new ModelView("/emp-form.jsp");
        mv.setValue("emptest", emptest);
        return mv;
    }
}
