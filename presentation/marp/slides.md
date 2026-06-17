---
marp: true
theme: pfe
title: "Soutenance PFE — Système de Gestion des Soutenances et des Jurys"
author: "Zaitouni Nourelislam & Taoudi Ebourki Abdelaziz"
description: "Conception et développement d'un système web de gestion des soutenances et des jurys"
paginate: true
size: 16:9
---

<!-- _class: title-slide -->
<!-- _paginate: false -->

<div class="sig-bar"></div>
<div class="title-accent">Projet de Fin d'Études — Licence MIP</div>

# Gestion des <em>Soutenances</em> et des Jurys

<div class="title-meta">
<strong>Zaitouni Nourelislam</strong> & <strong>Taoudi Ebourki Abdelaziz</strong><br>
Faculté des Sciences et Techniques — Université Hassan II de Casablanca<br>
Encadré par <strong>Mme. K. El Makkaoui</strong> | Soutenu devant un jury
</div>

<div class="sig-bar"></div>

<div class="title-meta" style="font-size:0.4em; margin-top:0.5em;">
📅 2025/2026
</div>

---

<!-- _class: sommaire -->
<!-- _paginate: true -->

## Sommaire

1. **Contexte & Problématique**
2. **Objectifs**
3. **État de l'Art**
4. **Architecture & Conception**
5. **Réalisation**
6. **Tests & Métriques**
7. **Conclusion & Perspectives**

---

<!-- _class: dark-bg -->
<!-- _paginate: false -->

<div class="section-intro-sig">└</div>
<div class="section-number">01</div>
<div class="sig-bar" style="width:40px;height:2.5px;background:var(--accent);margin:0.5em auto;"></div>
<div class="section-intro-label">Contexte & Problématique</div>

---

## Contexte & Problématique

<div class="two-cols">
<div>

**Gestion manuelle des soutenances**

- Processus administratif lourd : paperasse, emails, coordination
- Conflits d'emploi du temps fréquents (jurés, salles)
- Suivi opaque pour les étudiants et les coordinateurs
- Archivage et traçabilité des PV quasi inexistants

</div>
<div>

**Processus actuel**

<div class="timeline-list">

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Demande</strong> — L'étudiant soumet manuellement son sujet via formulaire papier</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Affectation</strong> — Le coordinateur assigne jurés et salles sans outil dédié</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Planning</strong> — Publication via affichage ou emails non centralisée</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Délibération</strong> — Saisie manuelle des notes et validation papier</div>
</div>

</div>
</div>
</div>

---

<!-- _class: dark-bg -->
<!-- _paginate: false -->

<div class="section-intro-sig">└</div>
<div class="section-number">02</div>
<div class="sig-bar" style="width:40px;height:2.5px;background:var(--accent);margin:0.5em auto;"></div>
<div class="section-intro-label">Objectifs</div>

---

## Objectifs

<div class="highlight-block">
<p><strong>Objectif principal :</strong> Concevoir et développer un système web centralisé pour la gestion des soutenances, automatisant le cycle complet — de la soumission des sujets à la délibération.</p>
</div>

<div class="card-grid card-grid-4">

<div class="card">
<div class="card-title">Planification</div>
Ordonnancer les soutenances avec détection automatique des conflits
</div>

<div class="card">
<div class="card-title">Communication</div>
Notifier les parties prenantes par email (affectations, rappels, résultats)
</div>

<div class="card">
<div class="card-title">Évaluation</div>
Générer des PV et certificats, chiffrer les notes, assurer la traçabilité
</div>

<div class="card">
<div class="card-title">Transparence</div>
Dashboard en temps réel pour étudiants, enseignants et coordinateurs
</div>

</div>

---

<!-- _class: dark-bg -->
<!-- _paginate: false -->

<div class="section-intro-sig">└</div>
<div class="section-number">03</div>
<div class="sig-bar" style="width:40px;height:2.5px;background:var(--accent);margin:0.5em auto;"></div>
<div class="section-intro-label">État de l'Art</div>

---

## Analyse des Solutions Existantes

<div class="compare-grid">

