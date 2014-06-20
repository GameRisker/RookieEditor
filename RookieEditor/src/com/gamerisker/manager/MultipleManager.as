package com.gamerisker.manager
{
	import com.gamerisker.editor.Editor;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	

	/**
	 *	多选管理器 
	 * @author Administrator
	 * 
	 */	
	public class MultipleManager
	{
		private static var m_listBox : Array
		
		public function MultipleManager()
		{
			
		}
		
		public static function Init() : void
		{
			m_listBox = new Array;
		}
		
		public static function set target(component : Editor) : void
		{
			var bool : Boolean = true;
			
			//如果已经添加控制点
			for(var i:int=0;i<m_listBox.length;i++)
			{
				if(m_listBox[i].Com == component)
				{
					m_listBox[i].clearPoint();
					m_listBox.splice(i,1);
					bool = false;
				}
			}
			
			//如果没有添加控制点
			if(bool)
			{
				m_listBox.push(new ControlBox(component));
			}
		}
		
		public static function set clear(component : Editor) : void
		{
			for(var i:int=0;i<m_listBox.length;i++)
			{
				if(m_listBox[i].Com == component)
				{
					m_listBox[i].clearPoint();
					m_listBox.splice(i,1);
				}
			}
		}
		
		public static function RemoveAll() : void
		{
			for(var i:int=0;i<m_listBox.length;i++)
			{
				(m_listBox[i] as ControlBox).Destroy();
			}
			
			m_listBox.length = 0;
		}
		
		private static function compareFunX(box1 : ControlBox , box2 : ControlBox) : ControlBox
		{
			if(box1.x > box2.x)
				return box1;
			else
				return box2;
		}
		
		public static function SetUp() : void
		{
			var comp : ControlBox;
			
			for(var i:int=0;i<m_listBox.length;i++)
			{
				comp = m_listBox[i];
				if(comp.Com)
				{
					comp.Com.y--;
				}
			}
		}
		
		public static function SetDown() : void
		{
			var comp : ControlBox;
			
			for(var i:int=0;i<m_listBox.length;i++)
			{
				comp = m_listBox[i];
				if(comp.Com)
				{
					comp.Com.y++;
				}
			}
		}
		
		public static function SetLeft() : void
		{
			var comp : ControlBox;
			
			for(var i:int=0;i<m_listBox.length;i++)
			{
				comp = m_listBox[i];
				if(comp.Com)
				{
					comp.Com.x--;
				}
			}
		}
		
		public static function SetRight() : void
		{
			var comp : ControlBox;
			
			for(var i:int=0;i<m_listBox.length;i++)
			{
				comp = m_listBox[i];
				if(comp.Com)
				{
					comp.Com.x++;
				}
			}
		}
		
		/**
		 *	设置X坐标间隔 
		 * @param value
		 * 
		 */		
		public static function SetDistanceW(value : int) : void
		{
			var image : Editor;
			if(m_listBox.length > 0)
			{
				m_listBox.sortOn("x",Array.NUMERIC);
				
				var lastX : int = m_listBox[0].x;
				var lastW : int = m_listBox[0].width;
				
				for(var i:int=1;i<m_listBox.length;i++)
				{
					image = m_listBox[i].Com;
					
					image.x = lastX + lastW + value;
					
					lastW = image.width;
					lastX = image.x;
				}
			}
			
		}
		
		/**
		 *	设置Y坐标间隔 
		 * @param value
		 * 
		 */		
		public static function SetDistanceH(value : int) : void
		{
			var image : Editor;
			if(m_listBox.length > 0)
			{
				m_listBox.sortOn("y",Array.NUMERIC);
				
				var lastY : int = m_listBox[0].y;
				var lastH : int = m_listBox[0].height;
				
				for(var i:int=1;i<m_listBox.length;i++)
				{
					image = m_listBox[i].Com;
					
					image.y = lastY + lastH + value;
					
					lastH = image.height;
					lastY = image.y;
				}
			}
		}
		
		/**
		 *	左对齐 
		 * 
		 */		
		public static function Left() : void
		{
			var image : Editor;
			if(m_listBox.length > 0)
			{
				m_listBox.sortOn("x",Array.NUMERIC);
				
				var lastX : int = m_listBox[0].x;
				
				for(var i:int=1;i<m_listBox.length;i++)
				{
					image = m_listBox[i].Com;
					
					image.x = lastX;
				}
			}
		}
		
		/**
		 *	右对齐 
		 * 
		 */		
		public static function Right() : void
		{
			var image : Editor;
			if(m_listBox.length > 0)
			{
				m_listBox.sortOn("widthx",Array.DESCENDING);
				
				var widthX : int = m_listBox[0].widthx;
				
				for(var i:int=1;i<m_listBox.length;i++)
				{
					image = m_listBox[i].Com;
					
					image.x = widthX - image.width;
				}
			}
		}
		
		/**
		 *	上对齐 
		 * 
		 */		
		public static function Top() : void
		{
			var image : Editor;
			if(m_listBox.length > 0)
			{
				m_listBox.sortOn("y",Array.NUMERIC);
				
				var lastY : int = m_listBox[0].y;
				
				for(var i:int=1;i<m_listBox.length;i++)
				{
					image = m_listBox[i].Com;
					
					image.y = lastY;
				}
			}		
		}
		
		/**
		 *	下对齐 
		 * 
		 */		
		public static function Down() : void
		{
			var image : Editor;
			if(m_listBox.length > 0)
			{
				m_listBox.sortOn("heighty",Array.DESCENDING);
				
				var heightY : int = m_listBox[0].heighty;
				
				for(var i:int=1;i<m_listBox.length;i++)
				{
					image = m_listBox[i].Com;
					
					image.y = heightY - image.height;
				}
			}
		}
				
	}
}


