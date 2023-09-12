import 'package:nylo_framework/nylo_framework.dart';

import '../../bootstrap/helpers.dart';

class AuthProvider implements NyProvider {
  @override
  boot(Nylo nylo) async {
    await event<SyncAuthToBackpackEvent>();

    return nylo;
  }

  @override
  afterBoot(Nylo nylo) async {

  }
}
