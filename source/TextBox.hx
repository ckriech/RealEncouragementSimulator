package;

import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxGame;
import flixel.FlxG;
import openfl.display.Sprite;

class TextBox {

    private static final OffscreenX:Float = 10000;
    private static final OffscreenY:Float = 10000;
    private static final MaxGroupSize:Int = 1;

    public var group(default, null):FlxSpriteGroup;

    public function new(text: FlxText) {
        this.group = new FlxSpriteGroup(OffscreenX, OffscreenY, MaxGroupSize);
        group.add(text);
    }
}