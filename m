From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 23/23] iommu/amd: Preallocate dma_ops apertures based on dma_mask
Date: Tue, 22 Dec 2015 23:21:28 +0100
Message-ID: <1450822888-22590-24-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Preallocate between 4 and 8 apertures when a device gets it
dma_mask. With more apertures we reduce the lock contention
of the domain lock significantly.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 60 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index eed355c..6f6502d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1892,6 +1892,23 @@ static void dma_ops_domain_free(struct dma_ops_domain *dom)
 	kfree(dom);
 }
 
+static int dma_ops_domain_alloc_apertures(struct dma_ops_domain *dma_dom,
+					  int max_apertures)
+{
+	int ret, i, apertures;
+
+	apertures = dma_dom->aperture_size >> APERTURE_RANGE_SHIFT;
+	ret       = 0;
+
+	for (i = apertures; i < max_apertures; ++i) {
+		ret = alloc_new_range(dma_dom, false, GFP_KERNEL);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 /*
  * Allocates a new protection domain usable for the dma_ops functions.
  * It also initializes the page table and the address allocator data
@@ -2800,14 +2817,43 @@ static int amd_iommu_dma_supported(struct device *dev, u64 mask)
 	return check_device(dev);
 }
 
+static int set_dma_mask(struct device *dev, u64 mask)
+{
+	struct protection_domain *domain;
+	int max_apertures = 1;
+
+	domain = get_domain(dev);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
+
+	if (mask == DMA_BIT_MASK(64))
+		max_apertures = 8;
+	else if (mask > DMA_BIT_MASK(32))
+		max_apertures = 4;
+
+	/*
+	 * To prevent lock contention it doesn't make sense to allocate more
+	 * apertures than online cpus
+	 */
+	if (max_apertures > num_online_cpus())
+		max_apertures = num_online_cpus();
+
+	if (dma_ops_domain_alloc_apertures(domain->priv, max_apertures))
+		dev_err(dev, "Can't allocate %d iommu apertures\n",
+			max_apertures);
+
+	return 0;
+}
+
 static struct dma_map_ops amd_iommu_dma_ops = {
-	.alloc = alloc_coherent,
-	.free = free_coherent,
-	.map_page = map_page,
-	.unmap_page = unmap_page,
-	.map_sg = map_sg,
-	.unmap_sg = unmap_sg,
-	.dma_supported = amd_iommu_dma_supported,
+	.alloc		= alloc_coherent,
+	.free		= free_coherent,
+	.map_page	= map_page,
+	.unmap_page	= unmap_page,
+	.map_sg		= map_sg,
+	.unmap_sg	= unmap_sg,
+	.dma_supported	= amd_iommu_dma_supported,
+	.set_dma_mask	= set_dma_mask,
 };
 
 int __init amd_iommu_init_api(void)
-- 
1.9.1
