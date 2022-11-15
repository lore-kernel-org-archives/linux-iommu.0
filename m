Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727C0AD5B
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D55521480;
	Tue, 15 Nov 2022 07:26:56 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ABBE13F587;
	Tue, 15 Nov 2022 07:26:49 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 2/9] iommu/sprd: Update to {map,unmap}_pages
Date: Tue, 15 Nov 2022 15:26:36 +0000
Message-Id: <9026464e8380b92d10d09103e215eb4306a5df7c.1668100209.git.robin.murphy@arm.com>
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
instead. This time we'll get the return values for unmaps correct too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/sprd-iommu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index fadd2c907222..0efd68d3409a 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -273,10 +273,11 @@ static void sprd_iommu_detach_device(struct iommu_domain *domain,
 }
 
 static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			  phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			  int prot, gfp_t gfp, size_t *mapped)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
+	size_t size = pgcount * SPRD_IOMMU_PAGE_SIZE;
 	unsigned long flags;
 	unsigned int i;
 	u32 *pgt_base_iova;
@@ -298,35 +299,37 @@ static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pgt_base_iova = dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT);
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	for (i = 0; i < page_num; i++) {
+	for (i = 0; i < pgcount; i++) {
 		pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
 		pabase += SPRD_IOMMU_PAGE_SIZE;
 	}
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	*mapped = size;
 	return 0;
 }
 
 static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			size_t size, struct iommu_iotlb_gather *iotlb_gather)
+			       size_t pgsize, size_t pgcount,
+			       struct iommu_iotlb_gather *iotlb_gather)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	unsigned long flags;
 	u32 *pgt_base_iova;
-	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
+	size_t size = pgcount * SPRD_IOMMU_PAGE_SIZE;
 	unsigned long start = domain->geometry.aperture_start;
 	unsigned long end = domain->geometry.aperture_end;
 
 	if (iova < start || (iova + size) > (end + 1))
-		return -EINVAL;
+		return 0;
 
 	pgt_base_iova = dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT);
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	memset(pgt_base_iova, 0, page_num * sizeof(u32));
+	memset(pgt_base_iova, 0, pgcount * sizeof(u32));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	return 0;
+	return size;
 }
 
 static void sprd_iommu_sync_map(struct iommu_domain *domain,
@@ -409,13 +412,13 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.probe_device	= sprd_iommu_probe_device,
 	.device_group	= sprd_iommu_device_group,
 	.of_xlate	= sprd_iommu_of_xlate,
-	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
+	.pgsize_bitmap	= SPRD_IOMMU_PAGE_SIZE,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sprd_iommu_attach_device,
 		.detach_dev	= sprd_iommu_detach_device,
-		.map		= sprd_iommu_map,
-		.unmap		= sprd_iommu_unmap,
+		.map_pages	= sprd_iommu_map,
+		.unmap_pages	= sprd_iommu_unmap,
 		.iotlb_sync_map	= sprd_iommu_sync_map,
 		.iotlb_sync	= sprd_iommu_sync,
 		.iova_to_phys	= sprd_iommu_iova_to_phys,
-- 
2.36.1.dirty

