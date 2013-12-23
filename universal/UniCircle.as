package xD.universal 
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingCitrusEngine;
	import flash.display.Sprite;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import xD.starling.Polygon;
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniCircle extends UniSprite
	{
		public function UniCircle(_radius:Number, _numEdges:int, _color:int = 0xFF0000) 
		{
			super();
			
			if (isStarling) 
			{
				var starlingPoly:* = new Polygon(_radius, _numEdges, _color);
				
				view.addChild(starlingPoly);
			}
			else 
			{
				var spriteQuad:flash.display.Sprite = new flash.display.Sprite();
				spriteQuad.graphics.beginFill(_color);
				spriteQuad.graphics.drawCircle(0, 0, _radius);
				
				view.addChild(spriteQuad);
			}
		}
	}
}