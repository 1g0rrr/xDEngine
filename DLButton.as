package xDEngine 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class DLButton extends Sprite 
	{
        private var mName:String;
		private var textClip:DLTextField;
		
		public function DLButton(text:String, buttonWidth:int = 50, buttonHeight:int = 80) 
		{
			textClip = new DLTextField(buttonWidth, buttonHeight, text);
			addChild(textClip);
			buttonMode = true;
			mouseChildren = false;
		}
		
		public function set text(_text:String):void {
			textClip.textField.text = _text;
		}
		
		public function set touchable (_isTouchable:Boolean):void {
			this.mouseEnabled = _isTouchable;
			this.mouseChildren = _isTouchable;
		}
		
		public function destroy():void {
			textClip.destroy();
			textClip = null;
		}
	}
}