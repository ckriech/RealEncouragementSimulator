package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;

class RainbowGenerator {

    private static final NumberOfStages: Int = 6;
    
    private var totalElapsed(null, null):Float = 0;
    private var cycleLength(null, null):Int;

    public function new(cycleLength) {
        this.cycleLength = cycleLength;
    }

    //how many cycles of animation have been completed (not a whole number)
    private function howManyComplete():Float {
        return totalElapsed / cycleLength;
    }

    //Current percent of the way through the current cycle (as number between 0 - 1, inclusive/exclusive)
    private function currentPercent(): Float {
        return howManyComplete() - Math.ffloor(howManyComplete());
    }

    // Number of stages completed  currentPercent / (1/(stages))
    private function positionInCycle(): Float {
        return currentPercent() / (1 / NumberOfStages);
    }

    //what stage are we on, should be 0,1,2,3,4,or 5
    private function currentStage(): Int {
        return Std.int(Math.ffloor(positionInCycle()));
    }

	public function nextState(elapsed:Float):FlxColor {
        totalElapsed += elapsed * 10;

        var rgb = switch (currentStage()) {
            case 0: 
                {
                    r: 255,
                    g: getRiseState(getDecimal(positionInCycle())),
                    b: 0
                };
            case 1:
                {
                    r: getFallState(getDecimal(positionInCycle())),
                    g: 255,
                    b: 0
                };
            case 2:
                {
                    r: 0,
                    g: 255,
                    b: getRiseState(getDecimal(positionInCycle()))
                };
            case 3:
                { 
                    r: 0,
                    g: getFallState(getDecimal(positionInCycle())),
                    b: 255
                };
            case 4:
                {
                    r: getRiseState(getDecimal(positionInCycle())),
                    g: 0,
                    b: 255
                };
            case 5:
                {
                    r: 255,
                    g: 0,
                    b: getFallState(getDecimal(positionInCycle())) 
                };
            case _:
                trace("idk what's up with these rgb values bud");
                { r: 255, g: 255, b: 255 };
        }

		return FlxColor.fromRGB(rgb.r, rgb.g, rgb.b);
    }

    // assumes percent is never greater than 1
	private function getRiseState(percent:Float):Int {
		var result = Std.int(Math.fceil(percent * 255));
		//trace("getRiseState: percent = " + percent + " result=" + result);
		return result;
	}

	private function getFallState(percent:Float):Int {
		var reversePercent = 1 - percent;
		var result = getRiseState(reversePercent);
		//trace("getFallState: percent = " + percent + " result=" + result);
		return result;
	}

	private function getDecimal(number:Float):Float {
		var result = number - Math.ffloor(number);
		//trace("getDecimal: number=" + number + " result=" + result);
		return result;
	}
}

		// trace("totalDuration=" + totalDuration + " howManyComplete=" + howManyComplete + " currentPercent=" + currentPercent + " currentPosition="
        // 	+ currentPosition + " stage=" + stage);
        
		// r start rise: 4, start decline: 1
		// g start rise: 0, start decline: 3
		// b start rise: 2, start decline: 5

		// at point 0: r:255,g:0  ,b:0
		// at point 1: r:255,g:255,b:0
		// at point 2: r:0  ,g:255,b:0
		// at point 3: r:0  ,g:255,b:255
		// at point 4: r:0  ,g:0,  b:255
		// at point 5: r:255,g:0,  b:255