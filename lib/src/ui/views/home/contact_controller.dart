import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tots_test/src/core/controllers/client_api.dart';
import 'package:tots_test/src/services/auth_service.dart';
import 'package:tots_test/src/ui/views/home/models/client.dart';

class ClientController extends ChangeNotifier {
  ClientController() {
    get();
  }

  bool isLoading = false;

  List<Client> list = [];
  List<Client> fullList = [];

  Future get() async {
    String? token = await AuthService().getAccessToken();
    if (token == null) return;
    fullList = await ClientApi().get(token: token);
    list = fullList;
    notifyListeners();
  }

  search(String query){
    if(query.isEmpty){
      list = fullList;
      notifyListeners();
      return;
    }
     query = query.toLowerCase();
  
  final aux = fullList.where((client) {
    final nameMatch = client.firstname.toLowerCase().contains(query);
    final lastNameMatch = client.lastname.toLowerCase().contains(query);
    final emailMatch = client.email.toLowerCase().contains(query);

    return nameMatch || lastNameMatch || emailMatch;
  }).toList();

  list = aux;
  notifyListeners();
  }

  Future add({required Client client}) async {
    String? token = await AuthService().getAccessToken();
    if (token == null) return;
    isLoading = true;
    notifyListeners();
    try {
      final response = await ClientApi().add(
        token: token,
        client: client,
      );
      if (response.isLeft) return;
    
      list = [response.right,...list];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log('add error: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  Future edit({required Client client}) async {
    String? token = await AuthService().getAccessToken();
    if (token == null) return;
    isLoading = true;
    notifyListeners();
    try {
       await ClientApi().edit(
        token: token,
        client: client,
      );

      List<Client> aux = [...list];
      final index = list.indexWhere((element) => element.id == client.id);
      if (index != -1) {
        aux[index] = client;
        list = aux;
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      log('add error: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  Future delete(Client client) async {
    String? token = await AuthService().getAccessToken();
    if (token == null) return;

    await ClientApi().delete(
      token: token,
      id: client.id.toString(),
    );
    List<Client> aux = [...list];
    aux.remove(client);
    list = aux;
    notifyListeners();
  }
}
