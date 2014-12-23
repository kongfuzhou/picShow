/**
 * Copyright bradsedito ( http://wonderfl.net/user/bradsedito )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/r3vQ
 */

    
    
    
    
package
{
    import flash.display.Sprite
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.Loader;
    import flash.net.URLRequest
    import flash.system.LoaderContext;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;
    import flash.text.FontType;
    import flash.text.TextFormatAlign;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.utils.ByteArray;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.display.BlendMode;
    import flash.display.PixelSnapping;
    import flash.geom.Rectangle;
    import flash.geom.ColorTransform;
    import flash.filters.BlurFilter;
    import flash.display.GradientType;


    public class TextToSpark extends Sprite 
    {
        private const STAGE_WIDTH:Number = stage.stageWidth;
        private const STAGE_HEIGHT:Number = stage.stageHeight;
        private const STAGE_CENTER_X:Number = stage.stageWidth / 2;
        private const STAGE_CENTER_Y:Number = stage.stageHeight / 2;
        private var _loader:Loader;
        private var _canvas:BitmapData;
        private var bmp:Bitmap;
        private var _particles:Array;
        private var _glow:BitmapData;
        private var _rect:Rectangle;
        private var cTra:ColorTransform;
        private var FocalLength:Number = 200;
        private var bullets:Array = [];
        private var bulletAmount:uint = 400;
        private var particles:Array = [];
        private var textForm:TextField;
        private var inputBtn:TextField;
        private var bmData:BitmapData;
        private var byteArray:ByteArray;
        private var txtPointArray:Array = [];

        private static var threshold:uint = 0x00FFFFFF;
        
        public function TextToSpark()
        {
            init()
        }
        private function init():void
        {
            var i:uint;
            var matrix:Matrix = new Matrix();
            matrix.rotate( Math.PI / 2 );
            var gr:Sprite = new Sprite();
            gr.graphics.beginGradientFill(
                GradientType.LINEAR,
                [ 0x000000, 0x000000 ],
                [ 1, 0 ],
                [ 127, 255 ],
                matrix
            );
            
            gr.graphics.drawRect( 0, 0, STAGE_WIDTH, STAGE_HEIGHT );
            gr.graphics.endFill();
            addChild( gr );

            _particles = [];
            _canvas = new BitmapData (STAGE_WIDTH, STAGE_HEIGHT, true, 0xFFFFFF);
            bmp = new Bitmap (_canvas);
            addChild (bmp);

            _glow = new BitmapData( STAGE_WIDTH/4, STAGE_HEIGHT/4, false, 0x0);
            var bm:Bitmap = addChild( new Bitmap( _glow, PixelSnapping.NEVER, true ) ) as Bitmap;
            bm.scaleX = bm.scaleY = 4;
            bm.blendMode = BlendMode.ADD;

            _rect = new Rectangle(0, 0, STAGE_WIDTH, STAGE_HEIGHT);
            cTra = new ColorTransform( 0.9, 0.9, 0.9, 1.0 );

            TextToBit();
            InputTextForm();

            for ( i = 0; i < bulletAmount; i++ )
            {
                var p:bullet = new bullet();
                bullets.push( p );
                PurposePoint( p );
            }
            addEventListener(Event.ENTER_FRAME, onEventHandler);

            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
            _loader.load( new URLRequest("http://level0.kayac.com/space.jpg"), new LoaderContext(true) );
        }
        
        private function onLoadComplete(e:Event):void {
            addChildAt( _loader.content, 0 ); 
        }
        
        private function InputTextForm():void
        {
            var tf:TextFormat = new TextFormat(); 
            tf.size = 14;
            tf.align = TextFormatAlign.CENTER;

            textForm = new TextField();
            textForm.width = 80;
            textForm.height = 24;
            textForm.x = STAGE_CENTER_X - textForm.width / 2 - 10;
            textForm.y = STAGE_HEIGHT - textForm.height - 10;
            textForm.type = TextFieldType.INPUT;
            textForm.border = true;
            textForm.background = true;
            textForm.textColor = 0x000000;
            textForm.defaultTextFormat = tf;

            addChild( textForm );

            tf.size = 14;
            tf.align = TextFormatAlign.CENTER;

            inputBtn = new TextField();
            inputBtn.width = 40;
            inputBtn.height = 20;
            inputBtn.x = textForm.width/2 + STAGE_CENTER_X;
            inputBtn.y = STAGE_HEIGHT - inputBtn.height - 10;
            inputBtn.type = TextFieldType.DYNAMIC;
            inputBtn.selectable = false;
            inputBtn.border = true;
            inputBtn.background = true;

            inputBtn.textColor = 0x000000;
            inputBtn.defaultTextFormat = tf;
            inputBtn.text = "input";

            addChild( inputBtn );

            var btnArea:Sprite = new Sprite();
            btnArea.graphics.beginFill( 0x0000ff, 0);
            btnArea.graphics.drawRect( inputBtn.x, inputBtn.y, 40, 20 );
            btnArea.graphics.endFill();
            addChild( btnArea )
            btnArea.buttonMode = true;

            btnArea.addEventListener(MouseEvent.MOUSE_DOWN, TextAnalyze )
        }
        
        private function TextAnalyze( event:MouseEvent ):void
        {
            if ( textForm.text == "" ) {
                textForm.text = "[BradSedito]";
            }
            TextToBit( textForm.text );
        }
        private function TextToBit( anlzTxt:String = "[BradSedito]" ):void
        {
            var txt:TextField = new TextField();
            txt.autoSize = "left";
            txt.x = 0;
            txt.y = 0;
            txt.type = TextFieldType.DYNAMIC;
            txt.selectable = false;
            var tf:TextFormat = new TextFormat();

            tf.size = 80;
            tf.align = TextFormatAlign.CENTER;
            txt.textColor = 0xFFFFFF;
            txt.defaultTextFormat = tf;

            txt.text = anlzTxt;
            
            var txtSprite:Sprite = new Sprite();
            txtSprite.addChild(txt);
            var tmpWidth:Number = txtSprite.width;
            setBestWidthHeight(txtSprite, 100, 100);
            
            var tw:uint = txtSprite.width;
            var th:uint = txtSprite.height;
            var size:uint = Math.max(tw, th);
            bmData = new BitmapData( size, size, true, 0x00000000 );
            var matrix:Matrix = new Matrix();
            var dX:Number;
            var dY:Number;
            
            if (tw > th) {
                dX = 0;
                dY = (tw - th) / 2;
            } else {
                dY = 0;
                dX = (th - tw) / 2;
            }
            matrix.scale(txtSprite.width / tmpWidth, txtSprite.width / tmpWidth);
            matrix.translate(dX, dY);
            bmData.draw(txtSprite, matrix);
            

            byteArray = bmData.getPixels( new Rectangle( 0, 0, bmData.width, bmData.height ) );
            byteArray.position = 0;
            txtPointArray = [];
            for (var i:uint = 0; i < size * size; i++) {
                var color:uint = byteArray.readInt();
                if ( color > threshold ) {
                var pos:uint = i;
                var px:Number = ( pos % size );
                var py:Number = Math.floor(pos / size);
                txtPointArray.push( {
                px:px,
                py:py
                } );
                }
            }
        }
        private function createParticle( sx:Number, sy:Number, sz:Number ):void {
            var i:int = 45;
            while (i--) {
                var p:Particle = new Particle();
                p.PositionX = sx;
                p.PositionY = sy;
                p.PositionZ = sz;

                var radius:Number = Math.sqrt(Math.random()) * 0.2;
                var angle:Number = Math.random() * (Math.PI) * 2;
                var angle2:Number = Math.random() * (Math.PI) * 2;
                p.vx = Math.cos(angle) * radius;
                p.vy = Math.sin(angle) * radius;
                p.vz = Math.cos(angle2) * radius;

                _particles.push(p);
            }
        }
        private function PurposePoint( t:* ):void {
            var rnd_point:int = int( Math.random() * txtPointArray.length );

            t.PurposeX = txtPointArray[ rnd_point ].px - 50;
            t.PurposeY = txtPointArray[ rnd_point ].py - 50;
            t.PurposeZ = -156;

            var rnd:Number = ( Math.random() * 2 + 2 ) / 100;
            t.vx = ( t.PurposeX - t.PositionX ) * rnd;
            t.vy = ( t.PurposeY - t.PositionY ) * rnd;
            t.vz = ( t.PurposeZ - t.PositionZ ) * rnd;
        }
        private function WtoS( t ):void {
            if ( t.PositionZ > -FocalLength ) {
                t.scale = FocalLength / (FocalLength + t.PositionZ);
                t.px = STAGE_CENTER_X + t.PositionX * t.scale;
                t.py = STAGE_CENTER_Y + t.PositionY * t.scale;
                t.visible = true;
            } else {
                t.visible = false;
            }
        }
        private function onEventHandler(eventObject:Event):void {
            var variation:Number = 0.04;
            var ctx:Number =  mouseX / 465;
            var cty:Number = mouseY / 465;
            if ( ctx > 0.95 ) {
                ctx = 0.95;
            } else if ( ctx < 0.05 ) {
                ctx = 0.05;
            }
            if ( cty > 0.95 ) {
                cty = 0.95;
            } else if ( cty < 0.05 ) {
                cty = 0.05;
            }
            if ( ctx > cTra.redMultiplier ) {
                cTra.redMultiplier += variation;
            } else {
                cTra.redMultiplier -= variation;
            }
            if ( cty > cTra.blueMultiplier ) {
                cTra.blueMultiplier += variation;
            } else {
                cTra.blueMultiplier -= variation;
            }

            var i:uint = bullets.length;
            while (i--) {
                if ( bullets[ i ].PositionY < bullets[ i ].PurposeY ) {
                createParticle( bullets[ i ].PurposeX, bullets[ i ].PurposeY, bullets[ i ].PurposeZ );
                bullets[ i ].launchPoint();
                PurposePoint( bullets[ i ] );
                } else {
                bullets[ i ].PositionX += bullets[ i ].vx;
                bullets[ i ].PositionY += bullets[ i ].vy;
                bullets[ i ].PositionZ += bullets[ i ].vz;
                }
            }
            _canvas.lock();
            _canvas.applyFilter( _canvas, _rect, new Point(), new BlurFilter( 1.6, 1.6 ) );
            _canvas.colorTransform( _rect, cTra );

            i = _particles.length;
            while (i--) {
                var p:Particle = _particles[ i ];
                p.vy += 0.01;

                p.vx *= 0.9;
                p.vy *= 0.9;
                p.vz *= 0.9;

                p.PositionX += p.vx;
                p.PositionY += p.vy;
                p.PositionZ += p.vz;

                WtoS( p );
                p.x = p.px;
                p.y = p.py;
                _canvas.setPixel32(p.x, p.y, p.c);

                if ( (p.x > STAGE_WIDTH || p.x < 0) || (p.y < 0 || p.y > STAGE_HEIGHT) || Math.abs(p.vx) < .01 || Math.abs(p.vy) < .01 || Math.abs(p.vz) < .01)
                {
                this._particles.splice(i, 1);
                }
            }
            _canvas.unlock();
            _glow.draw(_canvas, new Matrix(0.25, 0, 0, 0.25));
        }
        
        private function setBestWidthHeight(d:DisplayObject, maxWidth:int, maxHeight:int):void {
            d.width = Math.min(d.width, maxWidth);
            d.scaleY = d.scaleX;
            if (d.height > maxHeight) {
                d.height = maxHeight;
                d.scaleX = d.scaleY;
            }
        }
    }
}

//玉無??
import flash.display.Sprite;
class bullet extends Sprite
{
    public var scale:Number;

    public var PositionX:Number;
    public var PositionY:Number;
    public var PositionZ:Number;
    public var PurposeX:Number;
    public var PurposeY:Number;
    public var PurposeZ:Number;

    public var px:Number;
    public var py:Number;
    public var pz:Number;
    public var vx:Number;
    public var vy:Number;
    public var vz:Number;

    public function bullet():void
    {
        launchPoint();
    }
    public function launchPoint():void {
        PositionX = Math.random() * 80 - 40;
        PositionY = 250;
        PositionZ = Math.random() * 80 - 40;
    }
}

class Particle
{
    public var x:Number;
    public var y:Number;
    public var visible:Boolean;
    public var scale:Number;
    public var px:Number;
    public var py:Number;
    public var pz:Number;
    public var vx:Number;
    public var vy:Number;
    public var vz:Number;
    public var c:uint;

    public var PositionX:Number;
    public var PositionY:Number;
    public var PositionZ:Number;

    public function Particle()
    {
        this.x = 0;
        this.y = 0;
        this.vx = 0;
        this.vy = 0;
        this.vz = 0;
        this.c = 0xFFFFFFFF;
    }
}