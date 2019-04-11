From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH 4/9] iommu/dma-iommu: Add iommu_dma_map_page_coherent
Date: Thu, 11 Apr 2019 19:47:33 +0100
Message-ID: <20190411184741.27540-5-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchi
List-Id: iommu@lists.linux-foundation.org

Add iommu_dma_map_page_coherent function to allow mapping pages through
the dma-iommu api using the dev->coherent_dma_mask mask instead of the
dev->dma_mask mask

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 25 ++++++++++++++++++++-----
 include/linux/dma-iommu.h |  3 +++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 613d181e78a9..0128370f8b88 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -663,7 +663,8 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
+		size_t size, int prot, struct iommu_domain *domain,
+		dma_addr_t dma_limit)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	size_t iova_off = 0;
@@ -674,7 +675,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size = iova_align(&cookie->iovad, size + iova_off);
 	}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, size, dma_limit, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
@@ -693,7 +694,19 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
 	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
+}
+
+dma_addr_t iommu_dma_map_page_coherent(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, int prot)
+{
+	dma_addr_t dma_mask = dev->coherent_dma_mask;
+
+	if (!dma_mask)
+		dma_mask = dma_get_mask(dev);
+
+	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
+			iommu_get_dma_domain(dev), dma_mask);
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
@@ -883,7 +896,7 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 {
 	return __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
 }
 
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -910,7 +923,9 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain,
+			dma_get_mask(dev));
+
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index c527ded5c41c..185ff8500841 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -55,6 +55,9 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot);
+dma_addr_t iommu_dma_map_page_coherent(struct device *dev,
+		struct page *page, unsigned long offset,
+		size_t size, int prot);
 int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, int prot);
 
-- 
2.17.1
