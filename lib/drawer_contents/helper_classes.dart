import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MealCard {
  String day;
  int count;
  int time;
  bool if_veg;
  bool if_guest;
  MealCard({this.day, this.count, this.time, this.if_guest, this.if_veg});
}

class MealCardList extends ChangeNotifier {
  List<MealCard> mealCards = [];
  MealCardList({this.mealCards});

  getMealCard() => mealCards;

  void addMealCard(MealCard mealCard) {
    mealCards.add(mealCard);
    notifyListeners();
  }

  void removeMealCard(int index) {
    mealCards.removeAt(index);
    notifyListeners();
  }

  void updateMealCard(int index, String day){
    //print(day);
    //print(index);
    mealCards[index].day = day;
    print('Update ${mealCards[index].day}');
    notifyListeners();
  }

}
