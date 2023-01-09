//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@testable import Player

import Nimble
import XCTest

final class ItemNavigationTests: XCTestCase {
    func testCanReturnToPreviousItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        player.advanceToNextItem()
        expect(player.canReturnToPreviousItem()).to(beTrue())
    }

    func testCannotReturnToPreviousItemAtFront() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        expect(player.canReturnToPreviousItem()).to(beFalse())
    }

    func testCannotReturnToPreviousItemWhenEmpty() {
        let player = Player()
        expect(player.canReturnToPreviousItem()).to(beFalse())
    }

    func testCanAdvanceToNextItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        expect(player.canAdvanceToNextItem()).to(beTrue())
    }

    func testCannotAdvanceToNextItemAtBack() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        player.advanceToNextItem()
        expect(player.canAdvanceToNextItem()).to(beFalse())
    }

    func testCannotAdvanceToNextItemWhenEmpty() {
        let player = Player()
        expect(player.canAdvanceToNextItem()).to(beFalse())
    }

    func testCanAdvanceToNextItemOnFailedItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.unavailable.url)
        let item3 = PlayerItem(url: Stream.item(numbered: 3).url)
        let player = Player(items: [item1, item2, item3])
        player.advanceToNextItem()
        expect(player.canReturnToPreviousItem()).toAlways(beTrue(), until: .milliseconds(500))
    }

    func testCanReturnToPreviousItemOnFailedItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.unavailable.url)
        let item3 = PlayerItem(url: Stream.item(numbered: 3).url)
        let player = Player(items: [item1, item2, item3])
        player.advanceToNextItem()
        expect(player.canAdvanceToNextItem()).toAlways(beTrue(), until: .milliseconds(500))
    }

    func testAdvanceToNextItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        player.advanceToNextItem()
        expect(player.currentIndex).to(equal(1))
    }

    func testAdvanceToNextItemAtBack() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        player.advanceToNextItem()
        player.advanceToNextItem()
        expect(player.currentIndex).to(equal(1))
    }

    func testReturnToPreviousItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        player.advanceToNextItem()
        player.returnToPreviousItem()
        expect(player.currentIndex).to(equal(0))
    }

    func testReturnToPreviousItemAtFront() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.item(numbered: 2).url)
        let player = Player(items: [item1, item2])
        player.returnToPreviousItem()
        expect(player.currentIndex).to(equal(0))
    }

    func testReturnToPreviousItemOnFailedItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.unavailable.url)
        let item3 = PlayerItem(url: Stream.item(numbered: 3).url)
        let player = Player(items: [item1, item2, item3])
        player.advanceToNextItem()
        player.returnToPreviousItem()
        expect(player.currentIndex).to(equal(0))
    }

    func testAdvanceToNextItemOnFailedItem() {
        let item1 = PlayerItem(url: Stream.item(numbered: 1).url)
        let item2 = PlayerItem(url: Stream.unavailable.url)
        let item3 = PlayerItem(url: Stream.item(numbered: 3).url)
        let player = Player(items: [item1, item2, item3])
        player.advanceToNextItem()
        player.advanceToNextItem()
        expect(player.currentIndex).to(equal(2))
    }
}
