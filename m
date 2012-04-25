From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [RFC v2 0/5] Add NVIDIA Tegra DRM support
Date: Wed, 25 Apr 2012 11:44:57 +0200
Message-ID: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This series adds a basic DRM driver for NVIDIA Tegra 2 processors. It
currently only supports the RGB output and I've successfully tested it
against the fbcon kernel module and the xf86-video-modesetting driver.
The code uses the Tegra's IOMMU/GART to remap non-contiguous memory.
This means that currently video memory is limited to 32 MB, the size of
the GART aperture.

Changes in v2:
- split into several smaller source files
- represent individual devices in DT
- add drivers for individual devices
- EDID probing support via "ddc" property
- EDID support in DT using binary blobs
- basic (non-working) HDMI support
- support for carveout memory in DT

A lot of the above are really just stub implementations. Most notably
HDMI support is pretty much a copy of what NVIDIA has in their
downstream kernels, though I wasn't able to make it work except for the
EDID probing (I probably missed some pieces). Carveout memory also isn't
used right now.

Still this should now be in a state where other people (like Jon and
Terje from NVIDIA) and Lucas can start contributing. This series is
based on next-20120424.

Thierry

Robert Morell (1):
  drm: fixed: Add dfixed_frac

Thierry Reding (4):
  iommu: Include linux/types.h
  tps6586x: Add device tree support
  i2c: Add of_i2c_get_adapter() function
  drm: Add NVIDIA Tegra support

 .../devicetree/bindings/gpu/drm/tegra.txt          |  125 +++
 .../devicetree/bindings/regulator/tps6586x.txt     |   97 ++
 arch/arm/mach-tegra/board-dt-tegra20.c             |   14 +
 arch/arm/mach-tegra/include/mach/iomap.h           |    6 +
 arch/arm/mach-tegra/tegra2_clocks.c                |   19 +-
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/tegra/Kconfig                      |   19 +
 drivers/gpu/drm/tegra/Makefile                     |    7 +
 drivers/gpu/drm/tegra/tegra-dc.c                   |  630 +++++++++++++
 drivers/gpu/drm/tegra/tegra-dc.h                   |  245 +++++
 drivers/gpu/drm/tegra/tegra-drv.c                  |  600 ++++++++++++
 drivers/gpu/drm/tegra/tegra-drv.h                  |  201 ++++
 drivers/gpu/drm/tegra/tegra-dsi.c                  |  145 +++
 drivers/gpu/drm/tegra/tegra-encon.c                |  406 ++++++++
 drivers/gpu/drm/tegra/tegra-fb.c                   |  355 +++++++
 drivers/gpu/drm/tegra/tegra-gem.c                  |  425 +++++++++
 drivers/gpu/drm/tegra/tegra-hdmi.c                 |  994 ++++++++++++++++++++
 drivers/gpu/drm/tegra/tegra-hdmi.h                 |  462 +++++++++
 drivers/gpu/drm/tegra/tegra-host1x.c               |   90 ++
 drivers/gpu/drm/tegra/tegra-rgb.c                  |  148 +++
 drivers/gpu/drm/tegra/tegra-tvo.c                  |  152 +++
 drivers/i2c/i2c-core.c                             |   34 +
 drivers/mfd/tps6586x.c                             |  105 +++
 drivers/regulator/tps6586x-regulator.c             |    1 +
 include/drm/drm_fixed.h                            |    1 +
 include/drm/tegra_drm.h                            |   40 +
 include/linux/iommu.h                              |    1 +
 include/linux/mfd/tps6586x.h                       |    1 +
 include/linux/of_i2c.h                             |    7 +
 30 files changed, 5322 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/drm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/tps6586x.txt
 create mode 100644 drivers/gpu/drm/tegra/Kconfig
 create mode 100644 drivers/gpu/drm/tegra/Makefile
 create mode 100644 drivers/gpu/drm/tegra/tegra-dc.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-dc.h
 create mode 100644 drivers/gpu/drm/tegra/tegra-drv.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-drv.h
 create mode 100644 drivers/gpu/drm/tegra/tegra-dsi.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-encon.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-fb.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-gem.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-hdmi.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-hdmi.h
 create mode 100644 drivers/gpu/drm/tegra/tegra-host1x.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-rgb.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-tvo.c
 create mode 100644 include/drm/tegra_drm.h

-- 
1.7.10
