package xDEngine.sprite 
{
	import citrus.core.CitrusEngine;
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextInteractionMode;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class DLAnimationSequence extends MovieClip 
	{
		/* хмм, а это ж можно спрайтом всё сделать. И наверное надёжнее будет */
		public var onAnimationComplete:Signal;
		
		private var _SequenceClipClass:Class;
		private var _sequenceClip:*;
		private var _currentStateLabel:String;
		private var _currentStateHeight:Number;
		private var _currentState:DLMovieClip
		private var _loopAnimations:Array;
		private var _isCashed:Boolean;
		private var _squitArray:Array;
		
		
		private var _animSpeed:Number;
		
		public var mcSequences:Array = new Array();
		
		private var squitTween:TweenLite;
		
		/* Класс делает кэшированный сиквенс из готового клипа созданного по нужным правилам 
		 * Тоесть он всегда кэширован. Нет, не всегда. Кэш передаётся в ДЛМувиКлип и там уже строится как задумано.
		 * Сюда уже передается !только класс. Чтобы не создавать лишних сущностей. Хотя можно было бы и сделать универсальное.
		 * 
		 * */
		public function DLAnimationSequence(SequenceClipClass:Class, loopAnimations:Array = null, isCashed:Boolean = false, squitArray:Array = null, animSpeed:Number = 1 ) 
		{
			super();
			
			onAnimationComplete = new Signal(String); /* готово удалять */
			
			_SequenceClipClass = SequenceClipClass;
			/* !!! Надо почистить эту хренЬ, чтобы не создавался лишний клип */
			_sequenceClip = new SequenceClipClass();
			_animSpeed = animSpeed;
			_loopAnimations = loopAnimations;
			_isCashed = isCashed;
			_squitArray = squitArray;
			
			buildStates();
			
			//addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function removedFromStageHandler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			//_currentState.deactivate();
			destroy();
		}
		
		public function buildStates():void {
			_sequenceClip = new _SequenceClipClass() as MovieClip;
				
			for each(var label:FrameLabel in _sequenceClip.currentLabels) {
				_sequenceClip.gotoAndStop(label.name); 
				
				if (_sequenceClip.numChildren > 1) throw new Error('There is more than one child in item MovieClip: ' + _sequenceClip.currentLabel);
				if (_sequenceClip.numChildren == 0) throw new Error('There is no children in item MovieClip: ' + _sequenceClip.currentLabel);					
				
				var isLoop:Boolean;
				if (_loopAnimations == null) {
					isLoop = true;
				} else {
					isLoop = _loopAnimations.indexOf(label.name) > -1 ? true : false;
				}
				
				/* название label.name берётся из клипа главного сиквенса */
				mcSequences[label.name] = new DLMovieClip(_sequenceClip.getChildAt(0), isLoop, _isCashed, label.name, _animSpeed);
				DLMovieClip(mcSequences[label.name]).deactivate();
				addChild(mcSequences[label.name]); 
				/* надо всем сделать ремув чайлд
					всем сделать деактивейт и диспоуз. */
				mcSequences[label.name].onAnimationComplete.add(animationCompleteHandler)
			}
		}
		
		override public function get currentLabels():Array { /* Это важная функция, не надо удалять. Нужна для StarlingArt */
			return _sequenceClip.currentLabels;
		}		
		
		private function animationCompleteHandler():void {
			onAnimationComplete.dispatch(_currentStateLabel);
		}
		
		override public function gotoAndStop(frame:Object, scene:String = null):void {
			gotoAndStopNotCashed(frame, scene);
		}
		
		public function changeAnimation(animation:String, animLoop:Boolean = true):void {
			gotoAndStop(animation);
		}
		
		private function gotoAndStopNotCashed(frame:Object, scene:String = null):void {
			var squitScale:Number = 0.78;
			_currentStateLabel = frame as String;
			if (_currentState) {
				if(_squitArray != null && _squitArray.indexOf(_currentStateLabel) >= 0) { /* Если нужно присесть, приседаем с помощью твинов */
					var transformedVector:Point = new Point( _currentState.x, (_currentState.bottomClipY - _currentState.y) * squitScale );				
					var newY:Number = _currentState.bottomClipY - transformedVector.y;
					
					squitTween = TweenLite.to(_currentState, 0.05, { 
						scaleY: squitScale
						, y: newY
						, ease: Quad.easeIn
						, onComplete: squitCompleteHandler
						, overwrite: false 
					} );
				} else { /* Если не нужно приседать - меняем состояние без твинов */
					_currentState.deactivate();
					_currentState = mcSequences[_currentStateLabel];
					_currentState.activate();
				}
			} else { /* Если не существует предедущего состояния - запускаем просто */
				_currentState = mcSequences[_currentStateLabel];
				_currentState.activate();
			}
			
			function squitCompleteHandler():void {
				_currentState.deactivate();
				_currentState = mcSequences[_currentStateLabel];
				_currentState.activate();
				_currentState.scaleY = squitScale
				_currentState.y = newY;
				squitTween = TweenLite.to(_currentState, 0.05, { scaleY: 1, y: 0, ease: Quad.easeOut, overwrite: false } );		
			}			
		}
		
		public function destroy():void {
			onAnimationComplete.removeAll();
			onAnimationComplete = null;
			
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			for each(var animClip:DLMovieClip in mcSequences ) {
				animClip.destroy();
				removeChild(animClip);
				animClip = null;
			}
			mcSequences = null;
			_sequenceClip = null;
			_currentState = null;
			_loopAnimations = null;
			_squitArray = null;
			if(squitTween)
				squitTween.gc = true;
			squitTween = null;
		}
	}
}