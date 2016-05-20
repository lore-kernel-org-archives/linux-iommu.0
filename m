From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Fri, 20 May 2016 16:24:53 +0530
Message-ID: <1463741694-1735-7-git-send-email-sricharan@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org, architt@codeaurora.org, arnd@arndb.de
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

While using the generic pagetable ops the tlb maintenance
operation gets completed in the sync callback. So use writel_relaxed
for all register access and add a mb() at appropriate places.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/msm_iommu.c         |  24 +++++++--
 drivers/iommu/msm_iommu_hw-8xxx.h | 109 ++++++++++++++++++++------------------
 2 files changed, 79 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0299a37..dfcaeef 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -124,6 +124,9 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
 		SET_TLBLKCR(base, ctx, 0);
 		SET_CONTEXTIDR(base, ctx, 0);
 	}
+
+	/* Ensure completion of relaxed writes from the above SET macros */
+	mb();
 }
 
 static void __flush_iotlb(void *cookie)
@@ -141,6 +144,9 @@ static void __flush_iotlb(void *cookie)
 		list_for_each_entry(master, &iommu->ctx_list, list)
 			SET_CTX_TLBIALL(iommu->base, master->num, 0);
 
+		/* To ensure completion of TLBIALL above */
+		mb();
+
 		__disable_clocks(iommu);
 	}
 fail:
@@ -181,7 +187,8 @@ fail:
 
 static void __flush_iotlb_sync(void *cookie)
 {
-	/* To avoid a null function pointer */
+	/* To ensure completion of the TLBIVA in __flush_iotlb_range */
+	mb();
 }
 
 static const struct iommu_gather_ops msm_iommu_gather_ops = {
@@ -235,6 +242,9 @@ static void config_mids(struct msm_iommu_dev *iommu,
 		/* Set security bit override to be Non-secure */
 		SET_NSCFG(iommu->base, mid, 3);
 	}
+
+	/* Ensure completion of relaxed writes from the above SET macros */
+	mb();
 }
 
 static void __reset_context(void __iomem *base, int ctx)
@@ -257,6 +267,9 @@ static void __reset_context(void __iomem *base, int ctx)
 	SET_TLBFLPTER(base, ctx, 0);
 	SET_TLBSLPTER(base, ctx, 0);
 	SET_TLBLKCR(base, ctx, 0);
