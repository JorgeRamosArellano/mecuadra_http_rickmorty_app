import 'package:flutter/cupertino.dart';
import '../models/person_model.dart';
import '../models/preferences.dart';
import '../services/persons_services.dart';

class PersonProvider extends ChangeNotifier {
  List<Person> listPersons = [];
  List<String> listPersonsFavorites = [];
  List<Person> listPersonsSearch = [];

  void isFavorite(Person person) {
    person.favorite = !person.favorite;
    try {
      //En caso de que ya esté cargado en la Lista...
      listPersons.setAll(listPersons.indexOf(person), [person]);
    } catch (e) {
      listPersonsFavorites.add(person.id.toString());
    }
    notifyListeners();
  }

  Future<List<Person>> getPersons() async {
    //await Preferences.prefs.remove('myFavorites'); <- Clear all favorites
    listPersons = await PersonServices().getPersons(page: 1) as List<Person>;
    List<Person> page2 = await PersonServices().getPersons(page: 2) as List<Person>;
    listPersons.addAll(page2);
    listPersonsFavorites = Preferences.getFavorites();

    listPersons.forEach((person) async {
      if (listPersonsFavorites.contains(person.id.toString())) {
        person.favorite = true;
        listPersons.setAll(listPersons.indexOf(person), [person]);
      }
    });

    notifyListeners();
    return listPersons;
  }

  Future<List<Person>> getPersonSearch(String word) async {
    listPersonsSearch.clear();
    listPersonsSearch = await PersonServices().search(word) as List<Person>;

    listPersonsSearch.forEach((person) async {
      if (listPersonsFavorites.contains(person.id.toString())) {
        person.favorite = true;
        listPersonsSearch.setAll(listPersonsSearch.indexOf(person), [person]);
      }
    });

    return listPersonsSearch;
  }
}
