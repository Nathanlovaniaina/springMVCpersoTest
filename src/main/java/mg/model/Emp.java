package mg.model;

import java.util.List;

public class Emp {
    private int id;
    private String nom;
    private int nombre_membre;
    private List<Hobbi> hobbies;

    public Emp() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public int getNombre_membre() { return nombre_membre; }
    public void setNombre_membre(int nombre_membre) { this.nombre_membre = nombre_membre; }

    public List<Hobbi> getHobbies() { return hobbies; }
    public void setHobbies(List<Hobbi> hobbies) { this.hobbies = hobbies; }
}