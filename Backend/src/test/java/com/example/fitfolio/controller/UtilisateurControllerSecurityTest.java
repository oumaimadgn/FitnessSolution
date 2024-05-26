package com.example.fitfolio.controller;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.example.fitfolio.dto.AuthentificationDTO;
import com.example.fitfolio.dto.UtilisateurDTO;
import com.example.fitfolio.entity.Utilisateur;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
class UtilisateurControllerSecurityTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    
    //Authentication
    @Test
    void testAuthenticationWithValidCredentials() {
        // Given
        String email = "test@gmail.com";
        String password = "password";
        saveUtilisateur(email, password);

        // When
        ResponseEntity<Utilisateur> response = restTemplate.postForEntity(
                "http://localhost:" + port + "/api/v1/utilisateur/cherche1",
                new AuthentificationDTO(email, password), // Provide correct credentials here
                Utilisateur.class);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    void testAuthenticationWithInvalidCredentials() {
        // Given
        String email = "test@gmail.com";
        String password = "password";
        saveUtilisateur(email, password);

        // When
        ResponseEntity<Utilisateur> response = restTemplate.postForEntity(
                "http://localhost:" + port + "/api/v1/utilisateur/cherche",
                new AuthentificationDTO(email, "wrong_password"),
                Utilisateur.class);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
    }

    @Test
    void testAuthenticationWithoutCredentials() {
        // When
        ResponseEntity<Utilisateur> response = restTemplate.postForEntity(
                "http://localhost:" + port + "/api/v1/utilisateur/cherche",
                new AuthentificationDTO(),
                Utilisateur.class);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
    }

    private void saveUtilisateur(String email, String password) {
        UtilisateurDTO utilisateurDTO = new UtilisateurDTO();
        utilisateurDTO.setEmail(email);
        utilisateurDTO.setMotDePasse(password);
        restTemplate.postForEntity("http://localhost:" + port + "/api/v1/utilisateur/save", utilisateurDTO,
                Utilisateur.class);
    }
}
