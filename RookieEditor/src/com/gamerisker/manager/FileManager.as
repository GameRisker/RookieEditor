package com.gamerisker.manager
{
	import com.gamerisker.core.Define;
	import com.gamerisker.editor.Editor;
	import com.gamerisker.manager.SharedManager;
	
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import spark.components.Alert;

	/**
	 *	本地文件管理 <br>
	 *  主要完成本地文件操作 <br>
	 * @author GameRisker
	 * 
	 */	
	public class FileManager
	{
		private static var FileXML : XML;
		private static var packTemp : Object;
		
		public function FileManager(){}
		
		//======================================打开界面配置文件===========================
		/**
		 *	打开界面配置文件 
		 */
		public static function openViewFile() : void
		{
			var m_XMLFile : File = new File(SharedManager.getInstance().getUiSrcUrl());
			var fileFilter : FileFilter = new FileFilter("界面配置", "*.xml");
			m_XMLFile.addEventListener(FileListEvent.SELECT_MULTIPLE, OnOpenXMLFile);
			m_XMLFile.browseForOpenMultiple("打开界面配置", [fileFilter]);
		}
		
		/**
		 *	开发界面配置文件 
		 * @param event
		 * 
		 */		
		private static function OnOpenXMLFile(event : FileListEvent) : void
		{
			var m_XMLFile : File = event.target as File;
			m_XMLFile.removeEventListener(FileListEvent.SELECT_MULTIPLE, OnOpenXMLFile);
			
			var fileList : Array = event.files;
			var total : int = fileList.length;
			
			var list:Array = [];
			
			var editor : Editor;
			for (var i : int = 0; i < total; ++i)
			{
				var textStream : FileStream = new FileStream();
				textStream.open(fileList[i], FileMode.READ);
				var componentStr : String = textStream.readUTFBytes(textStream.bytesAvailable);
				var componentXML : XML = new XML(componentStr);
				editor = ComponentManager.setComponentByXML(componentXML);
				textStream.close();
			}
			
			Define.Scene_Edit.addChild(editor);
			
		}
		
		//======================================保存界面配置文件===========================
		/**
		 *	保存界面配置文件 
		 * @param eidtor
		 * 
		 */	
		public static function saveXMLFile() : void
		{
			if(Index > Define.editorContainer.numChildren - 1)
				Index = 1;
			
			var editor : Editor = Define.editorContainer.getChildAt(Index++) as Editor;
			
			if(editor)
			{
				var xml : String = editor.toXMLString();
				FileXML = new XML(xml);
				
				var m_XMLFile : File = new File(SharedManager.getInstance().getUiSrcUrl()+"\\"+editor.id+".xml");
				m_XMLFile.addEventListener(Event.SELECT, onSaveXMLFile,false,0,true);
				m_XMLFile.addEventListener(Event.CANCEL , onCancelFile);
				m_XMLFile.browseForSave("保存界面配置 " + String(FileXML.@id));
			}
		}
		
		private static function onCancelFile(event : Event) : void
		{
			if(Index < Define.editorContainer.numChildren)
			{
				saveXMLFile();
			}
			else
			{
				Index = 1;
			}
		}
		
		private static var Index : int = 1;
		private static function onSaveXMLFile(event : Event) : void
		{
			var m_XMLFile : File = event.target as File;
			var saveStream : FileStream = new FileStream;
			saveStream.open(m_XMLFile, FileMode.WRITE);
			
			saveStream.writeUTFBytes(FileXML.toXMLString());
			saveStream.close();
			
			if(Index < Define.editorContainer.numChildren)
			{
				saveXMLFile();
			}
			else
			{
				Index = 1;
			}
		}
		
		//======================================打包界面配置文件 ===========================
		private static var Interval : int;
		
		/**
		 *	打包界面配置文件 
		 */		
		public static function packXMLFile() : void
		{
			var m_XMLFile : File = new File(SharedManager.getInstance().getConfigUrl());
			m_XMLFile.addEventListener(Event.SELECT, OnOpenXMLDirectoryPackage);
			m_XMLFile.browseForDirectory("打开界面配置目录");
		}
		
		private static function OnOpenXMLDirectoryPackage(event : Event) : void
		{
			var m_XMLFile : File = event.target as File;
			m_XMLFile.removeEventListener(Event.SELECT, OnOpenXMLDirectoryPackage);
			
			packTemp = new Object;
			
			GetXMLFileList(m_XMLFile);
			
			Interval = setInterval(OnPackageTimerTick,300);
		}
		
		private static function GetXMLFileList(file : File) : void
		{
			if (file.nativePath.search(Define.RegExp_SVN) < 0 && file.nativePath.search(Define.RegExp_Thumbsdb) < 0)
			{
				var i : uint;
				if (file.isDirectory)
				{
					var fileList : Array = file.getDirectoryListing();
					var fileCount : uint = fileList.length;
					for (i = 0; i < fileCount; ++i)
					{
						GetXMLFileList(fileList[i]);
					}
				}
				else
				{
					var textStream : FileStream = new FileStream();
					textStream.open(file, FileMode.READ);
					var componentStr : String = textStream.readUTFBytes(textStream.bytesAvailable);
					var componentXML : XML = new XML(componentStr);
					var componentName : String = file.nativePath;
					componentName = componentName.replace(Define.RegExp_Path, "");
					componentName = componentName.replace(Define.RegExp_Extend, "");
					
					packTemp[componentName] = componentXML;
				}
			}
		}
		
		private static function OnPackageTimerTick() : void
		{
			clearInterval(Interval);
			
			var m_packageFile : File = new File(SharedManager.getInstance().getConfigUrl());
			m_packageFile.addEventListener(Event.SELECT, OnSavePackageFile);
			m_packageFile.browseForSave("保存界面包");
		}
		
		private static function OnSavePackageFile(event : Event) : void
		{
			var m_packageFile : File = event.target as File;
			m_packageFile.removeEventListener(Event.SELECT, OnSavePackageFile);
			
			var saveStream : FileStream = new FileStream;
			saveStream.open(m_packageFile, FileMode.WRITE);
			
			var binaryData : ByteArray = new ByteArray;
			binaryData.writeObject(packTemp);
			binaryData.compress();
			
			saveStream.writeBytes(binaryData);
			saveStream.close();
			
			Alert.show("打包界面配置成功！", "打包成功", Alert.OK , RookieEditor.getInstante().Editor);
		}
		
		//======================================解压配置文件 ===========================
		
		/**
		 *	 解压配置文件
		 * 
		 */		
		public static function onPrasePacke() : void
		{
			var m_packageFile : File = new File(SharedManager.getInstance().getConfigUrl());
			m_packageFile.addEventListener(Event.SELECT, OnOpenPackageFile);
			m_packageFile.browseForOpen("打开界面包");
		}
		
		private static function OnOpenPackageFile(event : Event) : void
		{
			var m_packageFile : File = event.target as File;
			m_packageFile.removeEventListener(Event.SELECT, OnOpenPackageFile);
			
			var packageStream : FileStream = new FileStream;
			packageStream.open(m_packageFile, FileMode.READ);
			
			var binaryData : ByteArray = new ByteArray;
			packageStream.readBytes(binaryData);
			binaryData.uncompress();
			
			packTemp = binaryData.readObject();
			
			packageStream.close();
			
			var m_directoryFile : File = new File;
			m_directoryFile.addEventListener(Event.SELECT, OnSaveUnPackageFile);
			m_directoryFile.browseForDirectory("请选择解包目录的配置文件");
		}
		
		private static function OnSaveUnPackageFile(event : Event) : void
		{
			var m_directoryFile : File = event.target as File;
			m_directoryFile.removeEventListener(Event.SELECT, OnSaveUnPackageFile);
			
			for(var componentXMLName : String in packTemp)
			{
				var xmlFile : File = new File(m_directoryFile.nativePath + "\\" + componentXMLName + ".xml");
				var xmlStream : FileStream = new FileStream;
				xmlStream.open(xmlFile, FileMode.WRITE);
				xmlStream.writeUTFBytes(packTemp[componentXMLName].toXMLString());
				xmlStream.close();
			}
			
			Alert.show("解包界面配置成功！", "解包成功", Alert.OK ,RookieEditor.getInstante().Editor);
		}
		
		//======================================一键打包配置文件 ===========================
		
		/**
		 *	 一键打包配置文件
		 * 
		 */		
		public static function keyPackXMLFile() : void
		{
			packTemp = new Object;
			
			GetXMLFileList(new File(SharedManager.getInstance().getUiSrcUrl()));
			
			var m_packageFile : File = new File(SharedManager.getInstance().getConfigUrl());
			
			var saveStream : FileStream = new FileStream;
			saveStream.open(m_packageFile, FileMode.WRITE);
			
			var binaryData : ByteArray = new ByteArray;
			binaryData.writeObject(packTemp);
			binaryData.compress();
			
			saveStream.writeBytes(binaryData);
			saveStream.close();
			
			Alert.show("打包界面配置成功！", "打包成功", Alert.OK ,RookieEditor.getInstante().Editor);
		}
	}
}
