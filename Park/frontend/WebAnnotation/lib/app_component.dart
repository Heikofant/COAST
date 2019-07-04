// Copyright (c) 2017, oliver. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:WebAnnotation/components/user_account/user_textlist_component.dart';
import 'package:WebAnnotation/components/user_account/user_wordlist_component.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:WebAnnotation/services/lang_service.dart' as langService;
import 'package:WebAnnotation/services/text_analysis_service.dart';
import 'package:WebAnnotation/services/segmentation_verification_service.dart';
import 'package:WebAnnotation/services/segmentation_proposal_service.dart';
import 'package:WebAnnotation/services/user_account_service.dart';
import 'package:WebAnnotation/components/user_account/user_delete_component.dart';
import 'package:WebAnnotation/components/text_analysis/text_analysis_component.dart';
import 'package:WebAnnotation/components/user_account/user_account_component.dart';
import 'package:WebAnnotation/components/word_review/word_review_component.dart';
import 'package:WebAnnotation/components/word_verification/word_verification_component.dart';
import 'package:WebAnnotation/components/home/home_component.dart';
import 'package:WebAnnotation/components/user_account/user_register_component.dart';
import 'package:WebAnnotation/app_service.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES, materialDirectives,
  formDirectives, TextAnalysisComponent, UserAccountComponent,
  WordReviewComponent, WordVerificationComponent, HomeComponent,
  UserRegisterComponent, UserDeleteComponent],
  providers: const [ROUTER_PROVIDERS, materialProviders, TextAnalysisService, UserDeleteComponent,
  UserAccountService, AppService, SegmentationProposalService, SegmentationVerificationService],
)
@RouteConfig(const [
  const Route(
      path: '/home',
      name: 'Home',
      component: HomeComponent,
      useAsDefault: true),
  const Route(
      path: '/text_analysis',
      name: 'TextAnalysis',
      component: TextAnalysisComponent),
  const Route(
      path: '/text_analysis/:text',
      name: 'TextAnalysisParam',
      component: TextAnalysisComponent),
  const Route(
      path: '/word_review/:wordIndex',
      name: 'WordReview',
      component: WordReviewComponent),
  const Route(
      path: '/word_verification/',
      name: 'WordVerification',
      component: WordVerificationComponent),
  const Route(
      path: '/user_account',
      name: 'UserAccount',
      component: UserAccountComponent),
    const Route(
        path: '/user_register',
        name: 'UserRegister',
        component: UserRegisterComponent),
    const Route(
        path: 'user_delete',
        name: 'DeleteUser',
        component: UserDeleteComponent),
  const Route(
      path: 'user-textlist',
      name: 'UserText',
      component: UserTextlistComponent),
  const Route(
      path: 'user-wordlist',
      name: 'UserWord',
      component: UserWordlistComponent),
  const Route(
      path: '/**',
      name: 'NotFound',
      component: HomeComponent)
])
class AppComponent implements OnInit {

  final AppService appService;
  final TextAnalysisService textAnalysisService;
  final UserAccountService userAccountService;
  final Router router;

  AppComponent(this.appService, this.textAnalysisService, this.userAccountService);

  @override
  ngOnInit() async {

  }

  void Pger(){
    langService.isEng = false;
  }

  void Peng(){
    langService.isEng = true;
  }

  String userText() {
    if(userAccountService.loggedIn) {
      return userAccountService.email;
    }

    return "Login";
  }

  String info() {
    return appService.infoMessageText;
  }

  String error() {
    return appService.errorMessageText;
  }

  String switchLang(String s){

    return langService.switchLang(s);
  }

}
