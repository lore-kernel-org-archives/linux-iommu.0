From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 2/5] iommu/dma: add support for non-strict mode
Date: Wed, 15 Aug 2018 09:28:27 +0800
Message-ID: <1534296510-12888-3-git-send-email-thunder.leizhen@huawei.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
   capable call domain->ops->flush_iotlb_all to flush TLB.
2. During the iommu domain initialization phase, base on domain->non_strict
   field to check whether non-strict mode is supported or not. If so, call
   init_iova_flush_queue to register iovad->flush_cb callback.
3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
   -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
   put off iova freeing, and omit iommu_tlb_sync operation.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c     |  1 +
 include/linux/iommu.h     |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ddcbbdb..f0257e9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -55,6 +55,9 @@ struct iommu_dma_cookie {
 	};
 	struct list_head		msi_page_list;
 	spinlock_t			msi_lock;
+
+	/* Only be assigned in non-strict mode, otherwise it's NULL */
+	struct iommu_domain		*domain;
 };

 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -257,6 +260,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }

+static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+
+	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
+	domain = cookie->domain;
+
+	domain->ops->flush_iotlb_all(domain);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -308,6 +322,14 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}

 	init_iova_domain(iovad, 1UL << order, base_pfn);
+
+	if (domain->non_strict) {
+		BUG_ON(!domain->ops->flush_iotlb_all);
+
+		cookie->domain = domain;
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+	}
+
 	if (!dev)
 		return 0;

@@ -390,6 +412,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
+	else if (cookie->domain)	/* non-strict mode */
+		queue_iova(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad), 0);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -405,7 +430,9 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);

-	WARN_ON(iommu_unmap(domain, dma_addr, size) != size);
+	WARN_ON(iommu_unmap_fast(domain, dma_addr, size) != size);
+	if (!domain->non_strict)
+		iommu_tlb_sync(domain);
 	iommu_dma_free_iova(cookie, dma_addr, size);
 }

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b3756..6255a69 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1263,6 +1263,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,

 	domain->ops  = bus->iommu_ops;
 	domain->type = type;
+	domain->non_strict = false;
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee..4bbcf39 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -88,6 +88,7 @@ struct iommu_domain_geometry {

 struct iommu_domain {
 	unsigned type;
+	bool non_strict;
 	const struct iommu_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
--
1.8.3