import com.gamerisker.core.Component;
import com.gamerisker.editor.Editor;

import flash.geom.Point;

import starling.display.Image;

class ControlBox
{
	private var leftTopBox : Image;
	private var leftBottomBox : Image;
	private var rightBottomBox : Image;
	private var rightTopBox : Image;
	private var centerBox : Image;
	private var leftCenterBox : Image;
	private var rightCenterBox : Image;
	private var topCenterBox : Image;
	private var bottomCenterBox : Image;
	private var m_com : Editor;
	
	public function ControlBox(comp : Editor) : void
	{
		m_com = comp;
		
		leftTopBox 			= getBox(m_com.id);
		leftBottomBox 		= getBox(m_com.id);
		rightBottomBox 		= getBox(m_com.id);
		rightTopBox  		= getBox(m_com.id);
		centerBox  			= getBox(m_com.id);
		leftCenterBox 		= getBox(m_com.id);
		rightCenterBox 		= getBox(m_com.id);
		topCenterBox 		= getBox(m_com.id);
		bottomCenterBox 	= getBox(m_com.id);
		
		changedPoint(leftTopBox,-leftTopBox.width,-leftTopBox.height);
		changedPoint(leftBottomBox, -leftBottomBox.width,m_com.height);
		changedPoint(rightBottomBox,m_com.width,m_com.height);
		changedPoint(rightTopBox,m_com.width,-rightTopBox.height);
		changedPoint(centerBox,(m_com.width - centerBox.width) / 2,(m_com.height - centerBox.height) / 2);
		changedPoint(leftCenterBox,-leftCenterBox.width,(m_com.height - leftCenterBox.height) / 2);
		changedPoint(rightCenterBox, m_com.width,(m_com.height - rightCenterBox.height) / 2);
		changedPoint(topCenterBox,(m_com.width - topCenterBox.width) / 2,-topCenterBox.height);
		changedPoint(bottomCenterBox,(m_com.width - bottomCenterBox.width) / 2,m_com.height);
		
		function changedPoint(box : Image,px : Number,py : Number) : void{
			
			var point : Point = m_com.localToGlobal(new Point(px,py));
			
			m_com.addChild(box);
			box.x = px;
			box.y = py;
		}
	}
	
	/**
	 *	下边框坐标 
	 * @return 
	 * 
	 */	
	public function get heighty() : int
	{
		return m_com.y + m_com.height;
	}
	
	/**
	 *	右边框坐标 
	 * @return 
	 * 
	 */	
	public function get widthx() : int
	{
		return m_com.x + m_com.width;
	}
	
	public function get height() : int
	{
		return m_com.height;
	}
	
	public function get width() : int
	{
		return m_com.width;
	}
	
	public function get y() : int
	{
		return m_com.y;
	}
	
	public function get x() : int
	{
		return m_com.x;
	}
	
	public function get Com() : Editor
	{
		return m_com;
	}
	
	/**
	 *	获取新	Box 
	 * @return 
	 * 
	 */		
	private function getBox(id : String) : Image
	{
		var box : flash.display.Shape = new flash.display.Shape;
		box.graphics.beginFill(0x000000,1);
		box.graphics.drawRect(0,0,10,10);
		box.graphics.endFill();
		var bitmap : flash.display.Bitmap = new flash.display.Bitmap;
		var bitmapdata : flash.display.BitmapData = new flash.display.BitmapData(6,6);
		bitmapdata.draw(box);
		bitmap.bitmapData = bitmapdata;
		
		var image : Image = starling.display.Image.fromBitmap(bitmap);
		image.name = id;
		
		return image;
	}
	
	public function Destroy() : void
	{
		clearPoint();
		
		leftTopBox.dispose();
		leftBottomBox.dispose();
		rightBottomBox.dispose();
		rightTopBox.dispose();
		centerBox.dispose();
		leftCenterBox.dispose();
		rightCenterBox.dispose();
		topCenterBox.dispose();
		bottomCenterBox.dispose();
	}
	
	/**
	 *	清除组件控制点 
	 * 
	 */		
	public function clearPoint() : void
	{
		m_com.removeChild(leftTopBox);
		m_com.removeChild(leftBottomBox);
		m_com.removeChild(rightBottomBox);
		m_com.removeChild(rightTopBox);
		m_com.removeChild(centerBox);
		m_com.removeChild(leftCenterBox);
		m_com.removeChild(rightCenterBox);
		m_com.removeChild(topCenterBox);
		m_com.removeChild(bottomCenterBox);
		
		m_com = null;
	}
}