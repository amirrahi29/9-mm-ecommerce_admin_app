class OrderModel{

  String? orderId;
  String? medicineId;
  String? qty;
  String? totalPrice;
  String? dateCreated;
  String? email;
  String? status;
  String? address;

  OrderModel({this.orderId,this.medicineId,this.qty,
    this.totalPrice,this.dateCreated,
  this.email,this.status,this.address});

  factory OrderModel.fromJson(Map<String, dynamic> json){
    return OrderModel(
      orderId: json['orderId'],
      medicineId: json['medicineId'],
      qty: json['qty'],
      totalPrice: json['totalPrice'],
      dateCreated: json['dateCreated'],
      email: json['email'],
      status: json['status'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'orderId':orderId,
      'medicineId':medicineId,
      'qty':qty,
      'totalPrice':totalPrice,
      'dateCreated':dateCreated,
      'email':email,
      'status':status,
      'address':address,
    };
  }

}