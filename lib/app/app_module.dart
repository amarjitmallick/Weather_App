import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/app/modules/home/data/home_module.dart';
import 'package:weather_app/app/modules/splash/data/splash_module.dart';
import 'package:weather_app/app/utils/routes.dart';

class AppModule extends Module {

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: SplashModule()),
        ModuleRoute(Routes.home, module: HomeModule()),
      ];
}
