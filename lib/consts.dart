
const String stripePublishableKey =
    "pk_test_51R43BaHmtaeZQO1hnVxJBwP9AXPj6AmEUEGTocBB4y7hudVwKmnWXYF1HZZxAZWFrfJEZR6uhNjOeyW32lSJOQKn00mGLtQCzO";
const String stripeSecretKey =
    "sk_test_51R43BaHmtaeZQO1hTnzLrxodV85XefHOmHXGCdnf8edx9WChwNuMj9UnnnKmt3ZGjrlMiiNRHygNFMNSa1GfrTDM00kNKEVGFl";


class AppConstant {
  AppConstant._();

  static const baseTodo = 'http://206.189.150.98:3000/api/v1'; //
  static baseImage(String path) =>
      'http://206.189.150.98:3000/public/images/$path';

  static const endPointBaseImage = 'http://206.189.150.98:3000/public/images';
  static const endPointUploadFile = '$baseTodo/file/upload';
}
