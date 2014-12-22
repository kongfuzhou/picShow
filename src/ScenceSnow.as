package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class ScenceSnow extends Sprite 
	{
		private var speedX:Number;
		private var SpeedY:Number;
		private var render:DisplayObject;
		private var duration:Number;
		private var _timer:Timer;
		private var maxX:Number;
		private var maxY:Number;
		private var autoHide:Boolean;
		/**
		 * 雪
		 * @param	render  雪的显示对象
		 * @param	maxX    最大X
		 * @param	maxY	最大Y
		 * @param	duration 新建时间间隔
		 * @param	speedX	 速度X
		 * @param	SpeedY	 速度Y
		 * @param   autoHide 是否自动消失
		 */
		public function ScenceSnow(render:DisplayObject=null,maxX:Number=100,maxY:Number=100,duration:Number=0,speedX:Number=5,SpeedY:Number=5,autoHide:Boolean=true) 
		{
			super();
			this.autoHide = autoHide;
			this.maxY = maxY;
			this.maxX = maxX;
			this.duration = duration;
			this.duration = duration;
			this.render = render;
			this.SpeedY = SpeedY;
			this.speedX = speedX;
			init();
		}
		
		private function init():void 
		{
			if (this.render) 
			{
				this.addChild(this.render);
			}else
			{
				this.graphics.beginFill(0xffffff);
				this.graphics.drawCircle(0, 0, 5);
				this.graphics.endFill();
			}
			
			if (this.duration>0) 
			{
				_timer = new Timer(this.duration);
				_timer.addEventListener(TimerEvent.TIMER, onTimerRun);
			}
		}
		
		private function onTimerRun(e:TimerEvent):void 
		{
			this.updatePos();
		}
		public function updatePos():void 
		{
			this.x += this.speedX;
			this.y += this.SpeedY;
			if (this.x>=this.maxX || this.maxY>=this.maxY) 
			{
				this.destroy();
			}
		}
		public function destroy():void 
		{
			if (this._timer) 
			{
				this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerRun);
			}
			if (this.parent && this.autoHide) 
			{
				this.parent.removeChild(this);
			}
		}
		
		
		
	}

}