+
+	/* Ensure completion of relaxed writes from the above SET macros */
+	mb();
 }
 
 static void __program_context(void __iomem *base, int ctx,
@@ -305,6 +318,9 @@ static void __program_context(void __iomem *base, int ctx,
 
 	/* Enable the MMU */
 	SET_M(base, ctx, 1);
+
+	/* Ensure completion of relaxed writes from the above SET macros */
+	mb();
 }
 
 static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
@@ -500,7 +516,8 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 	/* Invalidate context TLB */
 	SET_CTX_TLBIALL(iommu->base, master->num, 0);
 	SET_V2PPR(iommu->base, master->num, va & V2Pxx_VA);
-
+	/* Ensure completion of relaxed writes from the above SET macros */
+	mb();
 	par = GET_PAR(iommu->base, master->num);
 
 	/* We are dealing with a supersection */
@@ -714,7 +731,8 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	par = GET_PAR(iommu->base, 0);
 	SET_V2PCFG(iommu->base, 0, 0);
 	SET_M(iommu->base, 0, 0);
-
+	/* Ensure completion of relaxed writes from the above SET macros */
+	mb();
 	if (!par) {
 		pr_err("Invalid PAR value detected\n");
 		ret = -ENODEV;
diff --git a/drivers/iommu/msm_iommu_hw-8xxx.h b/drivers/iommu/msm_iommu_hw-8xxx.h
index fc16010..fe2c5ca 100644
--- a/drivers/iommu/msm_iommu_hw-8xxx.h
+++ b/drivers/iommu/msm_iommu_hw-8xxx.h
@@ -24,13 +24,19 @@
 #define GET_CTX_REG(reg, base, ctx) \
 				(readl((base) + (reg) + ((ctx) << CTX_SHIFT)))
 
-#define SET_GLOBAL_REG(reg, base, val)	writel((val), ((base) + (reg)))
+/*
+ * The writes to the global/context registers needs to be synced only after
+ * all the configuration writes are done. So use relaxed accessors and
+ * a barrier at the end.
+ */
+#define SET_GLOBAL_REG_RELAXED(reg, base, val) \
+			       writel_relaxed((val), ((base) + (reg)))
 
-#define SET_CTX_REG(reg, base, ctx, val) \
-			writel((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
+#define SET_CTX_REG_RELAXED(reg, base, ctx, val) \
+		writel_relaxed((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
 
-/* Wrappers for numbered registers */
-#define SET_GLOBAL_REG_N(b, n, r, v) SET_GLOBAL_REG(b, ((r) + (n << 2)), (v))
+ /* Wrappers for numbered registers */
+#define SET_GLOBAL_REG_N(b, n, r, v) SET_GLOBAL_REG_RELAXED(b, ((r) + (n << 2)), (v))
 #define GET_GLOBAL_REG_N(b, n, r)    GET_GLOBAL_REG(b, ((r) + (n << 2)))
 
 /* Field wrappers */
@@ -39,16 +45,17 @@
 	GET_FIELD(((b) + (r) + ((c) << CTX_SHIFT)), F##_MASK, F##_SHIFT)
 
 #define SET_GLOBAL_FIELD(b, r, F, v) \
-	SET_FIELD(((b) + (r)), F##_MASK, F##_SHIFT, (v))
+	SET_FIELD_RELAXED(((b) + (r)), F##_MASK, F##_SHIFT, (v))
 #define SET_CONTEXT_FIELD(b, c, r, F, v)	\
-	SET_FIELD(((b) + (r) + ((c) << CTX_SHIFT)), F##_MASK, F##_SHIFT, (v))
+	SET_FIELD_RELAXED(((b) + (r) + ((c) << CTX_SHIFT)), F##_MASK, F##_SHIFT, (v))
 
 #define GET_FIELD(addr, mask, shift)  ((readl(addr) >> (shift)) & (mask))
 
-#define SET_FIELD(addr, mask, shift, v) \
+#define SET_FIELD_RELAXED(addr, mask, shift, v) \
 do { \
 	int t = readl(addr); \
-	writel((t & ~((mask) << (shift))) + (((v) & (mask)) << (shift)), addr);\
+	writel_relaxed((t & ~((mask) << (shift))) + \
+		       (((v) & (mask)) << (shift)), addr);\
 } while (0)
 
 
@@ -96,20 +103,20 @@ do { \
 /* Global register setters / getters */
 #define SET_M2VCBR_N(b, N, v)	 SET_GLOBAL_REG_N(M2VCBR_N, N, (b), (v))
 #define SET_CBACR_N(b, N, v)	 SET_GLOBAL_REG_N(CBACR_N, N, (b), (v))
-#define SET_TLBRSW(b, v)	 SET_GLOBAL_REG(TLBRSW, (b), (v))
-#define SET_TLBTR0(b, v)	 SET_GLOBAL_REG(TLBTR0, (b), (v))
-#define SET_TLBTR1(b, v)	 SET_GLOBAL_REG(TLBTR1, (b), (v))
-#define SET_TLBTR2(b, v)	 SET_GLOBAL_REG(TLBTR2, (b), (v))
-#define SET_TESTBUSCR(b, v)	 SET_GLOBAL_REG(TESTBUSCR, (b), (v))
-#define SET_GLOBAL_TLBIALL(b, v) SET_GLOBAL_REG(GLOBAL_TLBIALL, (b), (v))
-#define SET_TLBIVMID(b, v)	 SET_GLOBAL_REG(TLBIVMID, (b), (v))
-#define SET_CR(b, v)		 SET_GLOBAL_REG(CR, (b), (v))
-#define SET_EAR(b, v)		 SET_GLOBAL_REG(EAR, (b), (v))
-#define SET_ESR(b, v)		 SET_GLOBAL_REG(ESR, (b), (v))
-#define SET_ESRRESTORE(b, v)	 SET_GLOBAL_REG(ESRRESTORE, (b), (v))
-#define SET_ESYNR0(b, v)	 SET_GLOBAL_REG(ESYNR0, (b), (v))
-#define SET_ESYNR1(b, v)	 SET_GLOBAL_REG(ESYNR1, (b), (v))
-#define SET_RPU_ACR(b, v)	 SET_GLOBAL_REG(RPU_ACR, (b), (v))
+#define SET_TLBRSW(b, v)	 SET_GLOBAL_REG_RELAXED(TLBRSW, (b), (v))
+#define SET_TLBTR0(b, v)	 SET_GLOBAL_REG_RELAXED(TLBTR0, (b), (v))
+#define SET_TLBTR1(b, v)	 SET_GLOBAL_REG_RELAXED(TLBTR1, (b), (v))
+#define SET_TLBTR2(b, v)	 SET_GLOBAL_REG_RELAXED(TLBTR2, (b), (v))
+#define SET_TESTBUSCR(b, v)	 SET_GLOBAL_REG_RELAXED(TESTBUSCR, (b), (v))
+#define SET_GLOBAL_TLBIALL(b, v) SET_GLOBAL_REG_RELAXED(GLOBAL_TLBIALL, (b), (v))
+#define SET_TLBIVMID(b, v)	 SET_GLOBAL_REG_RELAXED(TLBIVMID, (b), (v))
+#define SET_CR(b, v)		 SET_GLOBAL_REG_RELAXED(CR, (b), (v))
+#define SET_EAR(b, v)		 SET_GLOBAL_REG_RELAXED(EAR, (b), (v))
+#define SET_ESR(b, v)		 SET_GLOBAL_REG_RELAXED(ESR, (b), (v))
+#define SET_ESRRESTORE(b, v)	 SET_GLOBAL_REG_RELAXED(ESRRESTORE, (b), (v))
+#define SET_ESYNR0(b, v)	 SET_GLOBAL_REG_RELAXED(ESYNR0, (b), (v))
+#define SET_ESYNR1(b, v)	 SET_GLOBAL_REG_RELAXED(ESYNR1, (b), (v))
+#define SET_RPU_ACR(b, v)	 SET_GLOBAL_REG_RELAXED(RPU_ACR, (b), (v))
 
 #define GET_M2VCBR_N(b, N)	 GET_GLOBAL_REG_N(M2VCBR_N, N, (b))
 #define GET_CBACR_N(b, N)	 GET_GLOBAL_REG_N(CBACR_N, N, (b))
@@ -131,34 +138,34 @@ do { \
 
 
 /* Context register setters/getters */
-#define SET_SCTLR(b, c, v)	 SET_CTX_REG(SCTLR, (b), (c), (v))
-#define SET_ACTLR(b, c, v)	 SET_CTX_REG(ACTLR, (b), (c), (v))
-#define SET_CONTEXTIDR(b, c, v)	 SET_CTX_REG(CONTEXTIDR, (b), (c), (v))
-#define SET_TTBR0(b, c, v)	 SET_CTX_REG(TTBR0, (b), (c), (v))
-#define SET_TTBR1(b, c, v)	 SET_CTX_REG(TTBR1, (b), (c), (v))
-#define SET_TTBCR(b, c, v)	 SET_CTX_REG(TTBCR, (b), (c), (v))
-#define SET_PAR(b, c, v)	 SET_CTX_REG(PAR, (b), (c), (v))
-#define SET_FSR(b, c, v)	 SET_CTX_REG(FSR, (b), (c), (v))
-#define SET_FSRRESTORE(b, c, v)	 SET_CTX_REG(FSRRESTORE, (b), (c), (v))
-#define SET_FAR(b, c, v)	 SET_CTX_REG(FAR, (b), (c), (v))
-#define SET_FSYNR0(b, c, v)	 SET_CTX_REG(FSYNR0, (b), (c), (v))
-#define SET_FSYNR1(b, c, v)	 SET_CTX_REG(FSYNR1, (b), (c), (v))
-#define SET_PRRR(b, c, v)	 SET_CTX_REG(PRRR, (b), (c), (v))
-#define SET_NMRR(b, c, v)	 SET_CTX_REG(NMRR, (b), (c), (v))
-#define SET_TLBLKCR(b, c, v)	 SET_CTX_REG(TLBLCKR, (b), (c), (v))
-#define SET_V2PSR(b, c, v)	 SET_CTX_REG(V2PSR, (b), (c), (v))
-#define SET_TLBFLPTER(b, c, v)	 SET_CTX_REG(TLBFLPTER, (b), (c), (v))
-#define SET_TLBSLPTER(b, c, v)	 SET_CTX_REG(TLBSLPTER, (b), (c), (v))
-#define SET_BFBCR(b, c, v)	 SET_CTX_REG(BFBCR, (b), (c), (v))
-#define SET_CTX_TLBIALL(b, c, v) SET_CTX_REG(CTX_TLBIALL, (b), (c), (v))
-#define SET_TLBIASID(b, c, v)	 SET_CTX_REG(TLBIASID, (b), (c), (v))
-#define SET_TLBIVA(b, c, v)	 SET_CTX_REG(TLBIVA, (b), (c), (v))
-#define SET_TLBIVAA(b, c, v)	 SET_CTX_REG(TLBIVAA, (b), (c), (v))
-#define SET_V2PPR(b, c, v)	 SET_CTX_REG(V2PPR, (b), (c), (v))
-#define SET_V2PPW(b, c, v)	 SET_CTX_REG(V2PPW, (b), (c), (v))
-#define SET_V2PUR(b, c, v)	 SET_CTX_REG(V2PUR, (b), (c), (v))
-#define SET_V2PUW(b, c, v)	 SET_CTX_REG(V2PUW, (b), (c), (v))
-#define SET_RESUME(b, c, v)	 SET_CTX_REG(RESUME, (b), (c), (v))
+#define SET_SCTLR(b, c, v)	 SET_CTX_REG_RELAXED(SCTLR, (b), (c), (v))
+#define SET_ACTLR(b, c, v)	 SET_CTX_REG_RELAXED(ACTLR, (b), (c), (v))
+#define SET_CONTEXTIDR(b, c, v)	 SET_CTX_REG_RELAXED(CONTEXTIDR, (b), (c), (v))
+#define SET_TTBR0(b, c, v)	 SET_CTX_REG_RELAXED(TTBR0, (b), (c), (v))
+#define SET_TTBR1(b, c, v)	 SET_CTX_REG_RELAXED(TTBR1, (b), (c), (v))
+#define SET_TTBCR(b, c, v)	 SET_CTX_REG_RELAXED(TTBCR, (b), (c), (v))
+#define SET_PAR(b, c, v)	 SET_CTX_REG_RELAXED(PAR, (b), (c), (v))
+#define SET_FSR(b, c, v)	 SET_CTX_REG_RELAXED(FSR, (b), (c), (v))
+#define SET_FSRRESTORE(b, c, v)	 SET_CTX_REG_RELAXED(FSRRESTORE, (b), (c), (v))
+#define SET_FAR(b, c, v)	 SET_CTX_REG_RELAXED(FAR, (b), (c), (v))
+#define SET_FSYNR0(b, c, v)	 SET_CTX_REG_RELAXED(FSYNR0, (b), (c), (v))
+#define SET_FSYNR1(b, c, v)	 SET_CTX_REG_RELAXED(FSYNR1, (b), (c), (v))
+#define SET_PRRR(b, c, v)	 SET_CTX_REG_RELAXED(PRRR, (b), (c), (v))
+#define SET_NMRR(b, c, v)	 SET_CTX_REG_RELAXED(NMRR, (b), (c), (v))
+#define SET_TLBLKCR(b, c, v)	 SET_CTX_REG_RELAXED(TLBLCKR, (b), (c), (v))
+#define SET_V2PSR(b, c, v)	 SET_CTX_REG_RELAXED(V2PSR, (b), (c), (v))
+#define SET_TLBFLPTER(b, c, v)	 SET_CTX_REG_RELAXED(TLBFLPTER, (b), (c), (v))
+#define SET_TLBSLPTER(b, c, v)	 SET_CTX_REG_RELAXED(TLBSLPTER, (b), (c), (v))
+#define SET_BFBCR(b, c, v)	 SET_CTX_REG_RELAXED(BFBCR, (b), (c), (v))
+#define SET_CTX_TLBIALL(b, c, v) SET_CTX_REG_RELAXED(CTX_TLBIALL, (b), (c), (v))
+#define SET_TLBIASID(b, c, v)	 SET_CTX_REG_RELAXED(TLBIASID, (b), (c), (v))
+#define SET_TLBIVA(b, c, v)	 SET_CTX_REG_RELAXED(TLBIVA, (b), (c), (v))
+#define SET_TLBIVAA(b, c, v)	 SET_CTX_REG_RELAXED(TLBIVAA, (b), (c), (v))
+#define SET_V2PPR(b, c, v)	 SET_CTX_REG_RELAXED(V2PPR, (b), (c), (v))
+#define SET_V2PPW(b, c, v)	 SET_CTX_REG_RELAXED(V2PPW, (b), (c), (v))
+#define SET_V2PUR(b, c, v)	 SET_CTX_REG_RELAXED(V2PUR, (b), (c), (v))
+#define SET_V2PUW(b, c, v)	 SET_CTX_REG_RELAXED(V2PUW, (b), (c), (v))
+#define SET_RESUME(b, c, v)	 SET_CTX_REG_RELAXED(RESUME, (b), (c), (v))
 
 #define GET_SCTLR(b, c)		 GET_CTX_REG(SCTLR, (b), (c))
 #define GET_ACTLR(b, c)		 GET_CTX_REG(ACTLR, (b), (c))
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
