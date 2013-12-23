package xD.universal
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniModalsManager extends UniSprite
	{
		private var _currentModal:AModal = null;
		
		/* Лучше передавать сущность, а не класс, т.к. сущность можно проверить лишний раз */
		public function UniModalsManager()
		{
			super();
		}
		
		/* Также надо не забывать - что модальное окно - вне стейта. Поэтому надо следить, чтобы оно не осталось открытым, когда стейт уже переключился.
		 * Надо наверное сюда добавить сигнал, и по этому сигналу, о том, что переключился стейт - чистить модальные окна.
		 * */
		public function showModal(modal:AModal):void
		{
			if (_currentModal != null) return;
			
			_currentModal = modal;
			_currentModal.closeSignal.add(closeModalHandler);
			view.addChild(_currentModal.view);
		}
		
		private function closeModalHandler():void 
		{
			view.removeChild(_currentModal.view);
			_currentModal.destroy();
			_currentModal = null;
		}
	}
}