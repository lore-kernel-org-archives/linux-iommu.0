From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 0/6] OMAP IOMMU fixes
Date: Thu,  3 Apr 2014 22:01:32 +0200
Message-ID: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Sakari Ailus <sakari.ailus@iki.fi>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch set fixes miscellaneous issues with the OMAP IOMMU driver, found
when trying to port the OMAP3 ISP away from omap-iovmm to the ARM DMA API. The
biggest issue is fixed by patch 6/6, while the other patches fix smaller
problems that I've noticed when reading the code, without experiencing them at
runtime.

I believe I've addressed all comments received for v1. Suman, could you please
have a quick look at ack the patches you haven't acked yet ? I'll then send a
pull request.

Changes since v1:

- Dropped the "iommu/omap: Use the cache cleaning API" and "iommu/omap: Flush
  the TLB only after updating translation table entries" patches
- Reworked "iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()"
  to just break out of the loop
- Added patches 1/6 to 3/6

Laurent Pinchart (3):
  iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
  iommu/omap: Remove comment about supporting single page mappings only
  iommu/omap: Fix map protection value handling

Suman Anna (3):
  iommu/omap: Correct init value of iotlb_entry valid field
  iommu/omap: Remove omap_iommu_domain_has_cap() function
  iommu/omap: Move to_iommu definition from omap-iopgtable.h

 drivers/iommu/omap-iommu.c     | 31 ++++++++++++-------------------
 drivers/iommu/omap-iopgtable.h |  3 ---
 2 files changed, 12 insertions(+), 22 deletions(-)

-- 
Regards,

Laurent Pinchart

