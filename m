From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 4/5] iommu/msm: Set cacheability attributes without tex remap
Date: Wed, 12 Aug 2015 20:17:48 +0530
Message-ID: <1439390869-6347-5-git-send-email-sricharan@codeaurora.org>
References: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439390869-6347-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The cacheablity attributes are set when IOMMU_CACHE property
is true. So cachebility is set as either noncached (normal)
or cached (normal WBWA) directly and avoid setting using
tex remap.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/msm_iommu.c         | 66 +++------------------------------------
 drivers/iommu/msm_iommu_hw-8xxx.h | 10 ++----
 2 files changed, 8 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 1d95d7c..d554ffa 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -41,14 +41,9 @@ __asm__ __volatile__ (							\
 "   mrc   "   #processor "," #op1 ", %0,"  #crn "," #crm "," #op2 "\n"  \
 : "=r" (reg))
 
-#define RCP15_PRRR(reg)		MRC(reg, p15, 0, c10, c2, 0)
-#define RCP15_NMRR(reg)		MRC(reg, p15, 0, c10, c2, 1)
-
 /* bitmap of the page sizes currently supported */
 #define MSM_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
 
-static int msm_iommu_tex_class[4];
-
 DEFINE_SPINLOCK(msm_iommu_lock);
 static LIST_HEAD(qcom_iommu_devices);
 
@@ -122,8 +117,6 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
 		SET_TLBFLPTER(base, ctx, 0);
 		SET_TLBSLPTER(base, ctx, 0);
 		SET_TLBLKCR(base, ctx, 0);
-		SET_PRRR(base, ctx, 0);
-		SET_NMRR(base, ctx, 0);
 		SET_CONTEXTIDR(base, ctx, 0);
 	}
 }
@@ -232,13 +225,10 @@ static void __reset_context(void __iomem *base, int ctx)
 	SET_TLBFLPTER(base, ctx, 0);
 	SET_TLBSLPTER(base, ctx, 0);
 	SET_TLBLKCR(base, ctx, 0);
-	SET_PRRR(base, ctx, 0);
-	SET_NMRR(base, ctx, 0);
 }
 
 static void __program_context(void __iomem *base, int ctx, phys_addr_t pgtable)
 {
-	unsigned int prrr, nmrr;
 	__reset_context(base, ctx);
 
 	/* Set up HTW mode */
@@ -268,15 +258,6 @@ static void __program_context(void __iomem *base, int ctx, phys_addr_t pgtable)
 	SET_RCOSH(base, ctx, 1);
 	SET_RCNSH(base, ctx, 1);
 
-	/* Turn on TEX Remap */
-	SET_TRE(base, ctx, 1);
-
-	/* Set TEX remap attributes */
-	RCP15_PRRR(prrr);
-	RCP15_NMRR(nmrr);
-	SET_PRRR(base, ctx, prrr);
-	SET_NMRR(base, ctx, nmrr);
-
 	/* Turn on BFB prefetch */
 	SET_BFBDFE(base, ctx, 1);
 
@@ -452,7 +433,11 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long va,
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
 	sh = (prot & MSM_IOMMU_ATTR_SH) ? 1 : 0;
-	tex = msm_iommu_tex_class[prot & MSM_IOMMU_CP_MASK];
+
+	tex = TEX_0;
+
+	if (prot & IOMMU_CACHE)
+		tex |= BUFFERABLE | CACHEABLE;
 
 	if (tex < 0 || tex > NUM_TEX_CLASS - 1) {
 		ret = -EINVAL;
@@ -699,8 +684,6 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_TTBR0(base, ctx), GET_TTBR1(base, ctx));
 	pr_err("SCTLR  = %08x    ACTLR  = %08x\n",
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
-	pr_err("PRRR   = %08x    NMRR   = %08x\n",
-	       GET_PRRR(base, ctx), GET_NMRR(base, ctx));
 }
 
 static void insert_iommu_master(struct device *dev,
@@ -912,47 +895,8 @@ static void __exit msm_iommu_driver_exit(void)
 subsys_initcall(msm_iommu_driver_init);
 module_exit(msm_iommu_driver_exit);
 
-static int __init get_tex_class(int icp, int ocp, int mt, int nos)
-{
-	int i = 0;
-	unsigned int prrr = 0;
-	unsigned int nmrr = 0;
-	int c_icp, c_ocp, c_mt, c_nos;
-
-	RCP15_PRRR(prrr);
-	RCP15_NMRR(nmrr);
-
-	for (i = 0; i < NUM_TEX_CLASS; i++) {
-		c_nos = PRRR_NOS(prrr, i);
-		c_mt = PRRR_MT(prrr, i);
-		c_icp = NMRR_ICP(nmrr, i);
-		c_ocp = NMRR_OCP(nmrr, i);
-
-		if (icp == c_icp && ocp == c_ocp && c_mt == mt && c_nos == nos)
-			return i;
-	}
-
-	return -ENODEV;
-}
-
-static void __init setup_iommu_tex_classes(void)
-{
-	msm_iommu_tex_class[MSM_IOMMU_ATTR_NONCACHED] =
-			get_tex_class(CP_NONCACHED, CP_NONCACHED, MT_NORMAL, 1);
-
-	msm_iommu_tex_class[MSM_IOMMU_ATTR_CACHED_WB_WA] =
-			get_tex_class(CP_WB_WA, CP_WB_WA, MT_NORMAL, 1);
-
-	msm_iommu_tex_class[MSM_IOMMU_ATTR_CACHED_WB_NWA] =
-			get_tex_class(CP_WB_NWA, CP_WB_NWA, MT_NORMAL, 1);
-
-	msm_iommu_tex_class[MSM_IOMMU_ATTR_CACHED_WT] =
-			get_tex_class(CP_WT, CP_WT, MT_NORMAL, 1);
-}
-
 static int __init msm_iommu_init(void)
 {
-	setup_iommu_tex_classes();
 	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
 	return 0;
 }
diff --git a/drivers/iommu/msm_iommu_hw-8xxx.h b/drivers/iommu/msm_iommu_hw-8xxx.h
index fc16010..5be99cb 100644
--- a/drivers/iommu/msm_iommu_hw-8xxx.h
+++ b/drivers/iommu/msm_iommu_hw-8xxx.h
@@ -85,13 +85,9 @@ do { \
 #define SL_NG			(1 << 11)
 
 /* Memory type and cache policy attributes */
-#define MT_SO			0
-#define MT_DEV			1
-#define MT_NORMAL		2
-#define CP_NONCACHED		0
-#define CP_WB_WA		1
-#define CP_WT			2
-#define CP_WB_NWA		3
+#define BUFFERABLE		(1 << 0)
+#define CACHEABLE		(1 << 1)
+#define TEX_0			(1 << 2)
 
 /* Global register setters / getters */
 #define SET_M2VCBR_N(b, N, v)	 SET_GLOBAL_REG_N(M2VCBR_N, N, (b), (v))
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
