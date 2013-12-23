package xDEngine
{
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;
	import xDEngine.universal.AAnimationBetweenStates;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class ScreenManager extends Sprite
	{
		private var _ce:CitrusEngine = CitrusEngine.getInstance();

		private var _animationBetweenStates:AAnimationBetweenStates;
		
		private var _nextState:State;
		private var _externalChangeHandler:Function = null;
		private var _externalCompleteHandler:Function = null;
		
		/* Холдер не обязателен? Можно на менеджер ложить наверное. */
		private var _screenAnimationHolder:Sprite = new Sprite();
		
		/* Лучше передавать сущность, а не класс, т.к. сущность можно проверить лишний раз */
		public function ScreenManager()
		{
			super();
			
			addChild(_screenAnimationHolder);
		}
		
		public function setup(animationBetweenStates:AAnimationBetweenStates):void {
			
			/* Удаляем все сигналы и пр. */
			if (_animationBetweenStates != null) _animationBetweenStates.destroy();
			
			_animationBetweenStates = animationBetweenStates;
			
			_animationBetweenStates.changeScreenSignal.add(realChangeStateHandler);
			_animationBetweenStates.endAnimationSignal.add(endAnimationHandler);
		}

		
		public function changeState(nextState:State, externalChangeHandler:Function = null, externalCompleteHandler:Function = null):void
		{
			
			/* Дефолтная установка. Её можно переопределить */
			if (_animationBetweenStates == null) 
			{
				setup(new DefaultAnimationBetweenStates());
			}
			
			/*
			 * Если у нас уже идёт смена стейта, а сверху требуется новый, то текущая смена - затирается
			 * Нужно помнить об этом
			 * */
			_nextState = nextState;
			_externalChangeHandler = externalChangeHandler;
			_externalCompleteHandler = externalCompleteHandler;
			
			/* Удалять прошлую анимацию - не нужно. Она инициализируется. А удаляется с экрана уже после проигрывания. */
			_animationBetweenStates.initialize();
			_screenAnimationHolder.addChild(_animationBetweenStates);
			_animationBetweenStates.play();
		}
		
		private function realChangeStateHandler():void
		{
			_ce.state = _nextState;
			
			if (_externalChangeHandler != null)
			{
				_externalChangeHandler();
				_externalChangeHandler = null;
			}
		}
		
		private function endAnimationHandler():void
		{
			if (_screenAnimationHolder.contains(_animationBetweenStates))
			{
				_screenAnimationHolder.removeChild(_animationBetweenStates);
			}
			
			if (_externalCompleteHandler != null)
			{
				_externalCompleteHandler();
				_externalCompleteHandler = null;
			}
		}
		
		public function destroy():void
		{
			_animationBetweenStates.destroy();
		}
	}

}