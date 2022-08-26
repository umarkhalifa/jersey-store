class League{
  String name;
  String image;
  League({required this.name, required this.image});
}
List<League> leagues = [
  League(name: "Premier League", image: "assets/images/premier.png"),
  League(name: "La Liga", image: "assets/images/laliga.png"),
  League(name: "Bundesliga", image: "assets/images/bundesliga.png"),
  League(name: "Serie A", image: "assets/images/seriea.png"),
  League(name: "Ligue 1", image: "assets/images/league1.png"),
];