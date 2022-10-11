import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Content page provides the content for the swipe card
///
/// This consists of a picture, name, bio, age, and distance
class Content {
  // UUID
  final UniqueKey uniqueKey;
  // Profile images, in order of preference
  final List<String>? images;
  // User's display name / preferred name
  final String? displayName;
  // Shorthand bio
  final String? shortBio;
  // Optional major
  final String? major;
  // Optional occupation
  final String? occupation;
  // Optional pronouns
  final String? pronouns;
  // Distance from swiping user
  final double? distance;
  // Age of user
  final int? age;

  Content({
    this.images,
    this.displayName,
    this.shortBio,
    this.major,
    this.occupation,
    this.pronouns,
    this.age,
  }): uniqueKey = UniqueKey(), distance = 1.0;
  // distance should be calculated by zipcode or some other element stored in DB
}