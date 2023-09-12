import '/resources/pages/profile_page.dart';
import '/resources/pages/akun_page.dart';
import '/resources/pages/main_page.dart';
import '/resources/pages/kelahiran_page.dart';
import '/resources/pages/pernikahan_page.dart';
// import '../resources/pages/home_page.dart';
import '/resources/pages/register_page.dart';
import '/resources/pages/login_page.dart';
// import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

import 'guards/auth_route_guard.dart';

/*
|--------------------------------------------------------------------------
| App Router
|
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
| Learn more https://nylo.dev/docs/5.x/router
|--------------------------------------------------------------------------
*/

appRouter() => nyRoutes((router) {
  // router.route(HomePage.path, (context) => HomePage(), initialRoute: false, authPage: true, routeGuards: [AuthRouteGuard()]);
  // Add your routes here

  // router.route(NewPage.path, (context) => NewPage(), transition: PageTransitionType.fade);

  router.route(LoginPage.path, (context) => LoginPage(), initialRoute: true);

  router.route(RegisterPage.path, (context) => RegisterPage());

  router.route(MainPage.path, (context) => MainPage(), initialRoute: false, authPage: true, routeGuards: [AuthRouteGuard()]);

  router.route(PernikahanPage.path, (context) => PernikahanPage(), initialRoute: false, authPage: true, routeGuards: [AuthRouteGuard()]);

  router.route(KelahiranPage.path, (context) => KelahiranPage());


  router.route(AkunPage.path, (context) => AkunPage());

  router.route(ProfilePage.path, (context) => ProfilePage());
});
  
  
  
  
  
  
  