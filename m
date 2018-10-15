From: <hannah@marvell.com>
Subject: [PATCH 1/4] iommu/arm-smmu: introduce wrapper for writeq/readq
Date: Mon, 15 Oct 2018 15:00:43 +0300
Message-ID: <1539604846-21151-2-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, corbet@lwn.net, joro@8bytes.org, robh+dt@kernel.org, gregory.clement@bootlin.com, mark.rutland@arm.com, jason@lakedaemon.net, andrew@lunn.ch, sebastian.hesselbarth@gmail.com, robin.murphy@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com, nadavh@marvell.com, omrii@marvell.com, Hanna Hawa <hannah@marvell.com>
List-Id: iommu@lists.linux-foundation.org

From: Hanna Hawa <hannah@marvell.com>

This patch introduce the smmu_writeq_relaxed/smmu_readq_relaxed
helpers, as preparation to add specific Marvell work-around for
accessing 64bit width registers of ARM SMMU.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fd1b80e..fccb1d4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -88,9 +88,11 @@
  * therefore this actually makes more sense than it might first appear.
  */
 #ifdef CONFIG_64BIT
-#define smmu_write_atomic_lq		writeq_relaxed
+#define smmu_write_atomic_lq(smmu, val, reg)	\
+					smmu_writeq_relaxed(smmu, val, reg)
 #else
-#define smmu_write_atomic_lq		writel_relaxed
+#define smmu_write_atomic_lq(smmu, val, reg)	\
+					writel_relaxed(val, reg)
 #endif
 
 /* Translation context bank */
@@ -270,6 +272,19 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static inline void smmu_writeq_relaxed(struct arm_smmu_device *smmu,
+				       u64 val,
+				       void __iomem *addr)
+{
+	writeq_relaxed(val, addr);
+}
+
+static inline u64 smmu_readq_relaxed(struct arm_smmu_device *smmu,
+				     void __iomem *addr)
+{
+	return readq_relaxed(addr);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -465,6 +480,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 					  size_t granule, bool leaf, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
@@ -483,7 +499,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			iova >>= 12;
 			iova |= (u64)cfg->asid << 48;
 			do {
-				writeq_relaxed(iova, reg);
+				smmu_writeq_relaxed(smmu, iova, reg);
 				iova += granule >> 12;
 			} while (size -= granule);
 		}
@@ -492,7 +508,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
 		iova >>= 12;
 		do {
-			smmu_write_atomic_lq(iova, reg);
+			smmu_write_atomic_lq(smmu, iova, reg);
 			iova += granule >> 12;
 		} while (size -= granule);
 	}
@@ -548,7 +564,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 		return IRQ_NONE;
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
-	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	iova = smmu_readq_relaxed(smmu, cb_base + ARM_SMMU_CB_FAR);
 
 	dev_err_ratelimited(smmu->dev,
 	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
@@ -698,9 +714,11 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		writel_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
 		writel_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
 	} else {
-		writeq_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
+		smmu_writeq_relaxed(smmu, cb->ttbr[0],
+				    cb_base + ARM_SMMU_CB_TTBR0);
 		if (stage1)
-			writeq_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
+			smmu_writeq_relaxed(smmu, cb->ttbr[1],
+					    cb_base + ARM_SMMU_CB_TTBR1);
 	}
 
 	/* MAIRs (stage-1 only) */
@@ -1279,7 +1297,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
 	if (smmu->version == ARM_SMMU_V2)
-		smmu_write_atomic_lq(va, cb_base + ARM_SMMU_CB_ATS1PR);
+		smmu_write_atomic_lq(smmu, va, cb_base + ARM_SMMU_CB_ATS1PR);
 	else /* Register is only 32-bit in v1 */
 		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
 
@@ -1292,7 +1310,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		return ops->iova_to_phys(ops, iova);
 	}
 
-	phys = readq_relaxed(cb_base + ARM_SMMU_CB_PAR);
+	phys = smmu_readq_relaxed(smmu, cb_base + ARM_SMMU_CB_PAR);
 	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 	if (phys & CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
-- 
1.9.1
