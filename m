From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V4 5/7] iommu/msm: use generic ARMV7S short descriptor
	pagetable ops
Date: Mon, 16 May 2016 12:18:59 +0530
Message-ID: <1463381341-30498-6-git-send-email-sricharan@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1463381341-30498-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This iommu uses the armv7 short descriptor format. So use the
generic ARMV7S pagetable ops instead of rewriting the same stuff
in the driver.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/Kconfig     |   1 +
 drivers/iommu/msm_iommu.c | 400 ++++++++++++----------------------------------
 2 files changed, 104 insertions(+), 297 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 55b2b3a..1f5d496 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -92,6 +92,7 @@ config MSM_IOMMU
 	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
 	depends on BROKEN
 	select IOMMU_API
+	select IOMMU_IO_PGTABLE_ARMV7S
 	help
 	  Support for the IOMMUs found on certain Qualcomm SOCs.
 	  These IOMMUs allow virtualization of the address space used by most
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index a90a121..f7b4c11 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -35,27 +35,27 @@
 
 #include "msm_iommu_hw-8xxx.h"
 #include "msm_iommu.h"
+#include "io-pgtable.h"
 
 #define MRC(reg, processor, op1, crn, crm, op2)				\
 __asm__ __volatile__ (							\
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
+static struct iommu_ops msm_iommu_ops;
 
 struct msm_priv {
-	unsigned long *pgtable;
 	struct list_head list_attached;
 	struct iommu_domain domain;
+	struct io_pgtable_cfg	cfg;
+	struct io_pgtable_ops	*iop;
+	struct device		*dev;
+	spinlock_t		pgtlock; /* pagetable lock */
 };
 
 static struct msm_priv *to_msm_priv(struct iommu_domain *dom)
@@ -122,49 +122,74 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
 		SET_TLBFLPTER(base, ctx, 0);
 		SET_TLBSLPTER(base, ctx, 0);
 		SET_TLBLKCR(base, ctx, 0);
-		SET_PRRR(base, ctx, 0);
-		SET_NMRR(base, ctx, 0);
 		SET_CONTEXTIDR(base, ctx, 0);
 	}
 }
 
-static int __flush_iotlb(struct iommu_domain *domain)
+static void __flush_iotlb(void *cookie)
 {
-	struct msm_priv *priv = to_msm_priv(domain);
+	struct msm_priv *priv = cookie;
 	struct msm_iommu_dev *iommu = NULL;
 	struct msm_iommu_ctx_dev *master;
 	int ret = 0;
 
-#ifndef CONFIG_IOMMU_PGTABLES_L2
-	unsigned long *fl_table = priv->pgtable;
-	int i;
+	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
+		ret = __enable_clocks(iommu);
+		if (ret)
+			goto fail;
 
-	if (!list_empty(&priv->list_attached)) {
-		dmac_flush_range(fl_table, fl_table + SZ_16K);
+		list_for_each_entry(master, &iommu->ctx_list, list)
+			SET_CTX_TLBIALL(iommu->base, master->num, 0);
 
-		for (i = 0; i < NUM_FL_PTE; i++)
-			if ((fl_table[i] & 0x03) == FL_TYPE_TABLE) {
-				void *sl_table = __va(fl_table[i] &
-								FL_BASE_MASK);
-				dmac_flush_range(sl_table, sl_table + SZ_4K);
-			}
+		__disable_clocks(iommu);
 	}
-#endif
+fail:
+	return;
+}
+
+static void __flush_iotlb_range(unsigned long iova, size_t size,
+				size_t granule, bool leaf, void *cookie)
+{
+	struct msm_priv *priv = cookie;
+	struct msm_iommu_dev *iommu = NULL;
+	struct msm_iommu_ctx_dev *master;
+	int ret = 0;
+	int temp_size;
 
 	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
 		ret = __enable_clocks(iommu);
 		if (ret)
 			goto fail;
 
-		list_for_each_entry(master, &iommu->ctx_list, list)
-			SET_CTX_TLBIALL(iommu->base, master->num, 0);
+		list_for_each_entry(master, &iommu->ctx_list, list) {
+			temp_size = size;
+			do {
+				iova &= TLBIVA_VA;
+				iova |= GET_CONTEXTIDR_ASID(iommu->base,
+							    master->num);
+				SET_TLBIVA(iommu->base, master->num, iova);
+				iova += granule;
+			} while (temp_size -= granule);
+		}
 
 		__disable_clocks(iommu);
 	}
+
 fail:
-	return ret;
+	return;
+}
+
+static void __flush_iotlb_sync(void *cookie)
+{
+	/* To avoid a null function pointer */
 }
 
