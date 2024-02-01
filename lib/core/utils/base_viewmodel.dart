import 'package:flutter/foundation.dart';
import 'package:tentwenty_assignment/core/enums/view_states.dart';

class BaseViewModel extends ChangeNotifier {
  bool _disposed = false;
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
