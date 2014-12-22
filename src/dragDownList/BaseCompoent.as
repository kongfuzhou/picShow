package dragDownList 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class BaseCompoent extends Sprite 
	{
		protected var _styleObj:Object = {btnColor:0xcccccc,btnWidth:100,btnHeight:35,labelColor:"#ffffff" };
		protected var _button:Sprite;
		protected var _textField:TextField;
		private var _label:String;
		
		public function BaseCompoent() 
		{
			super();
			init();
			
		}
		
		protected function init():void 
		{
			
			_textField = new TextField();			
			_textField.mouseEnabled = false;
			this.drawButton();
		}
		protected function drawButton():void 
		{
			if (!this._button) 
			{
				this._button = new Sprite();
				this.addChild(this._button);
				this._button.addEventListener(MouseEvent.CLICK, onClickBtn);				
			}
			this._button.addChild(this._textField);
			this._button.graphics.clear();
			this._button.graphics.beginFill(this._styleObj.btnColor);
			this._button.graphics.drawRoundRect(0, 0, this._styleObj.btnWidth, this._styleObj.btnHeight, 5, 5);
			this.updateTextPos();
		}
		
		protected function onClickBtn(e:MouseEvent):void 
		{
			
		}
		protected function updateTextPos():void 
		{
			this._textField.x = (this._styleObj.btnWidth - this._textField.textWidth) / 2;
			this._textField.y = (this._styleObj.btnHeight - this._textField.textHeight) / 2;
		}
		protected function setLabel():void 
		{			
			this._textField.autoSize = "left";
			this._textField.htmlText = "<font color='"+this._styleObj.titleColor+"+'>"+this._label+"</font>"; 
			this.updateTextPos();
			
		}
		
		public function setStyle(style:String,value:*):void 
		{
			this._styleObj[style] = value;
			if (style=="labelColor") 
			{
				this._textField.htmlText = "<font color='"+this._styleObj.labelColor+"+'>"+this._label+"</font>"; 
			}else
			{
				this.drawButton();
			}
		}
		
		public function get label():String 
		{
			return _label;
		}
		
		public function set label(value:String):void 
		{
			_label = value;
			this.setLabel();
		}
		public function destroy():void 
		{
			if (this.parent) 
			{
				this.parent.removeChild(this);
			}
			if (this._button) 
			{
				this._button.removeEventListener(MouseEvent.CLICK, onClickBtn);
			}
		}
		
	}

}