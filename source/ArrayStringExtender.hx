package;

import flixel.FlxG;

class StringArrayExtender {
    static public function peekRandom(array:Array<String>) {
        var index:Int = FlxG.random.int(0, array.length - 1);
        return array[index];
    }
}