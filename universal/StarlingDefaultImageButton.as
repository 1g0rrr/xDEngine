package xDEngine.universal 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author ...
	 */
	public class StarlingDefaultImageButton extends UniSprite 
	{
		private var _image:Image;
		
		public var clickSignal:Signal = new Signal(Object);
		
		public function StarlingDefaultImageButton(texture:Texture) 
		{
			super();
			
			_image = new Image(texture);
			view.addChild(_image);

			view.useHandCursor = true;
			view.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		private function mouseDownHandler(e:*):void 
		{
			clickSignal.dispatch(this);
		}
		
		
		private function touchHandler(tEvt:TouchEvent):void {

			var touchBegan:Touch = tEvt.getTouch(this.view, TouchPhase.BEGAN);
			
			if (touchBegan) {
				clickSignal.dispatch(this);
			}
		}		
	}

}