Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5C18056
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:18:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E6B5D75;
	Tue, 12 Sep 2023 09:19:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 893453F738;
	Tue, 12 Sep 2023 09:18:56 -0700 (PDT)
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
Subject: [PATCH 5/8] iommu/tegra-gart: Update to {map,unmap}_pages
Date: Tue, 12 Sep 2023 17:18:41 +0100
Message-Id: <cd50888ca0a3b0a73b8765f947663782632ec09b.1694525662.git.robin.murphy@arm.com>
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
 drivers/iommu/tegra-gart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index a482ff838b53..a0136cd881e6 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -178,7 +178,8 @@ static inline int __gart_iommu_map(struct gart_device *gart, unsigned long iova,
 }
 
 static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t pa, size_t bytes, int prot, gfp_t gfp)
+			  phys_addr_t pa, size_t bytes, size_t count,
+			  int prot, gfp_t gfp, size_t *mapped)
 {
 	struct gart_device *gart = gart_handle;
 	int ret;
@@ -190,6 +191,9 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	ret = __gart_iommu_map(gart, iova, (unsigned long)pa);
 	spin_unlock(&gart->pte_lock);
 
+	if (!ret)
+		*mapped = bytes;
+
 	return ret;
 }
 
@@ -207,7 +211,7 @@ static inline int __gart_iommu_unmap(struct gart_device *gart,
 }
 
 static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t bytes, struct iommu_iotlb_gather *gather)
+			       size_t bytes, size_t count, struct iommu_iotlb_gather *gather)
 {
 	struct gart_device *gart = gart_handle;
 	int err;
@@ -275,8 +279,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= gart_iommu_attach_dev,
-		.map		= gart_iommu_map,
-		.unmap		= gart_iommu_unmap,
+		.map_pages	= gart_iommu_map,
+		.unmap_pages	= gart_iommu_unmap,
 		.iova_to_phys	= gart_iommu_iova_to_phys,
 		.iotlb_sync_map	= gart_iommu_sync_map,
 		.iotlb_sync	= gart_iommu_sync,
-- 
2.39.2.101.g768bb238c484.dirty

