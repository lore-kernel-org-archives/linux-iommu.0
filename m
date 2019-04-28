From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH v2] iommu/amd: flush not present cache in iommu_map_page
Date: Mon, 29 Apr 2019 00:47:02 +0100
Message-ID: <20190428234703.13697-1-tmurphy@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..ebd062522cf5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1307,6 +1307,16 @@ static void domain_flush_complete(struct protection_domain *domain)
 	}
 }
 
+/* Flush the not present cache if it exists */
+static void domain_flush_np_cache(struct protection_domain *domain,
+		dma_addr_t iova, size_t size)
+{
+	if (unlikely(amd_iommu_np_cache)) {
+		domain_flush_pages(domain, iova, size);
+		domain_flush_complete(domain);
+	}
+}
+
 
 /*
  * This function flushes the DTEs for all devices in domain
@@ -2435,10 +2445,7 @@ static dma_addr_t __map_single(struct device *dev,
 	}
 	address += offset;
 
-	if (unlikely(amd_iommu_np_cache)) {
-		domain_flush_pages(&dma_dom->domain, address, size);
-		domain_flush_complete(&dma_dom->domain);
-	}
+	domain_flush_np_cache(&dma_dom->domain, address, size);
 
 out:
 	return address;
@@ -2617,6 +2624,8 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		s->dma_length   = s->length;
 	}
 
+	domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+
 	return nelems;
 
 out_unmap:
@@ -3101,6 +3110,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
 	mutex_unlock(&domain->api_lock);
 
+	domain_flush_np_cache(domain, iova, page_size);
+
 	return ret;
 }
 
-- 
2.17.1
