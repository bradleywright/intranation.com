all: clean install

clean:
	rm -rf content/_build

install:
	rm -rf venv
	virtualenv --no-site-packages venv
	pip install -E venv -r requirements.txt
	echo "To use the virtualenv: source ./venv/bin/activate"

build:
	run-rstblog build content

serve:
	run-rstblog serve content

run: clean build serve
