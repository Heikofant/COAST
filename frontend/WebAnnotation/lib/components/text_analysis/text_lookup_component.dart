import 'dart:async';
import 'package:WebAnnotation/model/text_annotation/Word.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;
import 'package:WebAnnotation/app_service.dart';
import 'package:WebAnnotation/services/text_analysis_service.dart';
import 'package:WebAnnotation/services/user_account_service.dart';

@Component(
  selector: 'text-lookup',
  styleUrls: const ['text_analysis.css'],
  templateUrl: 'text_lookup_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    formDirectives
  ],
  providers: const [],
)
class TextLookupComponent implements OnInit {
  final AppService appService;
  final TextAnalysisService textAnalysisService;
  Map found;
  bool lookingup = false;

  TextLookupComponent(this.appService, this.textAnalysisService);

  @override
  ngOnInit() {

  }

  void dictionary(String values, String lemma, String pos) {
    if (values == null || values.isEmpty) return;
    lookingup = true;
    textAnalysisService.dictionary(values, lemma, pos).then((success) {
      lookingup = false;
      if (!success) {
        appService.errorMessage(switchLang("Fehler beim Wortsuchen. Versuchen Sie bitte nochmal."));
      } else {
        found = textAnalysisService.found;
      }
    });
  }

  String switchLang(String s) {
    return langService.switchLang(s);
  }


}