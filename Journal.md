## Cinquième cours - 18 octobre 2023  

* Choix du mot
  - Pour le projet, nous pensons prendre comme langue : l'anglais et l'italien et pour la troisième nous hésitons encore. Pour ce qui est du mot, nous avons décidé de choisir un terme qui peut avoir une connotation différente selon les folklores des langues choisies. Nous avons pour l'instant pensé à "renard" qui a par exemple une connotation positive en russe mais pas particulièrement dans les autres langues, voire négative en français. Nous avons également pensé au mot "sorcière" car il nous plait et s'imprègne aussi de la culture de la langue. Nous hésitons donc encore sur le mot mais le choix sera probablement fait entre ces deux là.


## Sixième cours - 25 octobre 2023

* Choix du mot
  - Nous hésitons toujours sur le choix de notre mot. Nous pensons choisir un mot comme "fourbe, malicieux, rusé ou encore sournois". On prendrait de ce fait le problème à l'envers et peut-être qu'on pourra remarquer si le mot se retrouve associé à des mots similaires selon les différentes langues.


## Septième cours - 8 novembre 2023

* Choix du mot
  - Nous avons enfin choisi notre mot, ce sera : arbre (en anglais, en russe et en italien).

 
## Huitième cours - 15 novembre 2023

* Projet
  - Nous agrandissons notre liste d'url chacun de notre côté. Nous avons également réfléchi à des mots coocurrents d'abres selon les différentes langues afin de voir certaines similitudes et différences.
  - Par exemple "arbre de Noël" se traduit tel quel en anglais et italien mais se dit "sapin de Noël" en russe.
  - Nous pensons aussi rechercher des expressions comme "arbre généalogique" ou "arbre syntaxique".

## Neuvième cours - 22 novembre 2023

* Projet
  - Le projet se passe bien. Nous n'avons pas été bloqué sur une étape en particulier. Nos 3 scripts personnels étaient relativement très similaires, de ce fait nous avons pris un script que nous avons étoffé au fur et à mesure des demandes lors des exercices. Florian a eu un problème d'encodage lors des extractions des pages avec *lynx*. Nous avons essayé sur l'ordinateur de Lucile qui a Ubuntu et nous n'avons pas eu le problème. Nous allons essayer de régler cette histoire au plus vite car c'est embêtant si Lucile est la seule a pouvoir lancer les scripts.

 
## Dixième cours - 29 novembre 2023

* Le problème précédent est réglé, nous utilisons maintenant *links* et plus *lynx*. De ce fait, tout le monde peut maintenant lancer les scripts et nous pouvons nous répartir les tâches comme il se doit !
* Modifications
  - Passer d'un script unique à un script par langue.
  - Retravailler les chemins afin de correspondre à l'arborescence demandée car nous n'avions pas fait exactement la même.
* Concordancier
  - Bien que la forme soit là, le concordancier n'est pas satisfaisant du tout. Il manque beacoup d'occurrence du mot et les contextes ne sont pas forcément logiques (répétition du mot dans le contexte gauche et droit). Nous allons devoir peaufiner ça... 
* Problèmes script russe
  - `\w` ne fonctionne pas pour le russe car ce ne sont pas des caractères ASCII, des recherches sont nécéssaires pour modifier l'expression régulière.
  - Erreur "exceeded PCRE's backtracking limit", l'expression est trop longue, c'est embêtant !


## Onzième cours - 6 décembre 2023

* Modifications
  - Mise en commun de nos journaux de bord afin de créer un pour le groupe.
  - Récupération de nouvelles urls pour les trois langues.
  - De nouveaux essais pour améliorer les concordanciers, il y a du progrès mais de nouveaux problèmes.
C'est pratique de pouvoir travailler en groupe lors des séances !


## Douzième cours - 13 décembre 2023

* Concordancier
  - On se consacre entièrement au concordancier pendant la séance (+un peu de récupération d'URLs). Notre principal problème était que le nombre de ligne avec nos mots ne correspondait pas au nombre de compte du mot dans la page. De ce fait, on loupait beaucoup d'informations. Après de longs moments d'observation de nos scripts, nous avons remarqué que l'on excluait toutes les occurrences de notre mot qui n'avait pas les deux contextes. Donc tous les mots en début, fin de paragraphes etc. étaient comptabilisés dans compte mais n'était pas inclus dans le tableau. Après avoir régler ce problème, le concordancier nous semble plutôt très satisfaisant !
* À faire :
  - finir de récupérer nos URLs afin d'avoir un compte d'au minimum 50 pour chaque langue.
  - retravailler chacun nos scripts s'il y a des problèmes liés à sa langue
  - se concerter pour la suite, mise en page du site etc.


## Période du 13 décembre au 7 janvier

* Nous avons les 5O URLs pour nos trois langues.
* Problème italien et anglais
  - Nous avons remarqué un problème au niveau des URLS, il ne garde pas le dernier lien. Par exemple, pour l'italien nous avons 55 URLs dans notre fichier texte, cependant dans notre tableau nous n'avons que les 54 premiers URLs... Ce problème n'existant pas dans le script russe, nous allons le regarder attentivement. 
* Nous avons finalisé les scripts et analysé nos corpus avec l'aide d'itrameur.
* Nous avons fait une refonte graphique du site, qui en avait grandement besoin. 
* Nous avons rajouté des pages présentant les principaux scripts utilisés. Pour afficher le code de manière élégante, avec de la coloration syntaxique, nous avons utilisé la bibliothèque prism (https://prismjs.com)






