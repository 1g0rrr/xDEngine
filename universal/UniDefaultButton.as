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
		
		public function UniDefaultButton(_width:Number, _height:Number, _color:int = 0xFF0000, _text:String = '', _font:String = "Verdana", _fontSize:int = 12, _fontColor:int = 0x000000) 
		{
			super();
			
			_rectangle = new UniQuad(_width, _height, _color);
			view.addChild(_rectangle.view);
			
			_labelTF = new UniTextField(_width, _height, _text, _font, _fontSize, _fontColor);
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
		
		override public function destroy():void 
		{
			if (isStarling) {
				view.removeEventListener(TouchEvent.TOUCH, touchHandler);
			} else {
				view.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}
			
			clickSignal.removeAll();
			super.destroy();
		}
		
	}

}