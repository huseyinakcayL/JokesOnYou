//
//  AppDelegate.swift
//  JokesOnYou
//
//  Created by HüseyinAkçay on 5.05.2023.
//

import Cocoa
import Carbon
import LocalAuthentication

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var context = LAContext()
    private var statusItem: NSStatusItem!
    var hotKey: Any?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "1.circle", accessibilityDescription: "1")
        }

        context.interactionNotAllowed = false
        setupMenus()
    }

    private func setupMenus() {
        let menu = NSMenu()

        let one = NSMenuItem(title: "One", action: #selector(didTapOne) , keyEquivalent: "l")
        one.keyEquivalentModifierMask = [.command, .option, .control]
        menu.addItem(one)

        let two = NSMenuItem(title: "Two", action: #selector(didTapTwo) , keyEquivalent: "2")
        menu.addItem(two)

        let three = NSMenuItem(title: "Three", action: #selector(didTapThree) , keyEquivalent: "3")
        menu.addItem(three)

        menu.addItem(NSMenuItem.separator())

        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }

    @objc private func didTapOne() {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access your account") { (success, error) in
            if success {
                self.changeStatusBarButton(number: 1)
            } else {
                self.changeStatusBarButton(number: 2)
            }
        }

    }

    @objc private func didTapTwo() {
        changeStatusBarButton(number: 2)
    }

    @objc private func didTapThree() {
        changeStatusBarButton(number: 3)
    }

    private func changeStatusBarButton(number: Int) {
        if let button = statusItem.button {
            DispatchQueue.main.async {
                button.image = NSImage(systemSymbolName: "\(number).circle",
                                       accessibilityDescription: number.description)
            }
        }
    }



}