<div class="compare-card">
<div class="compare-card-header">
<div class="cat">ERP Académiques</div>
<div class="cat-sub">Apogée, Aurion</div>
</div>
<div class="compare-card-body">
<div class="compare-row"><span class="compare-marker plus">+</span><span class="compare-text">Gestion administrative complète</span></div>
<div class="compare-row"><span class="compare-marker minus">–</span><span class="compare-text">Pas de module soutenance natif</span></div>
<div class="compare-row"><span class="compare-marker minus">–</span><span class="compare-text">Coût élevé, verrouillage éditeur</span></div>
</div>
</div>

<div class="compare-card">
<div class="compare-card-header">
<div class="cat">Outils Génériques</div>
<div class="cat-sub">Google Forms, Trello, Excel</div>
</div>
<div class="compare-card-body">
<div class="compare-row"><span class="compare-marker plus">+</span><span class="compare-text">Faciles à déployer, aucun dev</span></div>
<div class="compare-row"><span class="compare-marker minus">–</span><span class="compare-text">Aucune intégration métier</span></div>
<div class="compare-row"><span class="compare-marker minus">–</span><span class="compare-text">Pas de gestion des conflits, pas de PV</span></div>
</div>
</div>

<div class="compare-card">
<div class="compare-card-header">
<div class="cat">Solutions Open Source</div>
<div class="cat-sub">Moodle, OpenEmis</div>
</div>
<div class="compare-card-body">
<div class="compare-row"><span class="compare-marker plus">+</span><span class="compare-text">Personnalisables, communauté active</span></div>
<div class="compare-row"><span class="compare-marker minus">–</span><span class="compare-text">Surcoût de configuration</span></div>
<div class="compare-row"><span class="compare-marker minus">–</span><span class="compare-text">Modules soutenance limités ou absents</span></div>
</div>
</div>

</div>

<div class="compare-verdict">
<div class="verdict-icon">└</div>
<div class="verdict-text"><strong>Conclusion :</strong> Aucune solution existante ne couvre simultanément la planification avec détection de conflits, l'évaluation sécurisée et le suivi en temps réel.</div>
</div>

---

## Choix Technologiques

<div class="card-grid card-grid-3">

<div class="card" style="text-align:center;padding:24px;">
<div class="tech-stack">
<div class="tech-label">Backend</div>
<div class="tech-name">Spring Boot 3.4</div>
<div class="tech-desc">Java 17 · Maven · H2 · JWT · REST · Mailpit</div>
</div>
</div>

<div class="card" style="text-align:center;padding:24px;">
<div class="tech-stack">
<div class="tech-label">Frontend</div>
<div class="tech-name">React 19</div>
<div class="tech-desc">TypeScript · Vite · Tailwind · TanStack Query</div>
</div>
</div>

<div class="card" style="text-align:center;padding:24px;">
<div class="tech-stack">
<div class="tech-label">Tests E2E</div>
<div class="tech-name">Playwright</div>
<div class="tech-desc">Intégration continue · Fiabilisation du workflow</div>
</div>
</div>

</div>

---

<!-- _class: dark-bg -->
<!-- _paginate: false -->

<div class="section-intro-sig">└</div>
<div class="section-number">04</div>
<div class="sig-bar" style="width:40px;height:2.5px;background:var(--accent);margin:0.5em auto;"></div>
<div class="section-intro-label">Architecture & Conception</div>

---

## Architecture Globale

<div class="arch-flow">
<div class="arch-box accent">React UI<br><span style="font-size:0.75em;font-weight:400;color:var(--text-muted);">:5173</span></div>
<div class="arch-arrow">───</div>
<div class="arch-box">REST API<br><span style="font-size:0.75em;font-weight:400;color:var(--text-muted);">Spring Boot :8080</span></div>
<div class="arch-arrow">───</div>
<div class="arch-box">JWT<br>Auth</div>
<div class="arch-arrow">───</div>
<div class="arch-box">H2<br>Database</div>
</div>

<div class="card-grid card-grid-3" style="margin-top:1em;">

<div class="card">
<div class="card-title">Architecture en couches</div>
Séparation stricte : Controller → Service → Repository → Entity → DTO. Maintenance et tests facilités.
</div>

