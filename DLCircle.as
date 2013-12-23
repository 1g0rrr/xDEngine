package xD 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class DLCircle extends Sprite
	{
		
		public function DLCircle(radius:Number, color:int = 0xFF0000) 
		{
			super();
			graphics.beginFill(color);
			graphics.drawCircle(radius, radius, radius);
		}
	}
}