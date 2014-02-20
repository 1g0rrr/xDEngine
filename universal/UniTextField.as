package xDEngine.universal 
{
	import starling.text.TextField;
	import starling.utils.HAlign;
	import xDEngine.sprite.DLTextField;
	import xDEngine.universal.UniSprite;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniTextField extends UniSprite 
	{
		private var _textField:*;
		public function get textField():* { return _textField; }
		
		public function UniTextField(_width:int, _height:int, label:String, fontName:String="Verdana",
                                  fontSize:Number=12, color:uint=0x0, bold:Boolean=false) 
		{
			if (isStarling) {
				_textField = new starling.text.TextField(_width, _height, label, fontName, fontSize, color, bold);
				
				view.addChild(_textField);
			} else {
				_textField = new DLTextField(_width, _height, label, fontName, fontSize, color, bold);
				
				view.addChild(_textField);
			}
		}
		
		public function set text(value:String):void {
			_textField.text = value;
		}
		
		override public function destroy():void 
		{
			if (isStarling) {
				starling.text.TextField(_textField).dispose();
			}
			super.destroy();
		}
	}
}