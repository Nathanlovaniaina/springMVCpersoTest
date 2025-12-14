# Documentation API JSON Response

## Vue d'ensemble

Le framework supporte maintenant les réponses JSON avec l'annotation `@JsonResponse` et la conversion automatique pour les méthodes retournant des objets.

## Annotation @JsonResponse

### Utilisation

```java
@JsonResponse(message = "Message de succès", code = 200)
```

### Paramètres

- **message** (String, optionnel) : Message descriptif pour la réponse (défaut: "Success")
- **code** (int, optionnel) : Code HTTP de la réponse (défaut: 200)

## Formats de Réponse

### 1. Objet Unique

Quand votre méthode retourne un objet unique (POJO):

```json
{
  "status": "success",
  "message": "Employé récupéré avec succès",
  "code": 200,
  "data": {
    "id": 42,
    "nom": "Jean Dupont",
    "nombre_membre": 5,
    "hobbies": [
      {
        "nom": "Tennis",
        "dureer": 10
      }
    ]
  }
}
```

### 2. Liste d'Objets

Quand votre méthode retourne une Collection ou un tableau:

```json
{
  "status": "success",
  "message": "Liste des employés récupérée",
  "code": 200,
  "count": 2,
  "data": [
    {
      "id": 1,
      "nom": "Jean"
    },
    {
      "id": 2,
      "nom": "Sarah"
    }
  ]
}
```

## Exemples d'Utilisation

### Exemple 1: Retourner un objet avec @JsonResponse

```java
@GetRequest("api/emp/single")
@JsonResponse(message = "Employé récupéré avec succès", code = 200)
public Emp getEmpJson() {
    Emp emp = new Emp();
    emp.setId(42);
    emp.setNom("Jean Dupont");
    return emp;
}
```

### Exemple 2: Retourner une liste

```java
@GetRequest("api/emp/list")
@JsonResponse(message = "Liste des employés récupérée", code = 200)
public List<Emp> getEmpListJson() {
    List<Emp> empList = new ArrayList<>();
    // ... ajouter des employés
    return empList;
}
```

### Exemple 3: Retour String (JSON manuel)

Si une méthode retourne une String et que ce n'est pas un ModelView, elle sera automatiquement traitée comme du JSON:

```java
@GetRequest("api/emp/string")
public String getEmpString() {
    return "{\"status\":\"success\",\"data\":{\"test\":\"valeur\"}}";
}
```

### Exemple 4: Gérer les erreurs

```java
@GetRequest("api/emp/error")
@JsonResponse(message = "Erreur simulée", code = 404)
public Emp getEmpError() {
    return null; // Retournera data: null
}
```

## Comportement Automatique

### Sans @JsonResponse

- **Retour ModelView** : Comportement classique (forward vers JSP)
- **Retour String commençant par `{` ou `[`** : Traité comme JSON
- **Autres types** : Erreur de compilation

### Avec @JsonResponse

- **N'importe quel type de retour** est accepté et sérialisé en JSON
- Le framework génère automatiquement la structure avec status, message, code et data
- Support des objets complexes avec réflexion

## Types Supportés

Le `JsonResponseBuilder` supporte automatiquement:

- **Primitives et Wrappers** : int, Integer, long, Long, boolean, Boolean, etc.
- **String**
- **Collections** : List, Set, etc.
- **Arrays** : tableaux de n'importe quel type
- **Maps** : Map<String, Object>, etc.
- **POJOs** : Classes personnalisées avec champs publics ou getters/setters
- **Nested Objects** : Objets imbriqués avec collections, listes, etc.

## Endpoints de Test

Le projet inclut 4 endpoints de test dans `EmpController`:

1. **GET /api/emp/single** - Objet unique avec hobbies
2. **GET /api/emp/list** - Liste de 2 employés
3. **GET /api/emp/string** - JSON manuel via String
4. **GET /api/emp/error** - Test avec data null

## Page de Test

Une page HTML de test est disponible à:
```
http://localhost:8080/teste-framework-1.0.0/test-json.html
```

Cette page permet de tester facilement tous les endpoints avec un affichage formaté des réponses JSON.

## Architecture Technique

### Classes Créées

1. **JsonResponse.java** - Annotation pour marquer les méthodes JSON
   - Package: `com.monframework.core.util.Annotation`

2. **JsonResponseBuilder.java** - Générateur de réponses JSON
   - Package: `com.monframework.core.util`
   - Méthodes utilitaires: `success()`, `error()`, `buildJsonResponse()`

### Modifications

1. **RouteMapping.java**
   - Ajout de `InvokeResult.isJsonResponse()` et `getJsonContent()`
   - Détection de `@JsonResponse` dans `callMethodWithModel()`
   - Support des retours String JSON

2. **ModelView.java**
   - Modification de `getView()` pour écrire directement le JSON dans la réponse
   - Content-Type: `application/json; charset=UTF-8`

3. **ParameterResolver.java**
   - Vérification stricte de `Map<String,Object>` pour l'injection de formulaires

## Notes Importantes

- Les réponses JSON sont automatiquement encodées en UTF-8
- Le Content-Type est automatiquement défini à `application/json`
- Les caractères spéciaux sont correctement échappés (", \, \n, \r, \t)
- Les valeurs null sont sérialisées en `null` JSON
- Les listes vides retournent `"count": 0, "data": []`
