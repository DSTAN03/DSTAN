import '../utils/util.dart';

class AddressModel {
  String? id;
  String? titleFirst;
  String? titleSecond;
  String? description;
  bool? isSelected;

  AddressModel() {
    id = Util.getID();
  }
}

List<AddressModel> addresses = [
  AddressModel()
    ..titleFirst = 'My Home Address'
    ..titleSecond = 'Home'
    ..description =
        'K814A/58, Trần Cao Vân, Đà Nẵng, 50307, Việt Nam'
    ..isSelected = true,
  AddressModel()
    ..titleFirst = 'My Office Address'
    ..titleSecond = 'Office'
    ..description =
        '275B Núi Thành, Hoà Cường Bắc, Hải Châu, Đà Nẵng 550000, Việt Nam'
    ..isSelected = false,
];
