class AddressModel {
  final String? titleFirst;
  final String? titleSecond;
  final String? description;
  late bool? isSelected;

  // Constructor
  AddressModel({
    this.titleFirst,
    this.titleSecond,
    this.description,
    this.isSelected,
  });

  // Factory constructor để tạo đối tượng từ JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      titleFirst: json['structured_formatting'] != null
          ? json['structured_formatting']['main_text']
          : null,
      titleSecond: json['structured_formatting'] != null
          ? json['structured_formatting']['secondary_text']
          : null,
      description: json['description'],
    );
  }

  // Hàm chuyển đối tượng thành JSON nếu cần
  Map<String, dynamic> toJson() {
    return {
      'titleFirst': titleFirst,
      'titleSecond': titleSecond,
      'description': description,
    };
  }
}
