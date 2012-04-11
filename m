From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Wed, 11 Apr 2012 14:10:26 +0200
Message-ID: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series adds a basic DRM driver for NVIDIA Tegra 2 processors. It
currently only supports the RGB output and I've successfully tested it
against the fbcon kernel module and the xf86-video-modesetting driver.
The code uses the Tegra's IOMMU/GART to remap non-contiguous memory.
This means that currently video memory is limited to 32 MB, the size of
the GART aperture.

Note that this is very early work-in-progress and there is a lot of room
for improvement and cleanup. You'll also note that there is still a
whole lot of debugging output, most of which is disabled by default.

However I explicitly wanted to post this early to get feedback and to
discuss options on how to get this included in the mainline kernel. I
have been in contact with some people at NVIDIA and they seem to be
willing to work together on a solution that satisfies both their
requirements and those of the community.

Thierry

Thierry Reding (3):
  iommu: tegra/gart: Add device tree support
  drm: fixed: Add dfixed_frac() macro
  drm: Add NVIDIA Tegra support

Vandana Salve (1):
  iommu: tegra/gart: use correct gart_device

 .../devicetree/bindings/gpu/drm/tegra.txt          |   24 +
 arch/arm/boot/dts/tegra20.dtsi                     |    6 +
 arch/arm/mach-tegra/board-dt-tegra20.c             |    4 +
 arch/arm/mach-tegra/tegra2_clocks.c                |    8 +-
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/tegra/Kconfig                      |   10 +
 drivers/gpu/drm/tegra/Makefile                     |    5 +
 drivers/gpu/drm/tegra/tegra_drv.c                  | 2241 ++++++++++++++++++++
 drivers/gpu/drm/tegra/tegra_drv.h                  |  184 ++
 drivers/iommu/tegra-gart.c                         |   12 +-
 include/drm/drm_fixed.h                            |    1 +
 include/drm/tegra_drm.h                            |   44 +
 13 files changed, 2537 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/drm/tegra.txt
 create mode 100644 drivers/gpu/drm/tegra/Kconfig
 create mode 100644 drivers/gpu/drm/tegra/Makefile
 create mode 100644 drivers/gpu/drm/tegra/tegra_drv.c
 create mode 100644 drivers/gpu/drm/tegra/tegra_drv.h
 create mode 100644 include/drm/tegra_drm.h

-- 
1.7.10
