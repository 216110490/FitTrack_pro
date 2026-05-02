import 'package:flutter/material.dart';

import '../models/fitness_tip.dart';
import '../services/api_service.dart';

class TipProvider extends ChangeNotifier {
  FitnessTip? tip;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadTip() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      tip = await ApiService.fetchFitnessTip();
    } catch (e) {
      errorMessage = 'Could not load tip. Check internet connection.';
    }

    isLoading = false;
    notifyListeners();
  }
}
