From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
Date: Fri, 15 Jun 2012 20:55:58 -0500
Message-ID: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.luna@linaro.org>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Introduced hwmod support for OMAP3 (iva, isp) and OMAP4 (ipu, dsp),
along with the corresponding runtime PM and routines to deassert reset
lines, enable/disable clocks and configure sysc registers.

Due to compatibility an ifdef needs to be propagated (previously on
iommu resource info) to hwmod data in OMAP3, so users of iommu and
tidspbridge can avoid issues of two modules managing mmu data/irqs/resets;
this until tidspbridge can be safely migrated to iommu framework.

Although IOMMU hwmod patches were already submitted in the past,
this series adds few more changes, like:
- New reset handling, based on a series that needs to be accepted first.
- Fix for compile break if IOMMU_API is not selected.

Previous work can be found at:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60133.html

Omar Ramirez Luna (6):
  ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
  ARM: OMAP3: hwmod data: add mmu data for iva and isp
  ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
  ARM: OMAP3/4: iommu: migrate to hwmod framework
  ARM: OMAP2+: iommu: add reset handling
  ARM: OMAP3/4: iommu: adapt to runtime pm

 arch/arm/mach-omap2/devices.c              |    2 +-
 arch/arm/mach-omap2/iommu2.c               |   36 ------
 arch/arm/mach-omap2/omap-iommu.c           |  166 ++++++---------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  115 +++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  136 ++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/iommu.h    |   25 ++++-
 arch/arm/plat-omap/include/plat/iommu2.h   |    2 -
 drivers/iommu/omap-iommu.c                 |   68 ++++++-----
 8 files changed, 346 insertions(+), 204 deletions(-)

-- 
1.7.4.1

