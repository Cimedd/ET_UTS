import 'package:flutter/material.dart';
import 'package:imatching/result.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlayState();
  }
}

class _PlayState extends State<Play> {
  int level = 1;
  String value1 = "";
  String value2 = "";
  int index1 = 0;
  int index2 = 0;
  int mistakes = 0;
  int match = 0;
  int moves = 0;
  int timeCount = 0;
  int score = 0;
  late Timer _timer;
  bool isMatching = false;

  List<Level> levelList = <Level>[
    Level(cardNumber: 4, time: 20, column: 2),
    Level(cardNumber: 8, time: 40, column: 2),
    Level(cardNumber: 12, time: 60, column: 3),
  ];

  List<Cards> cardList = <Cards>[
    Cards(value: "banana", text: "Banana", image: "banana.png", isOpen: false),
    Cards(value: "cherry", text: "Cherry", image: "cherry.png", isOpen: false),
    Cards(value: "lemon", text: "Lemon", image: "lemon.png", isOpen: false),
    Cards(value: "pear", text: "Pear", image: "pear.png", isOpen: false),
    Cards(
      value: "pineapple",
      text: "Pineapple",
      image: "pineapple.png",
      isOpen: false,
    ),
    Cards(
      value: "watermelon",
      text: "Watermelon",
      image: "watermelon.png",
      isOpen: false,
    ),
  ];
  List<Cards> playcardList = [];

  void startTimer() {
    timeCount = levelList[level - 1].time;
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (timeCount == 0) {
          endGame("Time's Up!");
        } else {
          timeCount--;
        }
      });
    });
  }

  void StartUp() {}

  void endGame(String endText) {
    _timer.cancel();
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: Text('Game ended'),
            content: Text(endText),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Result(score: score),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  void initState() {
    super.initState();
    ShuffleCard();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void ShuffleCard() {
    setState(() {
      playcardList = [];

      playcardList =
          cardList
              .take((levelList[level - 1].cardNumber / 2).toInt())
              .map(
                (card) => Cards(
                  value: card.value,
                  image: card.image,
                  text: card.text,
                  isOpen: false,
                ),
              )
              .toList();

      playcardList.addAll(
        playcardList
            .map(
              (card) => Cards(
                value: card.value,
                image: card.image,
                text: card.text,
                isOpen: false,
              ),
            )
            .toList(),
      );
      playcardList.shuffle();
    });
  }

  void CheckMatch() async {
    if (value1 == value2) {
      setState(() {
        match += 1;
        score += 10;
        CheckWin();
      });
    } else {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        playcardList[index1].isOpen = false;
        playcardList[index2].isOpen = false;
        mistakes += 1;
      });
    }

    // Reset state outside of matching logic
    setState(() {
      value1 = "";
      value2 = "";
      index1 = 0;
      index2 = 0;
      moves += 1;
      isMatching = false;
    });
  }

  void OpenCard(String value, int index) {
    setState(() {
      if (value1 != "") {
        value2 = value;
        index2 = index;
        isMatching = true;
        CheckMatch();
      } else {
        value1 = value;
        index1 = index;
      }
    });
  }

  void CheckWin() async {
    if (match == (levelList[level - 1].cardNumber / 2)) {
      setState(() {
        if (level == 3) {
          endGame("You Won!");
        } else {
          level += 1;
          match = 0;
          ShuffleCard();
          _timer.cancel();
          startTimer();
        }
      });
    }
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.cyan,
              child: Row(
                children: [
                  BgText("Mistakes :$mistakes"),
                  SizedBox(width: 8),
                  BgText("Moves :$moves"),
                  SizedBox(width: 8),
                  BgText("Level $level"),
                  SizedBox(width: 20),
                  Text("Score :$score", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            LinearPercentIndicator(
              center: Text(formatTime(timeCount), style: TextStyle(color: Colors.white),),
              width: MediaQuery.of(context).size.width,
              lineHeight: 20.0,
              percent: (timeCount / levelList[level-1].time),
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: levelList[level - 1].column,
                children:
                    playcardList.asMap().entries.map((item) {
                      int index = item.key;
                      var card = item.value;
                      return SizedBox(
                        height: 100,
                        width: 100,
                        child: AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child:
                              card.isOpen
                                  ? Card(
                                    key: ValueKey("open_$index"),
                                    child: InkWell(
                                      child: SizedBox.expand(
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                "assets/images/${card.image}",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () => {},
                                    ),
                                  )
                                  : Card(
                                    key: ValueKey(
                                      "closed_$index",
                                    ), // ✅ Different key
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (!isMatching) {
                                            card.isOpen = true;
                                            OpenCard(card.value, index);
                                          }
                                        });
                                      },
                                      child: SizedBox.expand(
                                        child: Column(
                                          children: [
                                            
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cards {
  String value;
  String text;
  String image;
  bool isOpen;

  Cards({
    required this.value,
    required this.text,
    required this.image,
    required this.isOpen,
  });
}

class Level {
  int time;
  int cardNumber;
  int column;

  Level({required this.cardNumber, required this.time, required this.column});
}

Container BgText(String text) {
  return Container(
   
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
     color: Colors.blueAccent,
  ),
    child: Text(text, style: TextStyle(color: Colors.white)),
  );
}
