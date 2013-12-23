package xD.universal 
{
	import starling.text.TextField;
	import xD.sprite.DLTextField;
	import xD.universal.UniSprite;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniTextField extends UniSprite 
	{
		private var textField:*;
		public function UniTextField(_width:int, _height:int, label:String, fontName:String="Verdana",
                                  fontSize:Number=12, color:uint=0x0, bold:Boolean=false) 
		{
			if (isStarling) {
				textField = new starling.text.TextField(_width, _height, label, fontName, fontSize, color, bold);
				
				view.addChild(textField);
			} else {
				textField = new DLTextField(_width, _height, label, fontName, fontSize, color, bold);
				
				view.addChild(textField);
			}
		}
		
		public function set text(value:String):void {
			textField.text = value;
		}
	}
}