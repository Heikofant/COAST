import 'dart:async';
import 'dart:html';
import 'package:WebAnnotation/components/text_analysis/text_lookup_component.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;
import 'package:WebAnnotation/app_service.dart';
import 'package:WebAnnotation/services/text_analysis_service.dart';
import 'package:WebAnnotation/services/user_account_service.dart';
import 'package:WebAnnotation/components/text_analysis/text_preview_component.dart';
import 'package:WebAnnotation/components/text_analysis/text_settings_component.dart';
import 'package:WebAnnotation/components/text_analysis/text_input_component.dart';

@Component(
  selector: 'text-analysis',
  styleUrls: const ['text_analysis.css'],
  templateUrl: 'text_analysis_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    formDirectives,
    TextPreviewComponent,
    TextSettingsComponent,
    TextInputComponent,
    MaterialToggleComponent,
    TextLookupComponent
  ],
  providers: const [],
)
class TextAnalysisComponent implements OnInit {
  final AppService appService;
  final TextAnalysisService textAnalysisService;
  final UserAccountService userAccountService;

  final RouteParams routeParams;
  final Router router;

  TextAnalysisComponent(this.appService, this.textAnalysisService, this.userAccountService, this.router, this.routeParams);

  @ViewChild(TextInputComponent)
  TextInputComponent textInputComponent;

  @override
  Future<Null> ngOnInit() async {
    var routerText = routeParams.get('text');
    if(routerText != null && routerText.isNotEmpty) {
      textAnalysisService.lookupText = routerText;
      textInputComponent.lookup();
    }
      else if(textAnalysisService.annotatedText != null) {
      textAnalysisService.lookupText = textAnalysisService.annotatedText.originalText;
      textAnalysisService.applyCurrentConfiguration();
      appService.scrollToTop();
    } //this else if part is questionable since the analysis of saved texts doesn't work properly

    if(userAccountService.loggedIn) {
      userAccountService.queryTextConfigurations().then((success) {
       if (!success) {
          print("WARNING: could not load text configurations");
        }

      });
    }
  }

  String switchLang(String s){
    if (langService.isEng){
      window.history.pushState('en','en','text-analysis/en');
    } else {
      window.history.pushState('de','de','text-analysis/de');
    }
    return langService.switchLang(s);
  }

}
