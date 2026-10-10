# Broken Arrow — Scripts Cheat Engine


Toujours sauvegarder tes parties si tu veux éviter de les perdre ! Tous les scripts ciblent la **version actuellement installée** (Steam). *Fonctionne également pour n'importe quelle version locale.*

Après une mise à jour du jeu, les signatures ci-dessous risquent de ne plus correspondre au code : il faudra alors les retrouver.

**Processus à sélectionner :** `BrokenArrow.exe` (les scripts modifient `GameAssembly.dll` en mémoire).
**Cheat Engine :** version 7.x en 64 bits.

## Avertissements

- **Hors ligne / solo uniquement.** Le jeu utilise Easy Anti-Cheat. Evite ces scripts en ligne car tu risques un bannissement.
- Les mises à jour changent le code compilé. Les signatures AOB de ce dépôt ciblent **une version précise** et devront
  probablement être retrouvées après un correctif (voir « Mettre à jour les scripts après une mise à jour du jeu »).
- Peut corrompre les sauvegardes ou bloquer certaines missions. Fais une copie de tes sauvegardes.
- Tu utilises ces scripts à tes risques et périls. Aucune garantie n’est fournie.

**Broken Arrow — Scripts Cheat Engine** est une collection de scripts de triche pour le mode hors ligne / solo de *Broken Arrow*, écrits en **Cheat Engine Auto Assemble**.
Ils modifient la mémoire du jeu pendant son exécution : aucun fichier du jeu n’est modifié sur le disque ni redistribué.


---

## Installation et utilisation

1. Lance le jeu et charge une **mission** ou une **escarmouche**.
2. Ouvre Cheat Engine, clique sur l’icône de l’ordinateur et sélectionne **`BrokenArrow.exe`**.
3. Seul le script pour **l'Argent** nécessite cette étape : menu **Mono → Activate mono features**.
4. Ouvre **Memory View → Auto Assemble** (Ctrl+Alt+A).
5. Colle le / les blocs de script, puis choisis **File → Assign to current cheat table**.
6. Coche la case pour activer le script, décoche-la pour le désactiver (le code d’origine est alors restauré).
7. Recommence pour les autres scripts, puis enregistre la table (Ctrl+S).

### Quelques conventions
- **Global** : affecte aussi bien tes unités que celles de l’IA.
- **Joueur uniquement** : ne concerne que tes unités. Les modifications s’appliquent au moment de leur **apparition** : les unités déjà déployées ne sont pas affectées. Déploie-en de nouvelles.
- Dans Cheat Engine, les nombres sont interprétés en hexadécimal par défaut. Les constantes au format `(float)5.0` sont écrites directement.
- **Repères pour les nombres flottants :** `2.0 = 40000000`, `5.0 = 40A00000`, `10.0 = 41200000`, `1000.0 = 447A0000`, `5000.0 = 459C4000`, `10000.0 = 461C4000`.

---

## [1. Argent — 500 000](scripts/money500k.asm) *(testé en jeu, nécessite Mono)*

À chaque actualisation de l’interface de la boutique, ce script fixe `PlayerInfo.Points` à 500 000.
Remplace `(float)500000` par la valeur de ton choix.

---

## [2. Déploiement illimité d’unités](scripts/UnlimitedUnitDeploy.asm) *(testé en jeu)*

Supprime le refus « aucun emplacement de déploiement disponible » dans `OrderValidator.CheckToOrder`.
Tu peux utiliser ce script, le **n° 3** à la place, ou les deux ensemble : ils modifient des endroits différents.

---

## [3. Limite de déploiement portée à 20 unités (alternative au n° 2)](scripts/DeploymentUnit20.asm) *(version corrigée, testée en jeu)*

C’est cette valeur qui alimente réellement le compteur `4/4` : elle provient de `DeckSlotModel.Count`
(récupérée via `IDeckSlotModel.get_Count` / `get_TransportCount`). L’ancienne version du script
ne faisait que contourner la validation des ordres. Le compteur de l’interface continuait donc d’utiliser la vraie valeur (4), puis restait bloqué à 0
après un dépassement de la limite. Cette version modifie les deux accesseurs : **tout le jeu** (compteur,
validation et récupération d’un emplacement lorsqu’une unité est détruite) utilise désormais la valeur 20.

