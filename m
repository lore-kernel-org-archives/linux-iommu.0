From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 05/21] iommu/tegra: gart: Optimize mapping / unmapping performance
Date: Mon,  1 Oct 2018 01:48:17 +0300
Message-ID: <20180930224833.28809-6-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Currently GART writes one page entry at a time. More optimal would be to
aggregate the writes and flush BUS buffer in the end, this gives map/unmap
10-40% performance boost (depending on size of mapping) in comparison to
flushing after each page entry update.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f6cf5cd5aaca..86a855c0d031 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -287,7 +287,6 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		}
 	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return 0;
 }
@@ -304,7 +303,6 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	gart_set_pte(gart, iova, 0);
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return bytes;
 }
@@ -370,6 +368,14 @@ static int gart_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
+static void gart_iommu_sync(struct iommu_domain *domain)
+{
+	struct gart_domain *gart_domain = to_gart_domain(domain);
+	struct gart_device *gart = gart_domain->gart;
+
+	FLUSH_GART_REGS(gart);
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
@@ -384,6 +390,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
+	.iotlb_sync_map	= gart_iommu_sync,
+	.iotlb_sync	= gart_iommu_sync,
 };
 
 static int tegra_gart_suspend(struct device *dev)
-- 
2.19.0
