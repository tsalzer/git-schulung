# Konzept zur Git-Schulung

## Zielgruppe

- Entwickler mit SVN-Erfahrung
- Studenten ohne SCM-Erfahrung


## Ziel der Schulung

Am Ende der Veranstaltung soll jeder Teilnehmer in der Lage sein, in einem bestehenden Git-Projekt mitzuarbeiten.
Es soll ein Verständnis für die allgemeinen Konzepte (Commit, Branch, Tag, Lokales und Remote Repo) sowie für die
einfachen Arbeiten (Clone, Pull, Push, Commit, Branching, Tagging, Merging, einfache Kollisionsauflösung) vermittelt
werden.

Es wird auf die Besonderheiten von Git eingegangen (Rebase, History Rewrite).

Abgrenzung:

Die Schulung hat nicht den Anspruch, technische Details von Git jenseits des "Standard-Workflows" zu vermitteln.
Dafür wird [Pro Git](https://progit.org) empfohlen.


Gedankenfetzen:

- Konvertieren ist schlecht: $Id$
- automatische Filetype-Erkennung ist unsicher
- SCM ist immer Zeilenbasiert (CR/LF-Freude)
- xdiff für Binärformate, kein Mergen etc (spart nur Platz)


## Fahrplan

- Teil I
    - Begrüßung und Einstieg

- Teil II
	- Theorie
	- Technik prüfen
- Pause

- Teil III
	- Praxis


### I Begrüßung und Einstieg

Voraussetzungen:

- Teilnehmer anwesend und bereit

Inhalt:

- Begrüßung
- Ablauf erklären

### II Theorie

Voraussetzungen: 

Inhalt: Achtung: Reihenfolge den Abhängkeiten anpassen!

- Warum braucht man Versionkontrolle?
- Wann lohnt sich der Einsatz?
- Welche Anwendungszenarien gibt es?
- Was gehört unter Versionkontrolle und was nicht und warum?
- Grundbegriffe beim Umgang mit Versionskontrollsystemen
  - Repository
  - Commit
  - Branch
  - Trunk/Master/Main-Branch
  - Tag
- Konzepte und Workflows verschiedener Versionskontrollsysteme
  - Zentral
  - Dezentral

### Technik prüfen

Voraussetzungen: Jeder hat einen Rechner und Verbindung zur Test-VM

Inhalt:

- Jeder Prüft, ob er sich mit der Test-VM verbinden kann.

### Pause

Voraussetzungen: 

Inhalt:

- Entpannung
- Gerne auch Fragen


### III Praxis

Voraussetzungen: Jeder hat getestet, dass er auf die Test-VM kommt.

Inhalt:

- Lokal
  - Repository anlegen
  - Datei hinzufügen
  - Datei bearbeiten
  - Git Ignore
  - Branches
  - Merges
  - Tags
  - Git Log
- Remote
  - Git Clone
  - Add Remote
  - Fetch/Pull
  - Merge
  - Push


## Ablauf

(Ablauf der Schulung. Dieser Teil gehört in ein separates Dokument. Der Praxis-Teil benötigt vorbereitete Repos.)


### Umgang mit SCM

(Dieser Teil kann kurz gehalten werden. Der Nutzen von SCMs sollte eigentlich klar sein.)


#### Warum brauche ich ein SCM?

##### Aus Management-Sicht

-  Was haben wir welchem Kunden wann geliefert?
-  Wer hat das Codefragment xxx wann eingebracht? War das legal?
-  Haben wir unsere Version xxx vor oder nach yyy erstellt? Können wir das beweisen?
-  Welcher Entwickler hat wieviel Code beigesteuert? (Nur bedingt nützlich.)

##### Aus Entwicklersicht

- Es funktioniert (nicht mehr), was habe ich geändert?
- Hier ist etwas neu, wer kann mir das erklären?
- Das Mutterprojekt ist überarbeitet worden, ich brauche das in unserem Projekt.

##### Etwas exotischer

- Bei John Doe funktioniert's, das brauche ich hier.
- Ich habe da eine Idee, aber ich darf das Projekt nicht gefährden.
- Wann ist dieser Fehler reingekommen? Was ist die letzte Version, die noch funktioniert hat?
- Wenn mein Rechner kaputt geht, will ich nicht alles nochmal machen müssen

##### Wann lohnt sich der Einsatz eines SCM?

- Wann lohnt sich der Einsatz eines Versionskontrollsystems?
  - Warum auch für externe Mitarbeiter interessant?
  - Einsatzszenarien
- “Gewicht” der SCMs unterschiedlich... Entscheidungen später
- Zusammenfassung: IMMER (Time Machine)


#### Anwendungsszenarien SCM

##### Source Code Management

- klassisches Szenario
- Repo endhält Source Code
- Branches und Mergen sind normal
- History Rewrite möglich (Definition?)

Zusammenfassung: Repo ist Ausgangspunkt für die Ableitung von Artefakten (aka Software Kompilat)


##### Configuration Management

- nahe am Szenario Source Code Management
- Repo enthält Konfigurationsdateien, geordnet nach Umgebungen; keinen Code (im Source SCM!), keine Buildartefakte
  (im Build-Archiv!)
- Branches und Merges eingeschränkt sinnvoll
- History Rewrite eingeschränkt: Alte Konfigurationen sollten zugänglich bleiben

Zusammenfassung: Nicht Teil des Softwareentwicklungsprozesses, aber Teil des Software Lebenszyklus. Orientiert sich
stark an Erfordernissen des Anwendungsbetriebs.

##### Archivierung

- zeitlich lineare Ablage von Artefakten (Lieferungen, Dokumente, ...)
- Repos synchronisiert mit Entwicklungs-Repos (z.B. via Tagging: “Docs für Build x”)
- keine Branches (möglicherweise pro Kunde?), kein Mergen
- kein History Rewrite (revisionssicher)

Zusammenfassung: Repo ist Ablage, SCM wird hier “zweckentfremdet”


##### Was gehört in ein SCM? Was nicht?

Achtung! Abhängig von Anwendungsszenarien! Szenario Source Code Management wird angenommen.[a]

- Was gehört nicht unter Versionskontrolle bzw. wie geht man damit um? (+Konsequenzen)
  - individuelle Daten (Nutzername, Password, lokaler Port) - Projektkultur!
  - keine sensiblen Daten (kein Zugriffsschutz) - Projektkultur!
  - Keine abgeleiteten Inhalte (!)
    - tempfiles
    - IDE-Konfigurationen
    - Kompilate
    - ...
    - (alles, was aus dem generiert werden kann, was schon eingecheckt ist)
  - Commits werden nur veröffentlicht, wenn das Projekt kompiliert? (private/öffentliche Commits)
- Dokumentation der Arbeit
   - Saubere Commits erleichtern das Auffinden selbiger
   - sinnvolle Kommentare sind wichtig!
     - Branching-Konzept
   - production
   - development
   - testing?
   - mehrere Projekte in einem Repository

##### Sonderfall Binärdatei

- alles, was nicht (zeilenweise?) gemerged werden kann
- kann man nicht mergen
- Bilder, Zips

warum? context diff -- je größer die änderung, desto wahrscheinlicher falsch positive übereinstimmung,
mergeerfolg unwahrscheinlicher -> formate, die das nicht erlauben, sind ungeeignet für merges (sollten
extern verglichen werden)


Einige SCMs bringen Plugin-System mit, um Binärdateien zu mergen. Grundsätzlich verkomplizieren solche Systeme aber
das Management (siehe auch Sonderfall Keyword Substitution).


##### Sonderfall Keyword Substitution

- bekannt von $Id$ & Co aus RCS, CVS und SVN
- nicht in Binärdateien
- erfordert sichere Erkennung der Dateitypen
- ermöglicht Identifizierung von Code losgelöst vom SCM
- Alternative: Keyword Substitution im Build Prozeß: simpler, zuverlässig, hinreichend aussagekräftig


#### Gewicht von SCM

- Turn-Around-Zeit: extrem kurze Zeiten erweitern mögliche Anwendungsfälle
- Client-Server oder Distributed (Sonderfall RCS als “Fliegengewicht”)
- “intrusiveness”: transparenter Betrieb vs. dediziertes Ein-/Auschecken und read-only
- Offline-Fähigkeit? (erlaubt Arbeit trotz Ausfall vom Zentralserver oder ohne Netz)
- Verfügbarkeit auf allen Plattformen?
- Verfügbarkeit von Tools
- Kosten (SCMs werden immer noch mit Phantasiepreisen verkauft)


## --- break ---


## Einführung in Git

### Konzepte

Feld ebnen: Was sind bekannte SCM? (SVN, CVS, RCS, SourceSafe, ClearCase, Synergy)

- Was wird dort versioniert? - Dateien, Repository (SVN)
- Wie wird dort versioniert? - Server-basiert (RCS-), zentral (RCS-)
- Wie wird parallele Arbeit gehandhabt? - Locking, Branching, Merging

## Installation

### Windows

Paket von http://git-scm.com laden und installieren

Zwei (?) Varianten verfügbar: Cygwin und MSys Git.
Explorer-Integration Tortoise-Git

-> Hinweis: Referenz ist die CLI-Version


### Unix

Geht immer: Paket von http://git-scm.com laden und installieren

Debian:

  sudo apt-get install git

Red Hat:

	yum install git


### OSX

Paket von http://git-scm.com laden und installieren


## Anlegen eines Repos

- git init


## Clonen eines Repos

- git clone (lokal)
- git clone (remote)

## Einchecken einer Datei

- git add
    - Was ist der Index?
- git commit
    - Commit Message: Format und Inhalt


## Publizieren

- git push

## Branches

- git branch
    - git checkout -b


## Konflike

- git pull
- git fetch
- Was ist ein bare repo?


## Workflows

- nvie.com Workflow (traditionell, wie aus SVN bekannt)
- git rebase


## Weitere Quellen

- [Pro Git](https://progit.org)
- (weitere Quellen: [Link-Sammlung](Git_Linksammlung.md))
