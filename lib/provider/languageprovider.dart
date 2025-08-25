import 'package:flutter/material.dart';
import 'package:fm_adda/model/languagemodel.dart';
import 'package:fm_adda/webservice/apiservices.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageModel languageModel = LanguageModel();
  bool loading = false;

  getLanguage(String pageno) async {
    loading = true;
    languageModel = await ApiService().language(pageno);
    loading = false;
    notifyListeners();
  }
}
