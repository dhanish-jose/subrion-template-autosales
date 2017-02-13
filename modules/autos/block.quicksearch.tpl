<div class="sec sec-search{if 'index' != $core.page.name} sec-search--inner{/if}">
	<div class="container">
		<form class="q-search s-counter{if 'index' != $core.page.name} q-search--inner{/if}" action="{$smarty.const.IA_URL}search/cars/">
			<div class="row">
				<div class="col-md-{if 'index' == $core.page.name}6{else}12{/if}">
					<h4>{lang key='qsearch_find_a_perfect_car'}</h4>
					<div class="container-fluid q-search__inputs">
						<div class="row">
							<div class="col-md-4">
								<div class="btn-group btn-group-justified" data-toggle="buttons">
									<label class="btn btn-default">
										<input type="radio" name="condition" value="new" autocomplete="off"> <span class="fa fa-check"></span> {lang key='field_autos_condition+new'}
									</label>
									<label class="btn btn-default active">
										<input type="radio" name="condition" value="used" autocomplete="off" checked> <span class="fa fa-check"></span> {lang key='field_autos_condition+used'}
									</label>
								</div>
							</div>
							<div class="col-md-4">
								<select class="form-control js-car-make" name="mk">
									<option value="">{lang key='make'}</option>
									{foreach $car_blocks_data.search.categories as $item}
										<option value="{$item.id}"{if isset($smarty.get.mk) && $smarty.get.mk == $item.id} selected{/if}>{$item.name|escape:'html'}</option>
									{/foreach}
								</select>
							</div>
							<div class="col-md-4">
								<div class="q-search__loader"><div class="loader"></div></div>
								<select name="md" class="form-control js-car-model" data-spinner=".q-search__loader">
									<option value="">{lang key='model'}</option>
								</select>
							</div>
						</div>
					</div>

					<div class="container-fluid q-search__inputs">
						<div class="row">
							<div class="col-md-4">
								<select class="form-control" name="body">
									<option value="">{lang key='field_autos_body_type'}</option>
									{foreach $car_blocks_data.search.body_types as $key => $value}
										<option value="{$key}"{if isset($smarty.get.body) && $smarty.get.body == $key} selected{/if}>{$value}</option>
									{/foreach}
								</select>
							</div>
							<div class="col-md-4">
								<input class="form-control" type="text" name="price[f]" placeholder="{lang key='as_price_min'}" value="{if isset($smarty.get.price.f)}{$smarty.get.price.f}{/if}">
							</div>
							<div class="col-md-4">
								<input class="form-control" type="text" name="price[t]" placeholder="{lang key='as_price_max'}" value="{if isset($smarty.get.price.t)}{$smarty.get.price.t}{/if}">
							</div>
						</div>
					</div>

					<div class="container-fluid q-search__inputs">
						<div class="row">
							<div class="col-md-8">
								<label class="checkbox-inline c-checkbox">
									<input type="checkbox" name="pictures" value="1" checked>
									<span class="fa fa-square"></span>
									{lang key='with_pictures_only'}
								</label>
								<label class="checkbox-inline c-checkbox">
									<input type="checkbox" name="sold" value="1"> 
									<span class="fa fa-square"></span>
									{lang key='include_sold_listings'}
								</label>
							</div>
							<div class="col-md-4">
								<button class="btn btn-primary btn-block" type="submit">
									<span class="fa fa-search"></span> {lang key='search'}
								</button>
							</div>
						</div>
					</div>

					<p class="q-search__info">{lang key='total_cars_listed'}: <b class="text-success">{$num_autos}</b>. <a href="{$core.packages.autos.url}add/">{lang key='get_listed'}</a></p>
				</div>
				{if 'index' == $core.page.name}
					<div class="col-md-6">
						<h4>{lang key='qsearch_popular_makes'}</h4>
						{ia_blocks block='popular_makes'}
					</div>
				{/if}
			</div>
		</form>
	</div>
</div>
{ia_print_js files='_IA_URL_packages/autos/js/front/search'}

{ia_add_js}
	$(function() {
		var $form = $('form.s-counter'),
		buttonText = $form.find('button').html();

		$form.change(function()
		{
			var $this = $(this);

			$.post(intelli.config.ia_url + 'autos.json', {
				data: $form.serialize(),
				action: 'quicksearch_total'
			}).done(function(response) {
				if (typeof response.count == 'boolean' || typeof response.count == 'undefined')
				{
					var count = 0;
				}
				else
				{
					var count = response.count;
				}

				$this.find('button').html(buttonText + ' (' + count + ')');
			});
		});
	});
{/ia_add_js}