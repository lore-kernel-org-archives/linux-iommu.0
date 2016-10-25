From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/3] drivers: iommu: arm-smmu-v3: constify iommu_gather_ops structures
Date: Tue, 25 Oct 2016 23:36:11 +0530
Message-ID: <1477418772-12184-3-git-send-email-bhumirks@gmail.com>
References: <1477418772-12184-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477418772-12184-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, julia.lawall@lip6.fr
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Check for iommu_gather_ops structures that are only stored in the tlb
field of an io_pgtable_cfg structure. The tlb field is of type
const struct iommu_gather_ops *, so iommu_gather_ops structures
having this property can be declared as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 15c01c3..51d8be4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1358,7 +1358,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	} while (size -= granule);
 }
 
-static struct iommu_gather_ops arm_smmu_gather_ops = {
+static const struct iommu_gather_ops arm_smmu_gather_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync,
-- 
1.9.1
