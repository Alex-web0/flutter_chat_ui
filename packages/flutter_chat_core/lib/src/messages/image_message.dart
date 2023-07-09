import 'package:json_annotation/json_annotation.dart';

import '../date_time_epoch_converter.dart';
import '../message.dart';

part 'image_message.g.dart';

@JsonSerializable()
@EpochDateTimeConverter()
class ImageMessage extends Message {
  final String source;

  static const Object _nullMetadata = Object();

  const ImageMessage({
    required super.id,
    required super.senderId,
    required super.timestamp,

    /// needed to have [ImageMessage.type] in generated code
    // ignore: avoid_unused_constructor_parameters
    String? type,
    super.metadata,
    required this.source,
  }) : super(type: 'image');

  @override
  List<Object?> get props => super.props..addAll([source]);

  factory ImageMessage.fromJson(Map<String, dynamic> json) =>
      _$ImageMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageMessageToJson(this);

  @override
  ImageMessage copyWith({
    DateTime? timestamp,
    Object? metadata = _nullMetadata,
    String? source,
  }) =>
      ImageMessage(
        id: id,
        senderId: senderId,
        timestamp: timestamp ?? this.timestamp,
        metadata: metadata == _nullMetadata
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        source: source ?? this.source,
      );
}
