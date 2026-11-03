import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  String ngonNgu = 'vi';
  ThemeMode themeMode = ThemeMode.light;
  List<String> lichSuTim = [];

  SettingsService() {
    _docCaiDat();
  }

  Future<void> _docCaiDat() async {
    final sp = await SharedPreferences.getInstance();
    ngonNgu = sp.getString('ngon_ngu') ?? 'vi';
    themeMode = (sp.getBool('che_do_toi') ?? false)
        ? ThemeMode.dark
        : ThemeMode.light;
    lichSuTim = sp.getStringList('lich_su_tim') ?? [];
    notifyListeners();
  }

  Future<void> doiNgonNgu(String ma) async {
    ngonNgu = ma;
    notifyListeners();
    final sp = await SharedPreferences.getInstance();
    await sp.setString('ngon_ngu', ma);
  }

  Future<void> doiCheDoToi(bool bat) async {
    themeMode = bat ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('che_do_toi', bat);
  }

  Future<void> _luuLichSuTim() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setStringList('lich_su_tim', lichSuTim);
  }

  Future<void> themLichSuTim(String tuKhoa) async {
    final tu = tuKhoa.trim();
    if (tu.isEmpty) return;
    lichSuTim.remove(tu);
    lichSuTim.insert(0, tu);
    if (lichSuTim.length > 10) {
      lichSuTim = lichSuTim.sublist(0, 10);
    }
    notifyListeners();
    await _luuLichSuTim();
  }

  Future<void> xoaLichSuTim(String tuKhoa) async {
    lichSuTim.remove(tuKhoa);
    notifyListeners();
    await _luuLichSuTim();
  }

  Future<void> xoaHetLichSuTim() async {
    lichSuTim = [];
    notifyListeners();
    await _luuLichSuTim();
  }
}

final SettingsService caiDat = SettingsService();

String tr(String vi, String en) => caiDat.ngonNgu == 'vi' ? vi : en;
