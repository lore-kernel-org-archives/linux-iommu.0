From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 00/18] Clean up exposure of arch-internal code
Date: Mon, 27 Jul 2015 13:28:24 +0100
Message-ID: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This series of patches attempts to clean up the use of architecture
internal functions in drivers, and removes some functions from view
in the asm/ headers.  I'm also considering whether we need to add
some linker magic to hide symbols when building the built-in.o files.

This was triggered by 3rd party drivers "going under the covers" of
the DMA API and calling the dmac_*() functions directly, a practice
which I have always refused to allow.  This also breaks module
building (which is the big hint that they're doing something wrong.)

However, it also came to light that various drivers are using
__cpuc_* functions directly, which are non-portable, and is another
instance of "going under the covers" and tinkering with what should
be kept as architecture implementation details.

This series addresses some of these points.  It:

(a) moves dmac_map_area() and dmac_unmap_area() prototypes out of
    asm/cacheflush.h and into arch/arm/mm.
(b) provide a secure_flush() call for the Qualcomm secure monitor
    code.
(c) stop tegra smmu driver(s) from using __cpuc_flush_dcache_area,
    something which necessitates additional complexity to deal with
    the ARM vs ARM64 differences.  It should be using the DMA API.
    However, the Tegra SMMU driver is in really bad shape, and this
    isn't a simple conversion - it requires a lot of additional
    fixes to bring the code up to scratch.

It leaves the Rockchip IOMMU driver for the time being, but that is also
something which needs cleaning up in the same way as the Tegra SMMU
driver.

 arch/arm/include/asm/cacheflush.h |  21 ++-
 arch/arm/include/asm/glue-cache.h |   2 -
 arch/arm/mm/dma-mapping.c         |   1 +
 arch/arm/mm/dma.h                 |  32 ++++
 drivers/firmware/qcom_scm-32.c    |   4 +-
 drivers/iommu/tegra-smmu.c        | 297 ++++++++++++++++++++++++--------------
 drivers/memory/tegra/tegra114.c   |  17 ---
 drivers/memory/tegra/tegra124.c   |  30 ----
 drivers/memory/tegra/tegra30.c    |  17 ---
 include/soc/tegra/mc.h            |   7 -
 10 files changed, 242 insertions(+), 186 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