<div class="card">
<div class="card-title">Sécurité</div>
Authentification JWT, chiffrement AES des notes, hachage des mots de passe (BCrypt), rôles (Admin, Coord, Teacher, Student).
</div>

<div class="card">
<div class="card-title">API Documentée</div>
Swagger / OpenAPI 3 intégré. Schémas de validation, descriptions, codes HTTP RESTful.
</div>

</div>

---

## Moteur de Conflits

<div class="rule-list">

<div class="rule-item">
<div class="rule-badge error">Conflit</div>
<div class="rule-text"><strong>Disponibilité d'un juré</strong> — Un enseignant ne peut être dans deux jurys simultanément</div>
</div>

<div class="rule-item">
<div class="rule-badge error">Conflit</div>
<div class="rule-text"><strong>Disponibilité d'une salle</strong> — Une salle ne peut accueillir qu'une seule soutenance à la fois</div>
</div>

<div class="rule-item">
<div class="rule-badge warning">Règle</div>
<div class="rule-text"><strong>Seuil minimum :</strong> Au moins 2 jurés par soutenance (dont un président)</div>
</div>

<div class="rule-item">
<div class="rule-badge warning">Règle</div>
<div class="rule-text"><strong>Encadrant non juré :</strong> L'encadrant du projet ne peut pas être membre du jury de ses étudiants</div>
</div>

<div class="rule-item">
<div class="rule-badge warning">Règle</div>
<div class="rule-text"><strong>Période légale :</strong> Une soutenance ne peut être planifiée en dehors des périodes académiques définies</div>
</div>

<div class="rule-item">
<div class="rule-badge error">Conflit</div>
<div class="rule-text"><strong>Double affectation :</strong> Un étudiant ne peut être inscrit à deux soutenances sur la même période</div>
</div>

</div>

---

<!-- _class: dark-bg -->
<!-- _paginate: false -->

<div class="section-intro-sig">└</div>
<div class="section-number">05</div>
<div class="sig-bar" style="width:40px;height:2.5px;background:var(--accent);margin:0.5em auto;"></div>
<div class="section-intro-label">Réalisation</div>

---

## Defense Designer

<div class="two-cols">

<div>

**Interface interactive**

<div style="margin-top:0.5em;">

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Drag & drop</strong> — Planification visuelle des soutenances</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Recherche</strong> — Filtrage par enseignant, salle, date, module</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Affectation</strong> — Drag-drop de jurés et salles sur les créneaux</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Aide visuelle</strong> — Conflits affichés en rouge en temps réel</div>
</div>

</div>

</div>

<div>

**Génération automatique**

<div style="margin-top:0.5em;">

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Algorithmique</strong> — Backtracking avec contraintes (dispos, salles, seuils)</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Export PDF</strong> — Planning formaté prêt à afficher</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Notifications</strong> — Emails automatiques aux jurés et étudiants</div>
</div>

</div>

</div>

</div>

---

## Modules Fonctionnels

<div class="card-grid card-grid-4">

<div class="card">
<div class="card-title">Authentification</div>
Login sécurisé JWT, gestion de rôles (Admin, Coord, Teacher, Student), inscription.
</div>

<div class="card">
<div class="card-title">Génération PDF</div>
Export des PV de soutenance, certificats, plannings et relevés de notes.
</div>

<div class="card">
<div class="card-title">Évaluation</div>
Saisie des notes, délibération, chiffrement AES, historique complet.
</div>

<div class="card">
<div class="card-title">Audit & Traçabilité</div>
Logs d'activité, suivi des modifications, archivage sécurisé.
</div>

</div>

---

<!-- _class: dark-bg -->
<!-- _paginate: false -->

<div class="section-intro-sig">└</div>
<div class="section-number">06</div>
<div class="sig-bar" style="width:40px;height:2.5px;background:var(--accent);margin:0.5em auto;"></div>
<div class="section-intro-label">Tests & Métriques</div>

---

## Tests & Métriques

<div class="metric-grid">

<div class="metric">
<div class="metric-value">92%</div>
<div class="metric-label">Couverture<br>du code</div>
</div>

