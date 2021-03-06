# run pip install -r dev_requirements.txt before running make test
.PHONY: test upload clean

test: functional_test

functional_test:
	python -m tests.test_pygdbmi

publish: test clean
	python setup.py sdist bdist_wheel --universal
	twine upload dist/*

testpublish: test clean
	python setup.py sdist bdist_wheel --universal
	twine upload dist/* -r pypitest

clean:
	rm -rf dist build *.egg-info
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	make -C ./pygdbmi/docs clean

docs:
	make -C ./pygdbmi/docs
