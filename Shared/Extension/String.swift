// Copyright © 2022 Tokenary. All rights reserved.
// Helper extensions for working with `String` types

import Foundation

/// ToDo: This belongs to Tokenary Shared
extension String {
    
    // MARK: Properties
    
    static var empty: String = ""
    
    var maybeJSON: Bool {
        hasPrefix(Symbols.leftCurlyBrace) && hasSuffix(Symbols.rightCurlyBrace) && count > 3
    }
    
    var isOkAsPassword: Bool { count >= 4 }
    
    var withFirstLetterCapitalized: String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
    
    var withEllipsis: String { self + Symbols.ellipsis }
    
    var commonlyPrefixedTrimmedAddress: String {
        guard !isEmpty else { return self }
        let without0x = dropFirst(2)
        return without0x.prefix(4) + "..." + without0x.suffix(4)
    }
    
    var trimmedAddress: String {
        guard !isEmpty else { return self }
        return prefix(4 + 2) + "..." + suffix(4)
    }
    
    func trimmingAddress(sideLength: Int) -> String {
        guard !isEmpty, count > sideLength * 2 + 2 else { return self }
        return prefix(2 + sideLength) + "..." + suffix(sideLength)
    }
    
    // MARK: - Methods
    
    func removingOccurrences(of substrings: [String]) -> String {
        var result = self
        substrings.forEach { character in
            result = result.replacingOccurrences(of: character, with: String.empty)
        }
        return result
    }
    
    static func getRandomEmoticonsCollection(ofSize count: Int) -> [String] {
        var result: Set<String> = []
        outerLoop: for idx in .zero ..< count {
            while true {
                let valueToInsert: String
                if idx % 4 == .zero {
                    valueToInsert = String(
                        UnicodeScalar(String.validEmoticonUnicodeRange.randomElement()!) ?? String.defaultEmotion
                    )
                } else {
                    valueToInsert = String.validEmoticons.randomElement()!
                }
                
                let (inserted, _) = result.insert(valueToInsert)
                if inserted { continue outerLoop }
            }
        }
        return Array(result)
    }
    
    // MARK: - Private Properties
    
    // Authors favourites
    private static var defaultEmotion: Unicode.Scalar = "🔥"
    private static var defaultEmotion1: Unicode.Scalar = "💮"
    
    private static var validEmoticonUnicodeRange: ClosedRange = 0x1F600...0x1F64F
    
