Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B0168CB
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:18:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B2911FB;
	Tue, 12 Sep 2023 09:19:33 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC9A73F738;
	Tue, 12 Sep 2023 09:18:54 -0700 (PDT)
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
Subject: [PATCH 4/8] iommu/sun50i: Update to {map,unmap}_pages
Date: Tue, 12 Sep 2023 17:18:40 +0100
Message-Id: <395995e5097803f9a65f2fb79e0732d41c2b8a84.1694525662.git.robin.murphy@arm.com>
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
 drivers/iommu/sun50i-iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 74c5cb93e900..cb4cbba4c22f 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -589,7 +589,8 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 }
 
 static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			    phys_addr_t paddr, size_t size, size_t count,
+			    int prot, gfp_t gfp, size_t *mapped)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu = sun50i_domain->iommu;
@@ -616,13 +617,14 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	*pte_addr = sun50i_mk_pte(paddr, prot);
 	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	*mapped = size;
 
 out:
 	return ret;
 }
 
 static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-				 size_t size, struct iommu_iotlb_gather *gather)
+				 size_t size, size_t count, struct iommu_iotlb_gather *gather)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	phys_addr_t pt_phys;
@@ -838,8 +840,8 @@ static const struct iommu_ops sun50i_iommu_ops = {
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
 		.iova_to_phys	= sun50i_iommu_iova_to_phys,
-		.map		= sun50i_iommu_map,
-		.unmap		= sun50i_iommu_unmap,
+		.map_pages	= sun50i_iommu_map,
+		.unmap_pages	= sun50i_iommu_unmap,
 		.free		= sun50i_iommu_domain_free,
 	}
 };
-- 
2.39.2.101.g768bb238c484.dirty

