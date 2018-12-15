// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum Constants {

  internal enum Button {
    internal enum Text {
      /// Login With Facebook
      internal static let facebookLogin = Constants.tr("Localizable", "Button.text.facebookLogin")
    }
  }

  internal enum NonUI {
    internal enum Network {
      internal enum Auth {
        internal enum Login {
          /// /user/login
          internal static let api = Constants.tr("Localizable", "Non_UI.network.auth.login.api")
          /// login
          internal static let sampleResponse = Constants.tr("Localizable", "Non_UI.network.auth.login.sample_Response")
          internal enum Param {
            /// password
            internal static let password = Constants.tr("Localizable", "Non_UI.network.auth.login.param.password")
            /// username
            internal static let username = Constants.tr("Localizable", "Non_UI.network.auth.login.param.username")
          }
        }
        internal enum Refresh {
          /// /token/refresh
          internal static let api = Constants.tr("Localizable", "Non_UI.network.auth.refresh.api")
          /// sample_login
          internal static let sampleResponse = Constants.tr("Localizable", "Non_UI.network.auth.refresh.sample_Response")
        }
        internal enum Register {
          /// /user/register
          internal static let api = Constants.tr("Localizable", "Non_UI.network.auth.register.api")
          internal enum Param {
            /// password
            internal static let password = Constants.tr("Localizable", "Non_UI.network.auth.register.param.password")
            /// username
            internal static let username = Constants.tr("Localizable", "Non_UI.network.auth.register.param.username")
          }
        }
      }
      internal enum User {
        internal enum Login {
          /// register
          internal static let sampleResponse = Constants.tr("Localizable", "Non_UI.network.user.login.sample_Response")
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Constants {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
