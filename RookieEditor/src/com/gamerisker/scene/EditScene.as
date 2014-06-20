package com.gamerisker.scene
{
	import com.gamerisker.command.Command;
	import com.gamerisker.core.Define;
	import com.gamerisker.editor.Editor;
	import com.gamerisker.event.ComponentEvent;
	import com.gamerisker.manager.ComponentManager;
	import com.gamerisker.manager.ControlManager;
	import com.gamerisker.manager.FileManager;
	import com.gamerisker.manager.KeyboardManager;
	import com.gamerisker.manager.MouseManager;
	import com.gamerisker.manager.MultipleManager;
	import com.gamerisker.manager.TexturesManager;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import spark.components.Alert;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	
	public class EditScene
	{
		public function EditScene(){}
		
		public function Init(stg : Stage=null) : void
		{
			Define.starlingStg = stg;
			Define.editorContainer = new starling.display.Sprite;
			Define.editorContainer.name = "editorContainer";
			Define.editorContainer.x = 0;
			Define.editorContainer.y = 0;
			
			Define.starlingStg.addChild(Define.editorContainer);

			setStageSize(stg.stageWidth , stg.stageHeight);
			
//			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownQ ,KeyboardManager.Q);			//选择单击的组件
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownZ , KeyboardManager.Z , true);	//撤销
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownY , KeyboardManager.Y , true);	//撤销
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownDel ,KeyboardManager.Del);		//删除选中的组件
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownC , KeyboardManager.C , true);	//复制组件对象
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownV , KeyboardManager.V , true);	//粘贴组件对象
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownX , KeyboardManager.X , true);	//剪切组件对象
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownSave , KeyboardManager.S , true);	//保存组件对象为XML
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownO , KeyboardManager.O , true);	//打开XML文件
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownEsc , KeyboardManager.Esc);		//取消绑定在鼠标上的组件图标
			
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownA , KeyboardManager.A);			//设置组件向左移动
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownD , KeyboardManager.D);			//设置组件向右移动
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownW , KeyboardManager.W);			//设置组件向上移动
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownS , KeyboardManager.S);			//设置组件向下移动
			
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownUP , KeyboardManager.UP);			//批量设置组件向左移动
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownDOWN , KeyboardManager.DOWN);		//批量设置组件向右移动
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownLEFT , KeyboardManager.LEFT);		//批量设置组件向上移动
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownRIGHT , KeyboardManager.RIGHT);	//批量设置组件向下移动
			
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownF , KeyboardManager.F,true);		//打包目录下的所有XML文件
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownR , KeyboardManager.R,true);		//解析.cfg文件
			
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownSwapUp , KeyboardManager.UP , true);
			KeyboardManager.AddKeyEvent(KeyboardEvent.KEY_DOWN , OnKeyDownSwapDown , KeyboardManager.DOWN , true);
		}
		
		public function setStageSize(w : int,h : int) : void
		{
			var image : Image = Define.editorContainer.getChildByName("editorback") as Image;
			
			if(!image)
			{
				var _class : Class = TexturesManager.editorback as Class;
				var texture : Texture = Texture.fromBitmap(new _class);
				image = new Image(texture);
				image.x = 0;
				image.y = 0;
				image.alpha = 0;
				image.name = "editorback";
				addChild(image);
				
				RookieEditor.getInstante().Operate.addCommand(new Command(Command.NewName));//记录命令
				
				MouseManager.AddTouch(TouchPhase.ENDED , image , OnEditorClick);
			}

			image.width = w;
			image.height = h;
			
			RookieEditor.getInstante().setResizeStage(w,h);
		}
		
		/**
		 *	鼠标点击编辑区域 
		 * @param event
		 * 
		 */		
		public  function OnEditorClick(event : starling.events.TouchEvent , touch : Touch , child : starling.display.DisplayObject) : void
		{
			var posX : int;
			var posY : int;
			var editor : Editor = ComponentManager.getComponentByClass(MouseManager.GetName());
			
			if(editor)
			{
				editor.create();
				MouseManager.AddTouch(TouchPhase.BEGAN , editor , OnTouchDownClick);
				MouseManager.AddTouch(TouchPhase.HOVER , editor , OnTouchMoveComponent);
				MouseManager.RemoveBand();
				
				posX = touch.globalX;
				posY = touch.globalY;
				
				editor.addEventListener(ComponentEvent.CREATION_COMPLETE , create);
					
				function create(event:*):void
				{
					editor.x = posX - (editor.width >> 1);
					editor.y = posY - (editor.height >> 1);
					ControlManager.target = addChild(editor) as Editor;
					
					RookieEditor.getInstante().Operate.addCommand(new Command(Command.AddName));//记录命令
					
					editor.removeEventListener(ComponentEvent.CREATION_COMPLETE , create)
				}
			}
			else
			{
				if(touch.tapCount == 2)//双击
				{
					FileManager.openViewFile();
				}
			}
		}
		
		/**
		 *	点击了组件对象触发 ,记录当前点击的组件
		 * @param event
		 * @param touch
		 * @param child
		 * 
		 */		
		public  function OnTouchDownClick(event : starling.events.TouchEvent , touch : Touch , child : Editor) : void
		{
			var disobj : flash.display.DisplayObject = MouseManager.GetBand() as flash.display.DisplayObject;

			var container : Editor;
			var point : Point;
			var newEditor : Editor;
			var name : String = MouseManager.GetName();
			if(disobj!=null && ControlManager.GetCurrentHight() != null)
			{
				newEditor = ComponentManager.getComponentByClass(name);
				container = ControlManager.GetCurrentHight();
				point = container.globalToLocal(new Point(touch.globalX,touch.globalY));
				
				newEditor.create();
				newEditor.addEventListener(ComponentEvent.CREATION_COMPLETE , create)
				
				function create(event:*):void
				{
					newEditor.x = point.x - (newEditor.width >> 1);
					newEditor.y = point.y - (newEditor.height >> 1);
					container.addEditor(newEditor);
					ControlManager.target = newEditor;
					
					RookieEditor.getInstante().Operate.addCommand(new Command(Command.AddName));
					RookieEditor.getInstante().Tree.update();
					RookieEditor.getInstante().Code.update();
					
					newEditor.removeEventListener(ComponentEvent.CREATION_COMPLETE , create)
				}
				
				if(newEditor)
				{
					MouseManager.AddTouch(TouchPhase.BEGAN , newEditor , OnTouchDownClick);
					MouseManager.AddTouch(TouchPhase.HOVER , newEditor , OnTouchMoveComponent);
					
					MouseManager.RemoveBand();
					ControlManager.RemoveHighLight();
				}
			}
			else
			{
				if(event.ctrlKey)	//多选
				{
					MultipleManager.target = child;
					ControlManager.target = null;
				}
				else				//单选
				{
					MultipleManager.clear = child;
					ControlManager.target = child;
					MultipleManager.RemoveAll();
				}
				
			}
		}
		
		/**
		 *	鼠标滑入组件触发，给划入的组件一个标示 
		 * @param event
		 * @param touch
		 * @param child
		 * 
		 */
		public  function OnTouchMoveComponent(event : starling.events.TouchEvent , touch : Touch , child : Editor) : void
		{
			if(MouseManager.GetName()!=null)
			{
				ControlManager.AddHighLight(child);
			}
		}
		
		/**
		 *	取消选中的组件鼠标跟随绑定 
		 * @param event
		 * 
		 */		
		private  function OnKeyDownEsc(event : starling.events.KeyboardEvent) : void
		{
			if(MouseManager.GetBand() != null)
			{
				MouseManager.RemoveBand();
			}
			
			ControlManager.target = null;
		}
		
		
		/**
		 *	清空编辑区所有组件 
		 * 
		 */		
		public function Clear() : void
		{
			var container : starling.display.Sprite = Define.editorContainer;
			var child : Editor;
			var index : int = container.numChildren - 1;
			while(index > 0)
			{
				child = container.getChildAt(index) as Editor;
				if(child)
				{
					Define.editorContainer.removeChild(child);
					MouseManager.RemoveTouch(TouchPhase.BEGAN , child);
					MouseManager.RemoveTouch(TouchPhase.HOVER , child);
				}
				index--;
			}
			
			RookieEditor.getInstante().Operate.addCommand(new Command(Command.ClearName) , true);//记录命令
		}
		
		/**
		 *	按下Z 
		 * @param event
		 * 
		 */		
		private function OnKeyDownZ(event : starling.events.KeyboardEvent) : void
		{
			RookieEditor.getInstante().Operate.onDownKeyZ();
		}
		
		/**
		 *	按下Y 
		 * @param event
		 * 
		 */	
		private function OnKeyDownY(event : starling.events.KeyboardEvent) : void
		{
			RookieEditor.getInstante().Operate.onDownKeyY();
		}
		
		/**
		 *	键盘按下del键触发 
		 * @param event
		 * 
		 */		
		private function OnKeyDownDel(event : starling.events.KeyboardEvent) : void
		{
			var CurrentEditor : Editor =  ControlManager.getCurrentComponent();
			var editorContainer : Sprite = Define.editorContainer; 
			
			if(ControlManager.getCurrentComponent()!=null)//Del 键
			{
				MouseManager.RemoveTouch(TouchPhase.BEGAN , CurrentEditor);
				MouseManager.RemoveTouch(TouchPhase.HOVER , CurrentEditor);
				
				StarlingRemove(CurrentEditor);
				ControlManager.target = null;
				RookieEditor.getInstante().Tree.update();
				RookieEditor.getInstante().Code.update();
				RookieEditor.getInstante().Operate.addCommand(new Command(Command.DelName) , true);//记录命令
			}
			
			function StarlingRemove(child : Editor) : void{
				
				if(child==null)return;
				var component : Editor;
				if(child.parent == editorContainer)
				{
					editorContainer.removeChild(child);
				}
				else if(child.parent as Editor)
				{
					component = child.parent as Editor;
					component.removeEditor(CurrentEditor);
				}
								
				CurrentEditor.destroy();
				CurrentEditor = null;
			}
		}
		
		/**
		 *	批量操作 
		 * @param event
		 * 
		 */		
		private function OnKeyDownUP(event : starling.events.KeyboardEvent) : void
		{
			MultipleManager.SetUp();
		};
		
		private function OnKeyDownDOWN(event : starling.events.KeyboardEvent) : void
		{
			MultipleManager.SetDown();
		};
		
		private function OnKeyDownLEFT(event : starling.events.KeyboardEvent) : void
		{
			MultipleManager.SetLeft();
		};
		
		private function OnKeyDownRIGHT(event : starling.events.KeyboardEvent) : void
		{
			MultipleManager.SetRight();
		};
		
		
		private  function OnKeyDownA(event : starling.events.KeyboardEvent) : void
		{
			ControlManager.move(Define.MOVE_LEFE);
		}
		
		private  function OnKeyDownD(event : starling.events.KeyboardEvent) : void
		{
			ControlManager.move(Define.MOVE_RIGHT);
		}
		
		private  function OnKeyDownW(event : starling.events.KeyboardEvent) : void
		{
			ControlManager.move(Define.MOVE_UP);
		}
		
		private  function OnKeyDownS(event : starling.events.KeyboardEvent) : void
		{
			ControlManager.move(Define.MOVE_DOWN);
		}
		
		private function OnKeyDownSwapUp(event : starling.events.KeyboardEvent) : void
		{
			SwapEditorChildren("UP");
			RookieEditor.getInstante().Tree.update();
			RookieEditor.getInstante().Code.update();
			RookieEditor.getInstante().Operate.addCommand(new Command(Command.SwapName));//记录命令
		}
		
		private function OnKeyDownSwapDown(event : starling.events.KeyboardEvent) : void
		{
			SwapEditorChildren("DOWN");
			RookieEditor.getInstante().Tree.update();
			RookieEditor.getInstante().Code.update();
			RookieEditor.getInstante().Operate.addCommand(new Command(Command.SwapName));//记录命令
		}
		
		private function SwapEditorChildren(dis : String) : void
		{
			var component : Editor = ControlManager.getCurrentComponent();
			
			if(component==null)
			{
				Alert.show("修改层错误.","错误",Alert.OK,RookieEditor.getInstante().Editor);
				return;
			}
			var swapTarget : Editor;
			
			var parent : DisplayObjectContainer = component.parent;
			
			var curIndex : int = parent.getChildIndex(component);
			
			var tarIndex : int;
			
			switch(dis)
			{
				case "UP" :
					tarIndex = ++curIndex;
					break
				case "DOWN" :
					tarIndex = --curIndex;
					break
			}
			
			
			if(tarIndex < parent.numChildren)
			{
				swapTarget = parent.getChildAt(tarIndex) as Editor;
				
				if(component!=null && swapTarget != null)
				{
					parent.swapChildren(component,swapTarget);
				}
				
			}
		}
		/**
		 *	解压.cfg格式文件为xml 
		 * @param event
		 * 
		 */		
		private  function OnKeyDownR(event : starling.events.KeyboardEvent) : void
		{
			FileManager.onPrasePacke()
		}
		
		/**
		 *	打包文件夹 
		 * @param event
		 * 
		 */		
		private  function OnKeyDownF(event : starling.events.KeyboardEvent) : void
		{
			FileManager.packXMLFile()
		}
		
		/**
		 *	打开XML文件 
		 * @param event
		 * 
		 */		
		private  function OnKeyDownO(event : starling.events.KeyboardEvent) : void
		{
			FileManager.openViewFile();
		}
		
		/**
		 *	保存 
		 * @param event
		 * 
		 */
		private  function OnKeyDownSave(event : starling.events.KeyboardEvent) : void
		{
			if(ControlManager.getCurrentComponent() != null)
			{
				FileManager.saveXMLFile();
			}
			else
			{
				Alert.show("没有控制组件","错误",4,RookieEditor.getInstante().Editor);
			}
		}
		
		/**
		 *	键盘按下C触发 
		 * @param event
		 * 
		 */
		private  function OnKeyDownC(event : starling.events.KeyboardEvent) : void
		{
			var editor : Editor = ControlManager.getCurrentComponent();
			Define.copyEditor = editor.toCopy();
			ControlManager.target = null;
		}
		
		/**
		 *	键盘按下X触发 
		 * @param event
		 * 
		 */		
		private  function OnKeyDownX(event : starling.events.KeyboardEvent) : void
		{
			Define.copyEditor = ControlManager.getCurrentComponent();
			Define.editorContainer.removeChild(Define.copyEditor);
			ControlManager.target = null;
		}
		
		
		/**
		 *	键盘按下V触发 
		 * @param event
		 * 
		 */		
		private  function OnKeyDownV(event : starling.events.KeyboardEvent) : void
		{
			var editor : Editor = ControlManager.getCurrentComponent();
			if(Define.copyEditor)
			{
				if(editor)
				{
					editor.addEditor(Define.copyEditor);
				}
				else
				{
					addChild(Define.copyEditor);
				}
				
				if(!MouseManager.hasTouch(TouchPhase.BEGAN , Define.copyEditor))
				{
					MouseManager.AddTouch(TouchPhase.BEGAN , Define.copyEditor , OnTouchDownClick);
				}
				if(!MouseManager.hasTouch(TouchPhase.HOVER , Define.copyEditor))
				{
					MouseManager.AddTouch(TouchPhase.HOVER , Define.copyEditor , OnTouchMoveComponent);
				}
				
				ControlManager.target = Define.copyEditor;
				
				RookieEditor.getInstante().Tree.update();
				RookieEditor.getInstante().Code.update();
				RookieEditor.getInstante().Operate.addCommand(new Command(Command.AddName));//记录命令
				Define.copyEditor = null;
			}
		}
		
		public function addChild(child : starling.display.DisplayObject) : starling.display.DisplayObject
		{
			Define.editorContainer.addChild(child);
			
			RookieEditor.getInstante().Tree.update();
			RookieEditor.getInstante().Code.update();
			
			return child;
		}
		
		public function removeChild(child : starling.display.DisplayObject) : starling.display.DisplayObject
		{
			Define.editorContainer.removeChild(child);
			
			RookieEditor.getInstante().Tree.update();
			RookieEditor.getInstante().Code.update();
			RookieEditor.getInstante().Operate.addCommand(new Command(Command.DelName));//记录命令
			return child;
		}		
	}
}