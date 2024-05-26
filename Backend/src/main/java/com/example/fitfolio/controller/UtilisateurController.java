package com.example.fitfolio.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.fitfolio.dto.AuthentificationDTO;
import com.example.fitfolio.dto.UtilisateurDTO;
import com.example.fitfolio.entity.Activite;
import com.example.fitfolio.entity.Repas;
import com.example.fitfolio.entity.Utilisateur;
import com.example.fitfolio.repository.ActiviteRepo;
import com.example.fitfolio.repository.RepasRepo;
import com.example.fitfolio.repository.UtilisateurRepo;
import com.example.fitfolio.repository.DateERepo;
import com.example.fitfolio.repository.PlanActiviteRepo;
import com.example.fitfolio.repository.PlanRepasRepo;
import com.example.fitfolio.service.UtilisateurService;

@RestController
@CrossOrigin
@RequestMapping("api/v1/utilisateur")
public class UtilisateurController {

	@Autowired
    private ActiviteRepo activiteRepository;
    
    @Autowired
    private RepasRepo repasRepository;
    @Autowired
    private  PlanRepasRepo    planRepasRepo ;
    
    @Autowired
    private  PlanActiviteRepo   planActiviteRepo;
    
    @Autowired
    private  UtilisateurRepo   utilisateurRepo;
    

    @Autowired
    private UtilisateurService utilisateurService;
    @Autowired
    private DateERepo  dateERepo;
    

    @PostMapping(path = "/cherche")
    public ResponseEntity<Utilisateur> authentificationUtilisateur1(@RequestBody AuthentificationDTO authentificationDTO) {
        String email = authentificationDTO.getEmail();
        String motDePasse = authentificationDTO.getMotDePasse(); 
        Utilisateur utilisateur = utilisateurService.findByEmailAndMotdepasse(email, motDePasse); 
        
        if (utilisateur != null) {
            return ResponseEntity.ok(utilisateur);
        } else {
            
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }
    }
 @PostMapping(path = "/saveleila")
    public ResponseEntity<Utilisateur> saveUtilisateurleila(@RequestBody UtilisateurDTO utilisateurDTO) {
        System.out.println("Creation d'un nouveau Utilisateur!");
        // Suivre les interactions avec le frontend via la console du serveur backend
       Utilisateur utilisateur = utilisateurService.addUtilisateurleila(utilisateurDTO);
    // Afficher un message indiquant la création d'un utilisateur avec son adresse email sur console
       System.out.println("Création Utilisateur !" + utilisateur.getEmail());
        return ResponseEntity.ok(utilisateur);
    }

@PostMapping(path = "/cherche1")
public ResponseEntity<Utilisateur> rechercheParEmail(@RequestBody AuthentificationDTO authentificationDTO) {
    String email = authentificationDTO.getEmail();

    // Afficher l'en-tête de la requête envoyée par le frontend
    System.out.println("Demande de recherche par email : " + email);

    // Rechercher l'utilisateur par email dans la base de données
    Utilisateur utilisateur = utilisateurService.findByEmail(email);

    if (utilisateur != null) {
        // Retourner l'utilisateur trouvé s'il existe
        return ResponseEntity.ok(utilisateur);
    } else {
        // Retourner une erreur 500 si aucun utilisateur n'est trouvé
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
}

@PostMapping("/addPlanRepas")
public ResponseEntity<String> addPlanRepas(@RequestBody Map<String, Object> request) {
    try {
        // Récupérer le matricule de la requête
        Integer matricule = (Integer) request.get("matricule");

        // Trouver l'utilisateur associé au matricule
        Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());

        // Obtenir l'objectif de l'utilisateur
        String objectif = utilisateurService.findObjectif(utilisateur);

        // Récupérer les informations sur la période de planification des repas de l'utilisateur
        Long idDateU = utilisateur.getId_date().getIdDate();
        String DateD = utilisateur.getId_date().getDateDebut();
        String DateF = utilisateur.getId_date().getDateFin();

        LocalDate dateDebut = LocalDate.parse(DateD);
        LocalDate dateFin = LocalDate.parse(DateF);

        long nombreDeJours = dateFin.toEpochDay() - dateDebut.toEpochDay() + 1;

        List<Long> BreakfastIds = getRepasIds("Breakfast", objectif, DateD, DateF);
        List<Long> LunchIds = getRepasIds("Lunch", objectif, DateD, DateF);
        List<Long> DinnerIds = getRepasIds("Dinner", objectif, DateD, DateF);

        // Parcourir chaque jour pour créer un plan de repas
        for (int i = 0; i < nombreDeJours; i++) {
            LocalDate date = dateDebut.plusDays(i);
            String dateString = date.toString();

            Long fkRepaId = BreakfastIds.get(i);
            planRepasRepo.insertPlanRepas(dateString, idDateU, fkRepaId);

            // Insérer un plan de repas pour le déjeuner
            fkRepaId = LunchIds.get(i);
            planRepasRepo.insertPlanRepas(dateString, idDateU, fkRepaId);

            // Insérer un plan de repas pour le dîner
            fkRepaId = DinnerIds.get(i);
            planRepasRepo.insertPlanRepas(dateString, idDateU, fkRepaId);

            // Afficher les informations pour chaque plan de repas ajouté
            System.out.println("idDateU " + idDateU);
            System.out.println("fkRepaId " + fkRepaId);
            System.out.println("dateString " + dateString);
        }

        return ResponseEntity.ok("Plan de repas ajouté avec succès.");
    } catch (Exception e) {
    	// En cas d'erreur, retourner une réponse avec un code d'erreur interne du serveur pour les besoins de débogage
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Une erreur s'est produite lors de l'enregistrement du plan de repas.");
    }
}

