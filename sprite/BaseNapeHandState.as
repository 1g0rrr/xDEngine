package xDEngine.sprite 
{
	import citrus.core.State;
	import citrus.physics.nape.Nape;
	import flash.events.MouseEvent;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseNapeHandState extends BaseNapeState 
	{
		public var isUseHand:Boolean = true;
        public var hand:PivotJoint;
		
		private var _touchX:Number;
		private var _touchY:Number;
		
		public function BaseNapeHandState() 
		{
			super();
		}
		
		
		override public function initialize():void 
		{
			super.initialize();
            if (isUseHand) {
                hand = new PivotJoint(_physics.space.world, null, Vec2.weak(), Vec2.weak());
                hand.active = false;
                hand.stiff = false;
                hand.maxForce = 1e5;
                hand.space = _physics.space;
				
				_ce.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				_ce.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				_ce.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            }			
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
            hand.active = false;
		}
		
		private function mouseMoveHandler(e:MouseEvent):void 
		{
			_touchX = mouseX;
			_touchY = mouseY;			
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_touchX = mouseX;
			_touchY = mouseY;
				
			var touchPoint:Vec2 = Vec2.get(_touchX, _touchY);
			if (isUseHand) 
			{
				hand.anchor1.setxy(_touchX, _touchY);
				var bodyList:BodyList = _physics.space.bodiesUnderPoint(touchPoint);
				
				for (var i:uint = 0; i < bodyList.length; i++) 
				{
					var body:Body = bodyList.at(i);
					if (body.isDynamic()) 
					{
						hand.body2 = body;
						hand.anchor2 = body.worldPointToLocal(touchPoint, true);
						hand.active = true;
						break;
					}
				}
				bodyList.clear();
			}
			touchPoint.dispose();				
		}
		
		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
            if (hand != null && hand.active) {
                hand.anchor1.setxy(_touchX, _touchY);
                hand.body2.angularVel *= 0.9;
            }			
		}
		
		override public function destroy():void 
		{
			_ce.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_ce.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			_ce.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			super.destroy();
		}
	}

}