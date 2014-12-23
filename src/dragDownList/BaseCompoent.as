package dragDownList 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class BaseCompoent extends Sprite 
	{
		protected var _styleObj:Object = {btnColor:0xcccccc,btnWidth:100,btnHeight:35,labelColor:"#ffffff",buttonSkin:null };
		protected var _button:Sprite;
		protected var _textField:TextField;
		private var _label:String;
		protected var btnObj:DisplayObject;
		
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
				this._button.mouseChildren = false;
				
			}
			this._button.graphics.clear();
			if (this._styleObj.buttonSkin) 
			{
				if (this.btnObj) 
				{
					this.btnObj.width=this._styleObj.btnWidth;
					this.btnObj.height=this._styleObj.btnHeight;
				}else
				{
					if (this._styleObj.buttonSkin is DisplayObject) 
					{
						this.btnObj = this._styleObj.buttonSkin as DisplayObject;
						this._button.addChild(this.btnObj);
					}else if(this._styleObj.buttonSkin is Class)
					{
						this.btnObj = new this._styleObj.buttonSkin();
						if (this.btnObj) 
						{
							this._button.addChild(this.btnObj);
						}else
						{
							this._button.graphics.beginFill(this._styleObj.btnColor);
							this._button.graphics.drawRoundRect(0, 0, this._styleObj.btnWidth, this._styleObj.btnHeight, 5, 5);
						}
					}					
					if (this.btnObj) 
					{
						this._styleObj.btnWidth = this.btnObj.width;
						this._styleObj.btnHeight = this.btnObj.height;						
					}
				}
											
				
			}else
			{				
				this._button.graphics.beginFill(this._styleObj.btnColor);
				this._button.graphics.drawRoundRect(0, 0, this._styleObj.btnWidth, this._styleObj.btnHeight, 5, 5);
			}
			if (!this._button.contains(this._textField)) 
			{
				this._button.addChild(this._textField)
			}else
			{
				this._button.setChildIndex(this._textField, this._button.numChildren - 1);
			}
			this.updateTextPos();
		}
		
		protected function onClickBtn(e:MouseEvent):void 
		{
			
		}
		protected function updateTextPos():void 
		{
			this._textField.x = (this._styleObj.btnWidth - this._textField.width) / 2;
			this._textField.y = (this._styleObj.btnHeight - this._textField.height) / 2;
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
			if (style=="buttonSkin") 
			{
				if (value is DisplayObject) 
				{
					this.setStyle("btnWidth", (value as DisplayObject).width);
					this.setStyle("btnHeight", (value as DisplayObject).height);
				}				
			}
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