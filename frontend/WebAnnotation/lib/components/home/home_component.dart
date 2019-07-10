import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;

@Component(
    selector: 'home',
    styleUrls: const ['home.css'],
    templateUrl: 'home_component.html',
    directives: const [
      CORE_DIRECTIVES,
      ROUTER_DIRECTIVES
    ]
)
class HomeComponent implements OnInit {

  @override
  ngOnInit() {
  }

  String switchLang(String s){
    if (langService.isEng){
      window.history.pushState('en','en','home/en');
    } else {
      window.history.pushState('de','de','home/de');
    }
    return langService.switchLang(s);
  }

}