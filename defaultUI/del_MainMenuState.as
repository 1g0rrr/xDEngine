package xD.defaultUI
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import xD.DLQuad;
	import xD.DLTextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class del_MainMenuState extends DefaultModal
	{
		private var _rectangle:DLQuad;
		
		private var _playBtn:DefaultButton;
		
		private var _titleTF:DLTextField;
		
		public var playSignal:Signal = new Signal();
		
		public function del_MainMenuState()
		{
			super();
			/* Можно вынести все эти зарисовки в отдельный класс, вид. */
			/* В старлинге правда всё будет по-другому */
			_rectangle = new DLQuad(300, 200, 0xA64B00);
			_rectangle.x = _ce.stage.stageWidth / 2 - _rectangle.width / 2;
			_rectangle.y = _ce.stage.stageHeight / 2 - _rectangle.height / 2;
			addChild(_rectangle);
			
			
			_restartBtn = new DefaultButton(80, 30, 0xFF7400, 'Restart'); /* Надо будет упростить создание, до текста. */
			_restartBtn.x = _ce.stage.stageWidth / 2 - _restartBtn.width / 2;
			_restartBtn.y = _rectangle.getRect(_ce.stage).bottom - _restartBtn.height - 20;
			addChild(_restartBtn);

			_restartBtn.addEventListener(MouseEvent.MOUSE_DOWN, restartButtonHandler);
			
			_titleTF = new DLTextField(_rectangle.width, 20, 'Fail', 'Verdana', 20);
			_titleTF.x = _rectangle.x;
			_titleTF.y = _rectangle.y + 20;
			addChild(_titleTF);
		}
		
		private function restartButtonHandler(e:Event):void 
		{
			restartSignal.dispatch();
			close();
		}
		
		override public function destroy():void 
		{
			restartSignal.removeAll();
			super.destroy();
		}
	}
}