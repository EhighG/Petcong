import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

// ignore: must_be_immutable
class ChoiceRes extends Equatable {
  String? targetUid;
  // String? profileImgUrl;
  // List<String>? questions;

  // ChoiceRes({this.targetUid, this.profileImgUrl, this.questions});
  ChoiceRes({this.targetUid});

  ChoiceRes.fromJson(Map<String, dynamic>? map) {
    map!.forEach((key, value) {
      if (kDebugMode) {
        print('Key: ${key.toString()}, Value: ${value.toString()}');
      }
    });
    // if (map == null) {
    //   return;
    // }
    targetUid = map['targetUid'];
    // profileImgUrl = map['profileImgUrl'];
    // if (map['questions'] != null) {
    //   questions = <String>[];
    //   map['questions'].forEach((value) {
    //     questions!.add(value);
    //   });
    // }
  }
  toJson() {
    return {
      'targetUid': targetUid,
      // 'profileImgUrl': profileImgUrl,
      // 'questions': questions,
    };
  }

  @override
  List<Object?> get props => [
        targetUid,
        // profileImgUrl,
        // questions,
      ];
}
