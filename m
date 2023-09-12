Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9C18056
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:18:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7F27D75;
	Tue, 12 Sep 2023 09:19:28 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E6DF3F738;
	Tue, 12 Sep 2023 09:18:50 -0700 (PDT)
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
Subject: [PATCH 1/8] iommu/exynos: Update to {map,unmap}_pages
Date: Tue, 12 Sep 2023 17:18:37 +0100
Message-Id: <579176033e92d49ec9fc9f3d33d7b9d4c474f0b4.1694525662.git.robin.murphy@arm.com>
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
 drivers/iommu/exynos-iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c275fe71c4db..8892f5fb6bf0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1219,7 +1219,7 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
  */
 static int exynos_iommu_map(struct iommu_domain *iommu_domain,
 			    unsigned long l_iova, phys_addr_t paddr, size_t size,
-			    int prot, gfp_t gfp)
+			    size_t count, int prot, gfp_t gfp, size_t *mapped)
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_pte_t *entry;
@@ -1253,6 +1253,8 @@ static int exynos_iommu_map(struct iommu_domain *iommu_domain,
 	if (ret)
 		pr_err("%s: Failed(%d) to map %#zx bytes @ %#x\n",
 			__func__, ret, size, iova);
+	else
+		*mapped = size;
 
 	spin_unlock_irqrestore(&domain->pgtablelock, flags);
 
@@ -1274,7 +1276,7 @@ static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *domain
 }
 
 static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
-				 unsigned long l_iova, size_t size,
+				 unsigned long l_iova, size_t size, size_t count,
 				 struct iommu_iotlb_gather *gather)
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
@@ -1482,8 +1484,8 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
-		.map		= exynos_iommu_map,
-		.unmap		= exynos_iommu_unmap,
+		.map_pages	= exynos_iommu_map,
+		.unmap_pages	= exynos_iommu_unmap,
 		.iova_to_phys	= exynos_iommu_iova_to_phys,
 		.free		= exynos_iommu_domain_free,
 	}
-- 
2.39.2.101.g768bb238c484.dirty

