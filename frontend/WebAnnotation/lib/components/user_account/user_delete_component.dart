import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;
import 'package:WebAnnotation/app_service.dart';
import 'package:WebAnnotation/services/user_account_service.dart';
import 'package:angular_router/angular_router.dart';

@Component(
    selector: 'user-delete',
    styleUrls: const ['user.css'],
    templateUrl: 'user_delete_component.html',
    directives: const [
      CORE_DIRECTIVES,
      materialDirectives,
      formDirectives
    ]
)
class UserDeleteComponent implements OnInit {

  final AppService appService;
  final UserAccountService userAccountService;
  final Router router;

  String passwordText = "";

  UserDeleteComponent(this.appService, this.userAccountService, this.router);

  @override
  Future<Null> ngOnInit() async {

  }

  void deleteUser() {
    appService.clearMessage();
    if(passwordText.isEmpty) {
      return;
    }

    userAccountService.deleteUser(passwordText).then((success) {
      if (!success) {
        appService.errorMessage(switchLang("Fehler beim Kontolöschen. Versuchen Sie bitte nochmal."));
      } else {
        appService.infoMessage(
            switchLang("Ihr Konto wurde erfolgreich gelöscht."));
        router.navigate(['Home']);
      }
    });
  }

  String switchLang(String s){
    if (langService.isEng){
      window.history.pushState('en','en','user-delete/en');
    } else {
      window.history.pushState('de','de','user-delete/de');
    }
    return langService.switchLang(s);
  }
}