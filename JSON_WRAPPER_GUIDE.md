# Guide JsonResponseWrapper - Messages et Codes Dynamiques

## Vue d'ensemble

`JsonResponseWrapper` permet de définir dynamiquement le **message** et le **code HTTP** dans la méthode du contrôleur, sans avoir à utiliser l'annotation `@JsonResponse`.

## Avantages

✅ **Flexibilité totale** : Message et code définis dans la logique métier  
✅ **Logique conditionnelle** : Différents messages selon les résultats  
✅ **Statuts personnalisés** : "success", "error", "pending", "warning", etc.  
✅ **Codes HTTP appropriés** : 200, 201, 404, 422, 500, etc.

## Différences avec @JsonResponse

| Caractéristique | @JsonResponse | JsonResponseWrapper |
|----------------|---------------|---------------------|
| Message | Fixe dans l'annotation | Dynamique dans la méthode |
| Code HTTP | Fixe dans l'annotation | Dynamique dans la méthode |
| Statut | Toujours "success" | Personnalisable |
| Logique conditionnelle | ❌ Non | ✅ Oui |

## Méthodes Disponibles

### 1. Success avec code 200
```java
JsonResponseWrapper.success(data, "Message de succès")
```

### 2. Success avec code personnalisé
```java
JsonResponseWrapper.success(data, "Ressource créée", 201)
```

### 3. Erreur avec code 400
```java
JsonResponseWrapper.error("Message d'erreur")
```

### 4. Erreur avec code personnalisé
```java
JsonResponseWrapper.error("Non trouvé", 404)
```

### 5. Erreur avec données et code personnalisé
```java
JsonResponseWrapper.error(errorDetails, "Validation échouée", 422)
```

### 6. Réponse personnalisée complète
```java
JsonResponseWrapper.custom(data, "pending", "En attente", 202)
```

## Exemples Pratiques

### Exemple 1: GET Simple avec Message Dynamique

```java
@GetRequest("api/user/{id}")
public JsonResponseWrapper getUser(@PathVariable("id") int id) {
    User user = userService.findById(id);
    
    if (user == null) {
        return JsonResponseWrapper.error("Utilisateur #" + id + " introuvable", 404);
    }
    
    return JsonResponseWrapper.success(user, "Utilisateur trouvé", 200);
}
```

**Réponse si trouvé:**
```json
{
  "status": "success",
  "message": "Utilisateur trouvé",
  "code": 200,
  "data": {
    "id": 5,
    "nom": "Alice"
  }
}
```

**Réponse si non trouvé:**
```json
{
  "status": "error",
  "message": "Utilisateur #5 introuvable",
  "code": 404
}
```

### Exemple 2: POST avec Code 201 (Created)

```java
@PostRequest("api/emp/create")
public JsonResponseWrapper createEmployee(Emp emp) {
    // Validation
    if (emp.getNom() == null || emp.getNom().isEmpty()) {
        return JsonResponseWrapper.error("Le nom est requis", 400);
    }
    
    // Sauvegarde
    emp.setId(employeeService.save(emp));
    
    return JsonResponseWrapper.success(
        emp, 
        "Employé créé avec l'ID " + emp.getId(), 
        201
    );
}
```

**Réponse:**
```json
{
  "status": "success",
  "message": "Employé créé avec l'ID 42",
  "code": 201,
  "data": {
    "id": 42,
    "nom": "Jean Dupont"
  }
}
```

### Exemple 3: Validation avec Erreurs Détaillées (422)

```java
@PostRequest("api/emp/validate")
public JsonResponseWrapper validateEmployee(Emp emp) {
    List<String> errors = new ArrayList<>();
    
    if (emp.getNom() == null || emp.getNom().isEmpty()) {
        errors.add("Le nom est requis");
    }
    if (emp.getNombre_membre() < 0) {
        errors.add("Le nombre de membres doit être positif");
    }
    
    if (!errors.isEmpty()) {
        return JsonResponseWrapper.error(
            errors, 
            "Erreur de validation", 
            422
        );
    }
    
    return JsonResponseWrapper.success(emp, "Validation réussie", 200);
}
```

**Réponse en cas d'erreur:**
```json
{
  "status": "error",
  "message": "Erreur de validation",
  "code": 422,
  "data": [
    "Le nom est requis",
    "Le nombre de membres doit être positif"
  ]
}
```

### Exemple 4: Liste avec Message Dynamique

```java
@GetRequest("api/emp/search")
public JsonResponseWrapper searchEmployees(@RequestParam("name") String name) {
    List<Emp> results = employeeService.searchByName(name);
    
    if (results.isEmpty()) {
        return JsonResponseWrapper.success(
            results, 
            "Aucun employé trouvé pour '" + name + "'", 
            200
        );
    }
    
    String message = results.size() + " employé(s) trouvé(s) pour '" + name + "'";
    return JsonResponseWrapper.success(results, message, 200);
}
```

