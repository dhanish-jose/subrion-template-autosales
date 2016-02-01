{if isset($filters.item)}
	<form class="ia-form ia-form-filters" id="js-item-filters-form" data-item="{$filters.item}" action="{$smarty.const.IA_CLEAR_URL}search/{$filters.item}.json">
		{if $member}
			<div class="ia-form-filters__actions">
				<a href="{$smarty.const.IA_URL}search/my/" class="btn btn-xs btn-success" data-loading-text="{lang key='loading'}" id="js-cmd-open-searches">{lang key='my_searches'}</a>
				<div class="modal fade" id="js-modal-searches" tabindex="-1" role="dialog">
					<div class="modal-dialog" role="document"><div class="modal-content"></div></div>
				</div>
				{if isset($regular)}
					<button type="button" class="btn btn-xs btn-default" id="js-cmd-save-search">{lang key='save_this_search'}</button>
				{/if}
			</div>
		{/if}

		{ia_hooker name='smartyFrontFiltersBeforeFields'}

		{foreach $filters.fields as $field}
			{if !empty($filters.params[$field.name])}
				{$selected = $filters.params[$field.name]}
			{else}
				{$selected = null}
			{/if}
			<div class="form-group">
				<label>{lang key="field_{$field.name}"}</label>
				{switch $field.type}
					{case iaField::CHECKBOX break}
					<div class="radios-list">
						{html_checkboxes assign='checkboxes' name=$field.name options=$field.values separator='</div>' selected=$selected}
						<div class="checkbox">{'<div class="checkbox">'|implode:$checkboxes}
							</div>
					{case iaField::COMBO break}
						<select class="form-control js-interactive" name="{$field.name}[]" multiple>
							{if !empty($field.values)}
								{html_options options=$field.values selected=$selected}
							{/if}
						</select>

					{case iaField::RADIO break}
						<div class="radios-list">
							{if !empty($field.values)}
							{html_radios assign='radios' name=$field.name id=$field.name options=$field.values separator='</div>'}
							<div class="radio">{'<div class="radio">'|implode:$radios}
								{/if}
							</div>
					{case iaField::STORAGE}
					{case iaField::IMAGE}
					{case iaField::PICTURES break}
						<input type="checkbox" name="{$field.name}" value="1"{if $selected} checked{/if}>

					{case iaField::NUMBER break}
						<div class="range-slider">
							<input class="hidden no-js js-range-slider" id="range_{$field.name}" type="text" name=""
								data-type="double" 
								data-force-edges="true" 
								data-min="{$field.range[0]}" 
								data-max="{$field.range[1]}" 
								data-from="{$field.range[0]}" 
								data-to="{$field.range[1]}"
								{if 'release_year' == $field.name}
									data-step="1"
									data-prettify-enabled="false"
								{else}
									data-step="1000"
								{/if}
							>

							<input id="range_{$field.name}_from" type="hidden" name="{$field.name}[f]" maxlength="{$field.length}" {if $selected} value="{$selected.f|escape:'html'}"{/if}>
							<input id="range_{$field.name}_to" type="hidden" name="{$field.name}[t]" maxlength="{$field.length}" {if $selected} value="{$selected.t|escape:'html'}"{/if}>

							{ia_add_js}
$(function()
{
	$('#range_{$field.name}').ionRangeSlider(
	{
		onFinish: function(obj)
		{
			$('#range_{$field.name}_from').val(obj.from).trigger('change');
			$('#range_{$field.name}_to').val(obj.to).trigger('change');
		}
	});
});
							{/ia_add_js}
						</div>
					{case iaField::TEXT}
					{case iaField::TEXTAREA break}
						<input class="form-control" type="text" name="{$field.name}"{if is_string($selected)} value="{$selected|escape:'html'}"{/if}>

					{case iaField::TREE}
						<select class="form-control" name="{$field.name}[]" multiple>
							<option value="">&lt;{lang key='any'}&gt;</option>
							{if !empty($field.values)}
								{html_options options=$field.values selected=$selected}
							{/if}
						</select>
				{/switch}
			</div>
		{/foreach}

		{ia_hooker name='smartyFrontFiltersAfterFields'}
	</form>
	{ia_add_media files='select2, js:intelli/intelli.search, js:frontend/search, js: _IA_TPL_ion.rangeSlider.min'}
{/if}