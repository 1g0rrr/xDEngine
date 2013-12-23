package xDEngine.universal 
{
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniButton extends UniSprite 
	{
        private var mName:String;
		private var textClip:UniTextField;
		
		public function UniButton(text:String, buttonWidth:int = 50, buttonHeight:int = 80) 
		{
			textClip = new UniTextField(buttonWidth, buttonHeight, text);
			view.addChild(textClip.view);
			
			view.buttonMode = true;
			view.mouseChildren = false;
		}
		
		public function set text(_text:String):void {
			textClip.view.textField.text = _text;
		}
		
		//public function set touchable (_isTouchable:Boolean):void {
			//this.mouseEnabled = _isTouchable;
			//this.mouseChildren = _isTouchable;
		//}
		//
		//public function destroy():void {
			//textClip.destroy();
			//textClip = null;
		//}
	}
}