**Réponse avec résultats:**
```json
{
  "status": "success",
  "message": "3 employé(s) trouvé(s) pour 'Jean'",
  "code": 200,
  "count": 3,
  "data": [...]
}
```

### Exemple 5: Statut Personnalisé (pending)

```java
@PostRequest("api/order/submit")
public JsonResponseWrapper submitOrder(Order order) {
    // Soumettre la commande pour approbation
    order.setStatus("pending");
    orderService.save(order);
    
    return JsonResponseWrapper.custom(
        order,
        "pending",
        "Commande soumise, en attente d'approbation",
        202  // Accepted
    );
}
```

**Réponse:**
```json
{
  "status": "pending",
  "message": "Commande soumise, en attente d'approbation",
  "code": 202,
  "data": {
    "id": 123,
    "status": "pending"
  }
}
```

### Exemple 6: Erreur Serveur (500)

```java
@GetRequest("api/report/generate")
public JsonResponseWrapper generateReport() {
    try {
        Report report = reportService.generate();
        return JsonResponseWrapper.success(report, "Rapport généré", 200);
    } catch (Exception e) {
        return JsonResponseWrapper.error(
            "Erreur lors de la génération du rapport: " + e.getMessage(),
            500
        );
    }
}
```

## Codes HTTP Recommandés

| Code | Signification | Utilisation |
|------|---------------|-------------|
| 200 | OK | Succès général |
| 201 | Created | Ressource créée avec succès |
| 202 | Accepted | Requête acceptée mais en traitement |
| 400 | Bad Request | Erreur de syntaxe ou paramètres invalides |
| 401 | Unauthorized | Authentification requise |
| 403 | Forbidden | Accès interdit |
| 404 | Not Found | Ressource non trouvée |
| 422 | Unprocessable Entity | Erreur de validation métier |
| 500 | Internal Server Error | Erreur serveur |
| 503 | Service Unavailable | Service temporairement indisponible |

## Comparaison Complète

### Avec @JsonResponse (Statique)
```java
@GetRequest("api/emp")
@JsonResponse(message = "Liste des employés", code = 200)
public List<Emp> getAllEmployees() {
    return employeeService.findAll();
}
```
❌ Message et code toujours identiques  
❌ Impossible de gérer les erreurs avec un code différent

### Avec JsonResponseWrapper (Dynamique)
```java
@GetRequest("api/emp")
public JsonResponseWrapper getAllEmployees() {
    List<Emp> employees = employeeService.findAll();
    
    if (employees.isEmpty()) {
        return JsonResponseWrapper.success(
            employees, 
            "Aucun employé dans la base", 
            200
        );
    }
    
    return JsonResponseWrapper.success(
        employees, 
        employees.size() + " employé(s) trouvé(s)", 
        200
    );
}
```
✅ Message adapté au résultat  
✅ Logique conditionnelle possible

## Endpoints de Test

Le projet inclut 10 endpoints de test:

**Tests avec @JsonResponse:**
1. `GET /api/emp/single` - Objet unique
2. `GET /api/emp/list` - Liste
3. `GET /api/emp/string` - JSON manuel
4. `GET /api/emp/error` - Erreur

**Tests avec JsonResponseWrapper:**
5. `GET /api/emp/wrapper-success` - Success simple
6. `GET /api/emp/wrapper-notfound` - Erreur 404
7. `POST /api/emp/wrapper-create` - Création (201)
8. `GET /api/emp/wrapper-validation` - Validation (422)
9. `GET /api/emp/wrapper-custom` - Statut custom (pending)
10. `GET /api/emp/wrapper-list` - Liste avec message dynamique

## Page de Test Interactive

Accédez à la page de test pour essayer tous les endpoints:
```
http://localhost:8080/teste-framework-1.0.0/test-json.html
```

## Bonnes Pratiques

✅ **Utilisez JsonResponseWrapper** quand vous avez besoin de logique conditionnelle  
✅ **Utilisez @JsonResponse** pour les réponses simples et statiques  
✅ **Choisissez le bon code HTTP** selon le contexte  
✅ **Messages clairs** et descriptifs pour le client  
✅ **Gestion d'erreurs** avec codes appropriés (404, 422, 500, etc.)

## Compatibilité

JsonResponseWrapper fonctionne parfaitement avec:
- ✅ Tous les types de retour (POJOs, Lists, Arrays, Maps)
- ✅ Objets imbriqués complexes
- ✅ Méthodes GET, POST, PUT, DELETE
- ✅ Injection de paramètres (Model, HttpServletRequest, etc.)
- ✅ @PathVariable et @RequestParam
