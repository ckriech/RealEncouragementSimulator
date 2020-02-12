package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	var cycleLength: Float;
	var canvas: FlxSprite;

	override public function create():Void
	{
		cycleLength = 20;
		setUpRainbow();
		createPositiveEnvironment();
		super.create();
	}
	
	var text: FlxText;
	private function createPositiveEnvironment()
	{
		// canvas = new FlxSprite();
		// canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		// add(canvas);
		text = new FlxText(100,300,100,"You've got this, bud. You're strong and you'll make it, I'm sure.",20);
		text.screenCenter();
		add(text);	
	}

	override public function update(elapsed:Float):Void
	{
		var currentColor = generateNextRainbowState(cycleLength, elapsed);
		// canvas.drawCircle(100, 100, 100, currentColor);
		text.color = currentColor;
		super.update(elapsed);
	}

	var totalDuration: Float;

	public function setUpRainbow():Void
	{
		totalDuration = 0;
	}

	var r: Int;
	var g: Int;
	var b: Int;

	public function generateNextRainbowState(cycleLength: Float, elapsed: Float): FlxColor
		{
			/*
			cycleLength = 60
			totalDuration=15
			howManyComplete=
			currentPercent=15/60 = .25
			currentPosition=
				1 / 6 = length of a stage
				.25 / .1666667 /  = 1.49  
			*/

			totalDuration += elapsed * 10;
			
			var howManyComplete = totalDuration / cycleLength;
			//current percentage (as number between 0 - 1, inclusive/exclusive)
			var currentPercent = howManyComplete - Math.ffloor(howManyComplete);
			//Number of stages completed  currentPercent / (1/(stages))
			var currentPosition = currentPercent / (1 / 6);

			var stage = Math.ffloor(currentPosition);

			trace("totalDuration=" + totalDuration + " howManyComplete=" + howManyComplete + " currentPercent=" + currentPercent + " currentPosition=" + currentPosition + " stage=" + stage);
			//r start rise: 4, start decline: 1
			//g start rise: 0, start decline: 3
			//b start rise: 2, start decline: 5

			//at point 0: r:255,g:0  ,b:0
			//at point 1: r:255,g:255,b:0
			//at point 2: r:0  ,g:255,b:0
			//at point 3: r:0  ,g:255,b:255
			//at point 4: r:0  ,g:0,  b:255
			//at point 5: r:255,g:0,  b:255

			if (stage == 0) {
				//green start rise
				r = 255;
				g = getRiseState(getDecimal(currentPosition));
				b = 0;
			}

			if (stage == 1) {
				r = getFallState(getDecimal(currentPosition));
				g = 255;
				b = 0;
			}

			if (stage == 2) {
				r = 0;
				g = 255;
				b = getRiseState(getDecimal(currentPosition));
			}

			if (stage == 3) {
				r = 0;
				g = getFallState(getDecimal(currentPosition));
				b = 255;
			}

			if (stage == 4) {
				r = getRiseState(getDecimal(currentPosition));
				g = 0;
				b = 255;
			}

			if (stage == 5) {
				r = 255;
				g = 0;
				b = getFallState(getDecimal(currentPosition));
			}

			trace("r=" + r + " g=" + g + " b=" + b);
			return FlxColor.fromRGB(r,g,b);
		}

	//assumes percent is never greater than 1
	public function getRiseState(percent: Float): Int 
	{ 
		var result = Std.int(Math.fceil(percent * 255));
		trace("getRiseState: percent = " + percent + " result=" + result);
		return result;
	} 

	public function getFallState(percent: Float): Int 
	{
		var reversePercent = 1 - percent;
		var result = getRiseState(reversePercent);
		trace("getFallState: percent = " + percent + " result=" + result);
		return result;
	}

	public function getDecimal(number: Float): Float 
	{ 
		var result = number - Math.ffloor(number); 
		trace("getDecimal: number=" + number + " result=" + result);
		return result; 
	}
}
