package xDEngine.universal
{
	import adobe.utils.CustomActions;
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.State;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class UniScreenManager extends UniSprite
	{
		/* Будет универсальнго типа. */

		
		private var _nextState:*;

		
		private var _animationBetweenStates:AAnimationBetweenStates;
		
		private var _externalChangeHandler:Function = null;
		private var _externalCompleteHandler:Function = null;
		
		/* Этот скрин менеджер будет универсальным */
		public function UniScreenManager()
		{
			super();
		}
		
		public function setup(animationBetweenStates:AAnimationBetweenStates):void {
			
			/* Удаляем все сигналы и пр. */
			if (_animationBetweenStates != null) _animationBetweenStates.destroy();
			
			_animationBetweenStates = animationBetweenStates;
			
			_animationBetweenStates.changeScreenSignal.add(realChangeStateHandler);
			_animationBetweenStates.endAnimationSignal.add(endAnimationHandler);
		}

		
		public function changeState(nextState:*, externalChangeHandler:Function = null, externalCompleteHandler:Function = null):void
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
			addChild(_animationBetweenStates);
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
			if (view.contains(_animationBetweenStates.view))
			{
				removeChild(_animationBetweenStates);
			}
			
			if (_externalCompleteHandler != null)
			{
				_externalCompleteHandler();
				_externalCompleteHandler = null;
			}
		}
		
		override public function destroy():void
		{
			_animationBetweenStates.destroy();
			super.destroy();
		}
	}

}