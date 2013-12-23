package xD.universal 
{
	import citrus.core.CitrusEngine;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DefaultModal extends AModal 
	{
		private var _tween:TweenLite;
		private var _duration:Number = 0.5;
		
		private var _alphaBG:UniQuad;
		
		public var showTweenCompleteSignal:Signal = new Signal();
		
		public function DefaultModal() 
		{
			super();
			
			_alphaBG = new UniQuad(_ce.stage.stageWidth, _ce.stage.stageHeight, 0x000000);
			_alphaBG.view.alpha = 0.2;
			view.addChild(_alphaBG.view);
			
			view.alpha = 0;
			
			startShowTween();
		}
		
		override public function close():void 
		{
			startHideTween();
		}
		
		
		private function startShowTween():void 
		{
			var vars:TweenLiteVars = new TweenLiteVars();
			vars.prop('alpha', 1);
			vars.onComplete(showCompleteHandler);
			_tween = TweenLite.to(this.view, _duration, vars);
		}
		
		private function showCompleteHandler():void 
		{
			showTweenCompleteSignal.dispatch();
		}
		
		
		private function startHideTween():void 
		{
			var vars:TweenLiteVars = new TweenLiteVars();
			vars.prop('alpha', 0);
			vars.onComplete(hideCompleteHandler);
			_tween = TweenLite.to(this.view, _duration, vars);
		}
		
		private function hideCompleteHandler():void 
		{
			super.close();
		}
		

		override public function destroy():void 
		{
			showTweenCompleteSignal.removeAll();
			super.destroy();
		}
		
	}

}