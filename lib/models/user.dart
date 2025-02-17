class User {
  
  final int id;
  final String firstName; 
  final String lastName;
  final String email;
  final String image;
  final int age; 
  final String gender; 
  final String country; 
  final String designation; 

  // Constructor for the User class, requiring all properties to be provided
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.age,
    required this.gender,
    required this.country,
    required this.designation,
  });

  // Factory method to create a User instance from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], 
      firstName: json['firstName'], 
      lastName: json['lastName'], 
      email: json['email'], 
      image: json['image'], 
      age: json['age'], 
      gender: json['gender'], 
      country: json['address']['country'], 
      designation: json['company']['title'], 
    );
  }
}
