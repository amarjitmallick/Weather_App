import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/app/modules/home/data/home_store.dart';
import 'package:weather_app/app/modules/home/ui/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
      ];
}
