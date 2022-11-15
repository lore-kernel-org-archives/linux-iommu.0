Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD7BA40
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E51B152B;
	Tue, 15 Nov 2022 07:27:01 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14B203F587;
	Tue, 15 Nov 2022 07:26:53 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 6/9] iommu/qcom: Update to {map,unmap}_pages
Date: Tue, 15 Nov 2022 15:26:40 +0000
Message-Id: <ccff9a133d12ec938741720be6baf5d788b71ea0.1668100209.git.robin.murphy@arm.com>
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
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 3869c3ecda8c..424258138877 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -415,7 +415,8 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 }
 
 static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			  phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			  int prot, gfp_t gfp, size_t *mapped)
 {
 	int ret;
 	unsigned long flags;
@@ -426,13 +427,14 @@ static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		return -ENODEV;
 
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
-	ret = ops->map(ops, iova, paddr, size, prot, GFP_ATOMIC);
+	ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, GFP_ATOMIC, mapped);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
 	return ret;
 }
 
 static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+			       size_t pgsize, size_t pgcount,
+			       struct iommu_iotlb_gather *gather)
 {
 	size_t ret;
 	unsigned long flags;
@@ -449,7 +451,7 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	 */
 	pm_runtime_get_sync(qcom_domain->iommu->dev);
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
-	ret = ops->unmap(ops, iova, size, gather);
+	ret = ops->unmap_pages(ops, iova, pgsize, pgcount, gather);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
 	pm_runtime_put_sync(qcom_domain->iommu->dev);
 
@@ -587,8 +589,8 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
 		.detach_dev	= qcom_iommu_detach_dev,
-		.map		= qcom_iommu_map,
-		.unmap		= qcom_iommu_unmap,
+		.map_pages	= qcom_iommu_map,
+		.unmap_pages	= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
 		.iotlb_sync	= qcom_iommu_iotlb_sync,
 		.iova_to_phys	= qcom_iommu_iova_to_phys,
-- 
2.36.1.dirty

