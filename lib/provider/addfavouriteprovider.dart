import 'package:flutter/material.dart';
import 'package:fm_adda/model/successmodel.dart';
import 'package:fm_adda/webservice/apiservices.dart';

class AddFavouriteProvider extends ChangeNotifier {
  SuccessModel successModel = SuccessModel();
  bool loading = false;

  getAddFavourite(String userid, String songid) async {
    loading = true;
    successModel = await ApiService().addfavourite(userid, songid);
    loading = false;
    notifyListeners();
  }
}
