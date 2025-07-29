import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:talawa/view_model/main_screen_view_model.dart";

/// A robot class to automate interactions with the login form during integration tests.
class LoginFormRobot {
  const LoginFormRobot(this.tester);

  /// The [WidgetTester] instance used to interact with widgets during tests.
  final WidgetTester tester;

  /// Initializes the app and then login as Admin.
  ///
  /// This method performs the following steps:
  /// 1. Selects the language.
  /// 2. Opens the login form.
  /// 3. Enters the email and password for the admin user.
  /// 4. Submits the login form.
  ///
  /// **params**:
  ///   None
  ///
  /// **returns**:
  ///   None
  Future<void> loginAdmin() async {
    await _selectLanguage();
    await _openLoginForm();
    await _enterEmailAndPassword("testadmin1@example.com", "Pass@123");
    await _submit();
    expect(find.text("Unity Foundation - North"), findsOneWidget);
  }

  /// Select the English language from the language selection screen.
  ///
  /// **params**:
  ///   None
  ///
  /// **returns**:
  ///   None
  Future<void> _selectLanguage() async {
    await tester.pumpAndSettle(const Duration(seconds: 5));
    final Finder selectLanguageButton =
        find.byKey(const Key('SelectLangTextButton'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 500));
    expect(selectLanguageButton, findsOneWidget);
    await tester.tap(selectLanguageButton);
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.text('Skip'));
    print("Language selected");
  }

  /// Opens Login Form.
  ///
  /// This method performs the following steps:
  /// 1. Taps on the custom drawer button.
  /// 2. Taps on the "Join new Organization" button.
  /// 3. Taps on the "Login" button.
  /// **params**:
  ///   None
  ///
  /// **returns**:
  ///   None
  Future<void> _openLoginForm() async {
    await tester.pumpAndSettle(const Duration(seconds: 3));
    print("Finding Custom Drawer");

    final scaffoldState = MainScreenViewModel.scaffoldKey.currentState;
    if (scaffoldState == null) {
      throw Exception(
          "scaffoldKey.currentState is null. Is your widget fully built?",);
    }
    scaffoldState.openDrawer();

    await tester.pumpAndSettle(const Duration(seconds: 3));
    print("Custom Drawer opened");

    print("Finding Join new Organization button");
    // final Finder joinButton = find.byKey(MainScreenViewModel.keyDrawerJoinOrg);
    // expect(joinButton, findsOneWidget);
    // print("Join new Organization button found");
    // await tester.tap(joinButton);
    await tester.tap(find.widgetWithIcon(ListTile, Icons.add));
    print("Join new Organization button tapped");
    await tester.pumpAndSettle(const Duration(seconds: 3));
    final Finder loginButton = find.text('Login');
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  }

  /// Enter credentials in the Login Form.
  ///
  /// **params**:
  /// * `email`: Email address of the user/admin (i.e. testadmin1@example.com, testuser1@example.com).
  /// * `password`: Password of the user. (i.e. Pass@123)
  ///
  /// **returns**:
  ///   None
  Future<void> _enterEmailAndPassword(String email, String password) async {
    final Finder emailField = find.byKey(const Key('EmailInputField'));
    final Finder passwordField = find.byKey(const Key('PasswordInputField'));
    await tester.enterText(emailField, email);
    await tester.enterText(passwordField, password);
  }

  /// Submits the login form and redirects it.
  ///
  /// **params**:
  ///   None
  ///
  /// **returns**:
  ///   None
  Future<void> _submit() async {
    final Finder loginButton = find.byKey(const Key('LoginButton'));
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }
}
