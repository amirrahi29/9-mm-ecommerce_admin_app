class MedicineModel{

  int? uid;
  String? title;
  String? description;
  String? category;
  double? price;
  double? tax;
  String? medicineImage;
  String? date;

  MedicineModel({this.uid,this.title,this.description,this.category,this.price,this.tax,this.medicineImage,this.date});

  factory MedicineModel.fromJson(Map<String, dynamic> json){
    return MedicineModel(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      tax: json['tax'],
      medicineImage: json['medicineImage'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'uid':uid,
      'title':title,
      'description':description,
      'category':category,
      'price':price,
      'tax':tax,
      'medicineImage':medicineImage,
      'date':date,
    };
  }

}