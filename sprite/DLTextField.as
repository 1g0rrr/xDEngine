package xDEngine.sprite 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class DLTextField extends Sprite 
	{
		public var textField:TextField;
		private var my_fmt:TextFormat;
		
		public function DLTextField(_width:int, _height:int, label:String, fontName:String="Verdana",
                                  fontSize:Number=12, color:uint=0x0, bold:Boolean=false) 
		{
			textField = new TextField();
			textField.wordWrap = true;
			textField.width = _width;
			textField.height = _height;
			textField.multiline = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			
			my_fmt = new TextFormat();
			my_fmt.color = color;
			my_fmt.font = fontName;
			my_fmt.size = fontSize;
			my_fmt.bold = bold;
			my_fmt.align = TextFormatAlign.CENTER;

			textField.defaultTextFormat = my_fmt;

			textField.text = label;
			
			addChild(textField);
		}
		
		public function set vAlign(label:String):void {
			//my_fmt.align = 'center';
		}
		
		public function set hAlign(label:String):void {
			my_fmt.align = label;
		}
		
		public function set text(label:String):void {
			textField.text = label;
		}
		
		public function set color(color:uint):void {
			my_fmt.color = color;
			textField.defaultTextFormat = my_fmt;
		}
		
		public function set fontSize(fontSize:Number):void {
			my_fmt.size = fontSize;
			textField.defaultTextFormat = my_fmt;
		}
		
		public function set touchable (_isTouchable:Boolean):void {
			this.mouseEnabled = _isTouchable;
			this.mouseChildren = _isTouchable;
		}
		
		public function destroy():void {
			textField = null;
			my_fmt = null;
		}
	}
}