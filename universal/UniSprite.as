package xD.universal 
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingCitrusEngine;
	import flash.display.Sprite;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniSprite 
	{
		private var _view:*;
		public function get view():* { return _view; }
		
		/* А получится ли этот финт в старлинге? */
		protected var _ce:CitrusEngine = CitrusEngine.getInstance();
		protected function get isStarling():Boolean { return _ce is StarlingCitrusEngine; }
		
		public function UniSprite() 
		{
			if(isStarling) {
				_view = new starling.display.Sprite();
			} else {
				_view = new flash.display.Sprite();
			}
		}
		
		public function addChild(child:UniSprite):void {
			view.addChild(child.view);
		}
		
		public function removeChild(child:UniSprite):void {
			view.removeChild(child.view);
		}
		
		public function contains(child:UniSprite):Boolean {
			return view.contains(child.view);
		}
		
		public function get x():Number { return view.x };
		public function set x(value:Number):void { view.x = value };
		
		public function get y():Number { return view.y };
		public function set y(value:Number):void { view.y = value };
		
		public function get width():Number { return view.width };
		public function set width(value:Number):void { view.width = value };
		
		public function get height():Number { return view.height };
		public function set height(value:Number):void { view.height = value };
		
		public function get alpha():Number { return view.alpha };
		public function set alpha(value:Number):void { view.alpha = value };

		public function get scaleX():Number { return view.scaleX };
		public function set scaleX(value:Number):void { view.scaleX = value };	
		
		public function get scaleY():Number { return view.scaleY };
		public function set scaleY(value:Number):void { view.scaleY = value };		
	}
}