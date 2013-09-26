From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/9] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu register
	values
Date: Fri, 27 Sep 2013 00:36:14 +0200
Message-ID: <1380234982-1677-3-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380234982-1677-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently it is derived from smmu resource size.  In case of a
mismatchin between the two calculations trust DT more than register
values and overwrite cb_base.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6808577..4307fbc 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -207,7 +207,7 @@
 #define CBA2R_RW64_64BIT		(1 << 0)
 
 /* Translation context bank */
-#define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
+#define ARM_SMMU_CB_BASE(smmu)		((smmu)->cb_base)
 #define ARM_SMMU_CB(smmu, n)		((n) * (smmu)->pagesize)
 
 #define ARM_SMMU_CB_SCTLR		0x0
@@ -339,6 +339,7 @@ struct arm_smmu_device {
 	struct device_node		*parent_of_node;
 
 	void __iomem			*base;
+	void __iomem			*cb_base;
 	unsigned long			size;
 	unsigned long			pagesize;
 
@@ -1622,6 +1623,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned long size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;
+	unsigned long t;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
 
@@ -1702,12 +1704,23 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/* Check that we ioremapped enough */
 	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
-	size *= (smmu->pagesize << 1);
+	size *= smmu->pagesize;
+	smmu->cb_base = smmu->base + size;
+	size *= 2;
+
 	if (smmu->size < size)
 		dev_warn(smmu->dev,
 			 "device is 0x%lx bytes but only mapped 0x%lx!\n",
 			 size, smmu->size);
 
+	t = (unsigned long) smmu->base + (smmu->size >> 1);
+	if ((unsigned long)smmu->cb_base != t) {
+		dev_warn(smmu->dev, "address space mismatch, "
+			"overwriting cb_base (old: 0x%lx, new: 0x%lx)\n",
+			(unsigned long) smmu->cb_base, t);
+		smmu->cb_base = (void *) t;
+	}
+
 	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) &
 				      ID1_NUMS2CB_MASK;
 	smmu->num_context_banks = (id >> ID1_NUMCB_SHIFT) & ID1_NUMCB_MASK;
-- 
1.7.9.5
