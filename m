Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C4618056
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:18:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52ACC15;
	Tue, 12 Sep 2023 09:19:31 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BDC53F738;
	Tue, 12 Sep 2023 09:18:53 -0700 (PDT)
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
Subject: [PATCH 3/8] iommu/rockchip: Update to {map,unmap}_pages
Date: Tue, 12 Sep 2023 17:18:39 +0100
Message-Id: <ccc21bf7d1d0da8989d4d517a13d0846d6b71a38.1694525662.git.robin.murphy@arm.com>
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
 drivers/iommu/rockchip-iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 8ff69fbf9f65..bb00c67c1015 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -817,7 +817,8 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 }
 
 static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
-			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			phys_addr_t paddr, size_t size, size_t count,
+			int prot, gfp_t gfp, size_t *mapped)
 {
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
@@ -850,12 +851,14 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 				paddr, size, prot);
 
 	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
+	if (!ret)
+		*mapped = size;
 
 	return ret;
 }
 
 static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
-			     size_t size, struct iommu_iotlb_gather *gather)
+			     size_t size, size_t count, struct iommu_iotlb_gather *gather)
 {
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
@@ -1197,8 +1200,8 @@ static const struct iommu_ops rk_iommu_ops = {
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
-		.map		= rk_iommu_map,
-		.unmap		= rk_iommu_unmap,
+		.map_pages	= rk_iommu_map,
+		.unmap_pages	= rk_iommu_unmap,
 		.iova_to_phys	= rk_iommu_iova_to_phys,
 		.free		= rk_iommu_domain_free,
 	}
-- 
2.39.2.101.g768bb238c484.dirty

