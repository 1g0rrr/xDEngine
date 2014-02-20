package xDEngine.universal 
{
	import citrus.core.CitrusEngine;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author ...
	 */
	/**
	 * Нет. Модальное окно может закрываться сразу. А если нужен твин - переопределяем функцию клоуз в потомках. 
	 */
	public class AModal extends UniSprite 
	{
		public var closeSignal:Signal = new Signal();
		
		public function AModal() 
		{
			super();
		}
		
		public function close():void {
			closeSignal.dispatch();
		}
		
		override public function destroy():void {
			closeSignal.removeAll();
			super.destroy();
		}
	}

}