# Plan d'Amélioration — Plateforme de Gestion des Soutenances

> **Date:** 2026-05-25
> **Périmètre:** API (Spring Boot / MySQL), UI (React 19 / TypeScript 6 / Vite 8), Docs

---

## 🔴 Phase 1 — Correction des Bugs Bloquants (Semaine 1)

L'application ne compile pas ou plante au runtime. Ces correctifs sont PRÉALABLES à tout autre travail.

### 1.1 `SimpleSelect` manquant
**Fichier:** `system-gestion-soutenance-ui/src/components/coordinator/RoomSearchSelect.tsx:1`
**Action:** Créer le composant `SimpleSelect` dans `src/components/ui/` ou remplacer l'import par `Select` existant.
**Test:** `npx tsc --noEmit` + navigation vers le DefenseDesigner

### 1.2 `React.SubmitEvent` → `React.FormEvent`
**Fichiers:** 
- `system-gestion-soutenance-ui/src/pages/Login.tsx:30`
- `system-gestion-soutenance-ui/src/pages/auth/VerifyAccount.tsx:54`
**Action:** Remplacer `React.SubmitEvent<HTMLFormElement>` par `React.FormEvent<HTMLFormElement>`.
**Check:** Supprimer l'import `import React from "react"` dans Login.tsx si plus utilisé (React 19 JSX transform).

### 1.3 Import après export dans `constants.ts`
**Fichier:** `system-gestion-soutenance-ui/src/lib/constants.ts:7`
**Action:** Déplacer `import type { DefenseType } from "@/types"` avant le premier `export const`.

### 1.4 Gestion d'erreur blob dans api-core.ts
**Fichier:** `system-gestion-soutenance-ui/src/lib/api-core.ts:42-48`
**Action:** Si `responseType === "blob"` et `!response.ok`, lire d'abord `response.text()` pour tenter un parse JSON, sinon fallback sur message générique.

---

## 🔴 Phase 2 — Sécurité (Semaine 1)

### 2.1 Clé JWT en dur
**Fichier:** `system-gestion-soutenance-api/.../auth/jwt/JwtTokenProvider.java:14-16`
**Action:** Lire la clé depuis `application.properties` → `jwt.secret=${JWT_SECRET:fallback-dev-key}`. Utiliser `@Value("${jwt.secret}")`.
**Configuration:** Ajouter `jwt.secret` dans `application.properties` avec fallback dev, et override via variable d'environnement `JWT_SECRET`.

### 2.2 H2 Console exposée
**Fichier:** `system-gestion-soutenance-api/.../common/config/SecurityConfig.java:53`
**Action:** Remplacer `.requestMatchers("/h2-console/**").permitAll()` par `.requestMatchers("/h2-console/**").hasRole("ADMIN")`. Et/ou désactiver via `spring.h2.console.enabled=false` dans `application.properties` avec override via `H2_CONSOLE_ENABLED`.

### 2.3 Config CORS explicite
**Fichier:** `system-gestion-soutenance-api/.../common/config/SecurityConfig.java`
**Action:** Ajouter `http.cors(cors -> cors.configurationSource(corsConfigurationSource()))` avec une liste d'origins autorisés lue depuis les propriétés.

### 2.4 Migration H2 → MySQL
**Fichiers:** `application.properties`, `pom.xml`
**Actions:**
1. Ajouter dépendance MySQL Connector dans `pom.xml`
2. Créer `application-dev.properties` (H2) et `application-prod.properties` (MySQL)
3. Ajouter MySQL datasource config
4. Vérifier la compatibilité SQL de `data.sql` (les syntaxes H2 vs MySQL)
5. Ajouter `spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect` pour prod
6. Remplacer `tblUsers` mocking par vrai user service

---

## 🟠 Phase 3 — Mock Data & Démonrabilité (Semaine 1-2)

### 3.1 Populer les fichiers mock
**Fichiers:** `system-gestion-soutenance-ui/src/mocks/db/{students,teachers,coordinators,projects,groups,juries,defenses,notifications,unavailability,student}.ts`
**Action:** Ajouter 10-15 entrées réalistes dans chaque fichier. S'assurer que les IDs sont cohérents entre les fichiers (ex: les étudiants référencés dans `groupMembers` existent dans `students`).
**Priorité:** Élevée — sans ça, l'appli est vide pour tout le monde sauf admin.

