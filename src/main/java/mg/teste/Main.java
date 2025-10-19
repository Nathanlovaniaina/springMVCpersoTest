package mg.teste;

import java.lang.reflect.Method;
import com.monframework.core.util.Annotation.HandleURL;


public class Main {
    public static void main(String[] args) {
        Class<?> clazz = Teste.class;
        for (Method m : clazz.getDeclaredMethods()) {
            if (m.isAnnotationPresent(HandleURL.class)) {
                HandleURL ann = m.getAnnotation(HandleURL.class);
                System.out.println(ann.value());
            }
        }
    }
}