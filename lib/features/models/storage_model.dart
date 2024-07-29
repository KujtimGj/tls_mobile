class StorageModel {
  String? id;
  String? ticket;
  String? technician;
  List<String>? filesBefore = [];
  List<String>? filesAfter = [];
  DateTime? createdAt;
  DateTime? updatedAt;

  StorageModel({
      this.id,
      this.ticket,
      this.technician,
      this.filesBefore,
      this.filesAfter,
      this.createdAt,
      this.updatedAt,
  });

  int getFilesBeforeLength(){
    if(filesBefore == null){
      return 0;
    }
    return filesBefore!.length;
  }
  int getFilesAfterLength(){
    if(filesAfter == null){
      return 0;
    }
    return filesAfter!.length;
  }

  factory StorageModel.fromJson(Map<String, dynamic>? json) {
    if(json == null){
      return StorageModel();
    }
    return StorageModel(
      id: json['_id'],
      ticket: json['ticket'],
      technician: json['technician'],
      filesBefore: List<String>.from(json['files_before']),
      filesAfter: List<String>.from(json['files_after']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ticket': ticket,
      'technician': technician,
      'files_before': filesBefore,
      'files_after': filesAfter,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
