import '../utils/util.dart';

class PaymentMethodModel {
  String? id;
  String? name;
  bool? isSelected;

  PaymentMethodModel() {
    id = Util.getID();
  }
}

List<PaymentMethodModel> paymentMethods = [
  PaymentMethodModel()
    ..name = 'Credit, debit Card'
    ..isSelected = true,
  PaymentMethodModel()
    ..name = 'Paypal'
    ..isSelected = false,
  PaymentMethodModel()
    ..name = 'Cash on Delivery'
    ..isSelected = false,
];
