Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9BB168CB
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:18:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF2C4C15;
	Tue, 12 Sep 2023 09:19:36 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25E983F738;
	Tue, 12 Sep 2023 09:18:58 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	m.szyprowski@samsung.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: [PATCH 6/8] iommu/tegra-smmu: Update to {map,unmap}_pages
Date: Tue, 12 Sep 2023 17:18:42 +0100
Message-Id: <338c520ed947d6d5b9d0509ccb4588908bd9ce1e.1694525662.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1694525662.git.robin.murphy@arm.com>
References: <cover.1694525662.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivially update map/unmap to the new interface, which is quite happy
for drivers to still process just one page per call.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/tegra-smmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e445f80d0226..4cd2153bb076 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -751,7 +751,8 @@ __tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 }
 
 static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			  phys_addr_t paddr, size_t size, size_t count,
+			  int prot, gfp_t gfp, size_t *mapped)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	unsigned long flags;
@@ -761,11 +762,14 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp, &flags);
 	spin_unlock_irqrestore(&as->lock, flags);
 
+	if (!ret)
+		*mapped = size;
+
 	return ret;
 }
 
 static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+			       size_t size, size_t count, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	unsigned long flags;
@@ -971,8 +975,8 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= tegra_smmu_attach_dev,
-		.map		= tegra_smmu_map,
-		.unmap		= tegra_smmu_unmap,
+		.map_pages	= tegra_smmu_map,
+		.unmap_pages	= tegra_smmu_unmap,
 		.iova_to_phys	= tegra_smmu_iova_to_phys,
 		.free		= tegra_smmu_domain_free,
 	}
-- 
2.39.2.101.g768bb238c484.dirty

