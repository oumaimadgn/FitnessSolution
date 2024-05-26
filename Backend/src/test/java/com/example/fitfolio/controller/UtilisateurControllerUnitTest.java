package com.example.fitfolio.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.example.fitfolio.dto.AuthentificationDTO;
import com.example.fitfolio.dto.UtilisateurDTO;
import com.example.fitfolio.entity.Utilisateur;
import com.example.fitfolio.repository.PlanRepasRepo;
import com.example.fitfolio.service.UtilisateurService;

@ExtendWith(MockitoExtension.class)
class UtilisateurControllerUnitTest {

    @Mock
    private UtilisateurService utilisateurService;
    
    @Mock
    private PlanRepasRepo planRepasRepo;

    @InjectMocks
    private UtilisateurController utilisateurController;

    @Test
    void testAuthentificationUtilisateur1_ValidCredentials() {
        // Arrange
        AuthentificationDTO authentificationDTO = new AuthentificationDTO();
        authentificationDTO.setEmail("test@example.com");
        authentificationDTO.setMotDePasse("password");
        Utilisateur utilisateur = new Utilisateur();
        when(utilisateurService.findByEmailAndMotdepasse(anyString(), anyString())).thenReturn(utilisateur);

        // Act
        ResponseEntity<Utilisateur> responseEntity = utilisateurController.authentificationUtilisateur1(authentificationDTO);

        // Assert
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(utilisateur, responseEntity.getBody());
    }

    @Test
    void testSaveUtilisateur() {
        // Arrange
        UtilisateurDTO utilisateurDTO = new UtilisateurDTO();
        utilisateurDTO.setNom("John");
        utilisateurDTO.setPrenom("Doe");
        Utilisateur utilisateur = new Utilisateur();
        when(utilisateurService.addUtilisateurU(any())).thenReturn(utilisateur);

        // Act
        ResponseEntity<Utilisateur> responseEntity = utilisateurController.saveUtilisateur(utilisateurDTO);

        // Assert
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(utilisateur, responseEntity.getBody());
    }

    @Test
    void testRechercheParEmail_ExistingEmail() {
        // Arrange
        AuthentificationDTO authentificationDTO = new AuthentificationDTO();
        authentificationDTO.setEmail("test@example.com");
        Utilisateur utilisateur = new Utilisateur();
        when(utilisateurService.findByEmail(anyString())).thenReturn(utilisateur);

        // Act
        ResponseEntity<Utilisateur> responseEntity = utilisateurController.rechercheParEmail(authentificationDTO);

        // Assert
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(utilisateur, responseEntity.getBody());
    }

    @Test
    void testEditUtilisateur() {
        // Arrange
        UtilisateurDTO utilisateurDTO = new UtilisateurDTO();
        utilisateurDTO.setMatricule(1L);
        utilisateurDTO.setEmail("test@example.com");
        when(utilisateurService.updateUtilisateurByMatricule(any())).thenReturn("Update successful");

        // Act
        String response = utilisateurController.editUtilisateur(utilisateurDTO);

        // Assert
        assertEquals("Update successful", response);
    }
    
}
