import 'dart:convert';

class Services {
  final String secretKey;

  Services(this.secretKey);

  // Encrypt the text using the secret key
  String encrypt(String plaintext) {
    List<int> keyBytes = utf8.encode(secretKey);
    List<int> textBytes = utf8.encode(plaintext);

    List<int> encryptedBytes = List.generate(
        textBytes.length, (i) => textBytes[i] ^ keyBytes[i % keyBytes.length]);

    return base64.encode(encryptedBytes);
  }

  // Decrypt the text using the secret key
  String decrypt(String encryptedText) {
    List<int> keyBytes = utf8.encode(secretKey);
    List<int> encryptedBytes = base64.decode(encryptedText);

    List<int> decryptedBytes = List.generate(encryptedBytes.length,
        (i) => encryptedBytes[i] ^ keyBytes[i % keyBytes.length]);

    return utf8.decode(decryptedBytes);
  }
}
