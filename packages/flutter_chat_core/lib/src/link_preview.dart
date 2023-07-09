import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link_preview.g.dart';

@JsonSerializable()
class LinkPreview extends Equatable {
  final String link;
  final String? description;
  final String? imageUrl;
  final String? title;

  static const Object _nullDescription = Object();
  static const Object _nullImageUrl = Object();
  static const Object _nullTitle = Object();

  const LinkPreview({
    required this.link,
    this.description,
    this.imageUrl,
    this.title,
  });

  @override
  List<Object?> get props => [link, description, imageUrl, title];

  factory LinkPreview.fromJson(Map<String, dynamic> json) =>
      _$LinkPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$LinkPreviewToJson(this);

  LinkPreview copyWith({
    String? link,
    Object? description = _nullDescription,
    Object? imageUrl = _nullImageUrl,
    Object? title = _nullTitle,
  }) =>
      LinkPreview(
        link: link ?? this.link,
        description: description == _nullDescription
            ? this.description
            : description as String?,
        imageUrl:
            imageUrl == _nullImageUrl ? this.imageUrl : imageUrl as String?,
        title: title == _nullTitle ? this.title : title as String?,
      );
}
