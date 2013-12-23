package xDEngine.universal 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DefaultProgressBar extends UniSprite 
	{
		private var _background:UniQuad;
		private var _bar:UniQuad;
		
		public function DefaultProgressBar(width:Number = 100, height:Number = 20, outColor:int = 0xBF8F30, inColor:int = 0xFFAA00) 
		{
			super();
			_background = new UniQuad(width, height, outColor);
			addChild(_background);
			
			_bar = new UniQuad(width - 2, height - 2, inColor);
			_bar.x = 1;
			_bar.y = 1;
			addChild(_bar);
		}
		
		public function update(progress:Number):void {
			progress = progress > 1 ? 1 : progress;
			progress = progress < 0 ? 0 : progress;
			
			_bar.scaleX = progress;
		}
		
	}

}