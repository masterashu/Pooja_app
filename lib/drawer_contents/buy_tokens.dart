import 'dart:core';
import 'package:durga_pooja/drawer_contents/helper_classes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBuyTokens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => MealCardList(
          mealCards: [
            MealCard(count: 0),
          ],
        ),
        child: BuyTokens(),
      ),
    );
  }
}

class BuyTokens extends StatefulWidget {
  final String title;

  BuyTokens({Key key, this.title}) : super(key: key);

  @override
  _BuyTokensState createState() => _BuyTokensState();
}

class _BuyTokensState extends State<BuyTokens> {
  final _formKey = GlobalKey<FormState>();
  final List<String> events = ["Durga Pooja 2020", "Sports 2020"];
  final List<String> days = [
    "Shashti - 22 Oct",
    "Saptami - 23 Oct",
    "Ashtami - 24 Oct",
    "Navami - 25 Oct",
    "Dashami - 26 Oct",
  ];
  String _currentEvent;

  @override
  Widget build(BuildContext context) {
    final mealsList = Provider.of<MealCardList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Buy Tokens",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Choose Event",
              style: TextStyle(fontSize: 20.0),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField(
                validator: (val) {
                  String ans;
                  if (val != null && val.isEmpty) {
                    ans = "Please type in your email";
                  }
                  return ans;
                },
                items: events.map((event) {
                  return DropdownMenuItem(
                    value: event,
                    child: Text("$event"),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _currentEvent = val;
                  });
                },
                onSaved: (val) {
                  setState(() {
                    _currentEvent = val;
                  });
                },
              ),
            ),
            RaisedButton(
              child: Text("Add Meals"),
              onPressed: () {
                final formState = _formKey.currentState;
                if (formState.validate()) {
                  formState.save();
                  mealsList.addMealCard(MealCard());
                  /*
                  for (var i = 0; i < mealsList.getMealCard().length; i++) {
                    print(mealsList.getMealCard()[i].day);
                  }*/
                }
              },
            ),
            Flexible(
              child: ListView.builder(
                itemCount: mealsList.getMealCard().length,
                itemBuilder: (context, index) {
                  return BuildMeals(index: index, mealList: mealsList, key: ObjectKey(index));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildMeals extends StatefulWidget {
  final index;
  final mealList;

  BuildMeals({this.index, this.mealList, Key key}): super(key: key);

  @override
  _BuildMealsState createState() => _BuildMealsState();
}

class _BuildMealsState extends State<BuildMeals> {
  final List<String> days = [
    "Shashti - 22 Oct",
    "Saptami - 23 Oct",
    "Ashtami - 24 Oct",
    "Navami - 25 Oct",
    "Dashami - 26 Oct",
  ];

  @override
  String value;
  bool isNonVeg;
  bool isGuest;

  void initState() {
    super.initState();
    value = "Shashti - 22 Oct";
    isNonVeg = false;
    isGuest = false;
  }

  Widget build(BuildContext context) {
    //final mealList = Provider.of<MealCardList>(context);
    //var count = mealList.getMealCard()[widget.index].count;

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        // Not use it like here (it will not listen to changes)
        Provider.of<MealCardList>(context, listen: false)
            .removeMealCard(widget.index);
      }, //widget.mealList.removeMealCard(widget.index),
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text("Choose a day:"),
                DropdownButtonFormField(
                  //value: value,
                  items: days.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text("$day"),
                    );
                  }).toList(),
                  onChanged: (val) {
                    widget.mealList.updateMealCard(widget.index, val);
                    //widget.mealList.getMealCard()[widget.index].day = val;
                    for (var i = 0;
                        i < widget.mealList.getMealCard().length;
                        i++)
                      print(
                          "${widget.mealList.getMealCard()[i].day}  ${widget.mealList.getMealCard()[i].if_veg}");
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Switch(
                      value: isNonVeg,
                      onChanged: (val) {
                        //print(val);
                        setState(() {
                          isNonVeg = val;
                        });
                        widget.mealList.getMealCard()[widget.index].if_veg =
                            val;
                      },
                      activeTrackColor: Colors.redAccent,
                      activeColor: Colors.white,
                      inactiveTrackColor: Colors.green,
                    ),
                    Container(
                      child: isNonVeg
                          ? Text(
                              "NON-VEG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "VEG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      color: isNonVeg ? Colors.redAccent : Colors.greenAccent,
                      padding: EdgeInsets.all(2.0),
                    ),
                    Switch(
                      value: isGuest,
                      onChanged: (val) {
                        setState(() {
                          isGuest = val;
                        });
                        widget.mealList.getMealCard()[widget.index].if_guest =
                            val;
                      },
                      activeTrackColor: Colors.greenAccent,
                      activeColor: Colors.white,
                      inactiveTrackColor: Colors.blueAccent,
                    ),
                    Container(
                      child: isGuest
                          ? Text(
                              "GUEST",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "RESIDENT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      color: isGuest ? Colors.greenAccent : Colors.blueAccent,
                      padding: EdgeInsets.all(2.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
