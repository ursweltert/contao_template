<?php if (!defined('TL_ROOT')) die('You can not access this file directly!');

/**
 * TYPOlight webCMS
 * Copyright (C) 2005 Leo Feyer
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation, either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program. If not, please visit the Free
 * Software Foundation website at http://www.gnu.org/licenses/.
 *
 * PHP version 5
 * @copyright  Felix Pfeiffer : Neue Medien 2008 
 * @author     Felix Pfeiffer 
 * @package    ModuleRichttext 
 * @license    LGPL 
 * @filesource
 */


/**
 * Class ModuleRichttext 
 *
 * @copyright  Felix Pfeiffer : Neue Medien 2008 
 * @author     Felix Pfeiffer 
 * @package    Controller
 */
class ModuleRichttext extends Module
{

	/**
	 * Template
	 * @var string
	 */
	protected $strTemplate = 'mod_richtext';

	/**
	 * Redirect to the selected page
	 * @return string
	 */
	public function generate()
	{
		return parent::generate();
	}

	/**
	 * Generate module
	 */
	protected function compile()
	{
		$this->import('String');

		$text = $this->String->encodeEmail($this->richtext);
		$text = str_ireplace(array('<u>', '</u>'), array('<span style="text-decoration:underline;">', '</span>'), $text);
		$text = str_ireplace(array('</p>', '<br /><br />'), array("</p>\n", "<br /><br />\n"), $text);
		
		$this->Template->richtext = $text;
		
		// Add image
		if ($this->richtextAddImage && strlen($this->singleSRC) && is_file(TL_ROOT . '/' . $this->singleSRC))
		{
			$arrItem = array(
				'singleSRC'		=> $this->singleSRC,
				'alt'		    => $this->richtextAlt,
				'imagemargin'   => $this->richtextImagemargin,
				'floating'		=> $this->richtextFloating,
				'caption'		=> $this->richtextCaption,
				'imageUrl'		=> $this->richtextImageUrl,
				'size'			=> $this->richtextSize,
				'fullsize'		=> $this->fullsize
			);
			
			$this->addImageToTemplate($this->Template, $arrItem);
		}
	}
}

?>