import 'dart:math' as math;

class Backoff {
  int ms = 100;
  int max = 10000;
  int factor = 2;
  double jitter = 0.0;
  int attempts = 0;

  int duration() {
    int ms = this.ms * math.pow(factor, attempts++);

    if (jitter != 0.0) {
      final double rand = new math.Random().nextDouble();
      final int deviation = (rand * jitter * ms.toDouble()).toInt();
      ms = (rand * 10).floor() & 1 == 0 ? ms - deviation : ms + deviation;
    }

    return math.min(ms, max);
  }

  void reset() => attempts = 0;
}