    private static var validEmoticons: [String] = [
        "🌀", "🌁", "🌂", "🌃", "🌄", "🌅", "🌆", "🌇", "🌈", "🌉", "🌊", "🌋", "🌌", "🌍", "🌎", "🌏",
        "🌐", "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘", "🌙", "🌚", "🌛", "🌜", "🌝", "🌞", "🌟",
        "🌠", "🌡", "🌤", "🌥", "🌦", "🌧", "🌨", "🌩", "🌪", "🌫", "🌬", "🌭", "🌮", "🌯", "🌰", "🌱",
        "🌲", "🌳", "🌴", "🌵", "🌶", "🌷", "🌸", "🌹", "🌺", "🌻", "🌼", "🌽", "🌾", "🌿", "🍀", "🍁",
        "🍂", "🍃", "🍄", "🍅", "🍆", "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🍎", "🍏", "🍐", "🍑",
        "🍒", "🍓", "🍔", "🍕", "🍖", "🍗", "🍘", "🍙", "🍚", "🍛", "🍜", "🍝", "🍞", "🍟", "🍠", "🍡",
        "🍢", "🍣", "🍤", "🍥", "🍦", "🍧", "🍨", "🍩", "🍪", "🍫", "🍬", "🍭", "🍮", "🍯", "🍰", "🍱",
        "🍲", "🍳", "🍴", "🍵", "🍶", "🍷", "🍸", "🍹", "🍺", "🍻", "🍼", "🍽", "🍾", "🍿", "🎀", "🎁",
        "🎂", "🎖", "🎗", "🎃", "🎄", "🎅", "🎆", "🎇", "🎈", "🎉", "🎊", "🎋", "🎌", "🎍", "🎎", "🎞",
        "🎟", "🎠", "🎡", "🎢", "🎣", "🎤", "🎥", "🎦", "🎧", "🎨", "🎩", "🎪", "🎫", "🎬", "🎭", "🎮",
        "🎯", "🎰", "🎱", "🎲", "🎳", "🎴", "🎵", "🎶", "🎷", "🎸", "🎹", "🎺", "🎻", "🎼", "🎽", "🎾",
        "🎿", "🏀", "🏁", "🏂", "🏃", "🏄", "🏅", "🏆", "🏇", "🏈", "🏉", "🏊", "🏋", "🏌", "🏍", "🏎",
        "🏏", "🏐", "🏑", "🏒", "🏓", "🏔", "🏕", "🏖", "🏗", "🏘", "🏙", "🏚", "🏛", "🏜", "🏝", "🏞",
        "🏟", "🏠", "🏡", "🏢", "🏣", "🏤", "🐀", "🐁", "🐂", "🐃", "🐄", "🐅", "🐆", "🐇", "🐈", "🐉",
        "🐊", "🐋", "🐌", "🐍", "🐎", "🐏", "🐐", "🐑", "🐒", "🐓", "🐔", "🐕", "🐖", "🐗", "🐘", "🐙",
        "🐚", "🐛", "🐜", "🐝", "🐞", "🐟", "🐠", "🐡", "🐢", "🐣", "🐤", "🐥", "🐦", "🐧", "🐨", "🐩",
        "🐪", "🐫", "🐬", "🐭", "🐮", "🐯", "🐰", "🐱", "🐲", "🐳", "🐴", "🐵", "🐶", "🐷", "🐸", "🐹",
        "🐺", "🐻", "🐼", "🐽", "🐾", "🐿", "👀", "👁", "👂", "👃", "👄", "👅", "👆", "👇", "👈", "👉",
        "👊", "👋", "👌", "👍", "👎", "👏", "👐", "👑", "👒", "👓", "👔", "👕", "👖", "👗", "👘", "👙",
        "👚", "👛", "👜", "👝", "👞", "👟", "👠", "👡", "👢", "👣", "👤", "👥", "👦", "👧", "👨", "👩",
        "👪", "👫", "👬", "👭", "👮", "👯", "👰", "👱", "👲", "👳", "👴", "👵", "👶", "👷", "👸", "👹",
        "👺", "👻", "👼", "👽", "👾", "👿", "💀", "💁", "💂", "💃", "💄", "💅", "💆", "💇", "💈", "💉",
        "💊", "💋", "💌", "💍", "💎", "💏", "💐", "💑", "💒", "💓", "💔", "💕", "💖", "💗", "💘", "💙",
        "💚", "💛", "💜", "💝", "💞", "💟", "💠", "💡", "💢", "💣", "💤", "💥", "💦", "💧", "💨", "💩",
        "💪", "💫", "💬", "💭", "💮", "💯", "💰", "💱", "💲", "💳", "💴", "💵", "💶", "💷", "💸", "💹",
        "💺", "💻", "💼", "💽", "💾", "💿", "📀", "📁", "📂", "📃", "📄", "📅", "📆", "📇", "📈", "📉",
        "📊", "📋", "📌", "📍", "📎", "📏", "📐", "📑", "📒", "📓", "📔", "📕", "📖", "📗", "📘", "📙",
        "📚", "📛", "📜", "📝", "📞", "📟", "📠", "📡", "📢", "📣", "📤", "📥", "📦", "📧", "📨", "📩",
        "📪", "📫", "📬", "📭", "📮", "📯", "📰", "📱", "📲", "📳", "📴", "📵", "📶", "📷", "📸", "📹",
        "📺", "📻", "📼", "📽", "📿", "🔀", "🔁", "🔂", "🔃", "🔄", "🔅", "🔆", "🔇", "🔈", "🔉", "🔊",
        "🔋", "🔌", "🔍", "🔎", "🔏", "🔐", "🔑", "🔒", "🔓", "🔔", "🔬", "🔭", "🕐", "🗺", "🗻", "🗼",
        "🗽", "🗾", "🗿", "🖊", "🚀", "🚁", "🚂", "🚃", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚋",
        "🚌", "🚍", "🚎", "🚏", "🚐", "🚑", "🚒", "🚓", "🚔", "🚕", "🚖", "🚗", "🚘", "🚙", "🚚", "🚛",
        "🚜", "🚝", "🚞", "🚟", "🚠", "🚡", "🚢", "🚣", "🚤", "🚥", "🚦", "🚧", "🚨", "🚩", "🚪", "🚫",
        "🚬", "🚭", "🚮", "🚯", "🚰", "🔮", "🚱", "🚲", "🚳", "🚴", "🚵", "🚶", "✅", "✊", "❌", "🤌",
        "🤍", "🥇", "🥈", "🥉", "🥊", "🥋", "🥌", "🥍", "🥎", "🥏", "🥐", "🥑", "🥒", "🥓", "🥔", "🥕",
        "🥖", "🥗", "🥘", "🥙", "🥚", "🥛", "🥜", "🥝", "🥞", "🥟", "🥺", "🥻", "🥼", "🥽", "🥾", "🥿",
        "🦀", "🦁", "🦂", "🦃", "🦄", "🦅", "🦆", "🦇", "🦈", "🦉", "🦊", "🦋", "🦌", "🦍", "🦎", "🦏",
        "🦐", "🦑", "🦒", "🦓", "🦔", "🦕", "🦖", "🦗", "🦘", "🦙", "🦚", "🦛", "🦜", "🦝", "🦞", "🦟",
        "🦠", "🦡", "🦢", "🦣", "🧀", "🧁", "🧏", "🧐", "🧑", "🧒", "🧓", "🧔", "🧕", "🧖", "🧗", "🧘",
        "🧙", "🧚", "🧛", "🧜", "🧝", "🧞", "🧟", "🧠", "🧡", "🧢", "🧣", "🧤", "🧥", "🧦", "🧧", "🧨",
        "🧩", "🧪", "🧫", "🧬", "🧭", "🧮", "🧯", "🧰", "🧱", "🧲", "🧳", "🧴", "🧵", "🧶", "🧷", "🧸",
        "🧹", "🧺", "🧻", "🧼", "🧽", "🧾", "🧿", "🧂", "🧃", "🧄", "🧅", "🧆", "🧇", "🧈", "🧉", "🧊",
        "🧋", "🦤", "🦥", "🦦", "🦧", "🦨", "🦩", "🦪", "🦫", "🦬", "🦭", "🦮", "🦯", "🦰", "🦱", "🦲",
        "🦳", "🦴", "🦵", "🦶", "🦷", "🦸", "🦹", "🦺", "🦻", "🥠", "🥡", "🥢", "🥣", "🥤", "🥥", "🥦",
        "🥧", "🥨", "🥩", "🥪", "🥫", "🥬", "🥭", "🥮", "🥯", "🥰", "🥱", "🥲", "🥳", "🥴", "🥵", "🥶",
        "🥷", "🥸", "🤎", "🤏", "🤐", "🤯", "🤰", "🤱", "🤲", "🤳", "🤴", "🤵", "🤶", "🤷", "🤸", "🤹",
        "🤺", "🤑", "🤒", "🤓", "🤔", "🤕", "🤖", "🤗", "🤘", "🤙", "🤚", "🤛", "🤜", "🤝", "🤞", "🤟",
        "🤠", "🤡", "✋", "🚷", "❎", "🚸", "⛰", "⛱", "⛲", "⛳", "⛴", "⛵", "⛷", "⛸", "⛹", "⛺",
        "⛩", "⛪", "🛳", "🛴", "🛵", "🛶", "🛷", "🛸", "🛹", "🛺", "🛻", "🛼", "🚹", "🚺", "🚻", "🚼",
        "🚽", "🚾", "🚿", "🛀", "🛁", "🛂", "🛃", "🛄", "🛅", "🛋", "🛌", "🛍", "🛎", "🛏", "🛐", "🛑",
        "🛒", "🖋", "🖌", "🖍", "🕑", "🕒", "🕓", "🕔", "🕕", "🕖", "🕗", "🕳", "🕴", "🕵", "🕶", "🕷",
        "🕸", "🕹", "🕺", "🕘", "🕙", "🕚", "🕛", "🕜", "🕝", "🕞", "🕟", "🕠", "🕡", "🕢", "🕣", "🕤",
        "🕥", "🕦", "🕧", "🔕", "🔖", "🔗", "🔘", "🔙", "🔰", "🔱", "🔲", "🔳", "🔴", "🔵", "🔶", "🔷",
        "🔸", "🔹", "🔺", "🔻", "🔼", "🔽", "🔚", "🔛", "🔜", "🔝", "🔞", "🔟", "🔠", "🔡", "🔢", "🔣",
        "🔤", "🔥", "🏷", "🏸", "🏹", "🏺", "🏻", "🏥", "🏦", "🏧", "🏨", "🏩", "🏪", "🆎", "🆑", "🆒",
        "🆓", "🆔", "🆕", "🆖", "🆗", "🆘", "🆙", "🆚", "🏫", "🏬", "🏳", "🏴", "🏵", "🏭", "🏮", "🏯",
        "🏰", "🎏", "🎐", "🎑", "🎒", "🎓", "🈲", "🈳", "🈴", "🈵", "🈶", "🈸", "🈹", "🈺", "⏩", "⏪",
        "⏫", "⏬", "⏭", "⏮", "⏯", "⏰", "⏱", "⏲", "⏳", "⏸", "⏹", "⏺"
    ]
}
