//  Created by Sebastian Suchanowski (@ssuchanowski, www.synappse.co)

import Foundation

let args = CommandLine.arguments
if args.count != 3 {
    print("[ERROR] Usage: qc className storyboardName")
    exit(1)
}

let className = args[1]
let storyboardName = args[2]

let template = Template.fromClassName(className)
template.createFiles(className: className, storyboardName: storyboardName)