    public List<Long> getRepasIds(String categorie, String type, String debut, String fin) {
        LocalDate dateDebut = LocalDate.parse(debut);
        LocalDate dateFin = LocalDate.parse(fin);

        long nombreDeJours = dateFin.toEpochDay() - dateDebut.toEpochDay() + 1;
        List<Long> repasIds = new ArrayList<>();
        Random random = new Random();

        for (int i = 0; i < nombreDeJours; i++) {
            List<Long> repasIdsForDay = repasRepository.findByCategorieAndType(categorie, type);
            if (!repasIdsForDay.isEmpty()) {
                Long repasId = repasIdsForDay.get(random.nextInt(repasIdsForDay.size()));
                repasIds.add(repasId);
            }
        }

        return repasIds;
    }

    @PostMapping("/fetchRepas")
    public ResponseEntity<List<Repas>> fetchRepa(@RequestBody Map<String, Object> request) {
        try {
            // Récupérer le matricule de l'utilisateur à partir de la requête
            Integer matricule = (Integer) request.get("matricule");
             // Récupérer la date spécifique demandée dans la requête
            String date = (String) request.get("date");
            // Trouver l'utilisateur correspondant au matricule
            Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());

            // Récupérer l'identifiant de la date de l'utilisateur
            Long idDateU = utilisateur.getId_date().getIdDate();

            // Récupérer les dates de début et de fin de la période
            String Debut = utilisateur.getId_date().getDateDebut();
            String Fin = utilisateur.getId_date().getDateFin();

             // Formatter les dates pour les comparer facilement
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateCourante = LocalDate.parse(date, formatter);
            LocalDate datedebut = LocalDate.parse(Debut, formatter);
            LocalDate datefin = LocalDate.parse(Fin, formatter);

            // Déterminer le début et la fin de la semaine
            LocalDate lundi = dateCourante.with(DayOfWeek.MONDAY);
            LocalDate dimanche = dateCourante.with(DayOfWeek.SUNDAY);
            String Stringlundi = lundi.toString();
            String Stringdimanche = dimanche.toString();

            // Récupérer les références des repas pour la semaine actuelle
            List<Long> repasReferences = planRepasRepo.findRepasByDateRange(idDateU, Stringlundi, Stringdimanche);
            List<Repas> repasList = new ArrayList<>();

            // Ajouter chaque repas à la liste
            for (Long repasRef : repasReferences) {
                Repas repas = repasRepository.findById(repasRef).orElse(null);
                if (repas != null) {
                    repasList.add(repas);
                }
            }

            // Calculer le nombre de repas manquants pour remplir une semaine
            int nbrRepasVide = 21 - repasReferences.size();

            // Ajouter des repas vides au début de la semaine si nécessaire
            if (ChronoUnit.WEEKS.between(datedebut, dateCourante) < 1) {
                for (int i = 0; i < nbrRepasVide; i++) {
                    repasList.add(0, new Repas());
                }
            }

            // Ajouter des repas vides à la fin de la semaine si nécessaire
            if (ChronoUnit.WEEKS.between(dateCourante, datefin) < 1) {
                for (int i = 0; i < nbrRepasVide; i++) {
                    repasList.add(new Repas());
                }
            }

            // Retourner la liste des repas de la semaine
            return ResponseEntity.ok(repasList);
        } catch (Exception e) {
            // Retourner une erreur interne du serveur en cas d'exception
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/fetchRepajour")
    public ResponseEntity<List<Repas>> fetchRepajour(@RequestBody Map<String, Object> request) {
        try {
            // Récupérer le matricule de l'utilisateur à partir de la requête
            Integer matricule = (Integer) request.get("matricule");

            // Trouver l'utilisateur correspondant au matricule
            Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());

            // Récupérer l'identifiant de la date de l'utilisateur
            Long idDateU = utilisateur.getId_date().getIdDate();

            // Récupérer la date spécifique demandée dans la requête
            String date = (String) request.get("date");

            // Récupérer les références des repas pour la date spécifique
            List<Long> repasReferences = planRepasRepo.findRepasByDateandDateJ(idDateU, date);
            List<Repas> repasList = new ArrayList<>();

            // Ajouter chaque repas à la liste
            for (Long repasRef : repasReferences) {
                Repas repas = repasRepository.findById(repasRef).orElse(null);
                if (repas != null) {
                    repasList.add(repas);
                }
            }

            // Retourner la liste des repas pour la date spécifique
            return ResponseEntity.ok(repasList);
        } catch (Exception e) {
            // Retourner une erreur interne du serveur en cas d'exception
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @PostMapping("/deleteRepas")
    public ResponseEntity<String> deletePlanRepas(@RequestBody Map<String, Object> request) {
        try {
            // Récupérer le matricule de l'utilisateur à partir de la requête
            Integer matricule = (Integer) request.get("matricule");

            // Trouver l'utilisateur correspondant au matricule
            Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());

            // Récupérer l'identifiant de la date de l'utilisateur
            Long idDateU = utilisateur.getId_date().getIdDate();

            // Supprimer les plans de repas pour l'utilisateur pour la date spécifiée
            planRepasRepo.deletePlanRepasByDateId(idDateU);

            // Retourner un message de succès si la suppression est réussie
            return ResponseEntity.ok("Suppression réussie.");
        } catch (Exception e) {
            // Retourner un message d'erreur en cas d'échec de la suppression
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Échec de la suppression.");
        }
    }

    @PostMapping("/addPlanActivite")
    public ResponseEntity<String> addPlanActivite(@RequestBody Map<String, Object> request) {
        try {
            // Récupérer le matricule de l'utilisateur à partir de la requête
            Integer matricule = (Integer) request.get("matricule");

            // Trouver l'utilisateur correspondant au matricule
            Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());

            // Obtenir l'objectif de l'utilisateur
            String objectif = utilisateurService.findObjectif(utilisateur);

            // Récupérer les informations sur la période de planification des activités de l'utilisateur
            Long idDateU = utilisateur.getId_date().getIdDate();
            String DateD = utilisateur.getId_date().getDateDebut();
            String DateF = utilisateur.getId_date().getDateFin();
            LocalDate dateDebut = LocalDate.parse(DateD);
            LocalDate dateFin = LocalDate.parse(DateF);

            // Calculer le nombre de jours dans la période de planification
            long nombreDeJours = dateFin.toEpochDay() - dateDebut.toEpochDay() + 1;

            // Récupérer les identifiants des activités à planifier
            List<Long> activiteIds = getActiviteIds(objectif, DateD, DateF);
            System.out.println("idDateU " +activiteIds.get(1));

            // Parcourir chaque jour pour créer un plan d'activité
            for (int i = 0; i < nombreDeJours; i++) {
                LocalDate date = dateDebut.plusDays(i);
                String dateString = date.toString();

                Long fkRepaId = activiteIds.get(i);

                // Insérer un plan d'activité pour chaque jour de la période
                planActiviteRepo.insertPlanActivite(dateString, idDateU, fkRepaId);
            }

            // Retourner un message de succès une fois que tous les plans d'activité sont ajoutés
            return ResponseEntity.ok("Plan d'activité ajouté avec succès.");
        } catch (Exception e) {
            // Retourner un message d'erreur en cas d'échec de l'ajout du plan d'activité
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Une erreur s'est produite lors de l'enregistrement du plan d'activité.");
        }
    }
    public List<Long> getActiviteIds( String type, String debut, String fin) {
        LocalDate dateDebut = LocalDate.parse(debut);
        LocalDate dateFin = LocalDate.parse(fin);

        long nombreDeJours = dateFin.toEpochDay() - dateDebut.toEpochDay() + 1;
        List<Long> activiteIds = new ArrayList<>();
        Random random = new Random();

        for (int i = 0; i < nombreDeJours; i++) {
            List<Long> activiteIdsForDay = activiteRepository.findByType(type);
            if (!activiteIdsForDay.isEmpty()) {
                Long activiteId = activiteIdsForDay.get(random.nextInt(activiteIdsForDay.size()));
                activiteIds.add(activiteId);
            }
        }

        return activiteIds;
    }

