import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RatingDialog extends StatefulWidget {
  RatingDialog({
    required this.recipe_name,
  });
  String recipe_name;
  @override
  _RatingDialogState createState() => _RatingDialogState(recipe_name: recipe_name,);
}

class _RatingDialogState extends State<RatingDialog> {
  _RatingDialogState({
    required this.recipe_name,
  });
  String recipe_name;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void reteUser(int rating, String rated_uid) async {
    _db.collection("users")
        .doc(rated_uid)
        .update({"rating":rating});
  }

  int _stars = 0;

  Widget _buildStar(int starCount) {
    // int_starts = 0;
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Rate This Recipe'),),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: Navigator.of(context).pop,
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            reteUser(_stars,recipe_name);
            Navigator.of(context).pop(_stars);
          },
        )
      ],
    );
  }
}