+static const struct iommu_gather_ops msm_iommu_gather_ops = {
+	.tlb_flush_all = __flush_iotlb,
+	.tlb_add_flush = __flush_iotlb_range,
+	.tlb_sync = __flush_iotlb_sync,
+};
+
 static int msm_iommu_alloc_ctx(unsigned long *map, int start, int end)
 {
 	int idx;
@@ -232,15 +257,17 @@ static void __reset_context(void __iomem *base, int ctx)
 	SET_TLBFLPTER(base, ctx, 0);
 	SET_TLBSLPTER(base, ctx, 0);
 	SET_TLBLKCR(base, ctx, 0);
-	SET_PRRR(base, ctx, 0);
-	SET_NMRR(base, ctx, 0);
 }
 
-static void __program_context(void __iomem *base, int ctx, phys_addr_t pgtable)
+static void __program_context(void __iomem *base, int ctx,
+			      struct msm_priv *priv)
 {
-	unsigned int prrr, nmrr;
 	__reset_context(base, ctx);
 
+	/* Turn on TEX Remap */
+	SET_TRE(base, ctx, 1);
+	SET_AFE(base, ctx, 1);
+
 	/* Set up HTW mode */
 	/* TLB miss configuration: perform HTW on miss */
 	SET_TLBMCFG(base, ctx, 0x3);
@@ -248,8 +275,13 @@ static void __program_context(void __iomem *base, int ctx, phys_addr_t pgtable)
 	/* V2P configuration: HTW for access */
 	SET_V2PCFG(base, ctx, 0x3);
 
-	SET_TTBCR(base, ctx, 0);
-	SET_TTBR0_PA(base, ctx, (pgtable >> 14));
+	SET_TTBCR(base, ctx, priv->cfg.arm_v7s_cfg.tcr);
+	SET_TTBR0(base, ctx, priv->cfg.arm_v7s_cfg.ttbr[0]);
+	SET_TTBR1(base, ctx, priv->cfg.arm_v7s_cfg.ttbr[1]);
+
+	/* Set prrr and nmrr */
+	SET_PRRR(base, ctx, priv->cfg.arm_v7s_cfg.prrr);
+	SET_NMRR(base, ctx, priv->cfg.arm_v7s_cfg.nmrr);
 
 	/* Invalidate the TLB for this context */
 	SET_CTX_TLBIALL(base, ctx, 0);
@@ -268,38 +300,9 @@ static void __program_context(void __iomem *base, int ctx, phys_addr_t pgtable)
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
 
-#ifdef CONFIG_IOMMU_PGTABLES_L2
-	/* Configure page tables as inner-cacheable and shareable to reduce
-	 * the TLB miss penalty.
-	 */
-	SET_TTBR0_SH(base, ctx, 1);
-	SET_TTBR1_SH(base, ctx, 1);
-
-	SET_TTBR0_NOS(base, ctx, 1);
-	SET_TTBR1_NOS(base, ctx, 1);
-
-	SET_TTBR0_IRGNH(base, ctx, 0); /* WB, WA */
-	SET_TTBR0_IRGNL(base, ctx, 1);
-
-	SET_TTBR1_IRGNH(base, ctx, 0); /* WB, WA */
-	SET_TTBR1_IRGNL(base, ctx, 1);
-
-	SET_TTBR0_ORGN(base, ctx, 1); /* WB, WA */
-	SET_TTBR1_ORGN(base, ctx, 1); /* WB, WA */
-#endif
-
 	/* Enable the MMU */
 	SET_M(base, ctx, 1);
 }
@@ -316,13 +319,6 @@ static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
 		goto fail_nomem;
 
 	INIT_LIST_HEAD(&priv->list_attached);
-	priv->pgtable = (unsigned long *)__get_free_pages(GFP_KERNEL,
-							  get_order(SZ_16K));
-
-	if (!priv->pgtable)
-		goto fail_nomem;
-
-	memset(priv->pgtable, 0, SZ_16K);
 
 	priv->domain.geometry.aperture_start = 0;
 	priv->domain.geometry.aperture_end   = (1ULL << 32) - 1;
@@ -339,24 +335,35 @@ static void msm_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct msm_priv *priv;
 	unsigned long flags;
-	unsigned long *fl_table;
-	int i;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 	priv = to_msm_priv(domain);
+	kfree(priv);
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+}
 
