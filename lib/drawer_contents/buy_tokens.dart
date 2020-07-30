import 'dart:core';
import 'package:durga_pooja/drawer_contents/helper_classes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
class BuyTokens extends StatefulWidget {
  @override
  _BuyTokensState createState() => _BuyTokensState();
}

class _BuyTokensState extends State<BuyTokens> {
  final _formKey = GlobalKey<FormState>();
  //TODO: Try to make a stateful class of the widget buildMeals and make a class of the the following items

  final List<String> events = ["Durga Pooja 2020", "Sports 2020"];
  final List<String> days = [
    "Shashti - 22 Oct",
    "Saptami - 23 Oct",
    "Ashtami - 24 Oct",
    "Navami - 25 Oct",
    "Dashami - 26 Oct",
  ];
  var mealTime = {
    "Breakfast": 0,
    "Lunch": 0,
    "Dinner": 0,
  };
  String _currentEvent;
  String _currentDay;

  List<Widget> meals = <Widget>[]; // For adding each card to the list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy Tokens"),
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
                  if (val.isEmpty) {
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
                }
                meals.add(BuildMeals());
              },
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = meals[index];
                    return Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: UniqueKey(),
                      background: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Delete >>>',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        color: Colors.red,
                      ),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          meals.removeAt(index);
                        });
                      },
                      child: BuildMeals(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

//On Trial Stateful Implementation of buildMeals

class BuildMeals extends StatefulWidget {
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
  var mealTime = {
    "Breakfast": 0,
    "Lunch": 0,
    "Dinner": 0,
  };
  String _currentEvent;
  String _currentDay;
  Color _colorBreakFast = Colors.grey[200];
  Color _colorLunch = Colors.grey[200];
  Color _colorDinner = Colors.grey[200];
  bool isBreakfastPressed = false;
  bool isLunchPressed = false;
  bool isDinnerPressed = false;
  bool isNonVeg = false;
  bool isGuest = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text("Choose a day:"),
              DropdownButtonFormField(
                items: days.map((day) {
                  return DropdownMenuItem(
                    value: day,
                    child: Text("$day"),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _currentDay = val;
                  });
                },
                onSaved: (val) {
                  setState(() {
                    _currentDay = val;
                  });
                },
              ),
              Text("Meal Time :"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: _colorBreakFast,
                    child: Text("Breakfast"),
                    onPressed: () {
                      setState(() {
                        mealTime["BreakFast"] = 1;
                        isBreakfastPressed = !isBreakfastPressed;
                        _colorBreakFast = isBreakfastPressed
                            ? Colors.purple
                            : Colors.grey[200];
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    color: _colorLunch,
                    child: Text("Lunch"),
                    onPressed: () {
                      setState(() {
                        mealTime["Lunch"] = 1;
                        isLunchPressed = !isLunchPressed;
                        _colorLunch =
                            isLunchPressed ? Colors.purple : Colors.grey[200];
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    color: _colorDinner,
                    child: Text("Dinner"),
                    onPressed: () {
                      setState(() {
                        mealTime["Dinner"] = 1;
                        isDinnerPressed = !isDinnerPressed;
                        _colorDinner =
                            isDinnerPressed ? Colors.purple : Colors.grey[200];
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Switch(
                    value: isNonVeg,
                    onChanged: (val) {
                      setState(() {
                        isNonVeg = val;
                      });
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
    );
  }
}

 */

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
                  if (val.isEmpty) {
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
                  mealsList.addMealCard(MealCard(day: ""));
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
                  return BuildMeals(index: index, mealList: mealsList);
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
  BuildMeals({this.index, this.mealList});
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
  void initState(){
    super.initState();

  }

  Widget build(BuildContext context) {
    //final mealList = Provider.of<MealCardList>(context);
    //var count = mealList.getMealCard()[widget.index].count;
    return Consumer<MealCardList>(
      builder: (context,data,child){
        return Dismissible(
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) => widget.mealList.removeMealCard(widget.index),
            child:Container(
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
                child:Form(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text("Choose a day:"),
                        DropdownButtonFormField(
                          value:
                          items: days.map((day) {
                            return DropdownMenuItem(
                              value: day,
                              child: Text("$day"),
                            );
                          }).toList(),
                          onChanged: (val) {
                            widget.mealList.updateMealCard(widget.index,val);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ),
        );
      },
    );
  }
}
