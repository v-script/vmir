module vmir

import os

pub fn open_or_create_file(path string) &C.FILE {
	if !os.exists(path) {
		mut file := os.create(path) or { panic(err) }
		file.close()
	}
	cfile := os.vfopen(path, 'wb') or { panic(err) }
	return cfile
}

pub fn get_file(path string) ?&C.FILE {
	if !os.exists(path) {
		return error('file does not exist: $path')
	}
	cfile := os.vfopen(path, 'rb') or { panic(err) }
	return cfile
}
