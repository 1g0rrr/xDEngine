package xDEngine.universal
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import game.Settings;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DefaultAlertModal extends DefaultModal
	{
		private var _rectangle:UniQuad;
		
		private var _okBtn:UniDefaultButton;
		
		private var _titleTF:UniTextField;
		
		public var okSignal:Signal = new Signal();
		
		public function DefaultAlertModal(message:String = 'Alert')
		{
			super();
			/* Можно вынести все эти зарисовки в отдельный класс, вид. */
			/* В старлинге правда всё будет по-другому */
			_rectangle = new UniQuad(300, 200, 0xA64B00);
			_rectangle.x = Settings.stageWidth / 2 - _rectangle.width / 2;
			_rectangle.y = Settings.stageHeight / 2 - _rectangle.height / 2;
			addChild(_rectangle);
			
			
			_titleTF = new UniTextField(_rectangle.width, _rectangle.height, message, 'Verdana', 16);
			_titleTF.x = _rectangle.x;
			_titleTF.y = _rectangle.y;
			addChild(_titleTF);
			
			_okBtn = new UniDefaultButton(80, 30, 0xFF7400, 'ok'); /* Надо будет упростить создание, до текста. */
			_okBtn.x = Settings.stageWidth / 2 - _okBtn.width / 2;
			_okBtn.y = _rectangle.y + _rectangle.height - _okBtn.height - 20;
			addChild(_okBtn);

			_okBtn.clickSignal.add(okButtonHandler);
		}
		
		private function okButtonHandler(e:* = null):void 
		{
			okSignal.dispatch();
			close();
		}
		
		override public function destroy():void 
		{
			okSignal.removeAll();
			super.destroy();
		}
	}
}