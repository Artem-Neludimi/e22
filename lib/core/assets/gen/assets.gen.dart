/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/sbp_crown_jus.png
  AssetGenImage get sbpCrownJus =>
      const AssetGenImage('assets/images/sbp_crown_jus.png');

  /// File path: assets/images/sbp_cube_jus.png
  AssetGenImage get sbpCubeJus =>
      const AssetGenImage('assets/images/sbp_cube_jus.png');

  /// File path: assets/images/sbp_dialog_jus.png
  AssetGenImage get sbpDialogJus =>
      const AssetGenImage('assets/images/sbp_dialog_jus.png');

  /// File path: assets/images/sbp_game_bg_jus.png
  AssetGenImage get sbpGameBgJus =>
      const AssetGenImage('assets/images/sbp_game_bg_jus.png');

  /// File path: assets/images/sbp_game_onboarding_dialog_jus.png
  AssetGenImage get sbpGameOnboardingDialogJus =>
      const AssetGenImage('assets/images/sbp_game_onboarding_dialog_jus.png');

  /// File path: assets/images/sbp_menu_bg_jus.png
  AssetGenImage get sbpMenuBgJus =>
      const AssetGenImage('assets/images/sbp_menu_bg_jus.png');

  /// File path: assets/images/sbp_onboarding_bg_1_jus.png
  AssetGenImage get sbpOnboardingBg1Jus =>
      const AssetGenImage('assets/images/sbp_onboarding_bg_1_jus.png');

  /// File path: assets/images/sbp_onboarding_bg_2_jus.png
  AssetGenImage get sbpOnboardingBg2Jus =>
      const AssetGenImage('assets/images/sbp_onboarding_bg_2_jus.png');

  /// File path: assets/images/sbp_onboarding_bg_3_jus.png
  AssetGenImage get sbpOnboardingBg3Jus =>
      const AssetGenImage('assets/images/sbp_onboarding_bg_3_jus.png');

  /// File path: assets/images/sbp_pause_jus.png
  AssetGenImage get sbpPauseJus =>
      const AssetGenImage('assets/images/sbp_pause_jus.png');

  /// File path: assets/images/sbp_restart_jus.png
  AssetGenImage get sbpRestartJus =>
      const AssetGenImage('assets/images/sbp_restart_jus.png');

  /// File path: assets/images/sbp_splash_bg_jus.png
  AssetGenImage get sbpSplashBgJus =>
      const AssetGenImage('assets/images/sbp_splash_bg_jus.png');

  /// File path: assets/images/sbp_terms_of_use_bg_jus.png
  AssetGenImage get sbpTermsOfUseBgJus =>
      const AssetGenImage('assets/images/sbp_terms_of_use_bg_jus.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        sbpCrownJus,
        sbpCubeJus,
        sbpDialogJus,
        sbpGameBgJus,
        sbpGameOnboardingDialogJus,
        sbpMenuBgJus,
        sbpOnboardingBg1Jus,
        sbpOnboardingBg2Jus,
        sbpOnboardingBg3Jus,
        sbpPauseJus,
        sbpRestartJus,
        sbpSplashBgJus,
        sbpTermsOfUseBgJus
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/sbp_loading_jus.json
  LottieGenImage get sbpLoadingJus =>
      const LottieGenImage('assets/lottie/sbp_loading_jus.json');

  /// List of all assets
  List<LottieGenImage> get values => [sbpLoadingJus];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/sbp_map_jus.svg
  SvgGenImage get sbpMapJus => const SvgGenImage('assets/svg/sbp_map_jus.svg');

  /// File path: assets/svg/sbp_settings_jus.svg
  SvgGenImage get sbpSettingsJus =>
      const SvgGenImage('assets/svg/sbp_settings_jus.svg');

  /// File path: assets/svg/sbp_shop_jus.svg
  SvgGenImage get sbpShopJus =>
      const SvgGenImage('assets/svg/sbp_shop_jus.svg');

  /// File path: assets/svg/sbp_tasks_jus.svg
  SvgGenImage get sbpTasksJus =>
      const SvgGenImage('assets/svg/sbp_tasks_jus.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [sbpMapJus, sbpSettingsJus, sbpShopJus, sbpTasksJus];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
