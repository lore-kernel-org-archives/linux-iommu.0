From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 2/2] iommu/arm-smmu: add support for iova_to_phys
	through ATS1PR
Date: Tue, 20 Jan 2015 14:16:43 +0000
Message-ID: <20150120141643.GA1549@arm.com>
References: <1414617220-21493-1-git-send-email-mitchelh@codeaurora.org>
	<1414617220-21493-3-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414617220-21493-3-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hey Mitch,

On Wed, Oct 29, 2014 at 09:13:40PM +0000, Mitchel Humpherys wrote:
> Currently, we provide the iommu_ops.iova_to_phys service by doing a
> table walk in software to translate IO virtual addresses to physical
> addresses. On SMMUs that support it, it can be useful to ask the SMMU
> itself to do the translation. This can be used to warm the TLBs for an
> SMMU. It can also be useful for testing and hardware validation.
> 
> Since the address translation registers are optional on SMMUv2, only
> enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
> and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> Changes since v6:
>   - added missing lock
>   - fixed physical address mask

I had a go at rebasing this onto my current queue, but ended up making
quite a few changes. Can you take a look at the result, please?

Patch below (also on my for-joerg/arm-smmu/updates branch).

Thanks,

Will

--->8

>From 859a732e4f713270152c78df6e09accbde006734 Mon Sep 17 00:00:00 2001
From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Date: Wed, 29 Oct 2014 21:13:40 +0000
Subject: [PATCH] iommu/arm-smmu: add support for iova_to_phys through ATS1PR

Currently, we provide the iommu_ops.iova_to_phys service by doing a
table walk in software to translate IO virtual addresses to physical
addresses. On SMMUs that support it, it can be useful to ask the SMMU
itself to do the translation. This can be used to warm the TLBs for an
SMMU. It can also be useful for testing and hardware validation.

Since the address translation registers are optional on SMMUv2, only
enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
[will: reworked on top of generic iopgtbl changes]
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 006f006c35e9..1d6d43bb3395 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -34,6 +34,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -100,6 +101,7 @@
 #define ID0_S2TS			(1 << 29)
 #define ID0_NTS				(1 << 28)
 #define ID0_SMS				(1 << 27)
+#define ID0_ATOSNS			(1 << 26)
 #define ID0_CTTW			(1 << 14)
 #define ID0_NUMIRPT_SHIFT		16
 #define ID0_NUMIRPT_MASK		0xff
@@ -189,6 +191,8 @@
 #define ARM_SMMU_CB_TTBCR		0x30
 #define ARM_SMMU_CB_S1_MAIR0		0x38
 #define ARM_SMMU_CB_S1_MAIR1		0x3c
+#define ARM_SMMU_CB_PAR_LO		0x50
+#define ARM_SMMU_CB_PAR_HI		0x54
 #define ARM_SMMU_CB_FSR			0x58
 #define ARM_SMMU_CB_FAR_LO		0x60
 #define ARM_SMMU_CB_FAR_HI		0x64
@@ -198,6 +202,9 @@
 #define ARM_SMMU_CB_S1_TLBIVAL		0x620
 #define ARM_SMMU_CB_S2_TLBIIPAS2	0x630
 #define ARM_SMMU_CB_S2_TLBIIPAS2L	0x638
+#define ARM_SMMU_CB_ATS1PR_LO		0x800
+#define ARM_SMMU_CB_ATS1PR_HI		0x804
+#define ARM_SMMU_CB_ATSR		0x8f0
 
 #define SCTLR_S1_ASIDPNE		(1 << 12)
 #define SCTLR_CFCFG			(1 << 7)
@@ -209,6 +216,10 @@
 #define SCTLR_M				(1 << 0)
 #define SCTLR_EAE_SBOP			(SCTLR_AFE | SCTLR_TRE)
 
+#define CB_PAR_F			(1 << 0)
+
+#define ATSR_ACTIVE			(1 << 0)
+
 #define RESUME_RETRY			(0 << 0)
 #define RESUME_TERMINATE		(1 << 0)
 
@@ -282,6 +293,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_TRANS_S1		(1 << 2)
 #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
 #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
+#define ARM_SMMU_FEAT_TRANS_OPS		(1 << 5)
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
@@ -1220,8 +1232,52 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
+static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
+					      dma_addr_t iova)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+	struct device *dev = smmu->dev;
+	void __iomem *cb_base;
+	u32 tmp;
+	u64 phys;
+
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+
+	if (smmu->version == 1) {
+		u32 reg = iova & ~0xfff;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
+	} else {
+		u32 reg = iova & ~0xfff;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
+		reg = (iova & ~0xfff) >> 32;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
+	}
+
+	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
+				      !(tmp & ATSR_ACTIVE), 5, 50)) {
+		dev_err(dev,
+			"iova to phys timed out on 0x%pad. Falling back to software table walk.\n",
+			&iova);
+		return ops->iova_to_phys(ops, iova);
+	}
+
+	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
+	phys |= ((u64)readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;
+
+	if (phys & CB_PAR_F) {
+		dev_err(dev, "translation fault!\n");
+		dev_err(dev, "PAR = 0x%llx\n", phys);
+		return 0;
+	}
+
+	return (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
+}
+
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
-					 dma_addr_t iova)
+					dma_addr_t iova)
 {
 	phys_addr_t ret;
 	unsigned long flags;
@@ -1232,8 +1288,12 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 		return 0;
 
 	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
-	ret = ops->iova_to_phys(ops, iova);
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_TRANS_OPS)
+		ret = arm_smmu_iova_to_phys_hard(domain, iova);
+	else
+		ret = ops->iova_to_phys(ops, iova);
 	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
+
 	return ret;
 }
 
@@ -1496,6 +1556,11 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 
+	if (smmu->version == 1 || (!(id & ID0_ATOSNS) && (id & ID0_S1TS))) {
+		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
+		dev_notice(smmu->dev, "\taddress translation ops\n");
+	}
+
 	if (id & ID0_CTTW) {
 		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
 		dev_notice(smmu->dev, "\tcoherent table walk\n");
-- 
2.1.4
