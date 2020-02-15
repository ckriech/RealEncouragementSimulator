package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState {

	// private var _scrollable(null,null):FlxScrollableArea;
	private var _rainbowAnimation(null,null):RainbowGenerator =  new RainbowGenerator(Consts.RainbowCycleLength);

	override public function create():Void {
		createPositiveEnvironment();
		super.create();
	}

	var text:FlxText;
	private function createPositiveEnvironment():Void {
		text = new FlxText(0, 0, FlxG.width, getNewPhrase(), 30);
		add(text);
	}
	override public function update(elapsed:Float):Void {
		var currentColor = _rainbowAnimation.nextState(elapsed);
		text.color = currentColor;
		super.update(elapsed);
	}

	private function getNewPhrase():String {
		return Advice.generateHelpfuAdvice();
	}
}
