import 'dart:async';
import 'dart:developer';

import 'package:trusted_time/trusted_time.dart';

class TrustedTimeService {
  StreamSubscription<IntegrityEvent>? _subscription;

  void startMonitoring({void Function(TamperReason reason)? onIntegrityLost}) {
    log("start Monitoring Event Start");
    _subscription?.cancel();

    _subscription = TrustedTime.onIntegrityLost.listen((event) {
      log('TrustedTime event: ${event.reason}');

      switch (event.reason) {
        case TamperReason.systemClockJumped:
          log('⚠️ System clock changed');
          break;

        case TamperReason.deviceRebooted:
          log('⚠️ Device rebooted');
          break;

        case TamperReason.timezoneChanged:
          log('⚠️ Timezone changed');
          break;

        case TamperReason.forcedNtpSync:
          log('ℹ️ Forced NTP sync');
          break;

        case TamperReason.unknown:
          log('⚠️ Unknown integrity event');
          break;
      }

      onIntegrityLost?.call(event.reason);
    });
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
