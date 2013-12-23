package xDEngine.sprite 
{
	import citrus.core.State;
	import citrus.physics.nape.Nape;
	import citrus.physics.nape.NapeDebugArt;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseNapeState extends State 
	{
		protected var _physics:Nape;
		public function get physics():Nape { return _physics; }
		
		public function BaseNapeState() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			_physics = new Nape("nape", {velocityIterations: 10, positionIterations: 10});
			add(_physics);
			_physics.visible = true;			

			_physics.debugView.debugMode(NapeDebugArt.draw_Bodies | NapeDebugArt.draw_CollisionArbiters | NapeDebugArt.draw_Constraints);
		}
		
	}

}