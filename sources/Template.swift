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

    static func fromClassName(className: String) -> Template {
        var resultTemplate = Template.None

        let _  = Template.allValues().map { singleTemplate in
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
        case TVC: break // here to save data source and delegate
        case VC: break
        default: break
        }

        let classFileContent = fillFileTemplate(content(), className: className, storyboardName: storyboardName)
        saveFileToDisk(self, fileContent: classFileContent, className: className)

        let configuratorFileContent = fillFileTemplate(configuratorContent(), className: className, storyboardName: storyboardName)
        saveFileToDisk(.Configurator, fileContent: configuratorFileContent, className: className)

        let specFileContent = fillFileTemplate(specContent(), className: className, storyboardName: storyboardName)
        saveFileToDisk(.Spec, fileContent: specFileContent, className: className)

        print("Done!")
    }

    // MARK: Private

    private func content() -> String {
        return contentOf(self)
    }

    private func configuratorContent() -> String {
        return contentOf(.Configurator)
    }

    private func headerContent() -> String {
        return contentOf(.Header)
    }

    private func specContent() -> String {
        return contentOf(.Spec)
    }

    // MARK: Helpers

    private func contentOf(template: Template) -> String {
        var fileContent: String
        do {
            fileContent = try NSString(contentsOfFile: templateFileName(template), encoding: NSUTF8StringEncoding) as String
        } catch {
            fileContent = ""
        }

        return fileContent
    }

    private func fillFileTemplate(content: String, className: String, storyboardName: String) -> String {
        var result = content
        result = result.stringByReplacingOccurrencesOfString("$HEADER$", withString: headerContent())
        result = result.stringByReplacingOccurrencesOfString("$CLASS$", withString: className)
        result = result.stringByReplacingOccurrencesOfString("$CLASS_NO_SUFFIX$", withString: noSuffixName(className))
        return result.stringByReplacingOccurrencesOfString("$STORYBOARD$", withString: storyboardName)
    }

    private func noSuffixName(className: String) -> String {
        return className.substringToIndex(className.startIndex.advancedBy(className.characters.count - self.rawValue.characters.count))
    }

    private func templateFileName(template: Template) -> String {
        return ("~/.scripts/SwiftClassGenerator/templates/\(template.rawValue).swift" as NSString).stringByExpandingTildeInPath
    }

    private func resultFileName(template: Template, className: String) -> String {
        if template == .Spec || template == .Configurator {
            return "\(className)\(template.rawValue).swift"
        }
        return "\(noSuffixName(className))\(template.rawValue).swift"
    }

    private func saveFileToDisk(template: Template, fileContent: String, className: String) {
        do {
            try fileContent.writeToFile(resultFileName(template, className: className), atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            print("Error while saving \(resultFileName(template, className: className))")
        }
    }
}
