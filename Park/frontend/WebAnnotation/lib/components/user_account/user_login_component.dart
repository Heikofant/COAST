import 'dart:async';

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;
import 'package:WebAnnotation/app_service.dart';
import 'package:WebAnnotation/services/user_account_service.dart';

@Component(
    selector: 'user-login',
    styleUrls: const ['user.css'],
    templateUrl: 'user_login_component.html',
    directives: const [
      CORE_DIRECTIVES,
      materialDirectives,
      formDirectives
    ]
)
class UserLoginComponent implements OnInit {

  final AppService appService;
  final UserAccountService userAccountService;

  String emailText = "";
  String passwordText = "";

  UserLoginComponent(this.appService, this.userAccountService);

  @override
  Future<Null> ngOnInit() async {

  }

  void login() {
    appService.clearMessage();
    if(emailText.isEmpty || passwordText.isEmpty) {
      return;
    }

    userAccountService.login(emailText, passwordText).then((success) {
      if(!success) {
        appService.errorMessage(switchLang("Login fehlgeschlagen."));
        passwordText = "";
      }
    });
  }

  String switchLang(String s){
    if (langService.isEng){
      window.history.pushState('en','en','user-login/en');
    } else {
      window.history.pushState('de','de','user-login/de');
    }
    return langService.switchLang(s);
  }
}