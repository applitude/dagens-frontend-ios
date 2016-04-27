# dagens-frontend-ios

*Dagens* (arbeidstittel) er hovedprosjektet på appkveldene til iOS-gruppa i Applitude våren 2016. Motivasjonen for prosjektet er at vi trengte et allsidig prosjekt som går innom mange konsepter medlemmene våre får bruk for i egne apputviklingsprosjekter, og som enkelt kan deles inn i oppgaver med forskjellig vanskelighetsgrad.

Problemet appen løser er å få rask og oversiktlig info om dagens middag på SiO-restauranter. Matrettene vises i en liste sortert på hvor langt brukeren er fra restaurantene (geografisk). Dermed skal man kunne åpne appen og med en gang se hvilke retter som serveres i nærheten.

## Funksjoner

- [x] Sende HTTP-request til [dagens-backend](http://github.com/applitude/dagens-backend) for informasjon om matretter og restaurantene disse tilhører.
- [x] Parse den mottate JSON-fila til Dish- og Restaurant-objekter.
- [x] Lagre Dish- og Restaurant-objekter i egnet datastruktur (Dish-array med Restaurant-referanser i Dish-objektene).
- [x] Representere den nevnte Dish-arrayen i en UITableView.
- [ ] Ekspandere table view-cellene med mer info og knapp for kart når de trykkes på.
- [ ] Bruke Google Maps SDK for å hente informasjon om hvor langt restaurantene er fra brukerne, og sortere Dish-arrayen etter dette.
- [ ] Lage en innstillinger-side med valg om å skjule retter som inneholder gitte allergener.
- [ ] Masse kule funksjoner vi vil lære oss å implementere.

## Fremgang

Vi bruker [Trello](http://trello.com) for å holde orden på hva som er gjort, hva som skal gjøres og hva vi driver med akkurat nå. Trello-brettet vårt finnes [her](https://trello.com/b/3Swlyr9Q/dagens-frontend-ios).

## Skjermbilder

[kommer]
