Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F667BA3D
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F7851515;
	Tue, 15 Nov 2022 07:26:59 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA3BA3F587;
	Tue, 15 Nov 2022 07:26:51 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 4/9] iommu/msm: Update to {map,unmap}_pages
Date: Tue, 15 Nov 2022 15:26:38 +0000
Message-Id: <24a8f522710ddd6bbac4da154aa28799e939ebe4.1668100209.git.robin.murphy@arm.com>
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
 drivers/iommu/msm_iommu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 16179a9a7283..c60624910872 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -471,14 +471,16 @@ static void msm_iommu_detach_dev(struct iommu_domain *domain,
 }
 
 static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			 phys_addr_t pa, size_t len, int prot, gfp_t gfp)
+			 phys_addr_t pa, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped)
 {
 	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&priv->pgtlock, flags);
-	ret = priv->iop->map(priv->iop, iova, pa, len, prot, GFP_ATOMIC);
+	ret = priv->iop->map_pages(priv->iop, iova, pa, pgsize, pgcount, prot,
+				   GFP_ATOMIC, mapped);
 	spin_unlock_irqrestore(&priv->pgtlock, flags);
 
 	return ret;
@@ -493,16 +495,18 @@ static void msm_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			      size_t len, struct iommu_iotlb_gather *gather)
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *gather)
 {
 	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
+	size_t ret;
 
 	spin_lock_irqsave(&priv->pgtlock, flags);
-	len = priv->iop->unmap(priv->iop, iova, len, gather);
+	ret = priv->iop->unmap_pages(priv->iop, iova, pgsize, pgcount, gather);
 	spin_unlock_irqrestore(&priv->pgtlock, flags);
 
-	return len;
+	return ret;
 }
 
 static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -679,8 +683,8 @@ static struct iommu_ops msm_iommu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
 		.detach_dev	= msm_iommu_detach_dev,
-		.map		= msm_iommu_map,
-		.unmap		= msm_iommu_unmap,
+		.map_pages	= msm_iommu_map,
+		.unmap_pages	= msm_iommu_unmap,
 		/*
 		 * Nothing is needed here, the barrier to guarantee
 		 * completion of the tlb sync operation is implicitly
-- 
2.36.1.dirty

