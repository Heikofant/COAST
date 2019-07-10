import 'package:angular/angular.dart';
import 'dart:html';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;
import 'package:WebAnnotation/components/text_analysis/word_detail_component.dart';
import 'package:WebAnnotation/app_service.dart';
import 'package:WebAnnotation/services/text_analysis_service.dart';
import 'package:WebAnnotation/services/user_account_service.dart';
import 'package:WebAnnotation/model/text_annotation/Word.dart';
import 'package:WebAnnotation/model/text_annotation/AnnotationText.dart';
import 'package:WebAnnotation/components/text_analysis/text_lookup_component.dart';

@Component(
  selector: 'text-preview',
  styleUrls: const ['text_analysis.css'],
  templateUrl: 'text_preview_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    formDirectives,
    WordDetailComponent
  ],
  providers: const []
)
class TextPreviewComponent implements OnInit {
  final AppService appService;
  final TextAnalysisService textAnalysisService;
  final UserAccountService userAccountService;
  Map found;

  final Router router;

  TextPreviewComponent(this.appService, this.textAnalysisService,
      this.userAccountService, this.router);

  @override
  ngOnInit() {

  }

  AnnotationText annotatedText() {
    return textAnalysisService.annotatedText;
  }

  bool hasUnknownWords() {
    return textAnalysisService.annotatedText.nextMissingWord() != null;
  }

  String letterSpacing() {
    return textAnalysisService.selectedConfiguration.letter_spacing.toString() + 'px';
  }

  bool useSyllableSeparator() {
    return textAnalysisService.selectedConfiguration.use_syllable_separator;
  }

  String syllableSeparator() {
    return textAnalysisService.selectedConfiguration.syllable_separator;
  }

  void startWordReview() {
    // search first unknown word
    Word w = textAnalysisService.annotatedText.nextMissingWord();
    if(w == null) {
      appService.infoMessage(switchLang("Keine unbekannten Wörter."));
      return;
    }

    wordReview(w);
  }

  void wordReview(Word word) {
    if(userAccountService.loggedIn) {
      router.navigate(['WordReview', {'wordIndex': textAnalysisService.annotatedText.words.indexOf(word).toString()}]);
    } else {
      router.navigate(['UserAccount']);
      appService.infoMessage(
          switchLang('Sie müssen eingeloggt sein, um Wörter hinzuzufügen.'));
    }
  }

  void editWord(Word word) {
    annotatedText().editWord(word);
    textAnalysisService.dictionary(word.text, word.lemma, word.posId).then((success) {
      found = textAnalysisService.found;
    });
  }
  
  void showPrint() {
    window.print();

  }

  void openReadingMode() {
    var elem = querySelector("#textPreviewDiv");
    elem.requestFullscreen();
    /*var btn = querySelector("#openReadingModeButton");
    btn.text = switchLang("Lesemodus beenden");
    */

  }


  void copyToClipboard() {
    var annotationText = querySelector("#annotationText");
    window.getSelection().selectAllChildren(annotationText);

    if(!document.execCommand("copy")) {
      appService.errorMessage(switchLang("Fehler beim kopieren. Bitte markieren Sie den Text und kopieren diesen manuell (Strg+C)."));
    } else {
      appService.infoMessage(switchLang("Der Text wurde in die Zwischenablage kopiert."));
    }

    window.getSelection().removeAllRanges();
  }

  String switchLang(String s){

    return langService.switchLang(s);
  }
}