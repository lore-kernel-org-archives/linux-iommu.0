From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova, iommu_dma_apply_resv_region to the dma-iommu api
Date: Thu, 11 Apr 2019 19:47:32 +0100
Message-ID: <20190411184741.27540-4-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchi
List-Id: iommu@lists.linux-foundation.org

To convert the AMD iommu driver to the dma-iommu we need to wrap some of
the iova reserve functions.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cc5da30d6e58..613d181e78a9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -162,6 +162,33 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+static struct iova *iommu_dma_reserve_iova(struct iommu_domain *domain,
+		dma_addr_t iova_lo, dma_addr_t iova_hi)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	unsigned long order = __ffs(domain->pgsize_bitmap);
+
+	return reserve_iova(iovad, iova_lo >> order, iova_hi >> order);
+}
+
+void iommu_dma_copy_reserved_iova(struct iova_domain *from,
+		struct iommu_domain *to)
+{
+	struct iommu_dma_cookie *cookie = to->iova_cookie;
+	struct iova_domain *to_iovad = &cookie->iovad;
+
+	copy_reserved_iova(from, to_iovad);
+}
+
+void iommu_dma_apply_resv_region(struct device *dev,
+		 struct iommu_domain *domain, struct iommu_resv_region *region)
+{
+	dma_addr_t end = region->start + region->length - 1;
+
+	WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);
+}
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..c527ded5c41c 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -23,6 +23,7 @@
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/iova.h>
 #include <linux/msi.h>
 
 int iommu_dma_init(void);
@@ -57,6 +58,12 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, int prot);
 
+/* These are wrappers around some iova functions */
+void iommu_dma_apply_resv_region(struct device *dev,
+		struct iommu_domain *domain, struct iommu_resv_region *region);
+void iommu_dma_copy_reserved_iova(struct iova_domain *from,
+		struct iommu_domain *to);
+
 /*
  * Arch code with no special attribute handling may use these
  * directly as DMA mapping callbacks for simplicity
-- 
2.17.1
