import multiprocessing

workers = max(2, multiprocessing.cpu_count() * 2)
preload_app = True
worker_class = 'sync'
timeout = 300
bind = '0.0.0.0:2700'
loglevel = 'info'
limit_request_field_size = 16 * 1024 * 1024
