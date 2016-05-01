From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V3 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Mon,  2 May 2016 00:24:34 +0530
Message-ID: <1462128875-20988-7-git-send-email-sricharan@codeaurora.org>
References: <1462128875-20988-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462128875-20988-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

While using the generic pagetable ops the tlb maintenance
operation gets completed in the sync callback. So use writel_relaxed
for all register access and add a mb() at appropriate places.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/msm_iommu.c         | 11 ++++++++---
 drivers/iommu/msm_iommu_hw-8xxx.h |  7 ++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index db82f4a..39e81d3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -124,6 +124,7 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
 		SET_TLBLKCR(base, ctx, 0);
 		SET_CONTEXTIDR(base, ctx, 0);
 	}
+	mb(); /* sync */
 }
 
 static void __flush_iotlb(void *cookie)
@@ -143,6 +144,7 @@ static void __flush_iotlb(void *cookie)
 
 		__disable_clocks(iommu);
 	}
+	mb(); /* sync */
 fail:
 	return;
 }
@@ -181,7 +183,7 @@ fail:
 
 static void __flush_iotlb_sync(void *cookie)
 {
-	/* To avoid a null function pointer */
+	mb(); /* sync */
 }
 
 static const struct iommu_gather_ops msm_iommu_gather_ops = {
@@ -235,6 +237,7 @@ static void config_mids(struct msm_iommu_dev *iommu,
 		/* Set security bit override to be Non-secure */
 		SET_NSCFG(iommu->base, mid, 3);
 	}
+	mb(); /* sync */
 }
 
 static void __reset_context(void __iomem *base, int ctx)
@@ -257,6 +260,7 @@ static void __reset_context(void __iomem *base, int ctx)
 	SET_TLBFLPTER(base, ctx, 0);
 	SET_TLBSLPTER(base, ctx, 0);
 	SET_TLBLKCR(base, ctx, 0);
+	mb(); /* sync */
 }
 
 static void __program_context(void __iomem *base, int ctx,
@@ -305,6 +309,7 @@ static void __program_context(void __iomem *base, int ctx,
 
 	/* Enable the MMU */
 	SET_M(base, ctx, 1);
+	mb(); /* sync */
 }
 
 static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
@@ -500,7 +505,7 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 	/* Invalidate context TLB */
 	SET_CTX_TLBIALL(iommu->base, master->num, 0);
 	SET_V2PPR(iommu->base, master->num, va & V2Pxx_VA);
-
+	mb(); /* sync */
 	par = GET_PAR(iommu->base, master->num);
 
 	/* We are dealing with a supersection */
@@ -714,7 +719,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	par = GET_PAR(iommu->base, 0);
 	SET_V2PCFG(iommu->base, 0, 0);
 	SET_M(iommu->base, 0, 0);
-
+	mb(); /* sync */
 	if (!par) {
 		pr_err("Invalid PAR value detected\n");
 		ret = -ENODEV;
diff --git a/drivers/iommu/msm_iommu_hw-8xxx.h b/drivers/iommu/msm_iommu_hw-8xxx.h
index 84ba5739..161036c 100644
--- a/drivers/iommu/msm_iommu_hw-8xxx.h
+++ b/drivers/iommu/msm_iommu_hw-8xxx.h
@@ -24,10 +24,10 @@
 #define GET_CTX_REG(reg, base, ctx) \
 				(readl((base) + (reg) + ((ctx) << CTX_SHIFT)))
 
-#define SET_GLOBAL_REG(reg, base, val)	writel((val), ((base) + (reg)))
+#define SET_GLOBAL_REG(reg, base, val)	writel_relaxed((val), ((base) + (reg)))
 
 #define SET_CTX_REG(reg, base, ctx, val) \
-			writel((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
+		writel_relaxed((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
 
 /* Wrappers for numbered registers */
 #define SET_GLOBAL_REG_N(b, n, r, v) SET_GLOBAL_REG(b, ((r) + (n << 2)), (v))
@@ -48,7 +48,8 @@
 #define SET_FIELD(addr, mask, shift, v) \
 do { \
 	int t = readl(addr); \
-	writel((t & ~((mask) << (shift))) + (((v) & (mask)) << (shift)), addr);\
+	writel_relaxed((t & ~((mask) << (shift))) + \
+		       (((v) & (mask)) << (shift)), addr);\
 } while (0)
 
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