-	fl_table = priv->pgtable;
+static int msm_iommu_domain_config(struct msm_priv *priv)
+{
+	spin_lock_init(&priv->pgtlock);
 
-	for (i = 0; i < NUM_FL_PTE; i++)
-		if ((fl_table[i] & 0x03) == FL_TYPE_TABLE)
-			free_page((unsigned long) __va(((fl_table[i]) &
-							FL_BASE_MASK)));
+	priv->cfg = (struct io_pgtable_cfg) {
+		.quirks = IO_PGTABLE_QUIRK_TLBI_ON_MAP,
+		.pgsize_bitmap = msm_iommu_ops.pgsize_bitmap,
+		.ias = 32,
+		.oas = 32,
+		.tlb = &msm_iommu_gather_ops,
+		.iommu_dev = priv->dev,
+	};
 
-	free_pages((unsigned long)priv->pgtable, get_order(SZ_16K));
-	priv->pgtable = NULL;
+	priv->iop = alloc_io_pgtable_ops(ARM_V7S, &priv->cfg, priv);
+	if (!priv->iop) {
+		dev_err(priv->dev, "Failed to allocate pgtable\n");
+		return -EINVAL;
+	}
 
-	kfree(priv);
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+	msm_iommu_ops.pgsize_bitmap = priv->cfg.pgsize_bitmap;
+
+	return 0;
 }
 
 static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -367,6 +374,9 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct msm_priv *priv = to_msm_priv(domain);
 	struct msm_iommu_ctx_dev *master;
 
+	priv->dev = dev;
+	msm_iommu_domain_config(priv);
+
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
 		master = list_first_entry(&iommu->ctx_list,
@@ -392,14 +402,13 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 					}
 				config_mids(iommu, master);
 				__program_context(iommu->base, master->num,
-						  __pa(priv->pgtable));
+						  priv);
 			}
 			__disable_clocks(iommu);
 			list_add(&iommu->dom_node, &priv->list_attached);
 		}
 	}
 
-	ret = __flush_iotlb(domain);
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
@@ -415,11 +424,9 @@ static void msm_iommu_detach_dev(struct iommu_domain *domain,
 	struct msm_iommu_ctx_dev *master;
 	int ret;
 
-	spin_lock_irqsave(&msm_iommu_lock, flags);
-	ret = __flush_iotlb(domain);
-	if (ret)
-		goto fail;
+	free_io_pgtable_ops(priv->iop);
 
+	spin_lock_irqsave(&msm_iommu_lock, flags);
 	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
 		ret = __enable_clocks(iommu);
 		if (ret)
@@ -435,190 +442,30 @@ fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 }
 