### 3.2 Vérifier le login non-admin
**Fichier:** `system-gestion-soutenance-ui/src/mocks/handlers-admin.ts:16-73`
**Action:** S'assurer que les utilisateurs mock générés par les handlers ont des mots de passe valides. Vérifier que `student@univh2c.ma`, `coord@univh2c.ma`, `teacher@univh2c.ma` peuvent se connecter avec le mot de passe `1234`.

### 3.3 Améliorer la seed data SQL
**Fichier:** `system-gestion-soutenance-api/.../resources/data.sql`
**Action:** Réduire la duplication (std-1 à std-99 générés par pattern). Ajouter des données pour les tables manquantes (groupes, défenses, evaluations, notifications). Ajouter des comptes avec `is_active=false` pour tester le flux de vérification.

---

## 🟠 Phase 4 — Routes & Navigation (Semaine 2)

### 4.1 Routes manquantes dans VALID_ROUTES
**Fichier:** `system-gestion-soutenance-ui/src/components/layout/DashboardLayout.tsx:46-68`
**Action:** Ajouter `/coordinator/grades`, `/coordinator/documents`, `/teacher/schedule` au tableau `VALID_ROUTES`.

### 4.2 Fixer SetupGuard
**Fichier:** `system-gestion-soutenance-ui/src/components/auth/SetupGuard.tsx`
**Action:** Ne pas rediriger vers `/admin/config` si l'appel API échoue. Ajouter un state `error` qui montre un message d'erreur au lieu d'une boucle.

### 4.3 Sauvegarder l'URL de destination avant redirection login
**Fichier:** `system-gestion-soutenance-ui/src/components/auth/ProtectedRoute.tsx`
**Action:** Utiliser `location.pathname + location.search` comme state passé au navigate. Dans `Login.tsx`, lire ce state et rediriger vers la page d'origine après login réussi.

---

## 🟡 Phase 5 — Qualité de Code (Semaine 2-3)

### 5.1 Tests
**Action:** Ajouter au minimum :
- 1 test d'intégration API (SpringBootTest) pour le login
- 1 test composant (Vitest + React Testing Library) pour Login.tsx
- Config Vitest dans `vite.config.ts`
- `@vitest/coverage-v8` pour le rapport de couverture

### 5.2 Profils Spring (dev/prod)
**Fichiers:** 
- `application.properties` → config commune
- `application-dev.properties` → H2, debug SQL, CORS permissif
- `application-prod.properties` → MySQL, CORS restrictif, H2 console disabled
**Action:** Créer les 3 fichiers, activer le profil via `SPRING_PROFILES_ACTIVE`.

### 5.3 Extraire les gros composants
**Fichiers:**
- `system-gestion-soutenance-ui/src/pages/admin/AdminDashboard.tsx` (~300 lignes)
- `system-gestion-soutenance-ui/src/pages/coordinator/DefenseDesigner.tsx` (~537 lignes)
**Action:** Découper en sous-composants (StatsCards, UserTable, AuditLogPanel, DefenseCalendar, JuryPanel, etc.)

### 5.4 Uniformiser les exports
**Action:** Tout passer en named exports (sauf pages routing qui nécessitent `default`).

### 5.5 shadcn en devDependencies
**Fichier:** `system-gestion-soutenance-ui/package.json:36`
**Action:** Déplacer `"shadcn": "^4.7.0"` de `dependencies` vers `devDependencies`.

### 5.6 Supprimer les imports inutilisés
**Action:** Vérifier `cmdk` dans package.json, `react` import dans Login.tsx. Nettoyer.

---

## 🟡 Phase 6 — API Complétion (Semaine 2-3)

### 6.1 Endpoints manquants vs api-spec.md
**Action:** Comparer `api-spec.md` avec les controllers existants. Ajouter les endpoints manquants :
- Publish schedule (F7.7)
- Grade validation workflow (F8.4)
- PV generation (F10.2)
- Calendar export (F7.10)

### 6.2 Soft-delete pour User
**Fichier:** `User.java`
**Action:** Ajouter `deletedAt: Instant` et filtrer dans les requêtes. Vérifier les dépendances actives avant suppression (F3.6).

