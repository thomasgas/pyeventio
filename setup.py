from setuptools import setup, find_packages

with open('README.rst') as f:
    long_description = f.read()

setup(
    name='eventio',
    version='0.5.0',
    description='Python read-only implementation of the EventIO file format',
    long_description=long_description,
    url='https://github.com/fact-project/pyeventio',
    author='Dominik Neise, Maximilian Noethe',
    author_email='neised@phys.ethz.ch',
    license='MIT',
    packages=find_packages(),
    package_data={'eventio': ['resources/*']},
    install_requires=[
        'numpy'
    ],
    setup_requires=['pytest-runner'],
    tests_require=['pytest>=3.0.0'],
)
