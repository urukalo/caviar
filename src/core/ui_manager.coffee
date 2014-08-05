define 'UIManager', ['Caviar'], (Caviar) ->
	ANIMATIONS_EVENTS = 'webkitAnimationEnd oanimationend msAnimationEnd animationend'
	$stage = $('.caviar-stage')

	UIManager =
		createViewElement: (uid, layoutData) ->
			viewId = uid +  '_ci'
			el = "<div id='#{viewId}' class='caviar-ui-controler-instance caviar-next'>#{layoutData}</div>"
			Caviar.contentBox.append(el)
			viewId

		initializeLayout: (view) ->
			UIManager.addTransitionClassToElements view

		destroyDeadViews: () ->
			$('.caviar-dead').remove()

		transitionIn: (callback) -> 
			cb = callback || () ->

			$('.caviar-stage').toggleClass('caviar-transition-in');
			$('.caviar-ui-controler-instance.caviar-next').one ANIMATIONS_EVENTS, (e) -> 
				$this = $(this)
				$currentActive = $('.caviar-ui-controler-instance.caviar-active')
				$currentActive.removeClass('caviar-active').addClass('caviar-backgrounded')
				$this.addClass('caviar-keep').removeClass('caviar-next').addClass('caviar-active').removeClass('caviar-keep')
				$stage.removeClass('caviar-transition-in')

				cb()

			return

		transitionOut: (callback) -> 
			console.log('bootstrap.coffee')
			cb = callback || () -> 


			$('.caviar-backgrounded').toggleClass('caviar-backgrounded caviar-prev');
			$('.caviar-stage').addClass('caviar-transition-out');
			$('.caviar-ui-controler-instance.caviar-prev').one ANIMATIONS_EVENTS,  (e) ->
				$this = $(this)
				$currentActive = $('.caviar-ui-controler-instance.caviar-active')
				$currentActive.removeClass('caviar-active').addClass('caviar-dead')
				$this.addClass('caviar-keep').removeClass('caviar-prev').addClass('caviar-active').removeClass('caviar-keep')
				$stage.removeClass('caviar-transition-out')
				cb()

		transitionNone: (callback) ->
			cb = callback || () -> 
			$('.caviar-ui-controler-instance.caviar-next').toggleClass('caviar-next caviar-active');
			cb()