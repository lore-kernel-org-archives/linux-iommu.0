From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 7/7] iommu/arm-smmu-v3: Support 52-bit virtual address
Date: Mon, 26 Mar 2018 13:35:15 +0100
Message-ID: <d0c584bf33868c7606d4f88a583fb88b1ae8f201.1522065584.git.robin.murphy@arm.com>
References: <cover.1522065583.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1522065583.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Stage 1 input addresses are effectively 64-bit in SMMUv3 anyway, so
really all that's involved is letting io-pgtable know the appropriate
upper bound for T0SZ.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v3: Fix IDR5.VAX being a 2-bit field, and slight reorganisation of the
    stage 1 IAS logic. Since constraining to VA_BITS turns out to be an
    SMMUv3-specific behaviour, and would introduce an undesirable arm64
    dependency to io-pgtable, I ended up leaving it here.

 drivers/iommu/arm-smmu-v3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e0d46661c153..b0e23d6bd1ef 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -92,6 +92,8 @@
 #define IDR5_OAS_44_BIT			4
 #define IDR5_OAS_48_BIT			5
 #define IDR5_OAS_52_BIT			6
+#define IDR5_VAX			GENMASK(11, 10)
+#define IDR5_VAX_52_BIT			1
 
 #define ARM_SMMU_CR0			0x20
 #define CR0_CMDQEN			(1 << 3)
@@ -551,6 +553,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALLS		(1 << 11)
 #define ARM_SMMU_FEAT_HYP		(1 << 12)
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
+#define ARM_SMMU_FEAT_VAX		(1 << 14)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1591,7 +1594,8 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1:
-		ias = VA_BITS;
+		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
+		ias = min_t(unsigned long, ias, VA_BITS);
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
@@ -2634,6 +2638,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR5_GRAN4K)
 		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
 
+	/* Input address size */
+	if (FIELD_GET(IDR5_VAX, reg) == IDR5_VAX_52_BIT)
+		smmu->features |= ARM_SMMU_FEAT_VAX;
+
 	/* Output address size */
 	switch (FIELD_GET(IDR5_OAS, reg)) {
 	case IDR5_OAS_32_BIT:
-- 
2.16.1.dirty
