// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  internal static let background = ColorName(rgbaValue: 0xf5f5f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let body = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#323232"></span>
  /// Alpha: 100% <br/> (0x323232ff)
  internal static let bodyAlt1 = ColorName(rgbaValue: 0x323232ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cccccc"></span>
  /// Alpha: 100% <br/> (0xccccccff)
  internal static let bodyAlt2 = ColorName(rgbaValue: 0xccccccff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let dollarValue = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#323232"></span>
  /// Alpha: 100% <br/> (0x323232ff)
  internal static let dollarValueAlt = ColorName(rgbaValue: 0x323232ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0077bb"></span>
  /// Alpha: 100% <br/> (0x0077bbff)
  internal static let dollarValueCellLabel = ColorName(rgbaValue: 0x0077bbff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#304878"></span>
  /// Alpha: 100% <br/> (0x304878ff)
  internal static let facebookButtonStateHighlight = ColorName(rgbaValue: 0x304878ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3c5a98"></span>
  /// Alpha: 100% <br/> (0x3c5a98ff)
  internal static let facebookButtonStateNormal = ColorName(rgbaValue: 0x3c5a98ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let header = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#323232"></span>
  /// Alpha: 100% <br/> (0x323232ff)
  internal static let headerAlt1 = ColorName(rgbaValue: 0x323232ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#008a24"></span>
  /// Alpha: 100% <br/> (0x008a24ff)
  internal static let headerAlt2 = ColorName(rgbaValue: 0x008a24ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#faebd7"></span>
  /// Alpha: 100% <br/> (0xfaebd7ff)
  internal static let hindsightAntiqueWhite = ColorName(rgbaValue: 0xfaebd7ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#002d72"></span>
  /// Alpha: 100% <br/> (0x002d72ff)
  internal static let hindsightBlue = ColorName(rgbaValue: 0x002d72ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#008a24"></span>
  /// Alpha: 100% <br/> (0x008a24ff)
  internal static let hindsightDMMGreen = ColorName(rgbaValue: 0x008a24ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#323232"></span>
  /// Alpha: 100% <br/> (0x323232ff)
  internal static let hindsightDarkGray = ColorName(rgbaValue: 0x323232ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#4a0518"></span>
  /// Alpha: 100% <br/> (0x4a0518ff)
  internal static let hindsightDarkRed = ColorName(rgbaValue: 0x4a0518ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#003378"></span>
  /// Alpha: 100% <br/> (0x003378ff)
  internal static let hindsightHeaderBlue90 = ColorName(rgbaValue: 0x003378ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#bfc8d6"></span>
  /// Alpha: 100% <br/> (0xbfc8d6ff)
  internal static let hindsightLightGray = ColorName(rgbaValue: 0xbfc8d6ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5f8ba"></span>
  /// Alpha: 100% <br/> (0xa5f8baff)
  internal static let hindsightLightGreen = ColorName(rgbaValue: 0xa5f8baff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff3333"></span>
  /// Alpha: 100% <br/> (0xff3333ff)
  internal static let hindsightLightRed = ColorName(rgbaValue: 0xff3333ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#767676"></span>
  /// Alpha: 100% <br/> (0x767676ff)
  internal static let hindsightMedGray = ColorName(rgbaValue: 0x767676ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff0000"></span>
  /// Alpha: 100% <br/> (0xff0000ff)
  internal static let hindsightRed = ColorName(rgbaValue: 0xff0000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#654b90"></span>
  /// Alpha: 100% <br/> (0x654b90ff)
  internal static let hindsightTheme = ColorName(rgbaValue: 0x654b90ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let hindsightWhite = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#323232"></span>
  /// Alpha: 100% <br/> (0x323232ff)
  internal static let label = ColorName(rgbaValue: 0x323232ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#767676"></span>
  /// Alpha: 100% <br/> (0x767676ff)
  internal static let labelAlt1 = ColorName(rgbaValue: 0x767676ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cccccc"></span>
  /// Alpha: 100% <br/> (0xccccccff)
  internal static let labelAlt2 = ColorName(rgbaValue: 0xccccccff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#654b90"></span>
  /// Alpha: 100% <br/> (0x654b90ff)
  internal static let navBar = ColorName(rgbaValue: 0x654b90ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let navBarBlackText = ColorName(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#c9c9ce"></span>
  /// Alpha: 100% <br/> (0xc9c9ceff)
  internal static let tabBarBorder = ColorName(rgbaValue: 0xc9c9ceff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#004785"></span>
  /// Alpha: 100% <br/> (0x004785ff)
  internal static let tabBarSelected = ColorName(rgbaValue: 0x004785ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#979797"></span>
  /// Alpha: 100% <br/> (0x979797ff)
  internal static let tabBarUnselected = ColorName(rgbaValue: 0x979797ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
