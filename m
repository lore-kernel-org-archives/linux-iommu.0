From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] iommu/ipmmu-vmsa: Restrict IOMMU Domain Geometry to 32-bit address space
Date: Thu, 26 Jan 2017 10:53:11 +0100
Message-ID: <1485424391-29914-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

Currently, the IPMMU/VMSA driver supports 32-bit I/O Virtual Addresses
only, and thus sets io_pgtable_cfg.ias = 32.  However, it doesn't force
a 32-bit IOVA space through the IOMMU Domain Geometry.

Hence if a device (e.g. SYS-DMAC) rightfully configures a 40-bit DMA
mask, it will still be handed out a 40-bit IOVA, outside the 32-bit IOVA
space, leading to out-of-bounds accesses of the PGD when mapping the
IOVA.

Force a 32-bit IOMMU Domain Geometry to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should the generic code restrict the geometry based on IAS instead?
---
 drivers/iommu/ipmmu-vmsa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 798578f1676480c6..eb8b3df8733b15fb 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -424,6 +424,8 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	domain->cfg.ias = 32;
 	domain->cfg.oas = 40;
 	domain->cfg.tlb = &ipmmu_gather_ops;
+	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	domain->io_domain.geometry.force_aperture = true;
 	/*
 	 * TODO: Add support for coherent walk through CCI with DVM and remove
 	 * cache handling. For now, delegate it to the io-pgtable code.
-- 
1.9.1
