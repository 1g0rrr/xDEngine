package xDEngine.starling 
{
	import citrus.core.starling.StarlingCitrusEngine;
	import flash.events.Event;
	import xDEngine.universal.UniModalsManager;
	import xDEngine.universal.UniScreenManager;
	
	/**
	 * ...
	 * @author ...
	 */
	/* Ага, тоесть СтарлингЦитрусЭнжин - наследуется от обычного цитрус энжина и является флешевым спрайтом */
	public class xDStarlingEngine extends StarlingCitrusEngine 
	{
		public var sm:UniScreenManager;
		public var mm:UniModalsManager;
		
		private var _view:*;
		
		public function xDStarlingEngine() 
		{
			super();
		}
		
		override public function handleStarlingReady():void 
		{
			super.handleStarlingReady();
			
			_view = starling.stage;

			sm = new UniScreenManager();
			_view.addChild(sm.view);

			mm = new UniModalsManager();
			_view.addChild(mm.view);
		}
	}
}