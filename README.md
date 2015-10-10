Unterlagen zur Git-Schulung
===========================

Diese Unterlagen entspringen einem Dump von Notizen und Unterlagen für eine
Git-Schulung. Wenn es irgendwann mal fertig ist wird es fertige Unterlagen
für eine Git-Schulung enthalten.


Präsentation
------------

Die Präsentation verwendet [go's](http://golang.org/) Präsentationsmodul
[present](https://godoc.org/golang.org/x/tools/present). Das geht mit einigen
Einschränkungen daher, allerdings kann die Präsentation dann auch per Browers
angezeigt werden. Zum Start wird im geclonten Projekt einfach make gestartet:

    #> make
    mkdir -p src bin pkg
    GOPATH=/path/to/your/git-schulung go get golang.org/x/tools/cmd/present
    test -f bin/present
    GOPATH=/path/to/your/git-schulung bin/present
    2015/10/10 21:26:19 Open your web browser and visit http://127.0.0.1:3999

Richtet man den Browser jetzt auf die angegebene Adresse aus, kann man dort
aus den "Slide decks" die Präsentation "git-schulung.slide: Git Schulung"
auswählen. Voila!

Voraussetzung ist ein installiertes Go. Getestet wurde es mit Version 1.5.


Autoren
-------

- [Andreas Fett](https://github.com/afett)
- [Robert Peters](https://github.com/r2p2)
- [Till Salzer](https://github.com/tsalzer)

Lizenz
------
[![CC BY-SA](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

Dieses Material steht unter der Creative-Commons-Lizenz
Namensnennung - Weitergabe unter gleichen Bedingungen 4.0 International.
Um eine Kopie dieser Lizenz zu sehen, besuchen Sie
http://creativecommons.org/licenses/by-sa/4.0/.

Siehe auch [LICENSE](LICENSE)
