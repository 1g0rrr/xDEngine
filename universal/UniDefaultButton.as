package xDEngine.universal 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UniDefaultButton extends UniSprite 
	{
		private var _rectangle:UniQuad;
		private var _labelTF:UniTextField;
		
		public var clickSignal:Signal = new Signal(Object);
		
		public function UniDefaultButton(_width:Number, _height:Number, _color:int = 0xFF0000, _text:String = '') 
		{
			super();
			
			_rectangle = new UniQuad(_width, _height, _color);
			view.addChild(_rectangle.view);
			
			_labelTF = new UniTextField(_width, _height, _text);
			view.addChild(_labelTF.view);
			
			if (isStarling) {
				view.useHandCursor = true;
				view.addEventListener(TouchEvent.TOUCH, touchHandler);
			} else {
				_labelTF.view.mouseChildren = false;
			
				view.buttonMode = true;
				view.mouseChildren = false;
				
				view.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}
			
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