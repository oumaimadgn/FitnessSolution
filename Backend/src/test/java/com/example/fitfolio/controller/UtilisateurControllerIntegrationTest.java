package com.example.fitfolio.controller;

import com.example.fitfolio.dto.AuthentificationDTO;
import com.example.fitfolio.dto.UtilisateurDTO;
import com.example.fitfolio.entity.Utilisateur;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
class UtilisateurControllerIntegrationTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    void testRechercheParEmailEndpoint() {
        // Given
        String email = "test2@gmail.com";
        saveUtilisateur(email);

        // When
        ResponseEntity<Utilisateur> response = restTemplate.postForEntity("http://localhost:" + port + "/api/v1/utilisateur/cherche1",
                new HttpEntity<>(new AuthentificationDTO(email, null)), Utilisateur.class);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getEmail()).isEqualTo(email);
    }

    @Test
    void testAuthentificationUtilisateurEndpoint() {
        // Given
        String email = "test2@gmail.com";
        String password = "password";
        saveUtilisateur(email, password);

        // When
        ResponseEntity<Utilisateur> response = restTemplate.withBasicAuth(email, password)
                .postForEntity("http://localhost:" + port + "/api/v1/utilisateur/cherche1",
                new HttpEntity<>(new AuthentificationDTO(email, password)), Utilisateur.class);

        // Then
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody().getEmail()).isEqualTo(email);
    }

    private void saveUtilisateur(String email) {
        UtilisateurDTO utilisateurDTO = new UtilisateurDTO();
        utilisateurDTO.setEmail(email);
        restTemplate.postForEntity("http://localhost:" + port + "/api/v1/utilisateur/save", utilisateurDTO, String.class);
    }

    private void saveUtilisateur(String email, String password) {
        UtilisateurDTO utilisateurDTO = new UtilisateurDTO();
        utilisateurDTO.setEmail(email);
        utilisateurDTO.setMotDePasse(password);
        restTemplate.postForEntity("http://localhost:" + port + "/api/v1/utilisateur/save", utilisateurDTO, String.class);
    }
}
