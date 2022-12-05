

import 'package:buroleave/sessionmanager/preferences_helper.dart';


import '../utilities/constants.dart';

class SessionManager {
  Future<void> createSession(var userdata) async {
    await Future.wait(<Future>[
      setIsLoggedIn(true),

      setUserID(userdata.userId),

    ]);
  }



  Future<bool> get isLoggedIn =>
      PreferencesHelper.getBool(constants.KEY_IS_LOGGED_IN);

  Future setIsLoggedIn(bool value) =>
      PreferencesHelper.setBool(constants.KEY_IS_LOGGED_IN, value);


  Future<String> get userID =>
      PreferencesHelper.getString(constants.KEY_USERID);

  Future setUserID(String value) =>
      PreferencesHelper.setString(constants.KEY_USERID, value);


Future<String> get password =>
      PreferencesHelper.getString(constants.KEY_PASSWORD);

  Future setPassword(String value) =>
      PreferencesHelper.setString(constants.KEY_PASSWORD, value);

  Future setLang(String value) {
   return  PreferencesHelper.setString(constants.KEY_LANGUAGE, value);

  }

  Future setToken (String value) {

    return  PreferencesHelper.setString(constants.KEY_TOKEN, value);

  }

  Future<String> get selectedLang =>
            PreferencesHelper.getString(constants.KEY_LANGUAGE);


  Future setSupervisorInfo(String value) =>
      PreferencesHelper.setString(constants.KEY_SUPERVISOR_INFO, value);

  Future<String> get supervisorInfo =>
            PreferencesHelper.getString(constants.KEY_SUPERVISOR_INFO);


  Future setSubmoduleId(int value) =>
      PreferencesHelper.setInt(constants.KEY_SUBMODULE_ID, value);

  Future clearSubmoduleId() =>
      PreferencesHelper.setInt(constants.KEY_SUBMODULE_ID, 0);


  Future<int> get subModuleId =>
            PreferencesHelper.getInt(constants.KEY_SUBMODULE_ID);



  Future setPlanId(int value) =>
      PreferencesHelper.setInt(constants.KEY_PLAN_ID, value);

  Future clearPlanId() =>
      PreferencesHelper.setInt(constants.KEY_PLAN_ID, 0);


  Future<int> get planId =>
            PreferencesHelper.getInt(constants.KEY_PLAN_ID);

 Future<String> get token =>
            PreferencesHelper.getString(constants.KEY_TOKEN);



  Future<void> clearSession() async {
    await Future.wait(<Future>[
      setIsLoggedIn(false),

      setUserID(''),


    ]);
  }


//Leave module
//Added 4/12/2022
  Future setCountryinfo(String value) =>
      PreferencesHelper.setString(constants.KEY_COUNTRY_NAME, value);

  Future<String> get countryInfo =>
            PreferencesHelper.getString(constants.KEY_COUNTRY_NAME);


 Future setDivisioninfo(String value) =>
      PreferencesHelper.setString(constants.KEY_DIVISION_NAME, value);

  Future<String> get divisionInfo =>
            PreferencesHelper.getString(constants.KEY_DIVISION_NAME);

  Future setDistrictinfo(String value) =>
      PreferencesHelper.setString(constants.KEY_DISTRICT_NAME, value);

  Future<String> get districtInfo =>
            PreferencesHelper.getString(constants.KEY_DISTRICT_NAME);

 Future setCityinfo(String value) =>
      PreferencesHelper.setString(constants.KEY_CITY_NAME, value);

  Future<String> get cityInfo =>
            PreferencesHelper.getString(constants.KEY_CITY_NAME);

//Leave Module


}

final sessionManager = SessionManager();

