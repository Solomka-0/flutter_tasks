import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/user.dart';
import 'user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _passState = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  List<String> _countries = ['Россия', 'Украина', 'Германия', 'Франция'];
  late String? _selectedCountry = null;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("RegisterForm"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (value) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              validator: _validateName,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Полное имя *",
                hintText: "Как люди вас называют?",
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              onSaved: (value) => newUser.name = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,
              autofocus: true,
              onFieldSubmitted: (value) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: "Как до вас дозвониться?",
                helperText: "Формат: +7 (XXX) XXX-XX XX",
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    _phoneController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                labelText: "Номер телефона *",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(RegExp(r'^[()\d \- +]{1,15}$'),
                    allow: true),
              ],
              validator: (value) => _validatePhoneNumer(value)
                  ? null
                  : "Номер телефона должен выглядеть как +7 (XXX) XXX-XX XX",
              onSaved: (value) => newUser.phone = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Адрес электронной почты",
                hintText: "Введите адрес электронной почты",
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              // validator: _validateEmail,
              onSaved: (value) => newUser.email = value,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: "Страна"),
              items: _countries.map((country) {
                return DropdownMenuItem(child: Text(country), value: country);
              }).toList(),
              onChanged: (String? country) {
                print(country);
                setState(() {
                  _selectedCountry = country;
                });
              },
              value: _selectedCountry,
              validator: (val) {
                return val == null ? "Пожалуйста, выберите страну" : null;
              },
              onSaved: (String? value) => newUser.country = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              controller: _storyController,
              decoration: InputDecoration(
                labelText: "О себе",
                hintText: "Расскажите о себе",
                helperText: "Постарайтесь компактнее",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              onSaved: (value) => newUser.about = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              maxLength: 8,
              obscureText: _passState,
              decoration: InputDecoration(
                labelText: "Пароль *",
                hintText: "Введите пароль",
                suffixIcon: IconButton(
                  icon: Icon(
                      _passState ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passState = !_passState;
                    });
                  },
                ),
                icon: Icon(Icons.security),
              ),
              validator: _validatePassword,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _confirmPassController,
              maxLength: 8,
              obscureText: _passState,
              decoration: InputDecoration(
                labelText: "Подтверждение пароля *",
                hintText: "Подтвердите пароль",
                suffixIcon: IconButton(
                  icon: Icon(
                      _passState ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passState = !_passState;
                    });
                  },
                ),
                icon: Icon(Icons.border_color),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: _submitForm,
              color: Colors.green,
              child: Text(
                'Отправиль',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print("Форма валидна!");
      print("Name: ${_nameController.text}");
      print("Phone: ${_phoneController.text}");
      print("Email: ${_emailController.text}");
      print("About: ${_storyController.text}");
      print("Country: ${_selectedCountry}");
    } else {
      _showMessage(message: "Форма не заполнена");
    }
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z]+$');
    if (value!.isEmpty) {
      return 'Name is reqired.';
    } else if (!_nameExp.hasMatch(value)) {
      return "Пожалуйста, используйте только латинские буквы";
    } else {
      return null;
    }
  }

  bool _validatePhoneNumer(String? value) {
    final _phoneExp = RegExp(r'^\+7\(\d\d\d\)\d\d\d\-\d\d\d\d');
    return _phoneExp.hasMatch(value!);
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Поле не может быть пустым';
    } else if (!_emailController.text.contains('@')) {
      return "Недействительная электронная почта";
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length < 8) {
      return 'Должно быть минимум 8 символов';
    } else if (_confirmPassController.text != _passController.text) {
      return 'Пароли не совпадают';
    } else {
      return null;
    }
  }

  void _showMessage({String? message}) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          "$message",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showDialog({String? name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Регитсрация завершена',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            content: Text(
              '$name успешно прошел верификацию',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoPage(
                        userInfo: newUser,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Верификация",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
