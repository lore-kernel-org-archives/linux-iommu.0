From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 05/09] iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master
Date: Mon, 16 Oct 2017 21:30:07 +0900
Message-ID: <150815700766.32763.4264924157922538405.sendpatchset@little-apple>
References: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

The r8a7795 IPMMU supports 40-bit bus mastering. Both
the coherent DMA mask and the streaming DMA mask are
set to unlock the 40-bit address space for coherent
allocations and streaming operations.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4:
 - None

 Changes since V3:
 - None

 Changes since V2:
 - Updated the code and commit message to use 40 bits instead of 64 bits

 Changes since V1:
 - Updated the commit message

 drivers/iommu/ipmmu-vmsa.c |    1 +
 1 file changed, 1 insertion(+)

--- 0012/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-10-16 20:37:31.480607110 +0900
@@ -996,6 +996,7 @@ static int ipmmu_probe(struct platform_d
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = of_device_get_match_data(&pdev->dev);
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
