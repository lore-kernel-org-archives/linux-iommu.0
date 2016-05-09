From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu/arm-smmu: Use per-domain page sizes.
Date: Mon,  9 May 2016 17:20:09 +0100
Message-ID: <112fc0e5f9bbe08007778b8438b35025d8e876a4.1462810410.git.robin.murphy@arm.com>
References: <ea520b8c72b5a72a1731bd35f6e3e50872fe6764.1460048991.git.robin.murphy@arm.com>
	<cover.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ea520b8c72b5a72a1731bd35f6e3e50872fe6764.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we can accurately reflect the context format we choose for each
domain, do that instead of imposing the global lowest-common-denominator
restriction and potentially ending up with nothing. We currently have a
strict 1:1 correspondence between domains and context banks, so we don't
need to entertain the possibility of multiple formats _within_ a domain.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
[rm: split from original patch, added SMMUv3]
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Changes from v1: Rebased onto iommu/core to accommodate SMMUv2 changes.

 drivers/iommu/arm-smmu-v3.c | 19 ++++++++++---------
 drivers/iommu/arm-smmu.c    | 27 +++++++++++++++------------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4ff73ff64e49..ebab33e77d67 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -590,6 +590,7 @@ struct arm_smmu_device {
 
 	unsigned long			ias; /* IPA */
 	unsigned long			oas; /* PA */
+	unsigned long			pgsize_bitmap;
 
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
@@ -1516,8 +1517,6 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static struct iommu_ops arm_smmu_ops;
-
 static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
@@ -1555,7 +1554,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	}
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= arm_smmu_ops.pgsize_bitmap,
+		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
 		.oas		= oas,
 		.tlb		= &arm_smmu_gather_ops,
@@ -1566,7 +1565,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (!pgtbl_ops)
 		return -ENOMEM;
 
-	arm_smmu_ops.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	smmu_domain->pgtbl_ops = pgtbl_ops;
 
 	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
@@ -2410,7 +2409,6 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
 	bool coherent;
-	unsigned long pgsize_bitmap = 0;
 
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
@@ -2541,13 +2539,16 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 
 	/* Page sizes */
 	if (reg & IDR5_GRAN64K)
-		pgsize_bitmap |= SZ_64K | SZ_512M;
+		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
 	if (reg & IDR5_GRAN16K)
-		pgsize_bitmap |= SZ_16K | SZ_32M;
+		smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
 	if (reg & IDR5_GRAN4K)
-		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
+		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
 
-	arm_smmu_ops.pgsize_bitmap &= pgsize_bitmap;
+	if (arm_smmu_ops.pgsize_bitmap == -1UL)
+		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
+	else
+		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
 
 	/* Output address size */
 	switch (reg & IDR5_OAS_MASK << IDR5_OAS_SHIFT) {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7cd4ad98904a..0360919a5737 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -351,6 +351,7 @@ struct arm_smmu_device {
 	unsigned long			va_size;
 	unsigned long			ipa_size;
 	unsigned long			pa_size;
+	unsigned long			pgsize_bitmap;
 
 	u32				num_global_irqs;
 	u32				num_context_irqs;
@@ -396,8 +397,6 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
-static struct iommu_ops arm_smmu_ops;
-
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
 static LIST_HEAD(arm_smmu_devices);
 
@@ -957,7 +956,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= arm_smmu_ops.pgsize_bitmap,
+		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
 		.oas		= oas,
 		.tlb		= &arm_smmu_gather_ops,
@@ -971,8 +970,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		goto out_clear_smmu;
 	}
 
-	/* Update our support page sizes to reflect the page table format */
-	arm_smmu_ops.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	/* Update the domain's page sizes to reflect the page table format */
+	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
@@ -1814,19 +1813,23 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* Now we've corralled the various formats, what'll it do? */
-	size = 0;
 	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S)
-		size |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
+		smmu->pgsize_bitmap |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
 	if (smmu->features &
 	    (ARM_SMMU_FEAT_FMT_AARCH32_L | ARM_SMMU_FEAT_FMT_AARCH64_4K))
-		size |= SZ_4K | SZ_2M | SZ_1G;
+		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
 	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_16K)
-		size |= SZ_16K | SZ_32M;
+		smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
 	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K)
-		size |= SZ_64K | SZ_512M;
+		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
+
+	if (arm_smmu_ops.pgsize_bitmap == -1UL)
+		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
+	else
+		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
+	dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n",
+		   smmu->pgsize_bitmap);
 
-	arm_smmu_ops.pgsize_bitmap &= size;
-	dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n", size);
 
 	if (smmu->features & ARM_SMMU_FEAT_TRANS_S1)
 		dev_notice(smmu->dev, "\tStage-1: %lu-bit VA -> %lu-bit IPA\n",
-- 
2.8.1.dirty
