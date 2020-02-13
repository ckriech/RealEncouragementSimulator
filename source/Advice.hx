package;

import flixel.FlxGame;
import flixel.FlxG;
import openfl.display.Sprite;

using ArrayStringExtender;

class Advice {
	private static var positiveAdjs:Array<String> = ['strong', 'wise', 'dashing', 'buff', 'peerless', 'powerful', 'intelligent', 'perfect', 'nice'];
    private static var positiveVerbs:Array<String> = ["win"];
    private static var largeQuantitesOf:Array<String> = ['a lot of', 'tons of', 'fucktons of', 'huge amounts of', 'egregious quantities of', 'big ol\' piles of'];
    private static var desireableQualities:Array<String> = ['tenaciousness','sense of justice', 'correctness', 'knowledgeableness', 'gracefulness'];
	private static var positiveNouns:Array<String> = ["victory","freedom","the power of winning",'competition','the american flag'];
	private static var affectionateNicknanme:Array<String> = ["tiger","cowboy","kid","man","guy",'champion','knight', 'motherfucker','speciman'];
	private static var genericPlatitudes:Array<String> = [
        'you are the best',
        'you can do it',
        'you really look nice today',
        'I\'m amazed at your prescence',
        'you can do it'
    ];
    
	public static function generateHelpfuAdvice():String {
        var amount = FlxG.random.int(10, 20);

        var firstPart:String = genAdvice();
        var head:String = firstPart.substr(0,1);
        var tail:String = firstPart.substr(1);

        var advice: String = '${head.toUpperCase()}${tail}';
        for (i in 0...amount) {
            advice = advice + ', ${genAdvice()}';
        }

        return '$advice!';
    }

    private static function genAdvice(): String {
        var ran = FlxG.random.int(0,4);

        var result = switch(ran) {
            case 0: genBasic();
            case 1: genAdjNickname();
            case 2: youLookNiceToday();
            case 3: iLoveYouLikeILove();
            case 4: youLargeQuatityOfDesireableQuality();
            case _: "whhhhhhhhat??????";
        }

        return result;
    }

    private static function genBasic(): String {
        return genericPlatitudes.peekRandom();
    }

    private static function genAdjNickname():String {
        return 'you ${positiveAdjs.peekRandom()} ${affectionateNicknanme.peekRandom()}';
    }

    private static function youLookNiceToday():String {
        return 'hey ${affectionateNicknanme.peekRandom()}: you look ${positiveAdjs.peekRandom()} today';
    }

    private static function iLoveYouLikeILove(): String {
        return 'I love you like I love ${positiveNouns.peekRandom()}';
    }

    private static function youLargeQuatityOfDesireableQuality(): String {
        return 'you certainly have ${largeQuantitesOf.peekRandom()} ${desireableQualities.peekRandom()}';
    }
}