-static int msm_iommu_map(struct iommu_domain *domain, unsigned long va,
+static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t pa, size_t len, int prot)
 {
-	struct msm_priv *priv;
+	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
-	unsigned long *fl_table;
-	unsigned long *fl_pte;
-	unsigned long fl_offset;
-	unsigned long *sl_table;
-	unsigned long *sl_pte;
-	unsigned long sl_offset;
-	unsigned int pgprot;
-	int ret = 0, tex, sh;
-
-	spin_lock_irqsave(&msm_iommu_lock, flags);
-
-	sh = (prot & MSM_IOMMU_ATTR_SH) ? 1 : 0;
-	tex = msm_iommu_tex_class[prot & MSM_IOMMU_CP_MASK];
-
-	if (tex < 0 || tex > NUM_TEX_CLASS - 1) {
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	priv = to_msm_priv(domain);
-
-	fl_table = priv->pgtable;
-
-	if (len != SZ_16M && len != SZ_1M &&
-	    len != SZ_64K && len != SZ_4K) {
-		pr_debug("Bad size: %d\n", len);
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	if (!fl_table) {
-		pr_debug("Null page table\n");
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	if (len == SZ_16M || len == SZ_1M) {
-		pgprot = sh ? FL_SHARED : 0;
-		pgprot |= tex & 0x01 ? FL_BUFFERABLE : 0;
-		pgprot |= tex & 0x02 ? FL_CACHEABLE : 0;
-		pgprot |= tex & 0x04 ? FL_TEX0 : 0;
-	} else	{
-		pgprot = sh ? SL_SHARED : 0;
-		pgprot |= tex & 0x01 ? SL_BUFFERABLE : 0;
-		pgprot |= tex & 0x02 ? SL_CACHEABLE : 0;
-		pgprot |= tex & 0x04 ? SL_TEX0 : 0;
-	}
-
-	fl_offset = FL_OFFSET(va);	/* Upper 12 bits */
-	fl_pte = fl_table + fl_offset;	/* int pointers, 4 bytes */
-
-	if (len == SZ_16M) {
-		int i = 0;
-		for (i = 0; i < 16; i++)
-			*(fl_pte+i) = (pa & 0xFF000000) | FL_SUPERSECTION |
-				  FL_AP_READ | FL_AP_WRITE | FL_TYPE_SECT |
-				  FL_SHARED | FL_NG | pgprot;
-	}
-
-	if (len == SZ_1M)
-		*fl_pte = (pa & 0xFFF00000) | FL_AP_READ | FL_AP_WRITE | FL_NG |
-					    FL_TYPE_SECT | FL_SHARED | pgprot;
-
-	/* Need a 2nd level table */
-	if ((len == SZ_4K || len == SZ_64K) && (*fl_pte) == 0) {
-		unsigned long *sl;
-		sl = (unsigned long *) __get_free_pages(GFP_ATOMIC,
-							get_order(SZ_4K));
-
-		if (!sl) {
-			pr_debug("Could not allocate second level table\n");
-			ret = -ENOMEM;
-			goto fail;
-		}
-
-		memset(sl, 0, SZ_4K);
-		*fl_pte = ((((int)__pa(sl)) & FL_BASE_MASK) | FL_TYPE_TABLE);
-	}
-
-	sl_table = (unsigned long *) __va(((*fl_pte) & FL_BASE_MASK));
-	sl_offset = SL_OFFSET(va);
-	sl_pte = sl_table + sl_offset;
-
-
-	if (len == SZ_4K)
-		*sl_pte = (pa & SL_BASE_MASK_SMALL) | SL_AP0 | SL_AP1 | SL_NG |
-					  SL_SHARED | SL_TYPE_SMALL | pgprot;
-
-	if (len == SZ_64K) {
-		int i;
+	int ret;
 
-		for (i = 0; i < 16; i++)
-			*(sl_pte+i) = (pa & SL_BASE_MASK_LARGE) | SL_AP0 |
-			    SL_NG | SL_AP1 | SL_SHARED | SL_TYPE_LARGE | pgprot;
-	}
+	spin_lock_irqsave(&priv->pgtlock, flags);
+	ret = priv->iop->map(priv->iop, iova, pa, len, prot);
+	spin_unlock_irqrestore(&priv->pgtlock, flags);
 
-	ret = __flush_iotlb(domain);
-fail:
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 	return ret;
 }
 
-static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long va,
-			    size_t len)
+static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
+			      size_t len)
 {
-	struct msm_priv *priv;
+	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
-	unsigned long *fl_table;
-	unsigned long *fl_pte;
-	unsigned long fl_offset;
-	unsigned long *sl_table;
-	unsigned long *sl_pte;
-	unsigned long sl_offset;
-	int i, ret = 0;
-
-	spin_lock_irqsave(&msm_iommu_lock, flags);
-
-	priv = to_msm_priv(domain);
 
-	fl_table = priv->pgtable;
+	spin_lock_irqsave(&priv->pgtlock, flags);
+	len = priv->iop->unmap(priv->iop, iova, len);
+	spin_unlock_irqrestore(&priv->pgtlock, flags);
 
-	if (len != SZ_16M && len != SZ_1M &&
-	    len != SZ_64K && len != SZ_4K) {
-		pr_debug("Bad length: %d\n", len);
-		goto fail;
-	}
-
-	if (!fl_table) {
-		pr_debug("Null page table\n");
-		goto fail;
-	}
-
-	fl_offset = FL_OFFSET(va);	/* Upper 12 bits */
-	fl_pte = fl_table + fl_offset;	/* int pointers, 4 bytes */
-
-	if (*fl_pte == 0) {
-		pr_debug("First level PTE is 0\n");
-		goto fail;
-	}
-
-	/* Unmap supersection */
-	if (len == SZ_16M)
-		for (i = 0; i < 16; i++)
-			*(fl_pte+i) = 0;
-
-	if (len == SZ_1M)
-		*fl_pte = 0;
-
-	sl_table = (unsigned long *) __va(((*fl_pte) & FL_BASE_MASK));
-	sl_offset = SL_OFFSET(va);
-	sl_pte = sl_table + sl_offset;
-
-	if (len == SZ_64K) {
-		for (i = 0; i < 16; i++)
-			*(sl_pte+i) = 0;
-	}
-
-	if (len == SZ_4K)
-		*sl_pte = 0;
-
-	if (len == SZ_4K || len == SZ_64K) {
-		int used = 0;
-
-		for (i = 0; i < NUM_SL_PTE; i++)
-			if (sl_table[i])
-				used = 1;
-		if (!used) {
-			free_page((unsigned long)sl_table);
-			*fl_pte = 0;
-		}
-	}
-
-	ret = __flush_iotlb(domain);
-
-fail:
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-
-	/* the IOMMU API requires us to return how many bytes were unmapped */
-	len = ret ? 0 : len;
 	return len;
 }
 
@@ -699,8 +546,6 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_TTBR0(base, ctx), GET_TTBR1(base, ctx));
 	pr_err("SCTLR  = %08x    ACTLR  = %08x\n",
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
-	pr_err("PRRR   = %08x    NMRR   = %08x\n",
-	       GET_PRRR(base, ctx), GET_NMRR(base, ctx));
 }
 
 static void insert_iommu_master(struct device *dev,
@@ -941,47 +786,8 @@ static void __exit msm_iommu_driver_exit(void)
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
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
