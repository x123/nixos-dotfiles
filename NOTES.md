# finding the referrers to a derivation 
nix-store --query --referrers /nix/store/xh3r4fdyxkz4l3f7sicmml314zhy60s7-bazel-build-jaxlib-0.4.21.drv

# finding the referrers closure to a derivation
nix-store --query --referrers-closure /nix/store/xh3r4fdyxkz4l3f7sicmml314zhy60s7-bazel-build-jaxlib-0.4.21.drv

# force update flake.lock to local nixpkgs
nix flake update --override-input nixpkgs ~/src/nixpkgs
