package xDEngine.universal 
{
	import citrus.core.CitrusEngine;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import xDEngine.universal.UniQuad;
	/**
	 * ...
	 * @author ...
	 */
	public class DefaultAnimationBetweenStates extends AAnimationBetweenStates 
	{
		private var _quad:UniQuad;
		private var _tween:TweenLite = null;
		private var _duration:Number = 0.5;
		
		private var _quadWidth:int = 1024;
		private var _quadHeight:int = 768;
		
		public function DefaultAnimationBetweenStates() 
		{
			super();
			_quad = new UniQuad(_quadWidth, _quadHeight, 0x000000);
			addChild(_quad);
		}
		
		override public function initialize():void 
		{
			super.initialize();
			if(_tween != null) {
				_tween.kill();
			}
			_quad.alpha = 0;
		}
		
		override public function play():void 
		{
			super.play();
			showQuad();
		}
		
		private function showQuad():void {
			var vars:TweenLiteVars = new TweenLiteVars();
			vars.prop('alpha', 1);
			vars.onComplete(showQuadCompleteHandler);
			_tween = TweenLite.to(_quad, _duration, vars);
		}
		
		private function showQuadCompleteHandler():void {
			changeScreenSignal.dispatch();
			hideQuad();
		}
		
		private function hideQuad():void {
			var vars:TweenLiteVars = new TweenLiteVars();
			vars.prop('alpha', 0);
			vars.onComplete(hideQuadCompleteHandler);
			_tween = TweenLite.to(_quad, _duration, vars);
		}
		
		private function hideQuadCompleteHandler():void {
			endAnimationSignal.dispatch();
		}
		
	}

}