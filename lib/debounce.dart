import 'dart:async';

class Debounce {
  Debounce(this.timeout);

  Timer? _timer;
  final Duration timeout;

  void call(void Function() action) {
    if (_timer?.isActive ?? false) {
    } else {
      action();
      _timer = Timer(
        timeout,
        () {},
      );
    }
  }
}
