//import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tripso/mobile/screens/home/home_screen.dart';
// import 'package:tripso/shared/adaptive/dialog.dart';
// import 'package:tripso/shared/animation/fade_animation.dart';
// import 'package:tripso/shared/components/app_bar.dart';
// import 'package:tripso/shared/components/buttons.dart';
// import 'package:tripso/shared/components/navigator.dart';
// import 'package:tripso/shared/components/scrollable_form.dart';
// import 'package:tripso/shared/components/sized_box.dart';
// import 'package:tripso/shared/components/text_form_field.dart';
// import 'package:tripso/shared/constants/constants.dart';
// import 'package:tripso/shared/cubit/SignUpCubit/sign_up_state.dart';
// import 'package:tripso/shared/cubit/signUpCubit/sign_up_cubit.dart';
// import 'package:tripso/shared/network/cache_helper.dart';
// import 'package:tripso/shared/styles/asset_path.dart';
// import 'package:tripso/shared/styles/colors.dart';
//
// class SignUpScreen extends StatelessWidget {
//   static const String routeName = 'sign_up_screen';
//
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var formKey = GlobalKey<FormState>();
//     var firstnameController = TextEditingController();
//     var lastnameController = TextEditingController();
//     var emailController = TextEditingController();
//     var passwordController = TextEditingController();
//     return BlocProvider(
//       create: (BuildContext context) => SignUpCubit(),
//       child:
//       BlocConsumer<SignUpCubit, SignUpStates>(listener: (context, state) {
//         if (state is! SignUpLoadingState) {
//           MyDialog.showLoadingDialog(context, 'Loading...');
//           if (state is UserCreateSuccessState) {
//             MyDialog.showLoadingDialog(context, 'SignUp is successfully');
//             CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
//               uId = state.uid;
//               MyDialog.hideDialog(context);
//               navigateAndFinish(context, routeName: HomeScreen.routeName);
//             });
//           } else if (state is UserCreateErrorState) {
//             MyDialog.showLoadingDialog(context, 'SignUp is Error');
//             MyDialog.hideDialog(context);
//             MyDialog.showMessage(context, 'SignUp is Error',
//                 posActionTitle: 'Try Again',
//                 posAction: () {
//                   if (formKey.currentState!.validate()) {
//                     SignUpCubit.get(context).userSignUp(
//                       email: emailController.text,
//                       password: passwordController.text,
//                       firstName: firstnameController.text,
//                       lastName: lastnameController.text,
//                     );
//                     emailController.clear();
//                     passwordController.clear();
//                     firstnameController.clear();
//                     lastnameController.clear();
//                   }
//                 },
//                 negActionTitle: 'Cancel',
//                 negAction: () {
//                   Navigator.pop(context);
//                 });
//           }
//         }
//       }, builder: (context, state) {
//         return Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(AssetPath.signUPImage),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: FadeAnimation(
//             1.0,
//             child: Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: secondaryAppBar(),
//               body: CustomScrollableForm(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           pop(context);
//                         },
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           size: 25,
//                           color: secondaryColor,
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(
//                                 top: 30, bottom: 28, right: 20, left: 20),
//                             child: const Text(
//                               'Create Account',
//                               style: TextStyle(
//                                   fontSize: 30,
//                                   color: secondaryColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           const Space(width: 0, height: 32),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 50),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'First Name',
//                                   style: TextStyle(
//                                     color: secondaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const Space(width: 0, height: 8),
//                                 DefaultTextFormField(
//                                   color: secondaryColor.withOpacity(0.3),
//                                   context: context,
//                                   controller: firstnameController,
//                                   keyboardType: TextInputType.name,
//                                   validate: (String? value) {
//                                     if (value!.isEmpty) {
//                                       return 'First Name is Required';
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.edit_outlined,
//                                   hint: 'First Name',
//                                 ),
//                                 const Space(width: 0, height: 20),
//                                 const Text(
//                                   'Last Name',
//                                   style: TextStyle(
//                                     color: secondaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const Space(width: 0, height: 8),
//                                 DefaultTextFormField(
//                                   color: secondaryColor.withOpacity(0.3),
//                                   context: context,
//                                   controller: lastnameController,
//                                   keyboardType: TextInputType.name,
//                                   validate: (String? value) {
//                                     if (value!.isEmpty) {
//                                       return 'Last Name is Required';
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.edit_outlined,
//                                   hint: 'Last Name',
//                                 ),
//                                 const Space(width: 0, height: 20),
//                                 const Text(
//                                   'Email Address',
//                                   style: TextStyle(
//                                     color: secondaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const Space(width: 0, height: 8),
//                                 DefaultTextFormField(
//                                   color: secondaryColor.withOpacity(0.3),
//                                   context: context,
//                                   controller: emailController,
//                                   keyboardType: TextInputType.emailAddress,
//                                   validate: (String? value) {
//                                     if (value!.isEmpty) {
//                                       return 'Email is Required';
//                                     } else if (value.length < 16) {
//                                       return 'Sorry, your mail must be\n between 16 and 30 characters long.';
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                   prefix: Icons.alternate_email,
//                                   hint: 'Email Address',
//                                 ),
//                                 const Space(width: 0, height: 20),
//                                 const Text(
//                                   'Password',
//                                   style: TextStyle(
//                                     color: secondaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const Space(width: 0, height: 8),
//                                 DefaultTextFormField(
//                                   color: secondaryColor.withOpacity(0.3),
//                                   context: context,
//                                   obscuringCharacter: '*',
//                                   controller: passwordController,
//                                   keyboardType: TextInputType.visiblePassword,
//                                   validate: (String? value) {
//                                     if (value!.isEmpty) {
//                                       return "Password is Required";
//                                     } else if (value.length < 8) {
//                                       return "Use, 8 characters or more for your password";
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.lock_outline_sharp,
//                                   suffix: SignUpCubit.get(context).suffix,
//                                   isPassword:
//                                   SignUpCubit.get(context).isPassword,
//                                   suffixPressed: () {
//                                     SignUpCubit.get(context).showPassword();
//                                   },
//                                   hint: 'Password',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Space(width: 0, height: 70),
//                           defaultMaterialButton(
//                             function: () {
//                               if (formKey.currentState!.validate()) {
//                                 SignUpCubit.get(context).userSignUp(
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                   firstName: firstnameController.text,
//                                   lastName: lastnameController.text,
//                                 );
//                                 emailController.clear();
//                                 passwordController.clear();
//                                 firstnameController.clear();
//                                 lastnameController.clear();
//                               }
//                             },
//                             text: 'Sign up',
//                             color: primaryColor,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }




















//MaterialButton(
//                             onPressed: () async {
//                               try {
//                                 // Call auth.registerData() to add user data to database
//                                 await auth.registerData(
//                                   // Personal Information
//                                   first_nameController.text.trim(),
//                                   last_nameController.text.trim(),
//                                   phone_numberController.text.trim(),
//                                   emailController.text.trim(),
//                                   passwordController.text.trim(),
//                                   confirm_passwordController.text.trim(),
//                                   date_of_birthController.text.trim(),
//                                   addressController.text.trim(),
//                                   // Gender Information
//                                   Male,
//                                   Female,
//                                   // Medical Information
//                                   Yes_P,
//                                   No_P,
//                                   yes,
//                                   no,
//                                   blood_typeController.text.trim(),
//                                   health_problemsController.text.trim(),
//                                   // Car Information
//                                   plate_NOController.text.trim(),
//                                   modelController.text.trim(),
//                                   colorController.text.trim(),
//                                 );
//                                 // Navigate to sign-in page after successful registration
//                                 Navigator.pushNamed(context, LoginScreen.screenRoute);
//                               } catch (e) {
//                                 // Handle registration error
//                                 print('Registration Error: $e');
//                               }
//                             },