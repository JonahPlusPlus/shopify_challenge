{ pkgs }: {
	deps = [
        pkgs.ruby_2_7_4
        pkgs.rubyPackages_2_7_4.solargraph
        pkgs.rufo
        pkgs.sqlite
	];
}