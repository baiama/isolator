import 'package:shared_preferences/shared_preferences.dart';

class DataHelper {
  void setUpData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasks = prefs.getStringList("tasks");
    if (tasks == null && tasks!.isEmpty) {
      await prefs.setStringList('task_1', ['1, 2, 3']);
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
}
