package xD.universal 
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingCitrusEngine;
	import flash.display.Sprite;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniQuad extends UniSprite
	{
		public function UniQuad(_width:Number, _height:Number, _color:int = 0xFF0000) 
		{
			super();
			
			if (isStarling) 
			{
				var starlingQuad:* = new Quad(_width, _height, _color);
				
				view.addChild(starlingQuad);
			}
			else 
			{
				var spriteQuad:* = new flash.display.Sprite();
				spriteQuad.graphics.beginFill(_color);
				spriteQuad.graphics.drawRect(0, 0, _width, _height);
				
				view.addChild(spriteQuad);
			}
		}
	}
}