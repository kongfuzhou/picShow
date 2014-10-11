package picWall 
{
	import com.greensock.core.Animation;
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class PictureWall extends Sprite 
	{
		private const WIDTH:Number = 120;
		private const HEIGHT:Number = 270;
		private var _container:Sprite;
		private var _length:int;
		private var _stepH:Number=15;
		private var _stepW:Number=10;
		private var _dataProvide:Vector.<PicWallCellInfo>;
		private var _cellList:Array;
		
		public function PictureWall() 
		{
			super();
			init();
		}
		
		private function init():void 
		{
			_container = new Sprite();
			addChild(_container);
			_cellList = [];
			this.addEventListener(MouseEvent.CLICK, mouseClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function get dataProvide():Vector.<PicWallCellInfo> 
		{
			return _dataProvide;
		}
		
		public function set dataProvide(value:Vector.<PicWallCellInfo>):void 
		{
			_dataProvide = value;
			this._length = _dataProvide.length;
			this.renderer();
		}
		/**
		 * 相邻高度差
		 */
		public function get stepH():Number 
		{
			return _stepH;
		}
		
		public function set stepH(value:Number):void 
		{
			_stepH = value;
		}
		
		private function mouseClick(e:MouseEvent):void 
		{
			var cell:PicWallCell = this.getMouseCell(e.target as DisplayObject);
			trace(cell);
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			var cell:PicWallCell = this.getMouseCell(e.target as DisplayObject);
			if (cell)
			{
				cell.filters = [];
				cell.scaleX = cell.scaleY = 1;
			}
		}
		private var pri:int=-1;
		private function onMouseOver(e:MouseEvent):void 
		{
			var cell:PicWallCell = this.getMouseCell(e.target as DisplayObject);
			trace("onMouseOver=",cell)
			if (cell)
			{
				var index:int = this._cellList.indexOf(cell);
				trace("index=",index);
				if (index > -1 && pri!=index)
				{
					/*if (pri > -1 && pri < this._cellList.length)
					{
						var preCell:PicWallCell = this._cellList[pri];
						preCell.filters = [];
						preCell.scaleX = cell.scaleY = 1;
					}	*/				
					pri = index;
					cell.scaleX = cell.scaleY = 1.3;					
					TweenMax.to(cell, 0, {glowFilter:{color:0xffff00, alpha:1, blurX:30, blurY:30, strength:1, quality:2} } );
					this.reLayout(index);
				}
			}
		}
		private function getMouseCell(target:DisplayObject):PicWallCell 
		{
			var cell:PicWallCell;
			if (target is PicWallCell)
			{
				cell = target as PicWallCell;
			}else if (target==this)
			{
				return cell;
			}else
			{
				var parent:DisplayObjectContainer=target.parent;
				while (parent)
				{
					if (parent is PicWallCell)
					{
						cell = parent as PicWallCell;
						break;
					}
					if (parent == this)
					{
						break;
					}
					parent = parent.parent;
				}
			}
			
			return cell;
		}
		private function renderer(midi:int=1):void 
		{
			if (this._dataProvide && this._length>0)
			{
				this.pri = midi;
				this.clear();
				var cell:PicWallCell;
				
				var preX:Number=0;
				var preY:Number=0;
				var preW:Number=0;
				var gapX:Number=15;
				var gapY:Number=15;
				
				var tx:Number;
				var ty:Number;
				
				var tf:TimelineLite = new TimelineLite();
				tf.stop();
				var duration:Number = 0.25;
				var delay:Number = 0.15;
				for (var i:int = 0; i < this._length; i++) 
				{
					cell = new PicWallCell();					
					this._container.addChild(cell);
					cell.info = this._dataProvide[i];
					cell.alpha = 0;
					tx = preX + preW + gapX;
					ty = preY + gapY;
					preX = tx;
					preW = cell.width;
					preY = ty;
					//cell.rotation = 10;
					TweenMax.to(cell, duration, { delay:delay, x:tx, y:ty, alpha:1 } );
					//tf.append();
					_cellList.push(cell);
				}
				tf.play();
			}
		}
		private function reLayout(midi:int):void 
		{
			if (this._cellList.length > 0)
			{
				var cell:PicWallCell;
				
				var th:Number;
				var tw:Number;
				
				var tx:Number;
				var ty:Number;
				
				var preX:Number=0;
				var preY:Number=0;
				var preW:Number=0;
				var gapX:Number=15;
				var gapY:Number = 15;
				
				var duration:Number = 0.25;
				var delay:Number = 0.15;
				
				for (var i:int = 0; i < this._length; i++) 
				{
					cell = this._cellList[i];				
					tx = preX + preW + gapX;
					ty = preY + gapY;
					preX = tx;					
					preY = ty;
					preW = cell.width;
					//cell.rotation = 10;
					TweenMax.to(cell, duration, { delay:delay, x:tx, y:ty} );
				}
			}
		}
		private function clear():void 
		{
			while(this._container.numChildren>0)
			{
				this._container.removeChildAt(0);
			}
			var cell:PicWallCell;
			while (this._cellList.length > 0)
			{
				cell = this._cellList.pop() as PicWallCell;
				if (cell)
				{
					cell.distroy();
				}
			}
		}
		
		
		
	}

}