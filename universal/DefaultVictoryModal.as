package xDEngine.universal
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import game.Settings;
	import org.osflash.signals.Signal;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DefaultVictoryModal extends DefaultModal
	{
		private var _rectangle:UniQuad;
		
		private var _nextBtn:UniDefaultButton;
		private var _restartBtn:UniDefaultButton;
		
		public var restartSignal:Signal = new Signal();
		public var nextSignal:Signal = new Signal();
		
		private var _titleTF:UniTextField;

		public function DefaultVictoryModal()
		{
			super();
			/* Можно вынести все эти зарисовки в отдельный класс, вид. */
			/* В старлинге правда всё будет по-другому */
			_rectangle = new UniQuad(300, 200, 0xA64B00);
			_rectangle.x = Settings.stageWidth / 2 - _rectangle.width / 2;
			_rectangle.y = Settings.stageHeight / 2 - _rectangle.height / 2;
			addChild(_rectangle);
			
			_restartBtn = new UniDefaultButton(80, 30, 0xFF7400, 'Restart'); /* Надо будет упростить создание, до текста. */
			_restartBtn.x = Settings.stageWidth / 2 - _restartBtn.width - 20;
			_restartBtn.y = _rectangle.y + _rectangle.height - _restartBtn.height - 20;
			addChild(_restartBtn);
			
			_nextBtn = new UniDefaultButton(80, 30, 0xFF7400, 'Next');
			_nextBtn.x = Settings.stageWidth / 2 + 20;
			_nextBtn.y = _rectangle.y + _rectangle.height - _nextBtn.height - 20;
			addChild(_nextBtn);
			
			_nextBtn.clickSignal.add(nextButtonHandler);
			_restartBtn.clickSignal.add(restartButtonHandler);
			
			_titleTF = new UniTextField(_rectangle.width, 30, 'Victory', 'Verdana', 20);
			_titleTF.x = _rectangle.x;
			_titleTF.y = _rectangle.y + 20;
			addChild(_titleTF);			
		}
		
		private function restartButtonHandler(e:* = null):void 
		{
			restartSignal.dispatch();
			close();
		}
		
		private function nextButtonHandler(e:* = null):void
		{
			nextSignal.dispatch();
			close();
		}
		
		override public function destroy():void 
		{
			nextSignal.removeAll();
			restartSignal.removeAll();
			super.destroy();
		}
	}
}