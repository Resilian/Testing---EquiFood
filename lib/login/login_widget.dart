import 'package:equi_food_app/admin/adminpage.dart';
import 'package:equi_food_app/backend/backend.dart';
import 'package:equi_food_app/indiv_dashboard/indivDashboard.dart';
import 'package:equi_food_app/main.dart';
import 'package:equi_food_app/register/createUser.dart';
import 'package:equi_food_app/renderDashboard.dart';
import 'package:equi_food_app/restaurant_dashboard/restaurant_dashboard_widget_2.dart';
import 'package:equi_food_app/utils/displayAlert.dart';
import 'package:equi_food_app/utils/displaySnackbar.dart';

import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart'; // for user authentication
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_services.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController? emailTextController;
  TextEditingController? passwordTextController;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility = false;
  }

  /* method called to get rid of memory
     associated with the variables mentioned below
  */
  @override
  void dispose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    super.dispose();
  }

  // method to sign IN user with email and password
  // will only be called if the user chooses to authenticate with email and not other available providers
  Future signInUser() async {
    if (errorcheck()) {
      try {
        // NOTE: the '!' in front of email and password variables is to check if either of these are null
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailTextController!.text.trim(),
            password: passwordTextController!.text.trim());
      } on FirebaseAuthException catch (e) {
        String errorMsg = "An unknown error occurred. Could not log in user.";

        if (e.code == 'user-not-found') {
          errorMsg = "Could not found your account. Please try to sign up.";
        } else if (e.code == 'wrong-password') {
          errorMsg = "Incorrect password.";
        }

        // display error message to the user
        displaySnackbar(context, errorMsg);

        return;
      }

      // Navigator user to the RenderDashboard Page, which will redirect them to the
      // appropriate dashboard according to the user type
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => RenderDashboardWidget()),
          (route) => false);
    }
  }

  bool errorcheck() {
    if (emailTextController!.text.isEmpty ||
        passwordTextController!.text.isEmpty) {
      displayAlert(context, "Please fill up text boxes.");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () async {
                      context.pop();
                    },
                    child: Image.asset(
                      'assets/images/tempLogo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F4F8),
                      ),
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                        child: Text(
                          'Sign In',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Inter',
                                color: Color(0xFF0F1113),
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupWidget()),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                        ),
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Text(
                            'Sign Up',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF57636C),
                                  fontSize: 32,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Log in to your account below!',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Inter',
                            color: Color(0xFF57636C),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: TextFormField(
                      controller: emailTextController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Your email address',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF57636C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF57636C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Inter',
                            color: Color(0xFF0F1113),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: TextFormField(
                      controller: passwordTextController,
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF57636C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF57636C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordVisibility = !passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF57636C),
                            size: 22,
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Inter',
                            color: Color(0xFF0F1113),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: signInUser,
                        text: 'Login',
                        options: FFButtonOptions(
                          width: 150,
                          height: 50,
                          color: Color.fromARGB(255, 76, 191, 82),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                child: InkWell(
                    child: Text.rich(
                        TextSpan(
                          text: "Don't have account?",
                          children: <InlineSpan>[
                            TextSpan(
                                text: " Sign up",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 17, 154, 233)))
                          ],
                        ),
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Inter',
                            color: Color.fromARGB(255, 19, 19, 19),
                            fontSize: 16,
                            fontWeight: FontWeight.w300)),
                    onTap: () => {Navigator.of(context).pop()}),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 50,
                      fillColor: Colors.white,
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xFF0F1113),
                        size: 24,
                      ),
                      onPressed: () async {
                        await FirebaseServices().signInWithGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DonationsWidget())));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 50,
                      fillColor: Colors.white,
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                        color: Color(0xFF0F1113),
                        size: 24,
                      ),
                      onPressed: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        final user = await signInWithApple(context);
                        if (user == null) {
                          return;
                        }

                        context.goNamedAuth('setting', mounted);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
