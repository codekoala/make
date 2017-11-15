UPX := $(shell which upx)
upx_version := 3.94

# Compress built binaries.
compress: get-upx
	@$(UPX) ./bin/*

# Fetch a local copy of upx for binary compression (only if it's not already installed)
get-upx:
ifeq ($(UPX),)
        @mkdir -p ./upx/
        @curl -Ls https://github.com/upx/upx/releases/download/v$(upx_version)/upx-$(upx_version)-amd64_linux.tar.xz | tar Jx -C ./upx/ --strip-components 1
        $(eval UPX := ./upx/upx)
endif
        @$(UPX) --version
