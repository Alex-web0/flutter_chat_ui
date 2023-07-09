import 'package:json_annotation/json_annotation.dart';

import '../date_time_epoch_converter.dart';
import '../link_preview.dart';
import '../message.dart';

part 'text_message.g.dart';

@JsonSerializable()
@EpochDateTimeConverter()
class TextMessage extends Message {
  final String text;
  final LinkPreview? linkPreview;

  static const Object _nullMetadata = Object();
  static const Object _nullLinkPreview = Object();

  const TextMessage({
    required super.id,
    required super.senderId,
    required super.timestamp,

    /// needed to have [TextMessage.type] in generated code
    // ignore: avoid_unused_constructor_parameters
    String? type,
    super.metadata,
    required this.text,
    this.linkPreview,
  }) : super(type: 'text');

  @override
  List<Object?> get props => super.props..addAll([text]);

  factory TextMessage.fromJson(Map<String, dynamic> json) =>
      _$TextMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);

  @override
  TextMessage copyWith({
    DateTime? timestamp,
    Object? metadata = _nullMetadata,
    String? text,
    Object? linkPreview = _nullLinkPreview,
  }) =>
      TextMessage(
        id: id,
        senderId: senderId,
        timestamp: timestamp ?? this.timestamp,
        metadata: metadata == _nullMetadata
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        text: text ?? this.text,
        linkPreview: linkPreview == _nullLinkPreview
            ? this.linkPreview
            : linkPreview as LinkPreview?,
      );
}
