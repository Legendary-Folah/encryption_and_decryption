import 'package:data_encryption_and_decryption/services/services.dart';
import 'package:flutter/material.dart';

class EncryptionAndDecryption extends StatefulWidget {
  const EncryptionAndDecryption({super.key});

  @override
  State<EncryptionAndDecryption> createState() =>
      _EncryptionAndDecryptionState();
}

class _EncryptionAndDecryptionState extends State<EncryptionAndDecryption> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _encryptedTextController =
      TextEditingController();
  String encryptedText = '';
  String decryptedText = '';

//
  void encryptText() {
    String plainText = _textController.text;
    String key = _keyController.text;
    if (plainText.isNotEmpty && key.isNotEmpty) {
      Services encryptionService = Services(key);
      setState(() {
        encryptedText = encryptionService.encrypt(plainText);
      });
    }
  }

  void decryptText() {
    String encryptedText = _encryptedTextController.text;
    String key = _keyController.text;
    if (encryptedText.isNotEmpty && key.isNotEmpty) {
      Services encryptionService = Services(key);
      setState(() {
        decryptedText = encryptionService.decrypt(encryptedText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Data Encryption & Decryption',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Column(
              spacing: 20,
              children: [
                CustomTextField(
                  textController: _textController,
                  obscureText: false,
                  hintText: 'Enter plain text',
                ),
                CustomTextField(
                  textController: _keyController,
                  obscureText: true,
                  hintText: 'Enter secret key',
                  // suffixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.remove_red_eye,
                  //   ),
                  // ),
                ),
                CustomButton(
                  onPressed: encryptText,
                  text: 'Encrypt',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 6,
                  children: [
                    Text('Encrypted Text:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SelectableText(encryptedText,
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
                  ],
                ),
                Divider(),
                CustomTextField(
                  textController: _encryptedTextController,
                  obscureText: false,
                  hintText: 'Enter Encrypted Text',
                ),
                CustomButton(
                  onPressed: decryptText,
                  text: 'Decrypt Text',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 6,
                  children: [
                    Text('Decrypted Text:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SelectableText(decryptedText,
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController textController,
    required this.obscureText,
    required this.hintText,
    this.suffixIcon,
  }) : _textController = textController;

  final TextEditingController _textController;
  final bool obscureText;
  final String hintText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: TextField(
        obscureText: obscureText,
        controller: _textController,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 8)
            // contentPadding: EdgeInsets.symmetric(horizontal: 2),
            ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blue),
          elevation: WidgetStatePropertyAll(3),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
