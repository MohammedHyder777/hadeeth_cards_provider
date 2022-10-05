import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:provider/provider.dart';
class Hadeeth {
  String rawi;
  String hadeeth;
  String degree;
  int state;

  Hadeeth(
      {required this.rawi,
      required this.hadeeth,
      required this.degree,
      this.state = 0});
}

class AhadeethModel extends ChangeNotifier {
  AhadeethModel() {
    setAhadeeth();
  }

  ///////////// AHADEETH LIST SETTERS AND GETTER ////////////////////////////////
  List _ahadeeth = [];

  List initList = [
    Hadeeth(
        rawi: 'عمر بن الخطاب',
        hadeeth: 'إنما الأعمال بالنيات',
        degree: 'متفق عليه'),
    Hadeeth(
        rawi: 'أبي ذر ومعاذ بن جبل',
        hadeeth: 'اتق الله حيثما كنت',
        degree: 'الترمذي وقال: حديث حسن'),
    Hadeeth(
        rawi: 'النواس بن سمعان',
        hadeeth: 'البر حسن الخلق',
        degree: 'صحيح مسلم'),
    Hadeeth(
        rawi: 'أبي ذر',
        hadeeth: 'لا تحقرن من المعروف شيئا',
        degree: 'صحيح مسلم')
  ];

  /// Sets the value of ahadeeth list to the loadData() or initList.
  void setAhadeeth() async {
    try {
      _ahadeeth = await loadData();
    } catch (e) {
      _ahadeeth = initList;
    }
    notifyListeners();
  }

  /// Sets the value of ahadeeth to initList
  void setToInitAhadeeth() {
    _ahadeeth = initList;
    saveData();
    notifyListeners();
  }

  List get ahadeeth => _ahadeeth;

  ///////////// SHARED PREFERENCES WORK ////////////////////////////////////////

  void saveHadeeth(Hadeeth h, int index) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    // await prefs.setString('rawi$index', h.rawi);
    // await prefs.setString('hadeeth$index', h.hadeeth);
    // await prefs.setString('degree$index', h.degree);

    await prefs.setStringList('hadeeth$index', [h.rawi, h.hadeeth, h.degree]);

    await prefs.setInt('state$index', h.state);
  }

  void saveData() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('length', ahadeeth.length);
    for (var i = 0; i < ahadeeth.length; i++) {
      saveHadeeth(ahadeeth[i], i);
    }
  }

  Future<List> loadData() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    int? len = prefs.getInt('length');
    List<Hadeeth> shPrList = [];
    for (var i = 0; i < len!; i++) {
      // String rawi = prefs.getString('rawi$i')!;
      // String hadeeth = prefs.getString('hadeeth$i')!;
      // String degree = prefs.getString('degree$i')!;

      List hData = prefs.getStringList('hadeeth$i')!;
      int state = prefs.getInt('state$i')!;
      shPrList.add(Hadeeth(
          rawi: hData[0], hadeeth: hData[1], degree: hData[2], state: state));
    }

    return shPrList;
  }

  //////////////////////////////////////////////////////////////////////////////
  void addHadeeth(Hadeeth h) {
    _ahadeeth.add(h);
    print(_ahadeeth.length);
    saveData();
    notifyListeners();
  }

  void remove(Hadeeth h) {
    _ahadeeth.remove(h);
    print(_ahadeeth.length);
    saveData();
    notifyListeners();
  }

  void clear() {
    _ahadeeth.clear();
    saveData();
    notifyListeners();
  }
}
