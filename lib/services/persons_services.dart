import 'dart:convert';

import '../models/person_model.dart';

import 'package:http/http.dart' as http;

class PersonServices {
  PersonServices();

  final String _url = 'rickandmortyapi.com';

  Future<List<Person>> getPersons({int page = 1}) async {
    var url =
        Uri.https(_url, '/api/character', {'page': '$page'});
    final response = await http.get(url);
    final personModel = PersonModel.fromJson(response.body);
    return personModel.listPersons;
  }

  Future<String> getFirstCap(int personId) async {
    var url = Uri.https(_url, '/api/episode/$personId');
    final response = await http.get(url);
    final Map<String, dynamic> responseMap = jsonDecode(response.body);

    return ' ${responseMap['air_date'] ?? 'No Info'} - ${responseMap['episode'] ?? 'No Info'}';
  }

  Future<List<Person>> search(String word) async {
    var url =
        Uri.https(_url, '/api/character', {'name': word});
    final response = await http.get(url);
    final personModel = PersonModel.fromJson(response.body);
    return personModel.listPersons;
  }
}
