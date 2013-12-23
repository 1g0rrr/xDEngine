package xD.sprite 
{
	import citrus.core.CitrusEngine;
	import citrus.view.spriteview.SpriteArt;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import game.Settings;
	import org.osflash.signals.Signal;
	import ru.antkarlov.animation.AntActor;
	import ru.antkarlov.animation.AntAnim;
	import ru.antkarlov.animation.AntAnimCache;
	
	/**
	 * ...
	 * @author 1g0rrr
	 */
	public class DLMovieClip extends Sprite 
	{
		public var onAnimationComplete:Signal;
		
		private var _clip:*;
		private var _currentFrame:Number = 1;
		private var _animSpeed:Number;
		private var _isLoop:Boolean;
		private var _isCashed:Boolean;
		
		public var bottomClipY:Number;
		
		private var _clipName:String;
		/**
		 * АнтАктёр может чистится тоже, у него есть для этого функция
		 * Мувиклип - это анимация. Может выступать как сама, так и в наборе Сиквенсе. При убирании из сиквенса - одна функция. При окончательном уничтожении - другая.
		 * */
		
		
		/* ДЛМувиклип может создаться с нуля, тогда передаём в него класс, и создаём мувик. 
		 * Или же может создаваться из готового клипа, когда ДЛМувик выступает в качестве части сиквенса.
		 * 
		 * Можно сделать сиквенс мувиклип. Унаследованный от обычного. Или наоборот. Нужно еще передавать лейбл.
		 * А он как-то не очень вяжется сюда.
		 * Может создавать клип вне?
		 * */
		public function DLMovieClip(clipObject:*, isLoop:Boolean = true, isCashed:Boolean = false, label:String = null, animSpeed:Number = 1 ) 
		{
			super();

			onAnimationComplete = new Signal(); /* Готово !! удалить */
			
			_animSpeed = animSpeed;
			_isLoop = isLoop;
			_isCashed = isCashed;
			
			
			if (isCashed) {
				if (clipObject is Class) {
					_clipName = getQualifiedClassName(clipObject);
				} else {
					if(label)
						_clipName = label;
					else
						throw new Error('Не указано имя клипа');
				}
				
				_clip = new AntActor(); /* !! незабыть почистить*/
				
				var animClip:MovieClip = clipObject is Class ? new clipObject() : clipObject; /* !! незабыть почистить */

				/* Если в кэше нужного нам изображения нет - добавляем на лету */
				if ( !DLGame.antCache.isAnimInCache(_clipName) ) {
					//trace('Добавляем новый ', _clipName );
					var animation:AntAnim = new AntAnim(); /* !! (хмм, походу это нельзя чистить. Т.к. уничтожатся изображения.) незабыть почистить */
					animation.cacheFromClip(animClip);
					DLGame.antCache.addAnim(animation, _clipName); /* Типо глобальный кэш... */
				}
				
				AntActor(_clip).x = animClip.x;
				AntActor(_clip).y = animClip.y;
				AntActor(_clip).smoothing = true;
				AntActor(_clip).addAnimFromCache(_clipName);
				
			} else {
				if(clipObject is Class) {
					_clip = new clipObject() as MovieClip;
				} else if (clipObject is MovieClip){
					_clip = clipObject;
				}
			}
			
			clipObject = null;
			
			addChild(_clip as DisplayObject);

			activate();
			
			bottomClipY = _clip.y + _clip.getBounds(Main.stageLink).height; /* !! нужна ли эта переменная? */
		}
		
		public function activate():void {
			_clip.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			visible = true;
			_currentFrame = 1;
			allChildGotoFrame(_clip, _currentFrame);
		}
		
		public function deactivate():void {
			_clip.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			visible = false;
		}
		
		private function enterFrameHandler(e:Event):void {
			_currentFrame += _animSpeed;
			allChildGotoFrame(_clip, _currentFrame);

			if (_currentFrame >= _clip.totalFrames) {
				if(_isLoop) {
					_currentFrame = 1;
				} else {
					_clip.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				}
				onAnimationComplete.dispatch();
			}
			
		}
		
		protected function allChildGotoFrame(mc:*, frame:int):void /* Функция входит в рекурсию иногда  */
		{
			if (_isCashed) {
				mc.gotoAndStop(frame);
			} else {
				mc.gotoAndStop(frame);
				var tmpClip:Object;
				var n:int = mc.numChildren;

				for (var i:int = 0; i < n; i++)
				{
					tmpClip = mc.getChildAt(i); /* Нужно не забывать уничтожать tmpClip */
					if (tmpClip is MovieClip)
					{
						allChildGotoFrame(tmpClip as MovieClip, frame);
						tmpClip.gotoAndStop(frame);
					}
				}
				tmpClip = null;
			}
		}		
		
		public function get clip():* {
			return _clip;
		}
		public function get currentFrame():* {
			return _currentFrame;
		}
		
		public function set currentFrame(_frame:int):void {
			_currentFrame = _frame;
		}
		
		public function get numFrames():uint {
			return _clip.totalFrames;
		}
		
		/* Надо будет переназвать в дестрой */
		public function destroy():void {

			deactivate(); /* в этом месте удаляется и листенер */
			
			if (_clip is AntActor) {
				AntActor(_clip).free(); /*!! чистится ли при этом битмапы? Ведь там нет вызова dispose у битмапДаты*/
				_clip = null;
			} else if (_clip is MovieClip) {
				_clip = null; /* !! Нужно ли его удалять со стейджа от родителей? Не думаю. Т.к. на экран он нигде не выводится */
			} else {
				throw new Error('Неопознанный обьект в DLMovieClip');
			}
			
			onAnimationComplete.removeAll();
			onAnimationComplete = null;
		}
		
		public static function Circle(_radius:Number, _color:int = 0xFF0000):Sprite {
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(_color);
			sprite.graphics.drawCircle(0, 0, _radius);
			return sprite;			
		}
		
		public static function Quad(_width:Number, _height:Number, _color:int = 0xFF0000):Sprite {
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(_color);
			sprite.graphics.drawRect(0, 0, _width, _height);
			return sprite;
		}
	}

}