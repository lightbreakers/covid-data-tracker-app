
import 'package:flutter/foundation.dart';

class StatePage with ChangeNotifier{
  int _page=0;
  int get page => _page;

  int _scrollCountry=1;
  int get scrollCountry => _scrollCountry;

  int _scrollState=1;
  int get scrollState => _scrollState;

  bool _scrollStateSet=true;
  bool get scrollStateSet => _scrollStateSet;

  bool _scrollCountrySet=true;
  bool get scrollCountrySet => _scrollCountrySet;


  void pagechange(int i) {
    _page = i;
    notifyListeners();
  }

  void countryIndex(x) {
    _scrollCountry = x;
    _scrollCountrySet = !_scrollCountrySet;
    notifyListeners();
  }

  void stateIndex(x) {
    _scrollState = x;
    _scrollStateSet = !_scrollStateSet;
    notifyListeners();
  }
  void stateSet(){
  _scrollStateSet = !_scrollStateSet;
  }
  void countrySet(){
  _scrollCountrySet = !_scrollCountrySet;
  }
}