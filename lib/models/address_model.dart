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
  AddressModel()
    ..titleFirst = 'My Company Address'
    ..titleSecond = 'Office'
    ..description =
        '62 Xô Viết Nghệ Tĩnh, Hoà Cường Bắc, Hải Châu, Đà Nẵng 550000, Việt Nam'
    ..isSelected = false,
    AddressModel()
    ..titleFirst = 'My Office Address'
    ..titleSecond = 'Office'
    ..description =
        '100 Tôn Đức Thắng , Liên Chiểu, Hòa Khánh, Đà Nẵng 550000, Việt Nam'
    ..isSelected = false,
    AddressModel()
    ..titleFirst = 'My Company 2 Address'
    ..titleSecond = 'Office'
    ..description =
        '150 CMTT8, Cẩm Lệ, Hòa Vang, Đà Nẵng 550000, Việt Nam'
    ..isSelected = false,
    AddressModel()
    ..titleFirst = 'My Office 2 Address'
    ..titleSecond = 'Office'
    ..description =
        '10 Nguyễn Tri Phương, Thanh Khê, Đà Nẵng 550000, Việt Nam'
    ..isSelected = false,
    AddressModel()
    ..titleFirst = 'My Office Address'
    ..titleSecond = 'Office'
    ..description =
        '500 Điện Biên Phủ, Thanh Khê, Đà Nẵng 550000, Việt Nam'
    ..isSelected = false,
];
