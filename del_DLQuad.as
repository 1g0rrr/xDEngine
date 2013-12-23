package xDEngine 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class DLQuad extends Sprite
	{
		
		public function DLQuad(_width:Number, _height:Number, _color:int = 0xFF0000) 
		{
			super();
			graphics.beginFill(_color);
			graphics.drawRect(0, 0, _width, _height);
		}
	}
}