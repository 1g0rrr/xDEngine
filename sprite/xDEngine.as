package xD.sprite 
{
	import citrus.core.CitrusEngine;
	import flash.events.Event;
	import xD.universal.UniModalsManager;
	import xD.universal.UniScreenManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class xDEngine extends CitrusEngine 
	{
		public var sm:UniScreenManager;
		public var mm:UniModalsManager;
		
		private var _view:*;
		
		public function xDEngine() 
		{
			super();
		}
		
		override protected function handleAddedToStage(e:Event):void 
		{
			super.handleAddedToStage(e);

			_view = this.stage;
			
			sm = new UniScreenManager();
			_view.addChild(sm.view);
			
			mm = new UniModalsManager();
			_view.addChild(mm.view);
		}
	}
}