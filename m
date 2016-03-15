From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/04] iommu/ipmmu-vmsa: 32-bit ARM may have CONFIG_IOMMU_DMA=y
Date: Wed, 16 Mar 2016 02:04:41 +0900
Message-ID: <20160315170441.20615.78167.sendpatchset@little-apple>
References: <20160315170431.20615.30333.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160315170431.20615.30333.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Instead of assuming that CONFIG_ARM=y also means CONFIG_IOMMU_DMA=n,
convert the #ifdefs to take CONFIG_IOMMU_DMA into consideration
so 32-bit ARM can make use of CONFIG_IOMMU_DMA=y as well once those
bits are in place.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0007/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-03-15 21:05:40.590513000 +0900
@@ -22,7 +22,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
 #include <asm/pgalloc.h>
 #endif
@@ -40,7 +40,7 @@ struct ipmmu_vmsa_device {
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 	struct dma_iommu_mapping *mapping;
 #endif
 };
@@ -619,7 +619,7 @@ static int ipmmu_find_utlbs(struct ipmmu
 	return 0;
 }
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 static int ipmmu_map_attach(struct device *dev, struct ipmmu_vmsa_device *mmu)
 {
 	int ret;
