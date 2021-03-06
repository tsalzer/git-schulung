﻿Aufgaben
========

Eine kurze Liste der Aufgaben, die in zeitlicher Reihenfolge beim Workshop
von den Entwicklern ausgeführt werden sollen.

Leeres Repository anlegen
-------------------------

Basis
-----

Zunächst wird in das Projektverzeichnis gewechselt, welches noch nicht unter
Versionskontrolle steht. Anschließend werden die folgenden Befehle ausgeführt,
um das Projekt/Verzeichnis in die Versionskontrolle zu überführen.

- git init
- git status
- git add .
- git status
- git commit
- git status


- Legt die Datenbank an, welche von Git benötigt wird, um die Versionen zu
  verwalten.
- Zeigt den aktuellen Zustand des Working Dirs an. Es weist uns darauf hin,
  dass wir uns beim initialen Commit befinden und zeigt, welche Dateien nicht
  unter Versionskontrolle stehen.
- Überführt die Änderungen im Working Dir in den Index. Der Punkt gibt an,
  dass alle Dateien und Verzeichnisse im aktuellen Verzeichnis davon betroffen
  sein sollen.
- Zeigt an, dass es Änderungen gibt, welche committed werden können.
- Überführt die Änderungen in den Head. Es weist uns ebenfalls darauf hin,
  dass wir noch nicht konfiguriert haben, wer wir sind. Dazu gleich mehr.
- Zeigt, dass keine Änderungen vorliegen.


Author-Informationen konfigurieren
----------------------------------

Jedem Commit wird von Git ein Autor und ein Committer zugeordnet. Der Autor
ist der, welcher die Änderung vorgenommen hat und der Committer jener,
welcher die Änderung committet hat.


Mit Hilfe des Befehls:

    git log

kann man sich die History des Repositorys anzeigen lassen. Hier finden wir
auch unseren initialen Commit, wobei der Author nicht ganz korrekt ist.
Dem Hinweis aus dem vorhergehenden Commit folgend, sollten wir unseren Namen
und unsere E-Mail-Adresse korrigieren und für zukünftige Commits im System
hinterlegen.

    git config --global user.name "Your Name"
    git config --global user.email you@example.com
    git commit --amend --reset-author

Mit den Zeilen 1 und 2 werden euer Name und eure E-Mail-Addresse global
abgespeichert. Das heißt, dass für alle zukünftigen Projekte bereits die
richtigen Werte verwendet werden. Allerdings muss dies noch für den soeben
durchgeführten Commit nachgetragen werden, was in Zeile 3 Passiert. Der
Parameter `--amend` fügt die in der Working Copy getätigten Änderungen
noch zu dem letzten Commit hinzu.


Das Projekt schreitet voran
---------------------------

Es folgen ein paar einfache Änderungen, wobei jede Änderung mit einem
sinnvollen Commit und einer sinnvollen Commit-Nachricht aus dem
Working Directory in den Index und dort in den Head überführt wird.


