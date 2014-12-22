package  
{
	import com.greensock.easing.Elastic;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class Global 
	{
		public static const MAX_EFFECT:int = 5;
		public function Global() 
		{
			
		}
		public static function centerUI(ui:DisplayObject,containerW:Number,containerH:Number,uiPoint:Point=null,uiW:Number=-1,uiH:Number=-1):void 
		{
			ui.x = (containerW - (uiW==-1?ui.width:uiW)) / 2;
			ui.y = (containerH - (uiW == -1?ui.height:uiH)) / 2;
			if (uiPoint)
			{
				ui.x += uiPoint.x;
				ui.y += uiPoint.y;				
			}
		}
		public static function clearChild(container:DisplayObjectContainer):void 
		{
			while (container.numChildren>0) 
			{
				container.removeChildAt(0);
			}
		}
		
		public static function effect(obj:DisplayObject,type:int,duration:Number=0.3,onUpdate:Function=null,onComplete:Function=null):void 
		{
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			var tmpW:Number;
			switch (type) 
			{
				case 1: //模糊淡出
					obj.alpha = 0;
					TweenMax.to(obj, 0, {blurFilter:{blurX:15, blurY:15}});
					TweenMax.to(obj, duration, {blurFilter:{blurX:0, blurY:0},alpha:1,onUpdate:onUpdate,onComplete:onComplete } );
					break;
				case 2: //中心缩放
					obj.scaleX = obj.scaleY=0;
					TweenMax.to(obj, duration, {transformAroundCenter:{scaleX:1, scaleY:1},onUpdate:onUpdate,onComplete:onComplete});
					break;
				case 3: //中心缩放淡出
					obj.alpha = 0;
					obj.scaleX = obj.scaleY=0;
					TweenMax.to(obj, duration, {transformAroundCenter:{scaleX:1, scaleY:1},alpha:1,onUpdate:onUpdate,onComplete:onComplete});
					break;
				case 4: //平铺
					tmpW = obj.width;
					obj.width = 0;
					TweenMax.to(obj, duration, {width:tmpW,onUpdate:onUpdate,onComplete:onComplete } );
					break;
				case 5: //平铺淡出
					tmpW = obj.width;
					obj.width = 0;
					obj.alpha = 0;
					TweenMax.to(obj, duration, {width:tmpW,alpha:1,onUpdate:onUpdate,onComplete:onComplete } );
					break;
				
				
			}
		}
		
		
		
	}

}