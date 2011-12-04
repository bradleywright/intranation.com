all: clean install

clean:
	rm -rf venv
	rm -rf _build

install:
	virtualenv --no-site-packages venv
	pip install -E venv -r requirements.txt

build:
	run-rstblog build content

serve:
	run-rstblog serve content