- Pour passer à **25 unités**, remplace les deux occurrences de `B8 14 00 00 00` par `B8 19 00 00 00`.
- Les emplacements dont le compteur vaut 0 restent à 0 : un emplacement que tu ne possèdes pas ne devient pas disponible.
- Active le script une fois en mission. Désactive-le avant de modifier tes decks dans le menu,
  car l’éditeur de decks utilise lui aussi cette valeur.

---

## [4. Santé infinie — unités du joueur uniquement](scripts/InfiniteHealth.asm) *(testé en jeu)*

Lors de l’apparition d’une unité, si elle appartient à un joueur humain (`PlayerInfo._isBotSlot == 0`),
le script active le drapeau `Immortal` intégré au jeu (`SpawnData.Immortal` → `InitUnitHealth`).
Les unités de l’IA conservent leur santé normale. Seules les unités créées pendant que le script est activé sont concernées.

---

## [5. Carburant illimité — avions du joueur uniquement](scripts/UnlimitedFuel.asm) *(testé en jeu)*

À l’apparition d’un avion appartenant à un joueur humain, le script active le drapeau `InfiniteFuel` du jeu
(`SpawnData.InfiniteFuel` → `FuelComponent.InfiniteFuel`). Les avions de l’IA consomment toujours du carburant.

---

## [6. Munitions infinies — *global*](scripts/InfiniteAmmo.asm) *(testé en jeu)*

`AmmunitionContainer.get_AmmoAvailable` renvoie toujours la valeur 9999.

---

## [7. Chargeurs illimités — *global*](scripts/UnlimitedMagazine.asm) *(testé en jeu)*

Empêche le compteur des chargeurs restants de diminuer dans `ShotCycleAndReload`.
À noter : l’IA en profite également. Si l’interface affiche des valeurs incohérentes, désactive ce script et conserve le n° 6.

---

## [8. Rechargement instantané — *global*](scripts/InstantReload.asm) *(testé en jeu)*

Neutralise la condition qui vérifie si le rechargement est terminé dans `MagazineReloadingSystem.InternalUpdate`.

---

## [9. Rechargement instantané des bombes et de l’artillerie — *global*](scripts/InstabtReloadOfBombsAndArtillery.asm) *(testé en jeu)*

Remplace la lecture du délai de rechargement des bombes par une valeur nulle.

---

## [10. Fumigènes illimités — *global*](scripts/InfiniteSmokeBombs.asm) *(testé en jeu)*

La quantité de fumigènes ne diminue plus lors du lancement. Le temps de recharge reste toutefois actif.
À noter : l’IA en profite également.

---

## [11. Dégâts multipliés par 5 — *global*](scripts/AugmentedDamagex5.asm) *(testé en jeu)*

Multiplie par cinq les dégâts de chaque tir (`Ammunitions.get_Damage`). Modifie `(float)5.0` pour choisir un autre multiplicateur.
L’IA utilise les mêmes données de munitions et inflige donc elle aussi davantage de dégâts. Pour éviter cet effet, associe ce script au n° 4 (santé infinie).

---

## [12. Suivi d’apparition des unités du joueur — nécessaire pour les n° 13 et 14](scripts/PlayerSpawnTracker.asm)

Ce script n’a aucun effet visible à lui seul. À chaque apparition d’une unité, il vérifie si celle-ci
appartient au joueur humain. Si c’est le cas, il active un indicateur pendant que le jeu crée le composant
de brouillard de guerre de l’unité. Les scripts n° 13 et 14 lisent cet indicateur : **laisse donc ce script activé**.
Sans lui, les n° 13 et 14 ne font rien. Ils n’affectent pas non plus l’IA.

---

## [13. Portée de détection maximale — unités du joueur uniquement](scripts/MaximumPerceptionRange.asm) *(testé en jeu)*

