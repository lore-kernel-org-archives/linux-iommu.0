From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 2/6] iommu/dma: add support for non-strict mode
Date: Thu, 12 Jul 2018 14:18:28 +0800
Message-ID: <1531376312-2192-3-git-send-email-thunder.leizhen@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
   capable call domain->ops->flush_iotlb_all to flush TLB.
2. Add a new iommu capability: IOMMU_CAP_NON_STRICT, which used to indicate
   that the iommu domain support non-strict mode.
3. During the iommu domain initialization phase, call capable() to check
   whether it support non-strcit mode. If so, call init_iova_flush_queue
   to register iovad->flush_cb callback.
4. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
   -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
   put off iova freeing.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/dma-iommu.c | 25 +++++++++++++++++++++++++
 include/linux/iommu.h     |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ddcbbdb..9f0c77a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -55,6 +55,7 @@ struct iommu_dma_cookie {
 	};
 	struct list_head		msi_page_list;
 	spinlock_t			msi_lock;
+	struct iommu_domain		*domain_non_strict;
 };
 
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -257,6 +258,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
+static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+
+	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
+	domain = cookie->domain_non_strict;
+
+	domain->ops->flush_iotlb_all(domain);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -272,6 +284,7 @@ static int iova_reserve_iommu_regions(struct device *dev,
 int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev)
 {
+	const struct iommu_ops *ops = domain->ops;
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
@@ -308,6 +321,15 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
+
+	if ((ops->capable && ops->capable(IOMMU_CAP_NON_STRICT)) &&
+	    (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_NON_STRICT)) {
+		BUG_ON(!ops->flush_iotlb_all);
+
+		cookie->domain_non_strict = domain;
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+	}
+
 	if (!dev)
 		return 0;
 
@@ -390,6 +412,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
+	else if (cookie->domain_non_strict)
+		queue_iova(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad), 0);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee..82ed979 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -86,6 +86,12 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
 
+#define IOMMU_STRICT		0
+#define IOMMU_NON_STRICT	1
+#define IOMMU_STRICT_MODE_MASK	1UL
+#define IOMMU_DOMAIN_STRICT_MODE(domain)	\
+		(domain->type != IOMMU_DOMAIN_UNMANAGED)
+
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_ops *ops;
@@ -101,6 +107,7 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_NON_STRICT,		/* IOMMU supports non-strict mode */
 };
 
 /*
-- 
1.8.3
