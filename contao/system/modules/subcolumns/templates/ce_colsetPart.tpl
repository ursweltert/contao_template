
		</div>
	</div>
	<!-- <?php echo $this->colID ?> Column //-->
	<div class="<?php echo $this->class; ?> <?php echo $this->column; ?>"<?php echo $this->cssID; ?>>
		<div class="<?php echo $this->inside; ?>"<?php if ($this->gap['left'] || $this->gap['right']) : ?> style="<?php if ($this->gap['right']) : ?>padding-right:<?php echo $this->gap['right']; ?>;<?php endif; ?><?php if ($this->gap['left']) : ?>padding-left:<?php echo $this->gap['left']; ?>;<?php endif; ?>"<?php endif; ?>>
		