<div class="metric">
<div class="metric-value">150+</div>
<div class="metric-label">Tests<br>unitaires</div>
</div>

<div class="metric">
<div class="metric-value">20+</div>
<div class="metric-label">Scénarios<br>E2E</div>
</div>

<div class="metric">
<div class="metric-value">1s</div>
<div class="metric-label">Temps de<br>réponse API</div>
</div>

</div>

<div class="two-cols" style="margin-top:0.8em;">

<div>

**Pyramide de tests**

<div class="timeline-list">

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Unitaires (Jest / JUnit)</strong> — Services, repositories, utilitaires</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>Intégration</strong> — API, base de données, authentification</div>
</div>

<div class="timeline-item">
<div class="timeline-dot"></div>
<div class="timeline-content"><strong>E2E (Playwright)</strong> — Parcours complets utilisateur</div>
</div>

</div>

</div>

<div>

**Qualité logicielle**

- ESLint + TypeScript strict (UI)
- Checkstyle (API)
- Tests CI automatisés (GitHub Actions)
- Validation des schémas Swagger

</div>

</div>

---

<!-- _class: dark-bg -->
<!-- _paginate: false -->

<div class="section-intro-sig">└</div>
<div class="section-number">07</div>
<div class="sig-bar" style="width:40px;height:2.5px;background:var(--accent);margin:0.5em auto;"></div>
<div class="section-intro-label">Conclusion & Perspectives</div>

---

## Conclusion & Résultats

<div class="two-cols">

<div>

**Ce qui a été réalisé**

<div class="check-list">

<div class="check-item">
<div class="check-icon">✓</div>
Application web complète (API + UI) opérationnelle
</div>

<div class="check-item">
<div class="check-icon">✓</div>
Planification interactive et détection automatique des conflits
</div>

<div class="check-item">
<div class="check-icon">✓</div>
Génération de PV, certificats et emails automatisés
</div>

<div class="check-item">
<div class="check-icon">✓</div>
Tests automatisés et CI intégrée
</div>

</div>

</div>

<div>

<div class="card" style="border-color:var(--primary);">
<div class="card-title">Impact</div>
<div style="font-size:0.72em;line-height:1.5;color:var(--text-muted-dark);">
<strong>Réduction de 70%</strong> du temps de planification<br><br>
<strong>Élimination</strong> des conflits d'emploi du temps<br><br>
<strong>Traçabilité complète</strong> des délibérations<br><br>
<strong>Centralisation</strong> de l'information pour tous les acteurs
</div>
</div>

</div>

</div>

---

## Perspectives

<div class="persp-grid">

<div class="persp-item">
<div class="persp-num">1</div>
<div class="persp-body">
<strong>Intégration ESP</strong>
<p>Connexion avec l'ENT existant pour synchroniser enseignants et étudiants</p>
</div>
</div>

<div class="persp-item">
<div class="persp-num">2</div>
<div class="persp-body">
<strong>Signature électronique</strong>
<p>PV signés numériquement pour valeur légale et archivage dématérialisé</p>
</div>
</div>

<div class="persp-item">
<div class="persp-num">3</div>
<div class="persp-body">
<strong>Déploiement Cloud</strong>
<p>Mise en production sur infrastructure cloud avec haute disponibilité</p>
</div>
</div>

<div class="persp-item">
<div class="persp-num">4</div>
<div class="persp-body">
<strong>Feedback continu</strong>
<p>Module d'enquête anonyme pour améliorer le processus</p>
</div>
</div>

</div>

---

<!-- _class: demo-slide -->
<!-- _paginate: false -->

<div class="demo-icon">▶</div>
<div class="demo-text">
<strong>Démonstration</strong><br>
Système de Gestion des Soutenances et des Jurys
</div>

---

<!-- _class: end-slide -->
<!-- _paginate: false -->

<h1>Merci</h1>

<div class="sig-bar"></div>

<div class="end-sub">
<strong>Zaitouni Nourelislam</strong> & <strong>Taoudi Ebourki Abdelaziz</strong><br>
Faculté des Sciences et Techniques — Université Hassan II de Casablanca<br><br>
<em>Questions ?</em>
</div>
