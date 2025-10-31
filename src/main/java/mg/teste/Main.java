package mg.teste;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import com.monframework.core.util.Finder.ClassFinder;


public class Main {
    public static void main(String[] args) throws IOException {
        Path classesRoot;
        if (args.length >= 1) {
            classesRoot = Paths.get(args[0]).toAbsolutePath();
        } else {
            classesRoot = Paths.get("target/teste-framework-1.0.0/").toAbsolutePath();
        }

        List<String> annotated = ClassFinder.findClassesAnnotatedWithControleur(classesRoot);
        if (annotated.isEmpty()) {
            System.out.println(" (none found)");
        } else {
            annotated.forEach(s -> System.out.println(" - " + s));
        }

    }
}