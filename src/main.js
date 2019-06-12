window.onload = () => {
	const app = Elm.Main.init();


	let timer = 0;
	window.addEventListener('resize', () => {
  	if (timer > 0) {
    	clearTimeout(timer);
  	}

  	timer = setTimeout(() => {
			app.ports.windowResize.send(true);
  	}, 200);
	});
}
