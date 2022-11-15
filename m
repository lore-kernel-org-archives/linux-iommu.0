Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42749AD5B
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26FC91516;
	Tue, 15 Nov 2022 07:27:00 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F16013F587;
	Tue, 15 Nov 2022 07:26:52 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 5/9] iommu/ipmmu-vmsa: Update to {map,unmap}_pages
Date: Tue, 15 Nov 2022 15:26:39 +0000
Message-Id: <ad859ccc24720d72f8eafd03817c1fc11255ddc1.1668100209.git.robin.murphy@arm.com>
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
since we just pass them through to io-pgtable anyway. Since these are
domain ops now, the domain is inherently valid (not to mention that
container_of() wouldn't return NULL anyway), so garbage-collect that
check in the process.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 3b30c0752274..f491bfcaf0c6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -661,22 +661,22 @@ static void ipmmu_detach_device(struct iommu_domain *io_domain,
 }
 
 static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
-		     phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+		     phys_addr_t paddr, size_t pgsize, size_t pgcount,
+		     int prot, gfp_t gfp, size_t *mapped)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
-	if (!domain)
-		return -ENODEV;
-
-	return domain->iop->map(domain->iop, iova, paddr, size, prot, gfp);
+	return domain->iop->map_pages(domain->iop, iova, paddr, pgsize, pgcount,
+				      prot, gfp, mapped);
 }
 
 static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
-			  size_t size, struct iommu_iotlb_gather *gather)
+			  size_t pgsize, size_t pgcount,
+			  struct iommu_iotlb_gather *gather)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
-	return domain->iop->unmap(domain->iop, iova, size, gather);
+	return domain->iop->unmap_pages(domain->iop, iova, pgsize, pgcount, gather);
 }
 
 static void ipmmu_flush_iotlb_all(struct iommu_domain *io_domain)
@@ -879,8 +879,8 @@ static const struct iommu_ops ipmmu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.detach_dev	= ipmmu_detach_device,
-		.map		= ipmmu_map,
-		.unmap		= ipmmu_unmap,
+		.map_pages	= ipmmu_map,
+		.unmap_pages	= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
 		.iotlb_sync	= ipmmu_iotlb_sync,
 		.iova_to_phys	= ipmmu_iova_to_phys,
-- 
2.36.1.dirty