    @PostMapping("/fetchActivite")
    public ResponseEntity<List<Activite>> fetchActivite(@RequestBody Map<String, Object> request) {
        try {
            Integer matricule = (Integer) request.get("matricule");
            Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());
            Long idDateU = utilisateur.getId_date().getIdDate();
            String date = (String) request.get("date");
            String Debut = utilisateur.getId_date().getDateDebut();
            String Fin = utilisateur.getId_date().getDateFin();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateCourante = LocalDate.parse(date, formatter);
            LocalDate datedebut = LocalDate.parse(Debut, formatter);
            LocalDate datefin = LocalDate.parse(Fin, formatter);
            LocalDate lundi = dateCourante.with(DayOfWeek.MONDAY);
            LocalDate dimanche = dateCourante.with(DayOfWeek.SUNDAY);
            String Stringlundi = lundi.toString();
            String Stringdimanche = dimanche.toString();
            List<Long> activiteReferences = planActiviteRepo.findActiviteByDateRange(idDateU,  Stringlundi,  Stringdimanche);
            List<Activite> activiteList = new ArrayList<>();

            for (Long activiteRef : activiteReferences) {
                Activite activite = activiteRepository.findById(activiteRef).orElse(null);
                if (activite != null) {
                        activiteList.add(activite);
                }
            }

            int nbrActiviteVide = 7 - activiteReferences.size();

            if (ChronoUnit.WEEKS.between(datedebut,dateCourante) < 1) {
                for (int i = 0; i < nbrActiviteVide; i++) {
                        activiteList.add(0, new Activite());
                }
            }

            if (ChronoUnit.WEEKS.between(dateCourante, datefin) < 1) {
                for (int i = 0; i < nbrActiviteVide; i++) {
                        activiteList.add(new Activite());
                }
            }

            return ResponseEntity.ok(activiteList);
        } catch (Exception e) {

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/fetchActivitejour")
    public ResponseEntity<List<Activite>> fetchActivitejour(@RequestBody Map<String, Object> request) {
        try {
            Integer matricule = (Integer) request.get("matricule");
            Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());
            Long idDateU = utilisateur.getId_date().getIdDate();
            String date = (String) request.get("date");

            List<Long> activiteReferences = planActiviteRepo.findActiviteByDateandDateJ(idDateU, date);
            List<Activite> activiteList = new ArrayList<>();

            for (Long activiteRef : activiteReferences) {
                Activite activite = activiteRepository.findById(activiteRef).orElse(null);
                if (activite != null) {
                    activiteList.add(activite);
                }
            }

            return ResponseEntity.ok(activiteList);
        } catch (Exception e) {

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/addDate")
    public ResponseEntity<Map<String, Long>> addDate(@RequestBody Map<String, Object> request) {
        Map<String, Long> response = new HashMap<>();
        try {
            Integer matricule = (Integer) request.get("matricule");
            String dateDebut = (String) request.get("dateDebut");
            String dateFin = (String) request.get("dateFin");
            dateERepo.addDate(dateDebut, dateFin, (long) matricule);
            Long idDate = dateERepo.findByMatricule((long) matricule);
            response.put("idDate", idDate);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

@PostMapping("/dateE")
public ResponseEntity<String> updateUtilisateurDateE(@RequestBody Map<String, Object> request) {

      int matricule = (int) request.get("matricule");
      int dateE = (int) request.get("dateE");;

    try {
        utilisateurRepo.updateUtilisateurDateE((long) dateE,(long)matricule);
        return ResponseEntity.ok("Update successful for user with matricule: " + matricule);
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating user with matricule: " + matricule);
    }
}

@PutMapping(path = "/edit")
public String editUtilisateur(@RequestBody UtilisateurDTO utilisateurDTO) {

    return utilisateurService.updateUtilisateurByMatricule(utilisateurDTO);
}

@PostMapping("/deleteActivite")
public ResponseEntity<String> deletePlanActivite(@RequestBody Map<String, Object> request) {

    try {
        Integer matricule = (Integer) request.get("matricule");
        Utilisateur utilisateur = utilisateurService.findByMatricule(matricule.longValue());
        Long idDateU = utilisateur.getId_date().getIdDate();
        planActiviteRepo.deletePlanActiviteByDateId(idDateU);
        return ResponseEntity.ok("Delete passed successfully.");
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Delete failed.");
    }
}
}

