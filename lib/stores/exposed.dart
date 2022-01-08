import 'package:rocket/stores/app_store.dart';
import 'package:rocket/stores/data_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initStoresAndPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();

  appStore = AppStore();
  dataStore = DataStore();
}

SharedPreferences? sharedPreferences;

AppStore? appStore;
DataStore? dataStore;
//SettingsStore? settingsStore;
