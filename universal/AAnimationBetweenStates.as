package xDEngine.universal 
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingCitrusEngine;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import starling.display.Sprite;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author ...
	 */
	public class AAnimationBetweenStates extends UniSprite
	{
		public var changeScreenSignal:Signal = new Signal();
		public var endAnimationSignal:Signal = new Signal();
		
		public function AAnimationBetweenStates() 
		{
			super();
		}
		
		public function initialize():void {
		}
		
		public function play():void {
		}
		
		override public function destroy():void {
			changeScreenSignal.removeAll();
			endAnimationSignal.removeAll();
			super.destroy();
		}		
	}

}