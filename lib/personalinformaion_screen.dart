//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
//import 'package:udemy_flutter/login_screen.dart';
//import 'package:http/http.dart'as http;
import 'package:udemy_flutter/auth_services.dart';
import 'login_screen.dart';
//import 'dart:convert';

class PersonalInformationScreen extends StatefulWidget {
  static const String screenRoute = 'personalinformation_screen';
  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final auth = AuthServices();
  // personal

  final TextEditingController first_nameController = TextEditingController();
  final TextEditingController last_nameController = TextEditingController();
  final TextEditingController phone_numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirm_passwordController = TextEditingController();
  final TextEditingController date_of_birthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool Male = false;
  bool Female = false;

// medical
  bool Yes_P = false;
  bool No_P = false;
  bool yes = false;
  bool no = false;
  final TextEditingController blood_typeController = TextEditingController();
  final TextEditingController health_problemsController = TextEditingController();

  // car
  final TextEditingController plate_NOController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController modelController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ),
          onPressed: () {
              Navigator.pushNamed(context, LoginScreen.screenRoute);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Personal Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: first_nameController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'First Name is Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'First Name',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: last_nameController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Last Name is Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: phone_numberController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is Required';
                    }
                    else if (value.length != 11) {
                      return 'Sorry, your phone must be\n 11 numbers long.';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email is Required';
                    }
                    else if (value.length < 16) {
                      return 'Sorry, your mail must be\n between 16 and 30 characters long.';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'example@gmail.com',
                    hintStyle: TextStyle(
                        color: Colors.white70,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password';
                    }
                    else if (value.length < 8) {
                      return "Use, 8 characters or more for your password";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: confirm_passwordController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Confirm Password';
                    }
                    print(passwordController.text);

                    print(confirm_passwordController.text);

                    if(passwordController.text!=confirm_passwordController.text){
                      return "Password does not match";
                    }

                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  // onChanged: (String value)
                  // {
                  //   print(value);
                  //
                  // },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: date_of_birthController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Data of Birth ';
                    }
                    return null;
                  },
                  // onChanged: (String value)
                  // {
                  //   print(value);
                  //
                  // },
                  decoration: InputDecoration(
                    labelText: 'Date Of Birth',
                    hintText: '2001/5/14',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: addressController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Adderss is Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Adderss',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  children: [
                    Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      'Male',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Checkbox(
                        activeColor: Colors.orangeAccent,
                        checkColor: Colors.white,
                        value: Male,
                        onChanged: (value) {
                          setState(() {
                            Male=value!;
                          });
                        }),
                    SizedBox(
                      width: 140.0,
                    ),
                    Text(
                      'Female',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Checkbox(
                        activeColor: Colors.orangeAccent,
                        checkColor: Colors.white,
                        value: Female,
                        onChanged: (value) {
                          setState(() {
                            Female = value!;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),

                // Medical screen
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Medical Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Do you have a blood pressure ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Checkbox(
                            activeColor: Colors.orangeAccent,
                            checkColor: Colors.white,
                            value: Yes_P,
                            onChanged: (value) {
                              setState(() {
                                Yes_P = value!;
                              });
                            }),
                        SizedBox(
                          width: 180.0,
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Checkbox(
                            activeColor: Colors.orangeAccent,
                            checkColor: Colors.white,
                            value: No_P,
                            onChanged: (value) {
                              setState(() {
                                No_P = value!;
                              });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Do you have diabetes problems ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'yes',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Checkbox(
                                activeColor: Colors.orangeAccent,
                                checkColor: Colors.white,
                                value: yes,
                                onChanged: (value) {
                                  setState(() {
                                    yes = value!;
                                  });
                                }),
                            SizedBox(
                              width: 180.0,
                            ),
                            Text(
                              'no',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Checkbox(
                                activeColor: Colors.orangeAccent,
                                checkColor: Colors.white,
                                value: no,
                                onChanged: (value) {
                                  setState(() {
                                    no = value!;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: blood_typeController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Blood Type is Required';
                        }
                        return null;
                      },
                      // onChanged: (String value)
                      // {
                      //   print(value);
                      //
                      // },
                      decoration: InputDecoration(
                        labelText: 'Blood Type',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: health_problemsController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Health Problems is Required';
                        }
                        return null;
                      },
                      // onChanged: (String value)
                      // {
                      //   print(value);
                      //
                      // },
                      decoration: InputDecoration(
                        labelText: 'Health Problems',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    // car screen
                    Column(
                      children: [
                        Text(
                          'Car Information',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: modelController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Car Model is Required';
                            }
                            return null;
                          },
                          // onChanged: (String value)
                          // {
                          //   print(value);
                          // },
                          decoration: InputDecoration(
                            labelText: 'Car Model',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: colorController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Car Color is Required';
                            }
                            return null;
                          },
                          // onChanged: (String value)
                          // {
                          //   print(value);
                          // },
                          decoration: InputDecoration(
                            labelText: 'Car Color',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: plate_NOController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Plate Number is Required';
                            }
                            return null;
                          },
                          // onChanged: (String value)
                          // {
                          //   print(value);
                          //
                          // },
                          decoration: InputDecoration(
                            labelText: 'Plate Number',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFFffae46),
                          ),
                          width: double.infinity,
                          height: 35.0,
                          child: MaterialButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate())
                              {
                                      try{
                                 await auth.registerData(
                                   // Personal Information
                                 first_nameController.text.trim(),
                                  last_nameController.text.trim(),
                                   phone_numberController.text.trim(),
                                  emailController.text.trim(),
                                    passwordController.text.trim(),
                                    confirm_passwordController.text.trim(),
                                   date_of_birthController.text.trim(),
                                        addressController.text.trim(),
                                 // Gender Information
                                    Male,
                                     Female,
                                //  // Medical Information
                                  Yes_P,
                                   No_P,
                                   yes,
                                    no,
                                   blood_typeController.text.trim(),
                                   health_problemsController.text.trim(),
                                // // Car Information
                                 plate_NOController.text.trim(),
                                    modelController.text.trim(),
                                     colorController.text.trim(),
                                 );
                                //   // Navigate to sign-in page after successful registration
                                   Navigator.pushNamed(context, LoginScreen.screenRoute);
                                  }
                                   catch (e) {
                                  // Handle registration error
                                print('Registration Error: $e');
                              }
                              }
                            },

                            child: Text(
                              'Finish',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