Im Laufe der Entwicklung stellen wir fest, dass hin und wieder Dateien
auftauchen, welche nicht von der Versionskontrolle erfasst werden. Das
können beispielsweise benutzerbezogene IDE-Konfigurationen sein,
Sicherungsdateien der Texteditoren oder Kompilate. Da wir diese Dateien
niemals in das Repository hinzufügen möchten, irritieren sie bei der
Ausgabe des Kommandos git status. Um sie dort auszublenden und zu
verhindern, dass man sie versehentlich doch hinzufügt, kann man in jedem
Verzeichnis seines Working Directories eine Datei namens `.gitignore`
anlegen. Sie kann mit Globbing-Mustern gefüllt werden, die auf Datei-
und Verzeichnisnamen matchen, um diese fortan unter git status nicht
mehr anzuzeigen. Die Git-Ignore-Datei bezieht sich jeweils auf das
Verzeichnis in dem sie liegt und alle Unterverzeichnisse. Inhaltlich
könnte sie etwa so aussehen:

    *~
    bin/*
    core
    *.o
    *.so


An Projekten beteiligen
-----------------------

Möchte man sich an einem bereits bestehenden Projekt beteiligen, wird
dieses geklont. Dabei wird lokal eine Kopie des so genannten
Remote-Repositories angelegt.


    git clone <remote-path>
    # Vergleichen, Auschecken, Zeitreisen
    git diff: WA vs. index, index vs. HEAD, HEAD vs. HEAD^1
    git diff: datei a vs. datei b
    git checkout HEAD^1, git checkout HEAD^2
    git checkout -- (Änderungen verwerfen)


    git tag


    git log -1, git log -10


    gitk --all (ohne --all)


Branches anlegen
----------------

Um einen neuen Zweig vom Head zu erzeugen, genügt der Befehl:

    git branch <new-branch-name>

Wie man durch den Befehl:

    git branch

sieht, wurde der neue Branch zwar angelegt, das Sternchen signalisiert aber,
dass wir uns noch im Branch master befinden. Um zukünftige Commits auf den
neuen Branch anzuwenden, muss dieser noch ausgecheckt werden

    git checkout <new-branch-name>

Ein erneuter Aufruf des git branch Befehls zeigt, dass wir uns nun im neuen
Branch befinden. Das Anlegen eines neuen Branches und das darauf folgende
Auschecken lässt sich auch in einem Befehl zusammenfassen:

    git checkout -b <new-branch-name>


Branch switches: Keine Kollision
--------------------------------

- Datei a/abc inhalt 1 anlegen, einchecken
- Datei a/abc inhalt andern, nicht einchecken
- branch wechseln git branch b, b/abc inhalt einchecken


Branch switches: Kollision
--------------------------

- Datei a/xyz inhalt 1 anlegen, einchecken
- Datei b/xyz inhalt 2 anlegen, einchecken
- git branch a, a/xyz inhalt verändern, branch wechseln

-> Kollision erstmal ignorieren (lokale Änderung verwerfen)


Branches vergleichen
--------------------

    git diff    # -> Einführung des “universellen Konzeptes”
                #(alles läßt sich diffen)


Die Zwischenablage
------------------
Wie wir eben gesehen haben, kann es problematisch sein, bestimmte
git-Kommandos auszuführen, während sich nicht committete Änderungen
in seinem Working Directory bzw im Index befinden. Anstatt nun auf
seine Änderungen zu verzichten, lassen sich diese in einer Art
Zwischenablage, dem sogenannten Stash ablegen und später wieder zurückführen.

    git stash

Überführt alle Änderungen im Working Directory und im Index in die
Zwischenablage. Nun können die Working Directory gefährdenden Tätigkeiten
durchgeführt werden. Sind diese Abgeschlossen, lassen sich die vormals
getätigten Änderungen mit dem folgenden Befehl wieder anwenden.

    git stash pop

Einfaches Mergen
----------------

Branches: master

Beispiel sollte eine HTML-Seite oder etwas ähnlich einfaches sein.
Loose 2er Teams.

- neuen branch “feature” anlegen
- dateien auf master bearbeiten (z.b. stylesheet auf master auswechseln)
- änderung: feature implementieren
- bei jedem 2. teilnehmer wird das feature übernommen, alle anderen müssen
  das feature verwerfen.


Remote
======

Einfaches Fetchen
-----------------

2er teams: Repos gegenseitig eintragen. Player A fetcht von Player B und
zurück. Basis bilden Clone der vorangegangenen Übung, teams einigen sich
auf ein “Ur-Repo”.

- warum sieht man die änderungen nach dem fetch nicht -> gitk, dann merge!
- “ist das nicht lästig?” -> was macht pull?


Einfaches Pushen
----------------

2er teams, *ZUERST REPOS SICHERN*, dann: Player A pusht zu PLayer B. Wenn
alle damit fertig sind, sich die repos zu zerstören, wird das bare repo
erklärt.

Hinweis: Die Repos sollten trotzdem strukturell intakt sein.


- Hinweis, dass man das nur mit einem sauberen Sandkasten? machen sollte,
  da git alles wiederherstellen kann, nur nicht das was nicht committet ist?


Bare Repositories
-----------------

Es gibt Situationen, in denen man ein Repository bereitstellen, darin
aber nicht direkt über ein Working Directory Änderungen durchführen
möchte. Wie es beispielsweise bei zentralen Repositories der Fall ist.
Sogenannte Bare-Repositories dienen ausschließlich als Remote-Repositories
und können mit den folgenden Befehlen erzeugt werden.

    git init --bare

    git clone --bare <source-repository> <target>


Clonen vom bare-repo. gleiche Konstellation wie zuvor, nur wird nicht
direkt gepusht, sondern über ein --bare repo. erste einfache Konflikte.

-> Üben: Verändern vom modifizierten Dateien (working copy, noch nicht
   eingecheckt), über fetch, merge und pull.


Tags und Remote Repos
---------------------

Während Branches sehr flexibel sind und ihre Position im Laufe der
Entwicklung ändern können, markieren Tags besondere Punkte in der
Geschichte des Projektes. Sie dienen als eine Art Lesezeichen, um
etwa genau jene Version zu finden, welche an den Kunden ausgeliefert wurde.


Git verfügt über zwei Arten von Tags, die leichtgewichtigen und die
Tag-Objekte. Während leichtgewichtige Tags wie einfache Lesezeichen
verstanden werden können, die auf einen Commit zeichen, enthalten
Tag-Objekte auch Informationen darüber, wer das Lesezeichen gesetzt
hat und wann.


Leichtgewichtige Tägs können mit Hilfe des folgenden Befehls angelegt werden.


    git tag <tag-name>


Um ein Tag-Objekt zu erzeugen, verwendet man den folgenden Befehl.


    git tag -a <tag-name>


Wer ein mit seinem GPG-Key signiertes Tag-Objekt erzeugen möchte, kann
dies mit dem folgenden Befehl veranlassen.


    git tag -s <tagname>


Tags werden von git push standardmäßig ignoriert. Möchte man sie dennoch
auf das Remote-Repository schieben, muss dies durch den folgenden Befehl
explizit veranlasst werden.


    git push --tags <remote-name>


Mergen
======

Konflikte
---------

- Konflikte auflösen: weitere anforderungen, dann zwei branches zusammenführen
    - hilfe mit git gui
    - hilfe mit vi
    - hilfe mit IDEA (oder eine andere IDE) -> Vorschläge?


Konflikte bei Binärdateien
--------------------------

Konflikt mit Icons provizieren: Player A bekommt Icon Set 1, Player B
bekommt Icon Set 2. Mergen, Konflikte auflösen, Limits: keine Binärdateien,
keine Verwaltung der Resourcen (unbenutzte Icons werden nicht getrackt)


Rebase und History Rewrite
==========================

    git rebase - wann wird es gebraucht? (inklusive -i)
    git reset - erklären (Was passiert, wenn ein HEAD verschoben wird? )
    git rerere - erklären
    git reflog


Content Merge
-------------

(viel später)
- CSS refactoring, im feature branch
- anpassung im master
- im integrationsbranch zusammenführen
- auf dem master ausrollen

-> hat’s funktioniert?
    - wenn ja: toll!
    - wenn nein: auch gut, Entwickler sollen auch noch selber denken. ;)


Anderes
=======

    git archive -> Archive mit eingebautem SHA1
    git submodule -> geht (analog svn externals), aber braucht man das wirklich?


Speicherplatz: Wieviel Platz braucht das gesamte Projekt, viel davon `.git`?
Weitere Beispiele:
- Linux Kernel
- X86 

Anwendung
=========

Best Practice
-------------

Branching Modell

Weil Branches so einfach gehandelt werden können und deren gekonnter
Einsatz das Entwicklerleben dramatisch erleichtert, haben sich Leute
Gedanken gemacht, wie man Branches am Gewinnbringendsten nutzen kann.
Ein verbreitetes Modell, welches wohl auch in der iSX zum Einsatz kommen
soll, ist das "Erfolgreiche Git Branching Modell". Alle die das hier
lesen, finden eine ausführliche Bechreibung unter der URL
(http://nvie.com/posts/a-successful-git-branching-model/).


Für Kommandozeilenfans, denen die auf der Seite beschriebenen Befehle zu
umständlich sind, gibt es eine Scriptsammlung namens Git flow, welche
die beschriebenen Git-Kommandos, zur Einhaltung des Branching Modells,
in kleinen Befehlen zusammenfasst. (https://github.com/nvie/gitflow)

Real World Beispiele
====================

Konfigurationsmanagement
------------------------

- Branches:
    - master: “plain”-Konfiguration
    - dev: Konfiguration Entwicklungsmaschine
    - test: Konfiguration Testmaschine
    - kunde: Konfiguration Kundenmaschine

- änderung auf master
- anpassung auf speziellen Systemen
- mergen bei änderungen

-> warum funktioniert das? weil git änderungen trackt, nicht versionen
