__version__ = '0.1.0'

import warnings

from . import align, demultiplex, vector, cluster, aggregate, draw

from .main import run

warnings.simplefilter(action='ignore', category=FutureWarning)
