From: Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Remove unnecessary wrapper function
Date: Wed, 10 Oct 2018 11:29:27 +0100
Message-ID: <1539167367-20471-3-git-send-email-andrew.murray@arm.com>
References: <1539167367-20471-1-git-send-email-andrew.murray@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1539167367-20471-1-git-send-email-andrew.murray@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Simplify the code by removing an unnecessary wrapper function.

This was left behind by commit 2f657add07a8
("iommu/arm-smmu-v3: Specialise CMD_SYNC handling")

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c7bd18e..6947ccf 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1371,15 +1371,11 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 }
 
 /* IO_PGTABLE API */
-static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
-{
-	arm_smmu_cmdq_issue_sync(smmu);
-}
-
 static void arm_smmu_tlb_sync(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	__arm_smmu_tlb_sync(smmu_domain->smmu);
+
+	arm_smmu_cmdq_issue_sync(smmu_domain->smmu);
 }
 
 static void arm_smmu_tlb_inv_context(void *cookie)
@@ -1404,7 +1400,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * to guarantee those are observed before the TLBI. Do be careful, 007.
 	 */
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	__arm_smmu_tlb_sync(smmu);
+	arm_smmu_cmdq_issue_sync(smmu);
 }
 
 static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
@@ -1793,7 +1789,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
 
 	if (smmu)
-		__arm_smmu_tlb_sync(smmu);
+		arm_smmu_cmdq_issue_sync(smmu);
 }
 
 static phys_addr_t
-- 
2.7.4
