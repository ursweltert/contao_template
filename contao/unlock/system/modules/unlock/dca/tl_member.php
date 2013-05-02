<?php if (!defined('TL_ROOT')) die('You cannot access this file directly!');

/**
 * Contao Open Source CMS
 * Copyright (C) 2005-2011 Leo Feyer
 *
 * Formerly known as TYPOlight Open Source CMS.
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation, either
 * version 3 of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program. If not, please visit the Free
 * Software Foundation website at <http://www.gnu.org/licenses/>.
 *
 * PHP version 5
 * @copyright  Leo Unglaub 2011
 * @author     Leo Unglaub <leo@leo-unglaub.net>
 * @package    unlock
 * @license    LGPL
 * @filesource
 */


/**
 * Operations
 */
$GLOBALS['TL_DCA']['tl_member']['list']['operations']['unlock'] = array
(
	'label'				=> &$GLOBALS['TL_LANG']['tl_member']['unlock'],
	'href'				=> 'key=unlock',
	'attributes'		=> 'onclick="Backend.getScrollOffset();"',
	'icon'				=> 'system/modules/unlock/html/img/unlock.png',
	'button_callback'	=> array('UnlockMember', 'addUnlockButton')
);


class UnlockMember extends Backend
{
	/**
	 * Display the unlock button if the user is locked
	 * 
	 * @param array $row
	 * @param string $href
	 * @param string $label
	 * @param string $title
	 * @param string $icon
	 * @param array $attributes
	 * @return string
	 */
	public function addUnlockButton($row, $href, $label, $title, $icon, $attributes)
	{
		if ($row['locked'] + $GLOBALS['TL_CONFIG']['lockPeriod'] > time())
		{
			return '<a href="'.$this->addToUrl($href.'&amp;id='.$row['id']).'" title="'.specialchars($title).'"'.$attributes.'>'.$this->generateImage($icon, $label).'</a> ';
		}
	}
}
?>