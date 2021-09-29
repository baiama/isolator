import 'package:shared_preferences/shared_preferences.dart';

class DataHelper {
  Future<void> setUpData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasks = prefs.getStringList("tasks");
    if (tasks == null || tasks.isEmpty) {
      await prefs.setStringList('tasks', ['1', '2', '3']);
    }
  }

  Future<List<String>> get data async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasks = prefs.getStringList("tasks");
    if (tasks != null) {
      return tasks;
    }
    return [];
  }

  void setData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = await data;
    if (items.isNotEmpty) {
      items.removeWhere((element) => element == value);
    }
    await prefs.setStringList('tasks', items);
  }
}