Fixe à `10000.0` les distances de vision dans le brouillard de guerre pour les unités du joueur
(au sol, à basse altitude et à haute altitude). Le script n° 12 est requis. Seules les unités créées
pendant l’activation sont concernées. Si 10000 te paraît excessif, modifie les trois constantes
(`461C4000` = 10000.0, `459C4000` = 5000.0, `447A0000` = 1000.0).

---

## [14. Mode furtif — unités du joueur uniquement](scripts/StealthMode.asm) *(testé en jeu)*

Définit `FogOfWarComponent.AntiVisible` à `10.0` pour les unités du joueur, ce qui les rend
beaucoup plus difficiles à détecter. Le script n° 12 est requis. Si nécessaire, modifie `41200000` (soit `10.0`).
Seules les unités créées pendant que le script est activé sont concernées.

---

## Remarques et combinaisons

- ****Le script n° 12 doit être activé** pour que les **n° 13** et **14** fonctionnent. Les autres scripts sont indépendants.**

- Les n° 13 et 14 peuvent être activés simultanément : ils modifient des instructions voisines et s’enchaînent correctement.
- Les effets liés aux unités s’appliquent à leur apparition : après activation, déploie de **nouvelles** unités ou relance la mission.
- Si l’erreur « AOB not found » apparaît, le jeu a probablement été mis à jour : la signature doit être vérifiée.
- Si un script qui fonctionnait provoque soudain une erreur, décoche-le : les octets d’origine seront restaurés.
- Les scripts globaux (n° 6 à 11) renforcent aussi l’IA. Le n° 11 reste généralement avantageux si le n° 4
  rend tes unités immortelles, mais garde cet effet en tête.
- Commence par tester les scripts un par un. En cas de plantage, tu sauras plus facilement lequel en est responsable.

