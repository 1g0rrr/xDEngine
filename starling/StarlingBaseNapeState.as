package xD.starling 
{
	import citrus.core.starling.StarlingState;
	import citrus.physics.nape.Nape;
	import citrus.physics.nape.NapeDebugArt;
	
	/**
	 * ...
	 * @author ...
	 */
	public class StarlingBaseNapeState extends StarlingState 
	{
		protected var _physics:Nape;
		public function get physics():Nape { return _physics; }
		
		public function StarlingBaseNapeState() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			_physics = new Nape("nape", {velocityIterations: 10, positionIterations: 10});
			add(_physics);
			_physics.visible = true;	
			
		}
		
	}

}