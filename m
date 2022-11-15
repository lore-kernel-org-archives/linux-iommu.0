Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4FAD5F
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB0E150C;
	Tue, 15 Nov 2022 07:26:57 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2FA23F587;
	Tue, 15 Nov 2022 07:26:50 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 3/9] iommu/mediatek: Update to {map,unmap}_pages
Date: Tue, 15 Nov 2022 15:26:37 +0000
Message-Id: <25b65b71e7e5d1006469aee48bab07ca87227bfa.1668100209.git.robin.murphy@arm.com>
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

Update map/unmap to the new multi-page interfaces, which is dead easy
since we just pass them through to io-pgtable anyway.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/mtk_iommu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2ab2ecfe01f8..e2599ad8272b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -711,7 +711,8 @@ static void mtk_iommu_detach_device(struct iommu_domain *domain,
 }
 
 static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
@@ -720,17 +721,17 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		paddr |= BIT_ULL(32);
 
 	/* Synchronize with the tlb_lock */
-	return dom->iop->map(dom->iop, iova, paddr, size, prot, gfp);
+	return dom->iop->map_pages(dom->iop, iova, paddr, pgsize, pgcount, prot, gfp, mapped);
 }
 
 static size_t mtk_iommu_unmap(struct iommu_domain *domain,
-			      unsigned long iova, size_t size,
+			      unsigned long iova, size_t pgsize, size_t pgcount,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	iommu_iotlb_gather_add_range(gather, iova, size);
-	return dom->iop->unmap(dom->iop, iova, size, gather);
+	iommu_iotlb_gather_add_range(gather, iova, pgsize * pgcount);
+	return dom->iop->unmap_pages(dom->iop, iova, pgsize, pgcount, gather);
 }
 
 static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
@@ -938,8 +939,8 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_attach_device,
 		.detach_dev	= mtk_iommu_detach_device,
-		.map		= mtk_iommu_map,
-		.unmap		= mtk_iommu_unmap,
+		.map_pages	= mtk_iommu_map,
+		.unmap_pages	= mtk_iommu_unmap,
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
 		.iotlb_sync	= mtk_iommu_iotlb_sync,
 		.iotlb_sync_map	= mtk_iommu_sync_map,
-- 
2.36.1.dirty