Fonctions utiles pour retrouver les décalages après une mise à jour : `ShopPanelUI.Update` (money),
`OrderValidator.CheckToOrder` (#2), `DeckSlotModel.get_Count` / `get_TransportCount` (#3), `UnitBuilder.CreateUnitEcs` / `InitUnitHealth` (#4),
`InitPlaneFly` / `FuelComponent..ctor` (#5), `AmmunitionContainer.get_AmmoAvailable` (#6),
`ShotCycleAndReload` (#7), `MagazineReloadingSystem.InternalUpdate` (#8, #9),
`DeploySmoke` / `SmokeAbilityComponent` (#10), `Ammunitions.get_Damage` (#11),
`InitFogOfWar` / `FogOfWarComponent..ctor` (#12, #13, #14).

Avec ces valeurs, tu peux retrouver les RVA dans le fichier `dump.cs` généré par Il2CppDumper, puis désassembler la DLL pour retrouver les signatures AOB.

---

> La documentation et les commentaires des scripts sont en français. Le document ci-dessus sert aussi de README : copie chaque bloc `[ENABLE]/[DISABLE]` dans Cheat Engine.



## Démarrage rapide

1. Lance le jeu et charge une mission ou une escarmouche.
2. Ouvre Cheat Engine et connecte-le à **`BrokenArrow.exe`** (pas au lanceur).
3. (Argent uniquement) Menu **Mono → Activate mono features**.
4. Dans **Memory View**, ouvre **Auto Assemble** (Ctrl+Alt+A).
5. Colle **un seul** bloc de script de ce document, puis sélectionne **File → Assign to current cheat table**.
6. Coche la case pour activer le script, décoche-la pour le désactiver (les octets d’origine sont restaurés).
7. Enregistre la table (Ctrl+S), puis recommence pour les autres scripts.

## Index des scripts

| N° | Script | Portée | État |
|---|--------|-------|--------|
| 1 | Argent : 500 000 | Joueur | testé |
| 2 | Déploiement illimité d’unités | Joueur | testé |
| 3 | Limite de déploiement = 20 / 25 | Joueur | nouvelle version, à tester |
| 4 | Santé infinie | Unités du joueur uniquement | non testé |
| 5 | Carburant illimité | Avions du joueur uniquement | non testé |
| 6 | Munitions infinies | Global | non testé |
| 7 | Chargeurs illimités | Global | non testé |
| 8 | Rechargement instantané | Global | non testé |
| 9 | Rechargement instantané des bombes | Global | non testé |
| 10 | Fumigènes illimités | Global | non testé |
| 11 | Dégâts multipliés par 5 | Global | non testé |
| 12 | Suivi d’apparition des unités du joueur | Script auxiliaire | non testé |
| 13 | Portée de détection maximale | Unités du joueur (nécessite le n° 12) | non testé |
| 14 | Mode furtif | Unités du joueur (nécessite le n° 12) | non testé |

## Langage et outils

### Auto Assemble (le « langage » des scripts)

Les scripts sont écrits en **Cheat Engine Auto Assemble (AA)**, un petit langage qui combine de l’**assembleur x86-64** brut
et des directives propres à Cheat Engine. Cheat Engine assemble le code au moment où tu actives le script. Voici les directives utilisées dans ce dépôt :

| Directive | Rôle |
|---|---|
| `aobscanmodule(name, module, pattern)` | Recherche une signature d’octets (avec les jokers `??`/`*`) dans `GameAssembly.dll` à l’activation et enregistre le résultat comme symbole. Les scripts ne dépendent donc pas d’adresses fixes. |
| `alloc(name, size, near)` / `dealloc(name)` | Réserve puis libère une zone mémoire exécutable (« code cave ») près de l’adresse ciblée, afin qu’un `jmp` relatif de 5 octets puisse l’atteindre. |
| `label(name)` | Déclare des étiquettes utilisées dans le script. |
| `registersymbol(name)` / `unregistersymbol(name)` | Rend un symbole accessible dans la section `[DISABLE]`, puis le retire. |
| `readMem(address, size)` | Copie les octets d’origine dans une zone mémoire à l’activation, afin que `[DISABLE]` puisse les restaurer à l’identique. |
| `db ...` | Écrit directement des octets hexadécimaux, notamment pour restaurer le code exactement ou encoder certaines instructions. |
| `define(name, value)` | Effectue une substitution de texte, utilisée ici pour l’adresse de l’indicateur partagé. |
| Assembleur | Instructions x86-64 en syntaxe Intel (`mov`, `cmp`, `jmp`, `movss`, etc.). Les nombres sont **hexadécimaux par défaut** ; le préfixe `#` indique une valeur décimale. |

### Fonctionnement interne du jeu

*Broken Arrow* est un jeu basé sur **Unity IL2CPP** :

- Le code de gameplay C# est compilé à l’avance en code natif x64 dans **`GameAssembly.dll`**.
- Les métadonnées des classes, champs et méthodes se trouvent dans `BrokenArrow_Data/il2cpp_data/Metadata/global-metadata.dat`.
- La logique du jeu repose en grande partie sur l’architecture **ECS** (des composants regroupés en structures et des systèmes qui parcourent les entités). De nombreuses « valeurs » sont donc des champs de structures
  accessibles à des décalages fixes, comme `HealthComponent.Immortal`, `FuelComponent.InfiniteFuel` ou `FogOfWarComponent.AntiVisible`.

Les noms C# utilisés dans cette documentation (`PlayerInfo._isBotSlot`, `SpawnData.Immortal`, etc.) proviennent d’une extraction réalisée avec
[Il2CppDumper](https://github.com/Perfare/Il2CppDumper), qui a généré un fichier `dump.cs` contenant les méthodes et leurs RVA
(adresses relatives au module). Le désassemblage a été réalisé avec Python et Capstone.

**RVA ↔ décalage dans le fichier :** dans `GameAssembly.dll`, la section `.il2cpp` a une adresse virtuelle `0x1000` et un décalage brut de `0x400` dans le fichier,
donc `décalage fichier = RVA − 0xC00`. Cela permet d’examiner les octets de la DLL sans lancer le jeu.

## Techniques utilisées

1. **Recherche AOB / par signature** — chaque script repère sa cible grâce à une séquence d’octets plutôt qu’à une adresse codée en dur. Il
   peut ainsi tolérer l’ASLR et de petites modifications du jeu. Les signatures s’appuient sur de longues séquences d’instructions distinctives ; chacune a été vérifiée pour
   ne correspondre qu’une seule fois dans la version ciblée.

2. **Hooks inline via des zones de code** — les 5 à 15 premiers octets d’une fonction (ou d’un appel) sont remplacés par un `jmp` relatif
   vers une zone réservée avec `alloc`. Cette zone exécute le code personnalisé, puis revient à l’instruction qui suit les octets remplacés.
   Utilisé par : Argent, Santé infinie, Carburant illimité, Dégâts x5, Suivi d’apparition, Détection et Furtivité.

3. **Remplacement par des NOP** — les sauts conditionnels et les écritures qui imposent des limites sont remplacés par des octets `90` :
   - Déploiement illimité : `jle` (le refus « aucun emplacement disponible ») → `nop nop`
   - Chargeurs illimités : l’instruction de 7 octets qui diminue le nombre de chargeurs → `nop` × 7
   - Rechargement instantané : le saut `ja` de 6 octets qui attend la fin du rechargement → `nop` × 6

4. **Injection de constantes / remplacement à l’entrée**
   - Limite de déploiement : les accesseurs `DeckSlotModel.get_Count` et `get_TransportCount` sont réécrits directement
     pour renvoyer 20 (ou `25`) ; les emplacements dont le compteur vaut 0 restent à 0.
   - Munitions infinies : l’entrée de l’accesseur est remplacée par `mov eax,9999; ret`.
   - Bombes : `movss xmm6,[rax+0x84]` (minuteur) devient `xorps xmm6,xmm6`.
   - Fumigènes : `lea edx,[rax-1]` (quantité − 1) devient `lea edx,[rax]` (quantité inchangée).

5. **Réutilisation des indicateurs du jeu** — le jeu gère déjà les options `Immortal` et `InfiniteFuel` pour chaque unité (utilisées par
   certaines unités de campagne). Plutôt que de modifier globalement les valeurs de santé ou de carburant, les scripts activent ces indicateurs
   **à l’apparition de l’unité**, pour limiter proprement les effets au joueur.

6. **Filtrage réservé au joueur (suivi d’apparition)** — `SpawnData` contient `OwnerInfo` (un `PlayerInfo`) dont le champ `_isBotSlot`
   indique si l’unité appartient à l’IA. Pour la santé et le carburant, cette vérification est effectuée directement dans le hook d’apparition.
   Pour le brouillard de guerre (détection/furtivité), le constructeur ne connaît pas le propriétaire au moment de la création. Le **suivi d’apparition
   des unités du joueur (n° 12)** définit donc un octet indicateur partagé dans une zone de remplissage inutilisée (`GameAssembly.dll+112A20`) lorsque le joueur humain
   déploie une unité. Les zones de code de détection et de furtivité le lisent (`1` = effet activé, toute autre valeur = comportement normal).
   Sans ce suivi, ces deux scripts restent sans effet.

7. **Restauration exacte des octets** — toutes les modifications sont réversibles. Les correctifs simples sont restaurés avec `db` ; le hook du script Argent utilise
   `readMem` pour sauvegarder les cinq octets d’origine au moment de l’activation.

### Repères techniques (cette version)

| Fonctionnalité | Fonction (nom dans `dump.cs`) | RVA |
|---|---|---|
| Money | `ShopPanelUI.Update` (hook site) | 0x383012 |
| Unlimited deployment | `OrderValidator.CheckToOrder` | 0x35D520 (NOP at 0x35D74D) |
| Deployment limit 20 / 25 | `DeckSlotModel.get_Count` / `get_TransportCount` | 0x1910 / 0x1A10 |
| Infinite health | `UnitBuilder.<CreateUnitEcs>d__8.MoveNext` → `InitUnitHealth` | 0x365680 / hook at 0x365FD5, 0x34F900 |
| Unlimited fuel | `InitPlaneFly` → `FuelComponent..ctor` | 0x34D940 / hook at 0x34DD5E, 0x29DC30 |
| Infinite ammo | `AmmunitionContainer.get_AmmoAvailable` | 0x7A7470 |
| Unlimited magazines | `ShotCycleAndReload` | 0x7E36D0 (patch at 0x7E39B7) |
| Instant reload / bombs | `MagazineReloadingSystem.InternalUpdate` | 0x7CFA50 (patches at 0x7CFD66, 0x7CFCDF) |
| Infinite smoke | `DeploySmoke` | 0x6A5800 (patch at 0x6A5A1C) |
| Damage x5 | `Ammunitions.get_Damage` | 0x282DD0 |
| Spawn Tracker | `UnitBuilder.<CreateUnitEcs>d__8.MoveNext` → `InitFogOfWar` | hook at 0x365E98, 0x34AF20 |
| Perception / Stealth | `FogOfWarComponent..ctor` | 0x69FB90 (patches at 0x69FC61, 0x69FC5C) |

Les RVA sont relatives au module : en mémoire, ajoute l’adresse de base aléatoire de `GameAssembly.dll` ; dans le fichier sur disque, soustrais `0xC00`.

## Mettre à jour les scripts après une mise à jour du jeu

1. Relance **Il2CppDumper** sur les nouveaux fichiers `GameAssembly.dll` et `global-metadata.dat` pour générer un `dump.cs` à jour.
2. Recherche les fonctions indiquées dans le tableau technique ci-dessus (les noms C# changent rarement).
3. Désassemble le code autour de ces fonctions avec Capstone, Ghidra, x64dbg ou Cheat Engine, puis retrouve la séquence d’instructions équivalente
   décrite dans la section « Techniques utilisées ».
4. Mets à jour la signature AOB (conserve une longue séquence distinctive et remplace par `??` uniquement les octets qui ont changé), ainsi que les
   décalages des modifications.
5. Vérifie à nouveau que la signature ne correspond qu’à un seul emplacement avant de publier le script. Sinon, `aobscanmodule` choisira silencieusement la première correspondance.
6. Mets à jour le tableau des RVA et la colonne « État » si tu testes de nouveau les scripts.

## Dépannage

- **Erreur « AOB not found » à l’activation** → le jeu a été mis à jour : retrouve la signature comme indiqué plus haut. Vérifie aussi qu’aucun autre script ne
  modifie déjà les mêmes octets (pour les n° 12, 13 et 14, active d’abord le suivi d’apparition).
- **Erreur concernant un symbole ou une instruction `call`** → vérifie que Cheat Engine est connecté à `BrokenArrow.exe`, que tu utilises sa version 64 bits,
  et que tu as collé le bloc sans le modifier.
- **Le script Argent ne fait rien** → active les fonctionnalités Mono ou vérifie que la boutique est ouverte et qu’elle s’actualise.
- **Santé, carburant, détection ou furtivité sans effet** → ces scripts ne concernent que les unités **créées pendant leur activation**. Déploie de nouvelles unités
  ou relance la mission. Pour les n° 13 et 14, vérifie que le n° 12 est activé.
- **Le jeu plante peu après l’activation d’un script** → décoche ce script pour restaurer les octets d’origine. Teste les scripts un par un.

## Organisation conseillée du dépôt

Chaque fichier `scripts/*.txt` doit contenir un seul bloc `[ENABLE]` / `[DISABLE]`, afin de pouvoir être collé directement dans Cheat Engine
ou regroupé dans une table `.CT`.

## Licence

Licence **MIT** pour les scripts et la documentation.
Ce dépôt ne contient **aucun code, ressource ou binaire du jeu** : uniquement des scripts originaux fait à la main et des notes.
*Broken Arrow* et ses ressources restent la propriété de leurs détenteurs respectifs.
# Broken-Arrow-asm-scripts
