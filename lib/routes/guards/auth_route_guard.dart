import 'package:flutter/material.dart';
// import 'package:com.wentox.pelayanansyukurgpm/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../resources/pages/main_page.dart';

/*
|--------------------------------------------------------------------------
| Auth Route Guard
|
| Checks if the User is authenticated.
| Learn more https://nylo.dev/docs/5.x/router#route-guards
|--------------------------------------------------------------------------
*/

class AuthRouteGuard extends NyRouteGuard {
  AuthRouteGuard();

  @override
  Future<bool> canOpen(BuildContext? context, NyArgument? data) async {
    return (await Auth.loggedIn());
  }

  @override
  redirectTo(BuildContext? context, NyArgument? data) async {
    await routeTo(MainPage.path);
  }
}
