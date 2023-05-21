class ResponsePost {
    int id;
    int statusCode;
    String message;

    ResponsePost({
        required this.id,
        required this.statusCode,
        required this.message,
    });

    factory ResponsePost.fromJson(Map<String, dynamic> json) => ResponsePost(
        id: json["id"],
        statusCode: json["status_code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status_code": statusCode,
        "message": message,
    };
}