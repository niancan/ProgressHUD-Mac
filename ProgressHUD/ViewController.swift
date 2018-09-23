//
//  ViewController.swift
//  ProgressHUD, https://github.com/massimobio/ProgressHUD
//
//  Created by Massimo Biolcati on 9/10/18.
//  Copyright © 2018 Massimo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var modeSegmentedControl: NSSegmentedControl!
    @IBOutlet var styleSegmentedControl: NSSegmentedControl!
    @IBOutlet var maskSegmentedControl: NSSegmentedControl!
    @IBOutlet var positionSegmentedControl: NSSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showHUD(_ sender: Any) {

        switch modeSegmentedControl.selectedSegment {

        case 0: // Indeterminate

            ProgressHUD.show(withStatus: "Test Progress HUD")
//            let screen = NSScreen.screens[0]
//            let window = NSWindow(contentRect: screen.frame, styleMask: .fullScreen, backing: .buffered, defer: true, screen: screen)
//            let windowController = NSWindowController(window: window)
//            window.collectionBehavior = .fullScreenAuxiliary
//            windowController.showWindow(self)
//            window.toggleFullScreen(true)
//            window.contentView?.wantsLayer = true
//            window.contentView?.layer?.backgroundColor = .clear
//            window.backgroundColor = .clear
//            window.contentView?.showProgressHUD(title: "Doing Stuff",
//                                                message: "Completing something…",
//                                                mode: .indeterminate,
//                                                style: hudStyle,
//                                                maskType: hudMaskType,
//                                                position: hudPosition,
//                                                duration: 2) {
//                print("Finished showing indeterminate HUD")
//                windowController.close()
//            }

        case 1: // Determinate
            view.showProgressHUD(title: "Determinate Progress",
                                 message: "Almost done…",
                                 mode: .determinate,
                                 style: hudStyle,
                                 maskType: hudMaskType,
                                 position: hudPosition)
            DispatchQueue.global(qos: .default).async {
                var progress = 0.0
                for _ in 0..<100 {
                    usleep(10000)
                    progress += 0.01
                    self.view.setProgressHUDProgress(progress)
                }
                self.view.hideProgressHUD()

            }

        case 2: // Error
            view.showProgressHUD(title: "Error",
                                 message: "Something bad happened!",
                                 mode: .error,
                                 style: hudStyle,
                                 maskType: hudMaskType,
                                 position: hudPosition,
                                 duration: 2)

        case 3: // Success
            view.showProgressHUD(title: "Success",
                                 message: "Everything worked out in the end",
                                 mode: .success,
                                 style: hudStyle,
                                 maskType: hudMaskType,
                                 position: hudPosition,
                                 duration: 2)

        case 4: // Text Only
            view.showProgressHUD(title: "Message 🎸",
                                 message: "Showing text only.\nOn multiple lines.\nSquashed much?",
                                 mode: .text,
                                 style: hudStyle,
                                 maskType: hudMaskType,
                                 position: hudPosition,
                                 duration: 2)

        case 5: // Custom View
            let image = NSImage(named: "unicorn")!
            let imageView = NSImageView(frame: NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            imageView.image = image
            view.showProgressHUD(title: "Custom View",
                                 message: "I am not a horse",
                                 mode: .custom(view: imageView),
                                 style: hudStyle,
                                 maskType: hudMaskType,
                                 position: hudPosition,
                                 duration: 2)

        default:
            break
        }
    }

    private var hudStyle: ProgressHUDStyle {
        switch styleSegmentedControl.selectedSegment {
        case 0: return .light
        case 1: return .dark
        default: return .custom(foreground: .yellow, backgroud: .red)
        }
    }

    private var hudMaskType: ProgressHUDMaskType {
        switch maskSegmentedControl.selectedSegment {
        case 0: return .none
        case 1: return .clear
        case 2: return .black
        default: return .custom(color: NSColor.green.withAlphaComponent(0.6))
        }
    }

    private var hudPosition: ProgressHUDPosition {
        switch positionSegmentedControl.selectedSegment {
        case 0: return .top
        case 1: return .center
        default: return .bottom
        }
    }

}
