import 'package:WebAnnotation/model/text_annotation/Word.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;
import 'package:WebAnnotation/app_service.dart';
import 'package:WebAnnotation/services/text_analysis_service.dart';
import 'package:WebAnnotation/services/user_account_service.dart';

@Component(
  selector: 'text-input',
  styleUrls: const ['text_analysis.css'],
  templateUrl: 'text_input_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    formDirectives
  ],
  providers: const [],
)
class TextInputComponent implements OnInit {
  final AppService appService;
  final TextAnalysisService textAnalysisService;
  final UserAccountService userAccountService;
  Word word;

  TextInputComponent(this.appService, this.textAnalysisService, this.userAccountService);

  String textTitle = '';

  @override
  ngOnInit() {

  }

  void newText() {
    appService.clearMessage();
    textAnalysisService.clearText();
  }

  void saveText() {
    if(textTitle.isEmpty) {
      appService.errorMessage(switchLang("Bitte Titel eingeben."));
      return;
    }

    if(textAnalysisService.lookupText.isEmpty) {
      appService.errorMessage(switchLang("Bitte Text eingeben."));
      return;
    }

    appService.clearMessage();
    userAccountService.addText(textTitle, textAnalysisService.lookupText).then((success) {
      if(success) {
        appService.infoMessage(switchLang("Text hinzugefügt."));
      } else {
        appService.errorMessage(switchLang("Fehler beim speichern des Texts."));
      }
    });
  }

  String numInputRows() {
    if(textAnalysisService.annotatedText == null) {
      return "10";
    } else {
      return "5";
    }
  }

  void lookup() {
    appService.clearMessage();
    var userData = userAccountService.credentials();
    textAnalysisService.lookup(userData).then((success) {
      if(!success) {
        appService.errorMessage(switchLang("Der Text konnte nicht analysiert werden."));
      } else {

        appService.infoMessage(switchLang("Der Text wurde erfolgreich analysiert und wird in der Vorschau hervorgehoben dargestellt. Sie können in der Vorschau jedes Wort bearbeiten, indem Sie darauf klicken."));

        textAnalysisService.applyCurrentConfiguration();
        textAnalysisService.updatePOS();
      }
    });
  }

  String switchLang(String s){

    return langService.switchLang(s);
  }
}