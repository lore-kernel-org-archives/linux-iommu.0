Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C62168CB
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:18:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5474C1007;
	Tue, 12 Sep 2023 09:19:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF2DE3F738;
	Tue, 12 Sep 2023 09:18:51 -0700 (PDT)
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
Subject: [PATCH 2/8] iommu/omap: Update to {map,unmap}_pages
Date: Tue, 12 Sep 2023 17:18:38 +0100
Message-Id: <7bad94ffccd4cba32bded72e0860974012881e24.1694525662.git.robin.murphy@arm.com>
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
 drivers/iommu/omap-iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 537e402f9bba..9e07dc94af76 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1318,7 +1318,8 @@ static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa, int pgsz)
 }
 
 static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
-			  phys_addr_t pa, size_t bytes, int prot, gfp_t gfp)
+			  phys_addr_t pa, size_t bytes, size_t count,
+			  int prot, gfp_t gfp, size_t *mapped)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct device *dev = omap_domain->dev;
@@ -1356,13 +1357,15 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 			oiommu = iommu->iommu_dev;
 			iopgtable_clear_entry(oiommu, da);
 		}
+	} else {
+		*mapped = bytes;
 	}
 
 	return ret;
 }
 
 static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
-			       size_t size, struct iommu_iotlb_gather *gather)
+			       size_t size, size_t count, struct iommu_iotlb_gather *gather)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct device *dev = omap_domain->dev;
@@ -1740,8 +1743,8 @@ static const struct iommu_ops omap_iommu_ops = {
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= omap_iommu_attach_dev,
-		.map		= omap_iommu_map,
-		.unmap		= omap_iommu_unmap,
+		.map_pages	= omap_iommu_map,
+		.unmap_pages	= omap_iommu_unmap,
 		.iova_to_phys	= omap_iommu_iova_to_phys,
 		.free		= omap_iommu_domain_free,
 	}
-- 
2.39.2.101.g768bb238c484.dirty

