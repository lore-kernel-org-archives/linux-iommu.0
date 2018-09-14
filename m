From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v7 1/6] iommu/arm-smmu-v3: Implement flush_iotlb_all hook
Date: Fri, 14 Sep 2018 15:30:19 +0100
Message-ID: <f2c5d38962c1f7ceccdf5faafb90d7076eef0752.1536935328.git.robin.murphy@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536935328.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen@huawei.com>

.flush_iotlb_all is currently stubbed to arm_smmu_iotlb_sync() since the
only time it would ever need to actually do anything is for callers
doing their own explicit batching, e.g.:

	iommu_unmap_fast(domain, ...);
	iommu_unmap_fast(domain, ...);
	iommu_iotlb_flush_all(domain, ...);

where since io-pgtable still issues the TLBI commands implicitly in the
unmap instead of implementing .iotlb_range_add, the "flush" only needs
to ensure completion of those already-in-flight invalidations.

However, we're about to start using it in anger with flush queues, so
let's get a proper implementation wired up.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
[rm: expand commit message]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e395f1ff3f81..f10c852479fc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1781,6 +1781,14 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 	return ops->unmap(ops, iova, size);
 }
 
+static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->smmu)
+		arm_smmu_tlb_inv_context(smmu_domain);
+}
+
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
@@ -2008,7 +2016,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
-	.flush_iotlb_all	= arm_smmu_iotlb_sync,
+	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
-- 
2.19.0.dirty
