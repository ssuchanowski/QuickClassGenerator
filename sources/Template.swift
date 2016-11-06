//  Created by Sebastian Suchanowski (@ssuchanowski, www.synappse.co)

import Foundation

enum Template: String {
    case None
    case VC
    case TVC
    case Configurator
    case Spec
    case Header

    // MARK: Static

    static func fromClassName(_ className: String) -> Template {
        var resultTemplate = Template.None

        let _ = Template.allValues().map { singleTemplate in
            if className.hasSuffix(singleTemplate.rawValue) && (resultTemplate == .None || resultTemplate.rawValue.characters.count < singleTemplate.rawValue.characters.count) {
                resultTemplate = singleTemplate
            }
        }

        return resultTemplate
    }

    static func allValues() -> [Template] {
        return [VC, TVC, Configurator, Spec]
    }

    // MARK: Public

    func createFiles(className: String, storyboardName: String) {
        switch self {
            case .TVC: break // here to save data source and delegate
            case .VC: break
            default: break
        }

        let classFileContent = fillFileTemplate(content: content(), className: className, storyboardName: storyboardName)
        saveFileToDisk(template: self, fileContent: classFileContent, className: className)

        let configuratorFileContent = fillFileTemplate(content: configuratorContent(), className: className, storyboardName: storyboardName)
        saveFileToDisk(template: .Configurator, fileContent: configuratorFileContent, className: className)

        let specFileContent = fillFileTemplate(content: specContent(), className: className, storyboardName: storyboardName)
        saveFileToDisk(template: .Spec, fileContent: specFileContent, className: className)

        print("Done!")
    }

    // MARK: Private

    private func content() -> String {
        return contentOf(template: self)
    }

    private func configuratorContent() -> String {
        return contentOf(template: .Configurator)
    }

    private func headerContent() -> String {
        return contentOf(template: .Header)
    }

    private func specContent() -> String {
        return contentOf(template: .Spec)
    }

    // MARK: Helpers

    private func contentOf(template: Template) -> String {
        var fileContent: String
        do {
            fileContent = try NSString(contentsOfFile: templateFileName(template: template), encoding: String.Encoding.utf8.rawValue) as String
        } catch {
            fileContent = ""
        }

        return fileContent
    }

    private func fillFileTemplate(content: String, className: String, storyboardName: String) -> String {
        var result = content
        result = result.replacingOccurrences(of: "$HEADER$", with: headerContent())
        result = result.replacingOccurrences(of: "$CLASS$", with: className)
        result = result.replacingOccurrences(of: "$CLASS_NO_SUFFIX$", with: noSuffixName(className: className))
        return result.replacingOccurrences(of: "$STORYBOARD$", with: storyboardName)
    }

    private func noSuffixName(className: String) -> String {
        guard let indexDistance = String.IndexDistance(exactly: className.characters.count - self.rawValue.characters.count) else {
            assertionFailure()
            return ""
        }

        let indexOffset = className.index(className.startIndex, offsetBy: indexDistance)
        return className.substring(to: indexOffset)
    }

    private func templateFileName(template: Template) -> String {
        return ("~/.scripts/SwiftClassGenerator/templates/\(template.rawValue).swift" as NSString).expandingTildeInPath
    }

    private func resultFileName(template: Template, className: String) -> String {
        if template == .Spec || template == .Configurator {
            return "\(className)\(template.rawValue).swift"
        }
        return "\(noSuffixName(className: className))\(template.rawValue).swift"
    }

    private func saveFileToDisk(template: Template, fileContent: String, className: String) {
        do {
            try fileContent.write(toFile: resultFileName(template: template, className: className), atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Error while saving \(resultFileName(template: template, className: className))")
        }
    }
}
