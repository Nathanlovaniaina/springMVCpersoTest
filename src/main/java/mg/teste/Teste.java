package mg.teste;
import com.monframework.core.util.Annotation.HandleURL;

public class Teste {
    @HandleURL("/hello")
    public void hello() {}

    @HandleURL("/teste")
    public void about() {}
}