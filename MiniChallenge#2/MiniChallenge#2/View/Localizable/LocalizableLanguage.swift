import Foundation

public class LocalizableLanguage {
    
}
//Transformar a String no idioma que está o celular
extension String {
    func localizedLanguage() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
