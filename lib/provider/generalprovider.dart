import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fm_adda/model/generalsettingmodel.dart';
import 'package:fm_adda/model/introscreenmodel.dart';
import 'package:fm_adda/model/loginmodel.dart';
import 'package:fm_adda/model/pagesmodel.dart';
import 'package:fm_adda/model/registermodel.dart';
import 'package:fm_adda/model/sociallinkmodel.dart';
import 'package:fm_adda/utils/adhelper.dart';
import 'package:fm_adda/utils/constant.dart';
import 'package:fm_adda/utils/utils.dart';
import 'package:fm_adda/utils/sharedpref.dart';
import 'package:fm_adda/webservice/apiservices.dart';

class GeneralProvider extends ChangeNotifier {
  GeneralsettingModel generalSettingModel = GeneralsettingModel();
  IntroScreenModel introScreenModel = IntroScreenModel();
  LoginModel loginModel = LoginModel();
  SocialLinkModel socialLinkModel = SocialLinkModel();
  RegisterModel registerModel = RegisterModel();
  PagesModel pagesModel = PagesModel();
  bool loading = false;
  SharedPref sharedPre = SharedPref();
  bool isProgressLoading = false;

  Future<void> getGeneralsetting(BuildContext context) async {
    loading = true;
    generalSettingModel = await ApiService().generalSetting();
    printLog("genaral_setting status :==> ${generalSettingModel.status}");
    loading = false;
    printLog('generalSettingData status ==> ${generalSettingModel.status}');
    if (generalSettingModel.status == 200) {
      if (generalSettingModel.result != null) {
        for (var i = 0; i < (generalSettingModel.result?.length ?? 0); i++) {
          await sharedPre.save(
            generalSettingModel.result?[i].key.toString() ?? "",
            generalSettingModel.result?[i].value.toString() ?? "",
          );
        }
        Constant.userID = await sharedPre.read('userid');
        Constant.userImage = await sharedPre.read('userimage');
        /* Get Ads Init */
        if (context.mounted && !kIsWeb) {
          AdHelper.getAds(context);
        }
      }
    }
  }

  getIntroPages() async {
    loading = true;
    introScreenModel = await ApiService().getOnboardingScreen();
    loading = false;
    notifyListeners();
  }

  getRegister(type, fullName, email, mobile, password, countCode, countryName,
      deviceToken, deviceType) async {
    loading = true;
    registerModel = await ApiService().register(type, fullName, email, mobile,
        password, countCode, countryName, deviceToken, deviceType);
    loading = false;
    notifyListeners();
  }

  getLogin(type, mobile, email, password, deviceToken, deviceType, countryCode,
      countryName) async {
    loading = true;
    loginModel = await ApiService().login(type, mobile, email, password,
        deviceToken, deviceType, countryCode, countryName);
    loading = false;
    notifyListeners();
  }

  Future<void> getPages() async {
    loading = true;
    pagesModel = await ApiService().getPages();
    printLog("getPages status :==> ${pagesModel.status}");
    loading = false;
    notifyListeners();
  }

  getSocialLink() async {
    loading = true;
    socialLinkModel = await ApiService().getSocialLink();
    loading = false;
    notifyListeners();
  }

  setLoading(loading) {
    isProgressLoading = loading;
    notifyListeners();
  }
}
