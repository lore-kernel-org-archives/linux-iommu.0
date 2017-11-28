From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/4] iommu/arm-smmu-v3: Support 52-bit virtual address
Date: Tue, 28 Nov 2017 17:27:07 +0000
Message-ID: <e3ea3c0975cac510ee9e0d4205998da5a20bfd91.1511807303.git.robin.murphy@arm.com>
References: <cover.1511807303.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1511807303.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kristina.martsenko-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Stage 1 input addresses are effectively 64-bit in SMMUv3 anyway, so
really all that's involved is letting io-pgtable know the appropriate
upper bound for T0SZ.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e251762663c6..a209a02388af 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -102,6 +102,7 @@
 #define IDR5_OAS_44_BIT			(4 << IDR5_OAS_SHIFT)
 #define IDR5_OAS_48_BIT			(5 << IDR5_OAS_SHIFT)
 #define IDR5_OAS_52_BIT			(6 << IDR5_OAS_SHIFT)
+#define IDR5_VAX			(1 << 10)
 
 #define ARM_SMMU_CR0			0x20
 #define CR0_CMDQEN			(1 << 3)
@@ -604,6 +605,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALLS		(1 << 11)
 #define ARM_SMMU_FEAT_HYP		(1 << 12)
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
+#define ARM_SMMU_FEAT_VAX		(1 << 14)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1657,6 +1659,8 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1:
 		ias = VA_BITS;
+		if (VA_BITS > 48 && !(smmu->features & ARM_SMMU_FEAT_VAX))
+			ias = 48;
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
@@ -2695,6 +2699,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR5_GRAN4K)
 		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
 
+	/* Input address size */
+	if (reg & IDR5_VAX)
+		smmu->features |= ARM_SMMU_FEAT_VAX;
+
 	/* Output address size */
 	switch (reg & IDR5_OAS_MASK << IDR5_OAS_SHIFT) {
 	case IDR5_OAS_32_BIT:
-- 
2.13.4.dirty
