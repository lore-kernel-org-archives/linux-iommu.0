From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iommu/io-pgtable-arm: hide unused ipmmu_iotlb_sync
Date: Wed, 11 Oct 2017 15:59:06 +0200
Message-ID: <20171011135919.3653302-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Magnus Damm <damm+renesas@opensource.se>, Robin Murphy <robin.murphy@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There are two sets of iommu_ops in this driver, and only
one of them contains a reference to the ipmmu_iotlb_sync
function. This leads to a compiler warning when these
operations are not in use:

drivers/iommu/ipmmu-vmsa.c:622:13: error: 'ipmmu_iotlb_sync' defined but not used [-Werror=unused-function]

We either want to use the function in both operations, or
we should hide it. Without having additional information
which approach is correct, I'm picking the second one here,
which avoids the build error.

Fixes: 32b124492bdf ("iommu/io-pgtable-arm: Convert to IOMMU API TLB sync")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/ipmmu-vmsa.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index af8140054273..bdd0d0d20925 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -619,14 +619,6 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 	return domain->iop->unmap(domain->iop, iova, size);
 }
 
-static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
-{
-	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-
-	if (domain->mmu)
-		ipmmu_tlb_flush_all(domain);
-}
-
 static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 				      dma_addr_t iova)
 {
@@ -810,6 +802,14 @@ static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
 	}
 }
 
+static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
+{
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
+
+	if (domain->mmu)
+		ipmmu_tlb_flush_all(domain);
+}
+
 static int ipmmu_add_device_dma(struct device *dev)
 {
 	struct iommu_group *group;
-- 
2.9.0
