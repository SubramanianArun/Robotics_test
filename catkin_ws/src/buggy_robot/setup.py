#!/usr/bin/env python

from distutils.core import setup
from setuptools import find_packages
from catkin_pkg.python_setup import generate_distutils_setup

d = generate_distutils_setup(
    packages=[
      'buggy_robot'],
    package_dir={'': 'src'},
)

setup(**d)