### 6.3 Refresh token
**Action:** Implémenter un endpoint `/api/auth/refresh` avec un token de refresh (30 jours). Le refresh token est stocké en base ou dans un cookie httpOnly.

---

## 🟡 Phase 7 — Déploiement Docker (Semaine 3)

### 7.1 Dockerfile pour l'API
**Fichier:** `system-gestion-soutenance-api/Dockerfile`
**Contenu:** 
```dockerfile
FROM maven:3.9-amazoncorretto-21 AS build
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

FROM amazoncorretto:21-alpine
WORKDIR /app
COPY --from=build /app/api/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### 7.2 Dockerfile pour l'UI
**Fichier:** `system-gestion-soutenance-ui/Dockerfile`
**Contenu:**
```dockerfile
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### 7.3 docker-compose.yml
**Fichier:** `docker-compose.yml` à la racine du projet
**Contenu:** api + ui + mysql + (optionnel) maildev
```yaml
services:
  api:
    build: ./system-gestion-soutenance-api
    ports: ["8080:8080"]
    environment:
      - SPRING_PROFILES_ACTIVE=prod
      - JWT_SECRET=${JWT_SECRET}
      - MYSQL_HOST=db
    depends_on: [db]
  ui:
    build: ./system-gestion-soutenance-ui
    ports: ["80:80"]
    depends_on: [api]
  db:
    image: mysql:8.0
    volumes: [mysql_data:/var/lib/mysql]
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: defensedb
```

### 7.4 .env.example
**Fichier:** `.env.example`
**Contenu:** Toutes les variables avec documentation.

### 7.5 Health checks Docker
**Action:** Ajouter `healthcheck` dans chaque service du compose.

---

## 🟢 Phase 8 — Améliorations UX (Semaine 3-4)

### 8.1 Error boundary React
**Fichier:** Nouveau `src/components/error/ErrorBoundary.tsx`
**Action:** Encapsuler les routes dans un error boundary avec fallback UI.

### 8.2 États de chargement squelettes
**Action:** Vérifier que chaque page a un état de chargement (skeleton) cohérent avec le layout final.

### 8.3 Responsive design
**Action:** Tester et ajuster les pages admin sur tablette (1024px). Les pages student/teacher sont déjà responsive (F17.1).

### 8.4 Accessibilité
**Action:** Ajouter `aria-label` sur les boutons icônes. Vérifier la navigation clavier.

---

## 🔧 Notes Techniques

### MySQL vs H2
- MySQL 8.0+ recommandé
- Driver: `com.mysql.cj.jdbc.Driver`
- Dialect: `org.hibernate.dialect.MySQLDialect`
- Attention: les `INSERT ... VALUES (...)` avec des `'` dans les strings (ex: `Faculté des Sciences Ben M'Sik`) doivent être échappés correctement
- Les colonnes `TEXT` vs `VARCHAR` : vérifier les longueurs

### React 19 / TypeScript 6
- `React.SubmitEvent` n'existe plus → `React.FormEvent`
- JSX transform automatique → pas besoin d'importer `React` si on n'utilise pas `React.useState` etc.
- `verbatimModuleSyntax` → tous les imports de types doivent utiliser `import type`

### Sécurité
- Clé JWT: min 256 bits pour HMAC-SHA256
- BCrypt: le coût (strength) devrait être ≥ 10
- CORS: jamais `Access-Control-Allow-Origin: *` en production
- H2 console: jamais exposée en production, même avec auth

---

## 📊 Estimation Globale

| Phase | Effort | Dépendances | Livrable |
|-------|--------|-------------|----------|
| 1. Bugs bloquants | 1 jour | Aucune | Compilation OK |
| 2. Sécurité | 1 jour | Phase 1 | Pas de faille critique |
| 3. Mock data | 2 jours | Phase 1 | Appli démontrable |
| 4. Navigation | 1 jour | Phase 1 | Routes fonctionnelles |
| 5. Qualité code | 3 jours | Phases 1-4 | Code propre |
| 6. API complétion | 3 jours | Phases 1-2 | Feature parity |
| 7. Déploiement | 2 jours | Phase 2 (MySQL) | Docker ready |
| 8. UX | 2 jours | Phases 3-4 | Polissage |

**Total estimé:** ~15 jours ouvrés pour un développeur.
