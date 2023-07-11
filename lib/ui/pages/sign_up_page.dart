import 'package:flutter/material.dart';
import 'package:flutter_kos/shared/date_timenow.dart';
import 'package:flutter_kos/shared/shared_preferences.dart';
import 'package:flutter_kos/shared/snackbar.dart';
import 'package:flutter_kos/shared/theme.dart';
import 'package:flutter_kos/ui/pages/widgets/button.dart';
import 'package:flutter_kos/ui/pages/widgets/form.dart';
import 'package:flutter_kos/shared/shared_preferences.dart';

class SignUppage extends StatelessWidget {
  const SignUppage({super.key});

  void register(
    BuildContext ctx,
    String nama,
    String email,
    String pass,
  ) {
    SharedPrefUtils.saveNama(nama);
    SharedPrefUtils.saveEmail(email);
    SharedPrefUtils.savePassword(pass);
    SharedPrefUtils.saveTanggalGabung(DateTimeNow.now());

    CustomSnackBar.showToast(ctx, 'Berhasil Di simpan');
    Navigator.pushNamed(ctx, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaCotroller = TextEditingController();
    final TextEditingController emailCotroller = TextEditingController();
    final TextEditingController passwordCotroller = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            width: 350,
            height: 300,
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/kostopia.png'),
            )),
          ),
          Text(
            'Buat Akun Anda...',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: whiteColor),
            child: Column(
              children: [
                CustomFormField(
                  title: 'Nama',
                  controller: namaCotroller,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomFormField(
                  title: 'Alamat Email',
                  controller: emailCotroller,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomFormField(
                  title: 'Password',
                  obscureText: true,
                  controller: passwordCotroller,
                ),
                const SizedBox(
                  height: 38,
                ),
                CustomFillButton(
                  title: 'Register',
                  onPressed: () {
                    register(
                      context,
                      namaCotroller.text,
                      emailCotroller.text,
                      passwordCotroller.text,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomTextButton(
            title: 'Sign In',
            onPressed: () {
              Navigator.pushNamed(context, '/sign-in');
            },
          ),
        ],
      ),
    );
  }
}
