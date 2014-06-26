From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 00/10] Add NVIDIA Tegra124 IOMMU support
Date: Thu, 26 Jun 2014 22:49:40 +0200
Message-ID: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
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
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This series adds support for the IOMMU found on Tegra124 SoCs. The SMMU
groups memory clients into SWGROUPs and each SWGROUP can be assigned to
one I/O virtual address space. Translation of virtual addresses can be
enabled per memory client.

Patch 1 adds an IOMMU device registry. The driver in patch 4 will add
the IOMMU device with this registry, which will in turn be used by the
client drivers to attach to the IOMMU device. Note that the API that is
introduced in this patch may not be sufficient in the long term (f.e.
when multiple master interfaces need to be supported).

Patch 2 is v3 of the generic IOMMU device tree binding that has been
discussed previously. Patch 3 defines the device tree binding for the
NVIDIA Tegra124 memory controller (and references the generic IOMMU
binding).

Patch 4 implements a memory controller driver for NVIDIA Tegra124. It
initializes the latency allowance programming to sensible defaults and
registers an IOMMU device. Note that this is still somewhat work in
progress. The page tables aren't properly cleaned up yet and other
features of the memory controller may be useful to implement
subsequently.

Patches 5 through 8 add the device tree node for the memory controller
and enable IOMMU support in the display and SDMMC controllers as
examples.

Patches 9 and 10 add support for IOMMU to the DRM and SDMMC drivers.
SDMMC uses the DMA mapping API, which will make use of ARM's DMA/IOMMU
integration. DRM has special needs (buffers that are mapped can be
scanned out by either display controller) and not a good fit for the
DMA mapping API, so it uses the IOMMU API directly.

This has been tested using both SDMMC and DRM drivers via the IOMMU. For
DRM when an IOMMU is detected it will use shmem as backing store, which
removes the need for CMA. Importing from gk20a via the Nouveau driver
also works, but buffers occasionally have some kind of offset that I
haven't been able to track down yet.

Thierry

Thierry Reding (10):
  iommu: Add IOMMU device registry
  devicetree: Add generic IOMMU device tree bindings
  of: Add NVIDIA Tegra124 memory controller binding
  memory: Add Tegra124 memory controller support
  ARM: tegra: Add memory controller on Tegra124
  ARM: tegra: tegra124: Enable IOMMU for display controllers
  ARM: tegra: tegra124: Enable IOMMU for SDMMC controllers
  ARM: tegra: Select ARM_DMA_USE_IOMMU
  drm/tegra: Add IOMMU support
  mmc: sdhci-tegra: Add IOMMU support

 Documentation/devicetree/bindings/iommu/iommu.txt  |  156 ++
 .../memory-controllers/nvidia,tegra124-mc.txt      |   12 +
 arch/arm/boot/dts/tegra124.dtsi                    |   18 +
 arch/arm/mach-tegra/Kconfig                        |    1 +
 drivers/gpu/drm/tegra/dc.c                         |   21 +
 drivers/gpu/drm/tegra/drm.c                        |   17 +
 drivers/gpu/drm/tegra/drm.h                        |    3 +
 drivers/gpu/drm/tegra/fb.c                         |   16 +-
 drivers/gpu/drm/tegra/gem.c                        |  236 ++-
 drivers/gpu/drm/tegra/gem.h                        |    4 +
 drivers/iommu/iommu.c                              |   93 +
 drivers/memory/Kconfig                             |    9 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/tegra124-mc.c                       | 1945 ++++++++++++++++++++
 drivers/mmc/host/sdhci-tegra.c                     |    8 +
 include/dt-bindings/memory/tegra124-mc.h           |   30 +
 include/linux/iommu.h                              |   27 +
 17 files changed, 2573 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.txt
 create mode 100644 drivers/memory/tegra124-mc.c
 create mode 100644 include/dt-bindings/memory/tegra124-mc.h

-- 
2.0.0
