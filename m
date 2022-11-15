Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0C1AD5F
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE2581477;
	Tue, 15 Nov 2022 07:26:55 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9524A3F587;
	Tue, 15 Nov 2022 07:26:48 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 1/9] iommu/mediatek-v1: Update to {map,unmap}_pages
Date: Tue, 15 Nov 2022 15:26:35 +0000
Message-Id: <768e90ff0c2d61e4723049c1349d8bac58daa437.1668100209.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1668100209.git.robin.murphy@arm.com>
References: <cover.1668100209.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the core API has a proper notion of multi-page mappings, clean
up the old pgsize_bitmap hack by implementing the new interfaces
instead. This also brings a slight simplification since we no longer
need to worry about rolling back partial mappings on failure.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/mtk_iommu_v1.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6e0e65831eb7..69682ee068d2 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -327,44 +327,42 @@ static void mtk_iommu_v1_detach_device(struct iommu_domain *domain, struct devic
 }
 
 static int mtk_iommu_v1_map(struct iommu_domain *domain, unsigned long iova,
-			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			    int prot, gfp_t gfp, size_t *mapped)
 {
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
-	unsigned int page_num = size >> MT2701_IOMMU_PAGE_SHIFT;
 	unsigned long flags;
 	unsigned int i;
 	u32 *pgt_base_iova = dom->pgt_va + (iova  >> MT2701_IOMMU_PAGE_SHIFT);
 	u32 pabase = (u32)paddr;
-	int map_size = 0;
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	for (i = 0; i < page_num; i++) {
-		if (pgt_base_iova[i]) {
-			memset(pgt_base_iova, 0, i * sizeof(u32));
+	for (i = 0; i < pgcount; i++) {
+		if (pgt_base_iova[i])
 			break;
-		}
 		pgt_base_iova[i] = pabase | F_DESC_VALID | F_DESC_NONSEC;
 		pabase += MT2701_IOMMU_PAGE_SIZE;
-		map_size += MT2701_IOMMU_PAGE_SIZE;
 	}
 
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	mtk_iommu_v1_tlb_flush_range(dom->data, iova, size);
+	*mapped = i * MT2701_IOMMU_PAGE_SIZE;
+	mtk_iommu_v1_tlb_flush_range(dom->data, iova, *mapped);
 
-	return map_size == size ? 0 : -EEXIST;
+	return i == pgcount ? 0 : -EEXIST;
 }
 
 static size_t mtk_iommu_v1_unmap(struct iommu_domain *domain, unsigned long iova,
-				 size_t size, struct iommu_iotlb_gather *gather)
+				 size_t pgsize, size_t pgcount,
+				 struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
 	u32 *pgt_base_iova = dom->pgt_va + (iova  >> MT2701_IOMMU_PAGE_SHIFT);
-	unsigned int page_num = size >> MT2701_IOMMU_PAGE_SHIFT;
+	size_t size = pgcount * MT2701_IOMMU_PAGE_SIZE;
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	memset(pgt_base_iova, 0, page_num * sizeof(u32));
+	memset(pgt_base_iova, 0, pgcount * sizeof(u32));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	mtk_iommu_v1_tlb_flush_range(dom->data, iova, size);
@@ -586,13 +584,13 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.release_device	= mtk_iommu_v1_release_device,
 	.def_domain_type = mtk_iommu_v1_def_domain_type,
 	.device_group	= generic_device_group,
-	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
+	.pgsize_bitmap	= MT2701_IOMMU_PAGE_SIZE,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
 		.detach_dev	= mtk_iommu_v1_detach_device,
-		.map		= mtk_iommu_v1_map,
-		.unmap		= mtk_iommu_v1_unmap,
+		.map_pages	= mtk_iommu_v1_map,
+		.unmap_pages	= mtk_iommu_v1_unmap,
 		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
 		.free		= mtk_iommu_v1_domain_free,
 	}
-- 
2.36.1.dirty

