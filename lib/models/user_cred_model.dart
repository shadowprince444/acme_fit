class UserCredModel {
  String? userId, jwtToken, userName, email, imageUrl;
  UserCredModel({
    required this.imageUrl,
    required this.userId,
    required this.jwtToken,
    required this.userName,
    required this.email,
  });
}
