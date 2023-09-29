import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-page';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 10),
            Text('Đăng nhập'),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        //_passwordController.obscureText = !_passwordController.obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Đăng nhập với email và mật khẩu
                    // ...

                    // Nếu đăng nhập thành công, chuyển hướng đến màn hình chính
                    Navigator.of(context).pushNamed('/home');
                  }
                  // test trước, login không cần tk,mk
                  Navigator.of(context).pushNamed('/home-page');
                },
                child: Text('Đăng nhập'),
              ),
              TextButton(
                onPressed: () {
                  // Đi tới màn hình đăng ký
                  Navigator.of(context).pushNamed('/regis-page');
                },
                child: Text('Đăng ký'),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Quên mật khẩu?'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Trợ giúp'),
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
