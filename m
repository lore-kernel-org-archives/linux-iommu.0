From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 07/11] iommu/ipmmu-vmsa: IPMMU device is 64-bit bus master
Date: Mon, 06 Jun 2016 12:58:31 +0900
Message-ID: <20160606035831.31763.45061.sendpatchset@little-apple>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606035723.31763.66500.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

The r8a7795 IPMMU supports 64-bit bus mastering. Both
the coherent DMA mask and the streaming DMA mask are
set to unlock the 64-bit address space for coherent
allocations and streaming operations.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Updated the commit message

 drivers/iommu/ipmmu-vmsa.c |    1 +
 1 file changed, 1 insertion(+)

--- 0019/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:01:28.730607110 +0900
@@ -1082,6 +1082,7 @@ static int ipmmu_probe(struct platform_d
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = match->data;
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
