package mg.main;

import com.monframework.core.util.Annotation.ControleurAnnotation;
import com.monframework.core.util.Annotation.PostRequest;
import com.monframework.core.util.Annotation.GetRequest;
import com.monframework.core.util.Annotation.JsonResponse;
import com.monframework.core.util.Mapper.ModelView;
import com.monframework.core.util.Formatter.JsonResponseWrapper;

import mg.model.*;
import java.util.List;
import java.util.ArrayList;

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

    // ============ Tests JSON Response ============

    /**
     * Test 1: Retourne un objet unique Emp en JSON avec @JsonResponse
     */
    @GetRequest("api/emp/single")
    @JsonResponse(message = "Employé récupéré avec succès", code = 200)
    public Emp getEmpJson() {
        Emp emp = new Emp();
        emp.setId(42);
        emp.setNom("Jean Dupont");
        emp.setNombre_membre(5);
        
        // Ajouter des hobbies
        List<Hobbi> hobbies = new ArrayList<>();
        Hobbi h1 = new Hobbi();
        h1.setNom("Tennis");
        h1.setDureer(10);
        hobbies.add(h1);
        
        Hobbi h2 = new Hobbi();
        h2.setNom("Lecture");
        h2.setDureer(3);
        hobbies.add(h2);
        
        emp.setHobbies(hobbies);
        return emp;
    }

    /**
     * Test 2: Retourne une liste d'Emp en JSON avec @JsonResponse
     */
    @GetRequest("api/emp/list")
    @JsonResponse(message = "Liste des employés récupérée", code = 200)
    public List<Emp> getEmpListJson() {
        List<Emp> empList = new ArrayList<>();
        
        Emp emp1 = new Emp();
        emp1.setId(1);
        emp1.setNom("Jean");
        emp1.setNombre_membre(3);
        empList.add(emp1);
        
        Emp emp2 = new Emp();
        emp2.setId(2);
        emp2.setNom("Sarah");
        emp2.setNombre_membre(7);
        empList.add(emp2);
        
        return empList;
    }

    /**
     * Test 3: Retourne un String (sera converti en JSON)
     * Pas d'annotation @JsonResponse, mais retour String = JSON automatique
     */
    @GetRequest("api/emp/string")
    public String getEmpString() {
        return "{\"status\":\"success\",\"message\":\"Test manuel JSON\",\"code\":200,\"data\":{\"test\":\"valeur\"}}";
    }

    /**
     * Test 4: Test avec erreur simulée
     */
    @GetRequest("api/emp/error")
    @JsonResponse(message = "Erreur simulée", code = 404)
    public Emp getEmpError() {
        // Retourner null pour simuler une erreur
        return null;
    }

    // ============ Tests avec JsonResponseWrapper (message et code dynamiques) ============

    /**
     * Test 5: Retourne un employé avec message et code personnalisés
     * Utilise JsonResponseWrapper au lieu de @JsonResponse
     */
    @GetRequest("api/emp/wrapper-success")
    public JsonResponseWrapper getEmpWithWrapper() {
        Emp emp = new Emp();
        emp.setId(100);
        emp.setNom("Alice Martin");
        emp.setNombre_membre(8);
        
        // Message et code définis dynamiquement dans la méthode
        return JsonResponseWrapper.success(emp, "Employé récupéré dynamiquement", 200);
    }

    /**
     * Test 6: Erreur 404 avec JsonResponseWrapper
     */
    @GetRequest("api/emp/wrapper-notfound")
    public JsonResponseWrapper getEmpNotFound() {
        // Simulation: employé non trouvé
        return JsonResponseWrapper.error("Employé introuvable", 404);
    }

    /**
     * Test 7: Création réussie avec code 201
     */
    @PostRequest("api/emp/wrapper-create")
    public JsonResponseWrapper createEmp(Emp emptest) {
        // Simulation: sauvegarde de l'employé
        emptest.setId(999); // ID généré
        
        return JsonResponseWrapper.success(emptest, "Employé créé avec succès", 201);
    }

    /**
     * Test 8: Erreur de validation avec détails
     */
    @GetRequest("api/emp/wrapper-validation")
    public JsonResponseWrapper validationError() {
        // Simulation: erreur de validation
        List<String> errors = new ArrayList<>();
        errors.add("Le nom est requis");
        errors.add("Le nombre de membres doit être positif");
        
        return JsonResponseWrapper.error(errors, "Erreur de validation", 422);
    }

    /**
     * Test 9: Réponse personnalisée avec statut custom
     */
    @GetRequest("api/emp/wrapper-custom")
    public JsonResponseWrapper customResponse() {
        Emp emp = new Emp();
        emp.setId(555);
        emp.setNom("Bob");
        
        return JsonResponseWrapper.custom(emp, "pending", "En attente de validation", 202);
    }

    /**
     * Test 10: Liste avec message dynamique selon le nombre d'éléments
     */
    @GetRequest("api/emp/wrapper-list")
    public JsonResponseWrapper getEmpListWithWrapper() {
        List<Emp> empList = new ArrayList<>();
        
        Emp emp1 = new Emp();
        emp1.setId(10);
        emp1.setNom("Pierre");
        emp1.setNombre_membre(4);
        empList.add(emp1);
        
        Emp emp2 = new Emp();
        emp2.setId(20);
        emp2.setNom("Marie");
        emp2.setNombre_membre(6);
        empList.add(emp2);
        
        Emp emp3 = new Emp();
        emp3.setId(30);
        emp3.setNom("Luc");
        emp3.setNombre_membre(2);
        empList.add(emp3);
        
        // Message dynamique basé sur la taille de la liste
        String message = empList.size() + " employé(s) trouvé(s)";
        return JsonResponseWrapper.success(empList, message, 200);
    }
}
