package
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.flintparticles.common.actions.*;
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.energyEasing.Quadratic;
	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.twoD.actions.*;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.*;
	import org.flintparticles.twoD.renderers.*;
	import org.flintparticles.twoD.zones.*;
	
	[SWF(width=500,height=400,frameRate=30,backgroundColor=0x000000)]
	
	
	/**
	 * flint - fireworks
	 * @author wewell
	 * 
	 */        
	public class Fireworks extends Sprite
	{
		private var input:TextField
		private var emitter:Emitter2D;
		public function Fireworks()
		{
			init();			
		}
		
		private function init():void{				
			
			input = new TextField();
			input.border = true;
			input.width = 60;
			input.height = 20;
			input.maxChars = 6;
			input.htmlText = "hello";
			input.textColor = 0xFFFFFF;
			input.type = TextFieldType.INPUT;
			input.borderColor = 0xFFFFFF;
			//input.background = true;
			//input.backgroundColor = 0x00FF00;
			input.x = 30 + 2;
			//addChild(input);
			/*input.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void{
					if(e.keyCode == 13 && emitter != null){
							emitter.stop();
							emitter.removeEventListener(EmitterEvent.EMITTER_EMPTY, restart);
							var str:String = input.text;
							if(str == null || str == ""){
									str = "I♡U";
							}
							start(str);
					}
			});*/
			
			
			
			
		}
		
		public function start(txt:String = "wewell"):void {
				
			input.htmlText = txt;
			var t:TextField = new TextField();
			var f:TextFormat = new TextFormat();
			f.font = "Tahoma";
			f.size = 80;
			f.color = 0xFFFFFF;                                
			t.text = txt;
			t.setTextFormat(f);
			var w:int = t.textWidth;
			var h:int = t.textHeight;
			t.width = w + 10;
			t.height = h + 10;
			var bitmapData:BitmapData = new BitmapData(t.width,t.height,true,0x00000000);
			bitmapData.draw(t);
			emitter?emitter.stop():"";
			if (!emitter) 
			{
				//创建2D粒子发射器
			　　emitter = new Emitter2D();
			　　//计数器(每一秒中创建5000个粒子)
			　　emitter.counter = new Blast(5000);
			　　//初始化(粒子的初始位置，速度，图片和颜色)
			　　emitter.addInitializer( new ColorInit( 0xFFFF3300,0xFFFFFF00 ) );
			　　emitter.addInitializer( new Lifetime(8) );
			　　emitter.addInitializer( new Position( new DiscZone( new Point( 0, 0 ),5) ) );
			　　emitter.addInitializer( new Velocity( new BitmapDataZone( bitmapData, -bitmapData.width/2, -300 ) ) );
			　　//向发射器中添加动作,让每一帧都更新粒子的位置
			　　emitter.addAction( new Age( Quadratic.easeIn ) );
			　　emitter.addAction( new Fade( 1.0,0 ) );
			　　emitter.addAction( new Move() );
			　　emitter.addAction( new LinearDrag(0.6) );
			　　emitter.addAction( new Accelerate( 0,100) );
			　　emitter.addEventListener(EmitterEvent.EMITTER_EMPTY, restart);
				emitter.addEventListener(EmitterEvent.COUNTER_COMPLETE, onCounterCp);
			}			
		　　//定位粒子在舞台的上方
		　　var renderer:PixelRenderer = new PixelRenderer( new Rectangle( 0, 0, 850,500) );
		　　renderer.addFilter( new BlurFilter( 1.5,1.5,1 ) );
		　　renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.96,0 ] ) );
		　　renderer.addEmitter( emitter );
		　　addChild( renderer );
		　　emitter.x = 500;
		　　emitter.y = 450;			
		　　emitter.start( );
		}
		
		private function onCounterCp(e:EmitterEvent):void 
		{
			trace("onCounterCp 粒子完成!");
		}
		
		public function restart( ev:EmitterEvent ):void
		{
			//emitter.start();
		}
	}
}