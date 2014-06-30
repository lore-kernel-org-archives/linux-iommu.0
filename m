From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [RFC/PATCH 5/7] iommu: msm: Add support for V7L page table format
Date: Mon, 30 Jun 2014 09:51:54 -0700
Message-ID: <1404147116-4598-6-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com, thierry.reding@gmail.com, joro@8bytes.org, vgandhi@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Add support for VMSA long descriptor page table format (V7L) supporting the
following features:

    - ARM V7L page table format independent of ARM CPU page table format
    - 4K/64K/2M/32M/1G mappings (V7L)

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 .../devicetree/bindings/iommu/msm,iommu_v1.txt     |   4 +
 drivers/iommu/Kconfig                              |  10 +
 drivers/iommu/Makefile                             |   4 +
 drivers/iommu/msm_iommu-v1.c                       |  65 ++
 drivers/iommu/msm_iommu.c                          |  47 ++
 drivers/iommu/msm_iommu_dev-v1.c                   |   5 +
 drivers/iommu/msm_iommu_hw-v1.h                    |  86 +++
 drivers/iommu/msm_iommu_pagetable_lpae.c           | 717 +++++++++++++++++++++
 drivers/iommu/msm_iommu_priv.h                     |  12 +-
 9 files changed, 949 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/msm_iommu_pagetable_lpae.c

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt b/Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
index 412ed44..c0a8f6c 100644
--- a/Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
+++ b/Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
@@ -38,6 +38,10 @@ Optional properties:
   qcom,iommu-bfb-regs property. If this property is present, the
   qcom,iommu-bfb-regs property shall also be present, and the lengths of both
   properties shall be the same.
+- qcom,iommu-lpae-bfb-regs : See description for qcom,iommu-bfb-regs. This is
+  the same property except this is for IOMMU with LPAE enabled.
+- qcom,iommu-lpae-bfb-data : See description for qcom,iommu-bfb-data. This is
+  the same property except this is for IOMMU with LPAE enabled.
 
 Example:
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e972127..9053908 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -63,6 +63,16 @@ config MSM_IOMMU_V1
 
 	  If unsure, say N here.
 
+config MSM_IOMMU_LPAE
+	bool "Enable support for LPAE in IOMMU"
+	depends on MSM_IOMMU
+	help
+	  Enables Large Physical Address Extension (LPAE) for IOMMU. This allows
+	  clients of IOMMU to access physical addresses that are greater than
+	  32 bits.
+
+	  If unsure, say N here.
+
 config MSM_IOMMU_VBIF_CHECK
 	bool "Enable support for VBIF check when IOMMU gets stuck"
 	depends on MSM_IOMMU
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1f98fcc..debb251 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,7 +3,11 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU_V0) += msm_iommu-v0.o msm_iommu_dev-v0.o
 obj-$(CONFIG_MSM_IOMMU_V1) += msm_iommu-v1.o msm_iommu_dev-v1.o msm_iommu.o
+ifdef CONFIG_MSM_IOMMU_LPAE
+obj-$(CONFIG_MSM_IOMMU_V1) += msm_iommu_pagetable_lpae.o
+else
 obj-$(CONFIG_MSM_IOMMU_V1) += msm_iommu_pagetable.o
+endif
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
diff --git a/drivers/iommu/msm_iommu-v1.c b/drivers/iommu/msm_iommu-v1.c
index 046c3cf..2c574ef 100644
--- a/drivers/iommu/msm_iommu-v1.c
+++ b/drivers/iommu/msm_iommu-v1.c
@@ -35,8 +35,13 @@
 #include "msm_iommu_priv.h"
 #include "msm_iommu_pagetable.h"
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+/* bitmap of the page sizes currently supported */
+#define MSM_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_2M | SZ_32M | SZ_1G)
+#else
 /* bitmap of the page sizes currently supported */
 #define MSM_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
+#endif
 
 #define IOMMU_MSEC_STEP		10
 #define IOMMU_MSEC_TIMEOUT	5000
@@ -461,11 +466,19 @@ static void __release_SMT(u32 cb_num, void __iomem *base)
 	}
 }
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+static void msm_iommu_set_ASID(void __iomem *base, unsigned int ctx_num,
+			       unsigned int asid)
+{
+	SET_CB_TTBR0_ASID(base, ctx_num, asid);
+}
+#else
 static void msm_iommu_set_ASID(void __iomem *base, unsigned int ctx_num,
 			       unsigned int asid)
 {
 	SET_CB_CONTEXTIDR_ASID(base, ctx_num, asid);
 }
+#endif
 
 static void msm_iommu_assign_ASID(const struct msm_iommu_drvdata *iommu_drvdata,
 				  struct msm_iommu_master *master,
@@ -503,6 +516,38 @@ static void msm_iommu_assign_ASID(const struct msm_iommu_drvdata *iommu_drvdata,
 	msm_iommu_set_ASID(cb_base, master->cb_num, master->asid);
 }
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+static void msm_iommu_setup_ctx(void __iomem *base, unsigned int ctx)
+{
+	SET_CB_TTBCR_EAE(base, ctx, 1); /* Extended Address Enable (EAE) */
+}
+
+static void msm_iommu_setup_memory_remap(void __iomem *base, unsigned int ctx)
+{
+	SET_CB_MAIR0(base, ctx, msm_iommu_get_mair0());
+	SET_CB_MAIR1(base, ctx, msm_iommu_get_mair1());
+}
+
+static void msm_iommu_setup_pg_l2_redirect(void __iomem *base, unsigned int ctx)
+{
+	/*
+	 * Configure page tables as inner-cacheable and shareable to reduce
+	 * the TLB miss penalty.
+	 */
+	SET_CB_TTBCR_SH0(base, ctx, 3); /* Inner shareable */
+	SET_CB_TTBCR_ORGN0(base, ctx, 1); /* outer cachable*/
+	SET_CB_TTBCR_IRGN0(base, ctx, 1); /* inner cachable*/
+	SET_CB_TTBCR_T0SZ(base, ctx, 0); /* 0GB-4GB */
+
+
+	SET_CB_TTBCR_SH1(base, ctx, 3); /* Inner shareable */
+	SET_CB_TTBCR_ORGN1(base, ctx, 1); /* outer cachable*/
+	SET_CB_TTBCR_IRGN1(base, ctx, 1); /* inner cachable*/
+	SET_CB_TTBCR_T1SZ(base, ctx, 0); /* TTBR1 not used */
+}
+
+#else
+
 static void msm_iommu_setup_ctx(void __iomem *base, unsigned int ctx)
 {
 	/* Turn on TEX Remap */
@@ -527,6 +572,8 @@ static void msm_iommu_setup_pg_l2_redirect(void __iomem *base, unsigned int ctx)
 	SET_CB_TTBR0_RGN(base, ctx, 1);   /* WB, WA */
 }
 
+#endif
+
 static int program_SMT(struct msm_iommu_master *master, void __iomem *base)
 {
 	u32 *sids = master->sids;
@@ -915,6 +962,15 @@ static int msm_iommu_unmap_range(struct iommu_domain *domain, unsigned int va,
 	return 0;
 }
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+static phys_addr_t msm_iommu_get_phy_from_PAR(unsigned long va, u64 par)
+{
+	phys_addr_t phy;
+	/* Upper 28 bits from PAR, lower 12 from VA */
+	phy = (par & 0xFFFFFFF000ULL) | (va & 0x00000FFF);
+	return phy;
+}
+#else
 static phys_addr_t msm_iommu_get_phy_from_PAR(unsigned long va, u64 par)
 {
 	phys_addr_t phy;
@@ -927,6 +983,7 @@ static phys_addr_t msm_iommu_get_phy_from_PAR(unsigned long va, u64 par)
 
 	return phy;
 }
+#endif
 
 static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 					  phys_addr_t va)
@@ -1013,11 +1070,19 @@ static int msm_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+static inline void print_ctx_mem_attr_regs(struct msm_iommu_context_reg regs[])
+{
+	pr_err("MAIR0   = %08x    MAIR1   = %08x\n",
+		 regs[DUMP_REG_MAIR0].val, regs[DUMP_REG_MAIR1].val);
+}
+#else
 static inline void print_ctx_mem_attr_regs(struct msm_iommu_context_reg regs[])
 {
 	pr_err("PRRR   = %08x    NMRR   = %08x\n",
 		 regs[DUMP_REG_PRRR].val, regs[DUMP_REG_NMRR].val);
 }
+#endif
 
 void print_ctx_regs(struct msm_iommu_context_reg regs[])
 {
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 5c7981e..34fe73a 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -105,7 +105,49 @@ struct msm_iommu_master *msm_iommu_find_master(struct msm_iommu_drvdata *drv,
 }
 
 #ifdef CONFIG_ARM
+#ifdef CONFIG_MSM_IOMMU_LPAE
 #ifdef CONFIG_ARM_LPAE
+/*
+ * If CONFIG_ARM_LPAE AND CONFIG_MSM_IOMMU_LPAE are enabled we can use the MAIR
+ * register directly
+ */
+u32 msm_iommu_get_mair0(void)
+{
+	unsigned int mair0;
+
+	RCP15_MAIR0(mair0);
+	return mair0;
+}
+
+u32 msm_iommu_get_mair1(void)
+{
+	unsigned int mair1;
+
+	RCP15_MAIR1(mair1);
+	return mair1;
+}
+#else
+/*
+ * However, If CONFIG_ARM_LPAE is not enabled but CONFIG_MSM_IOMMU_LPAE is enabled
+ * we'll just use the hard coded values directly..
+ */
+u32 msm_iommu_get_mair0(void)
+{
+	return MAIR0_VALUE;
+}
+
+u32 msm_iommu_get_mair1(void)
+{
+	return MAIR1_VALUE;
+}
+#endif
+
+#else
+#ifdef CONFIG_ARM_LPAE
+/*
+ * If CONFIG_ARM_LPAE is enabled AND CONFIG_MSM_IOMMU_LPAE is disabled
+ * we must use the hardcoded values.
+ */
 u32 msm_iommu_get_prrr(void)
 {
 	return PRRR_VALUE;
@@ -116,6 +158,10 @@ u32 msm_iommu_get_nmrr(void)
 	return NMRR_VALUE;
 }
 #else
+/*
+ * If both CONFIG_ARM_LPAE AND CONFIG_MSM_IOMMU_LPAE are disabled
+ * we can use the registers directly.
+ */
 #define RCP15_PRRR(reg)		MRC(reg, p15, 0, c10, c2, 0)
 #define RCP15_NMRR(reg)		MRC(reg, p15, 0, c10, c2, 1)
 
@@ -136,6 +182,7 @@ u32 msm_iommu_get_nmrr(void)
 }
 #endif
 #endif
+#endif
 #ifdef CONFIG_ARM64
 u32 msm_iommu_get_prrr(void)
 {
diff --git a/drivers/iommu/msm_iommu_dev-v1.c b/drivers/iommu/msm_iommu_dev-v1.c
index c1fa732..30f6b07 100644
--- a/drivers/iommu/msm_iommu_dev-v1.c
+++ b/drivers/iommu/msm_iommu_dev-v1.c
@@ -28,8 +28,13 @@
 
 #include "msm_iommu_hw-v1.h"
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+static const char *BFB_REG_NODE_NAME = "qcom,iommu-lpae-bfb-regs";
+static const char *BFB_DATA_NODE_NAME = "qcom,iommu-lpae-bfb-data";
+#else
 static const char *BFB_REG_NODE_NAME = "qcom,iommu-bfb-regs";
 static const char *BFB_DATA_NODE_NAME = "qcom,iommu-bfb-data";
+#endif
 
 static int msm_iommu_parse_bfb_settings(struct platform_device *pdev,
 				    struct msm_iommu_drvdata *drvdata)
diff --git a/drivers/iommu/msm_iommu_hw-v1.h b/drivers/iommu/msm_iommu_hw-v1.h
index f26ca7c..64e951e 100644
--- a/drivers/iommu/msm_iommu_hw-v1.h
+++ b/drivers/iommu/msm_iommu_hw-v1.h
@@ -924,6 +924,7 @@ do { \
 			GET_CONTEXT_FIELD(b, c, CB_TLBSTATUS, SACTIVE)
 
 /* Translation Table Base Control Register: CB_TTBCR */
+/* These are shared between VMSA and LPAE */
 #define GET_CB_TTBCR_EAE(b, c)       GET_CONTEXT_FIELD(b, c, CB_TTBCR, EAE)
 #define SET_CB_TTBCR_EAE(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_TTBCR, EAE, v)
 
@@ -937,6 +938,54 @@ do { \
 #define GET_CB_TTBCR_NSCFG1(b, c)    \
 			GET_CONTEXT_FIELD(b, c, CB_TTBCR, NSCFG1)
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+
+/* LPAE format */
+
+/* Translation Table Base Register 0: CB_TTBR */
+#define SET_TTBR0(b, c, v)       SET_CTX_REG_Q(CB_TTBR0, (b), (c), (v))
+#define SET_TTBR1(b, c, v)       SET_CTX_REG_Q(CB_TTBR1, (b), (c), (v))
+
+#define SET_CB_TTBR0_ASID(b, c, v)  SET_CONTEXT_FIELD_Q(b, c, CB_TTBR0, ASID, v)
+#define SET_CB_TTBR0_ADDR(b, c, v)  SET_CONTEXT_FIELD_Q(b, c, CB_TTBR0, ADDR, v)
+
+#define GET_CB_TTBR0_ASID(b, c)     GET_CONTEXT_FIELD_Q(b, c, CB_TTBR0, ASID)
+#define GET_CB_TTBR0_ADDR(b, c)     GET_CONTEXT_FIELD_Q(b, c, CB_TTBR0, ADDR)
+#define GET_CB_TTBR0(b, c)          GET_CTX_REG_Q(CB_TTBR0, (b), (c))
+
+/* Translation Table Base Control Register: CB_TTBCR */
+#define SET_CB_TTBCR_T0SZ(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBCR, T0SZ, v)
+#define SET_CB_TTBCR_T1SZ(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBCR, T1SZ, v)
+#define SET_CB_TTBCR_EPD0(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBCR, EPD0, v)
+#define SET_CB_TTBCR_EPD1(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBCR, EPD1, v)
+#define SET_CB_TTBCR_IRGN0(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_TTBCR, IRGN0, v)
+#define SET_CB_TTBCR_IRGN1(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_TTBCR, IRGN1, v)
+#define SET_CB_TTBCR_ORGN0(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_TTBCR, ORGN0, v)
+#define SET_CB_TTBCR_ORGN1(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_TTBCR, ORGN1, v)
+#define SET_CB_TTBCR_NSCFG0(b, c, v) \
+				SET_CONTEXT_FIELD(b, c, CB_TTBCR, NSCFG0, v)
+#define SET_CB_TTBCR_NSCFG1(b, c, v) \
+				SET_CONTEXT_FIELD(b, c, CB_TTBCR, NSCFG1, v)
+
+#define SET_CB_TTBCR_SH0(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_TTBCR, SH0, v)
+#define SET_CB_TTBCR_SH1(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_TTBCR, SH1, v)
+#define SET_CB_TTBCR_A1(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_TTBCR, A1, v)
+
+#define GET_CB_TTBCR_T0SZ(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBCR, T0SZ)
+#define GET_CB_TTBCR_T1SZ(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBCR, T1SZ)
+#define GET_CB_TTBCR_EPD0(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBCR, EPD0)
+#define GET_CB_TTBCR_EPD1(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBCR, EPD1)
+#define GET_CB_TTBCR_IRGN0(b, c, v)  GET_CONTEXT_FIELD(b, c, CB_TTBCR, IRGN0)
+#define GET_CB_TTBCR_IRGN1(b, c, v)  GET_CONTEXT_FIELD(b, c, CB_TTBCR, IRGN1)
+#define GET_CB_TTBCR_ORGN0(b, c, v)  GET_CONTEXT_FIELD(b, c, CB_TTBCR, ORGN0)
+#define GET_CB_TTBCR_ORGN1(b, c, v) GET_CONTEXT_FIELD(b, c, CB_TTBCR, ORGN1)
+
+#define SET_CB_MAIR0(b, c, v)        SET_CTX_REG(CB_MAIR0, (b), (c), (v))
+#define SET_CB_MAIR1(b, c, v)        SET_CTX_REG(CB_MAIR1, (b), (c), (v))
+
+#define GET_CB_MAIR0(b, c)           GET_CTX_REG(CB_MAIR0, (b), (c))
+#define GET_CB_MAIR1(b, c)           GET_CTX_REG(CB_MAIR1, (b), (c))
+#else
 #define SET_TTBR0(b, c, v)           SET_CTX_REG(CB_TTBR0, (b), (c), (v))
 #define SET_TTBR1(b, c, v)           SET_CTX_REG(CB_TTBR1, (b), (c), (v))
 
@@ -956,6 +1005,7 @@ do { \
 #define GET_CB_TTBR0_NOS(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBR0, NOS)
 #define GET_CB_TTBR0_IRGN0(b, c)    GET_CONTEXT_FIELD(b, c, CB_TTBR0, IRGN0)
 #define GET_CB_TTBR0_ADDR(b, c)     GET_CONTEXT_FIELD(b, c, CB_TTBR0, ADDR)
+#endif
 
 /* Translation Table Base Register 1: CB_TTBR1 */
 #define SET_CB_TTBR1_IRGN1(b, c, v) SET_CONTEXT_FIELD(b, c, CB_TTBR1, IRGN1, v)
@@ -1439,6 +1489,28 @@ do { \
 
 #define CB_TTBR0_ADDR        (CB_TTBR0_ADDR_MASK    << CB_TTBR0_ADDR_SHIFT)
 
+#ifdef CONFIG_MSM_IOMMU_LPAE
+/* Translation Table Base Register: CB_TTBR */
+#define CB_TTBR0_ASID        (CB_TTBR0_ASID_MASK    << CB_TTBR0_ASID_SHIFT)
+#define CB_TTBR1_ASID        (CB_TTBR1_ASID_MASK    << CB_TTBR1_ASID_SHIFT)
+
+/* Translation Table Base Control Register: CB_TTBCR */
+#define CB_TTBCR_T0SZ        (CB_TTBCR_T0SZ_MASK    << CB_TTBCR_T0SZ_SHIFT)
+#define CB_TTBCR_T1SZ        (CB_TTBCR_T1SZ_MASK    << CB_TTBCR_T1SZ_SHIFT)
+#define CB_TTBCR_EPD0        (CB_TTBCR_EPD0_MASK    << CB_TTBCR_EPD0_SHIFT)
+#define CB_TTBCR_EPD1        (CB_TTBCR_EPD1_MASK    << CB_TTBCR_EPD1_SHIFT)
+#define CB_TTBCR_IRGN0       (CB_TTBCR_IRGN0_MASK   << CB_TTBCR_IRGN0_SHIFT)
+#define CB_TTBCR_IRGN1       (CB_TTBCR_IRGN1_MASK   << CB_TTBCR_IRGN1_SHIFT)
+#define CB_TTBCR_ORGN0       (CB_TTBCR_ORGN0_MASK   << CB_TTBCR_ORGN0_SHIFT)
+#define CB_TTBCR_ORGN1       (CB_TTBCR_ORGN1_MASK   << CB_TTBCR_ORGN1_SHIFT)
+#define CB_TTBCR_NSCFG0      (CB_TTBCR_NSCFG0_MASK  << CB_TTBCR_NSCFG0_SHIFT)
+#define CB_TTBCR_NSCFG1      (CB_TTBCR_NSCFG1_MASK  << CB_TTBCR_NSCFG1_SHIFT)
+#define CB_TTBCR_SH0         (CB_TTBCR_SH0_MASK     << CB_TTBCR_SH0_SHIFT)
+#define CB_TTBCR_SH1         (CB_TTBCR_SH1_MASK     << CB_TTBCR_SH1_SHIFT)
+#define CB_TTBCR_A1          (CB_TTBCR_A1_MASK      << CB_TTBCR_A1_SHIFT)
+
+#else
+
 /* Translation Table Base Register 0: CB_TTBR0 */
 #define CB_TTBR0_IRGN1       (CB_TTBR0_IRGN1_MASK   << CB_TTBR0_IRGN1_SHIFT)
 #define CB_TTBR0_S           (CB_TTBR0_S_MASK       << CB_TTBR0_S_SHIFT)
@@ -1452,6 +1524,7 @@ do { \
 #define CB_TTBR1_RGN         (CB_TTBR1_RGN_MASK     << CB_TTBR1_RGN_SHIFT)
 #define CB_TTBR1_NOS         (CB_TTBR1_NOS_MASK     << CB_TTBR1_NOS_SHIFT)
 #define CB_TTBR1_IRGN0       (CB_TTBR1_IRGN0_MASK   << CB_TTBR1_IRGN0_SHIFT)
+#endif
 
 /* Global Register Masks */
 /* Configuration Register 0 */
@@ -1830,6 +1903,12 @@ do { \
 #define CB_TTBCR_A1_MASK           0x01
 #define CB_TTBCR_EAE_MASK          0x01
 
+/* Translation Table Base Register 0/1: CB_TTBR */
+#ifdef CONFIG_MSM_IOMMU_LPAE
+#define CB_TTBR0_ADDR_MASK         0x7FFFFFFFFULL
+#define CB_TTBR0_ASID_MASK         0xFF
+#define CB_TTBR1_ASID_MASK         0xFF
+#else
 #define CB_TTBR0_IRGN1_MASK        0x01
 #define CB_TTBR0_S_MASK            0x01
 #define CB_TTBR0_RGN_MASK          0x01
@@ -1842,6 +1921,7 @@ do { \
 #define CB_TTBR1_RGN_MASK          0x1
 #define CB_TTBR1_NOS_MASK          0X1
 #define CB_TTBR1_IRGN0_MASK        0X1
+#endif
 
 /* Global Register Shifts */
 /* Configuration Register: CR0 */
@@ -2219,6 +2299,11 @@ do { \
 #define CB_TTBCR_SH1_SHIFT          28
 
 /* Translation Table Base Register 0/1: CB_TTBR */
+#ifdef CONFIG_MSM_IOMMU_LPAE
+#define CB_TTBR0_ADDR_SHIFT         5
+#define CB_TTBR0_ASID_SHIFT         48
+#define CB_TTBR1_ASID_SHIFT         48
+#else
 #define CB_TTBR0_IRGN1_SHIFT        0
 #define CB_TTBR0_S_SHIFT            1
 #define CB_TTBR0_RGN_SHIFT          3
@@ -2232,5 +2317,6 @@ do { \
 #define CB_TTBR1_NOS_SHIFT          5
 #define CB_TTBR1_IRGN0_SHIFT        6
 #define CB_TTBR1_ADDR_SHIFT         14
+#endif
 
 #endif
diff --git a/drivers/iommu/msm_iommu_pagetable_lpae.c b/drivers/iommu/msm_iommu_pagetable_lpae.c
new file mode 100644
index 0000000..60908a8
--- /dev/null
+++ b/drivers/iommu/msm_iommu_pagetable_lpae.c
@@ -0,0 +1,717 @@
+/* Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/errno.h>
+#include <linux/iommu.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+
+#include <asm/cacheflush.h>
+
+#include "msm_iommu_priv.h"
+#include "msm_iommu_pagetable.h"
+
+#define NUM_FL_PTE      4   /* First level */
+#define NUM_SL_PTE      512 /* Second level */
+#define NUM_TL_PTE      512 /* Third level */
+
+#define PTE_SIZE	8
+
+#define FL_ALIGN	0x20
+
+/* First-level/second-level page table bits */
+#define FL_OFFSET(va)           (((va) & 0xC0000000) >> 30)
+
+#define FLSL_BASE_MASK            (0xFFFFFFF000ULL)
+#define FLSL_1G_BLOCK_MASK        (0xFFC0000000ULL)
+#define FLSL_BLOCK_MASK           (0xFFFFE00000ULL)
+#define FLSL_TYPE_BLOCK           (1 << 0)
+#define FLSL_TYPE_TABLE           (3 << 0)
+#define FLSL_PTE_TYPE_MASK        (3 << 0)
+#define FLSL_APTABLE_RO           (2 << 61)
+#define FLSL_APTABLE_RW           (0 << 61)
+
+#define FL_TYPE_SECT              (2 << 0)
+#define FL_SUPERSECTION           (1 << 18)
+#define FL_AP0                    (1 << 10)
+#define FL_AP1                    (1 << 11)
+#define FL_AP2                    (1 << 15)
+#define FL_SHARED                 (1 << 16)
+#define FL_BUFFERABLE             (1 << 2)
+#define FL_CACHEABLE              (1 << 3)
+#define FL_TEX0                   (1 << 12)
+#define FL_NG                     (1 << 17)
+
+/* Second-level page table bits */
+#define SL_OFFSET(va)             (((va) & 0x3FE00000) >> 21)
+
+/* Third-level page table bits */
+#define TL_OFFSET(va)             (((va) & 0x1FF000) >> 12)
+
+#define TL_TYPE_PAGE              (3 << 0)
+#define TL_PAGE_MASK              (0xFFFFFFF000ULL)
+#define TL_ATTR_INDEX_MASK        (0x7)
+#define TL_ATTR_INDEX_SHIFT       (0x2)
+#define TL_NS                     (0x1 << 5)
+#define TL_AP_RO                  (0x3 << 6) /* Access Permission: R */
+#define TL_AP_RW                  (0x1 << 6) /* Access Permission: RW */
+#define TL_SH_ISH                 (0x3 << 8) /* Inner shareable */
+#define TL_SH_OSH                 (0x2 << 8) /* Outer shareable */
+#define TL_SH_NSH                 (0x0 << 8) /* Non-shareable */
+#define TL_AF                     (0x1 << 10)  /* Access Flag */
+#define TL_NG                     (0x1 << 11) /* Non-Global */
+#define TL_CH                     (0x1ULL << 52) /* Contiguous hint */
+#define TL_PXN                    (0x1ULL << 53) /* Privilege Execute Never */
+#define TL_XN                     (0x1ULL << 54) /* Execute Never */
+
+/* normal non-cacheable */
+#define PTE_MT_BUFFERABLE         (1 << 2)
+/* normal inner write-alloc */
+#define PTE_MT_WRITEALLOC         (7 << 2)
+
+#define PTE_MT_MASK               (7 << 2)
+
+#define FOLLOW_TO_NEXT_TABLE(pte) ((u64 *) __va(((*pte) & FLSL_BASE_MASK)))
+
+static void __msm_iommu_pagetable_unmap_range(struct msm_iommu_pt *pt, u32 va,
+					      u32 len, u32 silent);
+
+static inline void clean_pte(u64 *start, u64 *end,
+				s32 redirect)
+{
+	if (!redirect)
+		dmac_flush_range(start, end);
+}
+
+s32 msm_iommu_pagetable_alloc(struct msm_iommu_pt *pt)
+{
+	u32 size = PTE_SIZE * NUM_FL_PTE + FL_ALIGN;
+	phys_addr_t fl_table_phys;
+
+	pt->unaligned_fl_table = kzalloc(size, GFP_KERNEL);
+	if (!pt->unaligned_fl_table)
+		return -ENOMEM;
+
+
+	fl_table_phys = virt_to_phys(pt->unaligned_fl_table);
+	fl_table_phys = ALIGN(fl_table_phys, FL_ALIGN);
+	pt->fl_table = phys_to_virt(fl_table_phys);
+
+	pt->sl_table_shadow = kcalloc(NUM_FL_PTE, sizeof(u64 *), GFP_KERNEL);
+	if (!pt->sl_table_shadow) {
+		kfree(pt->unaligned_fl_table);
+		return -ENOMEM;
+	}
+	clean_pte(pt->fl_table, pt->fl_table + NUM_FL_PTE, pt->redirect);
+	return 0;
+}
+
+void msm_iommu_pagetable_free(struct msm_iommu_pt *pt)
+{
+	s32 i;
+	u64 *fl_table = pt->fl_table;
+
+	for (i = 0; i < NUM_FL_PTE; ++i) {
+		if ((fl_table[i] & FLSL_TYPE_TABLE) == FLSL_TYPE_TABLE) {
+			u64 p = fl_table[i] & FLSL_BASE_MASK;
+
+			free_page((u32)phys_to_virt(p));
+		}
+		if ((pt->sl_table_shadow[i]))
+			free_page((u32)pt->sl_table_shadow[i]);
+	}
+	kfree(pt->unaligned_fl_table);
+
+	pt->unaligned_fl_table = 0;
+	pt->fl_table = 0;
+
+	kfree(pt->sl_table_shadow);
+}
+
+void msm_iommu_pagetable_free_tables(struct msm_iommu_pt *pt, unsigned long va,
+				 size_t len)
+{
+	/*
+	 * Adding 2 for worst case. We could be spanning 3 second level pages
+	 * if we unmapped just over 2MB.
+	 */
+	u32 n_entries = len / SZ_2M + 2;
+	u32 fl_offset = FL_OFFSET(va);
+	u32 sl_offset = SL_OFFSET(va);
+	u32 i;
+
+	for (i = 0; i < n_entries && fl_offset < NUM_FL_PTE; ++i) {
+		void *tl_table_va;
+		u32 entry;
+		u64 *sl_pte_shadow;
+
+		sl_pte_shadow = pt->sl_table_shadow[fl_offset];
+		if (!sl_pte_shadow)
+			break;
+		sl_pte_shadow += sl_offset;
+		entry = *sl_pte_shadow;
+		tl_table_va = __va(((*sl_pte_shadow) & ~0xFFF));
+
+		if (entry && !(entry & 0xFFF)) {
+			free_page((unsigned long)tl_table_va);
+			*sl_pte_shadow = 0;
+		}
+		++sl_offset;
+		if (sl_offset >= NUM_TL_PTE) {
+			sl_offset = 0;
+			++fl_offset;
+		}
+	}
+}
+
+
+#ifdef CONFIG_ARM_LPAE
+/*
+ * If LPAE is enabled in the ARM processor then just use the same
+ * cache policy as the kernel for the SMMU cached mappings.
+ */
+static inline u32 __get_cache_attr(void)
+{
+	return pgprot_kernel & PTE_MT_MASK;
+}
+#else
+/*
+ * If LPAE is NOT enabled in the ARM processor then hard code the policy.
+ * This is mostly for debugging so that we can enable SMMU LPAE without
+ * ARM CPU LPAE.
+ */
+static inline u32 __get_cache_attr(void)
+{
+	return PTE_MT_WRITEALLOC;
+}
+
+#endif
+
+/*
+ * Get the IOMMU attributes for the ARM LPAE long descriptor format page
+ * table entry bits. The only upper attribute bits we currently use is the
+ * contiguous bit which is set when we actually have a contiguous mapping.
+ * Lower attribute bits specify memory attributes and the protection
+ * (Read/Write/Execute).
+ */
+static inline void __get_attr(s32 prot, u64 *upper_attr, u64 *lower_attr)
+{
+	u32 attr_idx = PTE_MT_BUFFERABLE;
+
+	*upper_attr = 0;
+	*lower_attr = 0;
+
+	if (!(prot & (IOMMU_READ | IOMMU_WRITE))) {
+		prot |= IOMMU_READ | IOMMU_WRITE;
+		WARN_ONCE(1, "No attributes in iommu mapping; assuming RW\n");
+	}
+
+	if ((prot & IOMMU_WRITE) && !(prot & IOMMU_READ)) {
+		prot |= IOMMU_READ;
+		WARN_ONCE(1, "Write-only unsupported; falling back to RW\n");
+	}
+
+	if (prot & IOMMU_CACHE)
+		attr_idx = __get_cache_attr();
+
+	*lower_attr |= attr_idx;
+	*lower_attr |= TL_NG | TL_AF;
+	*lower_attr |= (prot & IOMMU_CACHE) ? TL_SH_ISH : TL_SH_NSH;
+	*lower_attr |= (prot & IOMMU_WRITE) ? TL_AP_RW : TL_AP_RO;
+}
+
+static inline u64 *make_second_level_tbl(struct msm_iommu_pt *pt, u32 offset)
+{
+	u64 *sl = (u64 *) __get_free_page(GFP_KERNEL);
+	u64 *fl_pte = pt->fl_table + offset;
+
+	if (!sl) {
+		pr_err("Could not allocate second level table\n");
+		goto fail;
+	}
+
+	pt->sl_table_shadow[offset] = (u64 *) __get_free_page(GFP_KERNEL);
+	if (!pt->sl_table_shadow[offset]) {
+		free_page((u32) sl);
+		pr_err("Could not allocate second level shadow table\n");
+		goto fail;
+	}
+
+	memset(sl, 0, SZ_4K);
+	memset(pt->sl_table_shadow[offset], 0, SZ_4K);
+	clean_pte(sl, sl + NUM_SL_PTE, pt->redirect);
+
+	/* Leave APTable bits 0 to let next level decide access permissinons */
+	*fl_pte = (((phys_addr_t)__pa(sl)) & FLSL_BASE_MASK) | FLSL_TYPE_TABLE;
+	clean_pte(fl_pte, fl_pte + 1, pt->redirect);
+fail:
+	return sl;
+}
+
+static inline u64 *make_third_level_tbl(s32 redirect, u64 *sl_pte,
+					u64 *sl_pte_shadow)
+{
+	u64 *tl = (u64 *) __get_free_page(GFP_KERNEL);
+
+	if (!tl) {
+		pr_err("Could not allocate third level table\n");
+		goto fail;
+	}
+	memset(tl, 0, SZ_4K);
+	clean_pte(tl, tl + NUM_TL_PTE, redirect);
+
+	/* Leave APTable bits 0 to let next level decide access permissions */
+	*sl_pte = (((phys_addr_t)__pa(tl)) & FLSL_BASE_MASK) | FLSL_TYPE_TABLE;
+	*sl_pte_shadow = *sl_pte & ~0xFFF;
+	clean_pte(sl_pte, sl_pte + 1, redirect);
+fail:
+	return tl;
+}
+
+static inline s32 tl_4k_map(u64 *tl_pte, phys_addr_t pa,
+			    u64 upper_attr, u64 lower_attr, s32 redirect)
+{
+	s32 ret = 0;
+
+	if (*tl_pte) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
+	*tl_pte = upper_attr | (pa & TL_PAGE_MASK) | lower_attr | TL_TYPE_PAGE;
+	clean_pte(tl_pte, tl_pte + 1, redirect);
+fail:
+	return ret;
+}
+
+static inline s32 tl_64k_map(u64 *tl_pte, phys_addr_t pa,
+			     u64 upper_attr, u64 lower_attr, s32 redirect)
+{
+	s32 ret = 0;
+	s32 i;
+
+	for (i = 0; i < 16; ++i)
+		if (*(tl_pte+i)) {
+			ret = -EBUSY;
+			goto fail;
+		}
+
+	/* Add Contiguous hint TL_CH */
+	upper_attr |= TL_CH;
+
+	for (i = 0; i < 16; ++i)
+		*(tl_pte+i) = upper_attr | (pa & TL_PAGE_MASK) |
+			      lower_attr | TL_TYPE_PAGE;
+	clean_pte(tl_pte, tl_pte + 16, redirect);
+fail:
+	return ret;
+}
+
+static inline s32 sl_2m_map(u64 *sl_pte, phys_addr_t pa,
+			    u64 upper_attr, u64 lower_attr, s32 redirect)
+{
+	s32 ret = 0;
+
+	if (*sl_pte) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
+	*sl_pte = upper_attr | (pa & FLSL_BLOCK_MASK) |
+		  lower_attr | FLSL_TYPE_BLOCK;
+	clean_pte(sl_pte, sl_pte + 1, redirect);
+fail:
+	return ret;
+}
+
+static inline s32 sl_32m_map(u64 *sl_pte, phys_addr_t pa,
+			     u64 upper_attr, u64 lower_attr, s32 redirect)
+{
+	s32 i;
+	s32 ret = 0;
+
+	for (i = 0; i < 16; ++i) {
+		if (*(sl_pte+i)) {
+			ret = -EBUSY;
+			goto fail;
+		}
+	}
+
+	/* Add Contiguous hint TL_CH */
+	upper_attr |= TL_CH;
+
+	for (i = 0; i < 16; ++i)
+		*(sl_pte+i) = upper_attr | (pa & FLSL_BLOCK_MASK) |
+			      lower_attr | FLSL_TYPE_BLOCK;
+	clean_pte(sl_pte, sl_pte + 16, redirect);
+fail:
+	return ret;
+}
+
+static inline s32 fl_1G_map(u64 *fl_pte, phys_addr_t pa,
+			    u64 upper_attr, u64 lower_attr, s32 redirect)
+{
+	s32 ret = 0;
+
+	if (*fl_pte) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
+	*fl_pte = upper_attr | (pa & FLSL_1G_BLOCK_MASK) |
+		  lower_attr | FLSL_TYPE_BLOCK;
+
+	clean_pte(fl_pte, fl_pte + 1, redirect);
+fail:
+	return ret;
+}
+
+static inline s32 common_error_check(size_t len, u64 const *fl_table)
+{
+	s32 ret = 0;
+
+	if (len != SZ_1G && len != SZ_32M && len != SZ_2M &&
+	    len != SZ_64K && len != SZ_4K) {
+		pr_err("Bad length: %d\n", len);
+		ret = -EINVAL;
+	} else if (!fl_table) {
+		pr_err("Null page table\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static inline s32 handle_1st_lvl(struct msm_iommu_pt *pt, u32 offset,
+				 phys_addr_t pa, size_t len, u64 upper_attr,
+				 u64 lower_attr)
+{
+	s32 ret = 0;
+	u64 *fl_pte = pt->fl_table + offset;
+
+	if (len == SZ_1G) {
+		ret = fl_1G_map(fl_pte, pa, upper_attr, lower_attr,
+				pt->redirect);
+	} else {
+		/* Need second level page table */
+		if (*fl_pte == 0) {
+			if (make_second_level_tbl(pt, offset) == NULL)
+				ret = -ENOMEM;
+		}
+		if (!ret) {
+			if ((*fl_pte & FLSL_TYPE_TABLE) != FLSL_TYPE_TABLE)
+				ret = -EBUSY;
+		}
+	}
+	return ret;
+}
+
+static inline s32 handle_3rd_lvl(u64 *sl_pte, u64 *sl_pte_shadow, u32 va,
+				 phys_addr_t pa, u64 upper_attr,
+				 u64 lower_attr, size_t len, s32 redirect)
+{
+	u64 *tl_table;
+	u64 *tl_pte;
+	u32 tl_offset;
+	s32 ret = 0;
+	u32 n_entries;
+
+	/* Need a 3rd level table */
+	if (*sl_pte == 0) {
+		if (make_third_level_tbl(redirect, sl_pte, sl_pte_shadow)
+					 == NULL) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+	}
+
+	if ((*sl_pte & FLSL_TYPE_TABLE) != FLSL_TYPE_TABLE) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
+	tl_table = FOLLOW_TO_NEXT_TABLE(sl_pte);
+	tl_offset = TL_OFFSET(va);
+	tl_pte = tl_table + tl_offset;
+
+	if (len == SZ_64K) {
+		ret = tl_64k_map(tl_pte, pa, upper_attr, lower_attr, redirect);
+		n_entries = 16;
+	} else {
+		ret = tl_4k_map(tl_pte, pa, upper_attr, lower_attr, redirect);
+		n_entries = 1;
+	}
+
+	/* Increment map count */
+	if (!ret)
+		*sl_pte_shadow += n_entries;
+
+fail:
+	return ret;
+}
+
+int msm_iommu_pagetable_map(struct msm_iommu_pt *pt, unsigned long va,
+			    phys_addr_t pa, size_t len, int prot)
+{
+	s32 ret;
+	struct scatterlist sg;
+
+	ret = common_error_check(len, pt->fl_table);
+	if (ret)
+		goto fail;
+
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = pa;
+	sg.length = len;
+
+	ret = msm_iommu_pagetable_map_range(pt, va, &sg, len, prot);
+
+fail:
+	return ret;
+}
+
+static void fl_1G_unmap(u64 *fl_pte, s32 redirect)
+{
+	*fl_pte = 0;
+	clean_pte(fl_pte, fl_pte + 1, redirect);
+}
+
+size_t msm_iommu_pagetable_unmap(struct msm_iommu_pt *pt, unsigned long va,
+				size_t len)
+{
+	msm_iommu_pagetable_unmap_range(pt, va, len);
+	return len;
+}
+
+static phys_addr_t get_phys_addr(struct scatterlist *sg)
+{
+	/*
+	 * Try sg_dma_address first so that we can
+	 * map carveout regions that do not have a
+	 * struct page associated with them.
+	 */
+	phys_addr_t pa = sg_dma_address(sg);
+
+	if (pa == 0)
+		pa = sg_phys(sg);
+	return pa;
+}
+
+#ifdef CONFIG_IOMMU_FORCE_4K_MAPPINGS
+static inline int is_fully_aligned(unsigned int va, phys_addr_t pa, size_t len,
+				   int align)
+{
+	if (align == SZ_4K)
+		return  IS_ALIGNED(va | pa, align) && (len >= align);
+	else
+		return 0;
+}
+#else
+static inline int is_fully_aligned(unsigned int va, phys_addr_t pa, size_t len,
+				   int align)
+{
+	return  IS_ALIGNED(va | pa, align) && (len >= align);
+}
+#endif
+
+s32 msm_iommu_pagetable_map_range(struct msm_iommu_pt *pt, u32 va,
+		       struct scatterlist *sg, u32 len, s32 prot)
+{
+	phys_addr_t pa;
+	u32 offset = 0;
+	u64 *fl_pte;
+	u64 *sl_pte;
+	u64 *sl_pte_shadow;
+	u32 fl_offset;
+	u32 sl_offset;
+	u64 *sl_table = NULL;
+	u32 chunk_size, chunk_offset = 0;
+	s32 ret = 0;
+	u64 up_at;
+	u64 lo_at;
+	u32 redirect = pt->redirect;
+	unsigned int start_va = va;
+
+	BUG_ON(len & (SZ_4K - 1));
+
+	if (!pt->fl_table) {
+		pr_err("Null page table\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	__get_attr(prot, &up_at, &lo_at);
+
+	pa = get_phys_addr(sg);
+
+	while (offset < len) {
+		u32 chunk_left = sg->length - chunk_offset;
+
+		fl_offset = FL_OFFSET(va);
+		fl_pte = pt->fl_table + fl_offset;
+
+		chunk_size = SZ_4K;
+		if (is_fully_aligned(va, pa, chunk_left, SZ_1G))
+			chunk_size = SZ_1G;
+		else if (is_fully_aligned(va, pa, chunk_left, SZ_32M))
+			chunk_size = SZ_32M;
+		else if (is_fully_aligned(va, pa, chunk_left, SZ_2M))
+			chunk_size = SZ_2M;
+		else if (is_fully_aligned(va, pa, chunk_left, SZ_64K))
+			chunk_size = SZ_64K;
+
+		ret = handle_1st_lvl(pt, fl_offset, pa, chunk_size,
+				     up_at, lo_at);
+		if (ret)
+			goto fail;
+
+		sl_table = FOLLOW_TO_NEXT_TABLE(fl_pte);
+		sl_offset = SL_OFFSET(va);
+		sl_pte = sl_table + sl_offset;
+		sl_pte_shadow = pt->sl_table_shadow[fl_offset] + sl_offset;
+
+		if (chunk_size == SZ_32M)
+			ret = sl_32m_map(sl_pte, pa, up_at, lo_at, redirect);
+		else if (chunk_size == SZ_2M)
+			ret = sl_2m_map(sl_pte, pa, up_at, lo_at, redirect);
+		else if (chunk_size == SZ_64K || chunk_size == SZ_4K)
+			ret = handle_3rd_lvl(sl_pte, sl_pte_shadow, va, pa,
+					     up_at, lo_at, chunk_size,
+					     redirect);
+		if (ret)
+			goto fail;
+
+		offset += chunk_size;
+		chunk_offset += chunk_size;
+		va += chunk_size;
+		pa += chunk_size;
+
+		if (chunk_offset >= sg->length && offset < len) {
+			chunk_offset = 0;
+			sg = sg_next(sg);
+			pa = get_phys_addr(sg);
+		}
+	}
+fail:
+	if (ret && offset > 0)
+		__msm_iommu_pagetable_unmap_range(pt, start_va, offset, 1);
+	return ret;
+}
+
+void msm_iommu_pagetable_unmap_range(struct msm_iommu_pt *pt, u32 va, u32 len)
+{
+	__msm_iommu_pagetable_unmap_range(pt, va, len, 0);
+}
+
+static void __msm_iommu_pagetable_unmap_range(struct msm_iommu_pt *pt, u32 va,
+					      u32 len, u32 silent)
+{
+	u32 offset = 0;
+	u64 *fl_pte;
+	u64 *sl_pte;
+	u64 *tl_pte;
+	u32 fl_offset;
+	u32 sl_offset;
+	u64 *sl_table;
+	u64 *tl_table;
+	u32 tl_start, tl_end;
+	u32 redirect = pt->redirect;
+
+	BUG_ON(len & (SZ_4K - 1));
+
+	while (offset < len) {
+		u32 entries;
+		u32 left_to_unmap = len - offset;
+		u32 type;
+
+		fl_offset = FL_OFFSET(va);
+		fl_pte = pt->fl_table + fl_offset;
+
+		if (*fl_pte == 0) {
+			if (!silent)
+				pr_err("First level PTE is 0 at index 0x%x (offset: 0x%x)\n",
+					fl_offset, offset);
+			return;
+		}
+		type = *fl_pte & FLSL_PTE_TYPE_MASK;
+
+		if (type == FLSL_TYPE_BLOCK) {
+			fl_1G_unmap(fl_pte, redirect);
+			va += SZ_1G;
+			offset += SZ_1G;
+		} else if (type == FLSL_TYPE_TABLE) {
+			sl_table = FOLLOW_TO_NEXT_TABLE(fl_pte);
+			sl_offset = SL_OFFSET(va);
+			sl_pte = sl_table + sl_offset;
+			type = *sl_pte & FLSL_PTE_TYPE_MASK;
+
+			if (type == FLSL_TYPE_BLOCK) {
+				*sl_pte = 0;
+
+				clean_pte(sl_pte, sl_pte + 1, redirect);
+
+				offset += SZ_2M;
+				va += SZ_2M;
+			} else if (type == FLSL_TYPE_TABLE) {
+				u64 *sl_pte_shadow =
+				    pt->sl_table_shadow[fl_offset] + sl_offset;
+
+				tl_start = TL_OFFSET(va);
+				tl_table =  FOLLOW_TO_NEXT_TABLE(sl_pte);
+				tl_end = (left_to_unmap / SZ_4K) + tl_start;
+
+				if (tl_end > NUM_TL_PTE)
+					tl_end = NUM_TL_PTE;
+
+				entries = tl_end - tl_start;
+
+				memset(tl_table + tl_start, 0,
+				       entries * sizeof(*tl_pte));
+
+				clean_pte(tl_table + tl_start,
+					  tl_table + tl_end, redirect);
+
+				BUG_ON((*sl_pte_shadow & 0xFFF) < entries);
+
+				/* Decrement map count */
+				*sl_pte_shadow -= entries;
+
+				if (!(*sl_pte_shadow & 0xFFF)) {
+					*sl_pte = 0;
+					clean_pte(sl_pte, sl_pte + 1,
+						  pt->redirect);
+				}
+
+				offset += entries * SZ_4K;
+				va += entries * SZ_4K;
+			} else {
+				if (!silent)
+					pr_err("Second level PTE (0x%llx) is invalid at index 0x%x (offset: 0x%x)\n",
+						*sl_pte, sl_offset, offset);
+			}
+		} else {
+			if (!silent)
+				pr_err("First level PTE (0x%llx) is invalid at index 0x%x (offset: 0x%x)\n",
+					*fl_pte, fl_offset, offset);
+		}
+	}
+}
+
+phys_addr_t msm_iommu_iova_to_phys_soft(struct iommu_domain *domain,
+							phys_addr_t va)
+{
+	pr_err("iova_to_phys is not implemented for LPAE\n");
+	return 0;
+}
+
+void __init msm_iommu_pagetable_init(void)
+{
+}
diff --git a/drivers/iommu/msm_iommu_priv.h b/drivers/iommu/msm_iommu_priv.h
index 031e6b4..1064d89 100644
--- a/drivers/iommu/msm_iommu_priv.h
+++ b/drivers/iommu/msm_iommu_priv.h
@@ -31,13 +31,23 @@
  * clients trying to unmap an address that is being used.
  * fl_table_shadow will use the lower 9 bits for the use count and the upper
  * bits for the second level page table address.
+ * sl_table_shadow uses the same concept as fl_table_shadow but for LPAE 2nd
+ * level page tables.
  */
+#ifdef CONFIG_MSM_IOMMU_LPAE
+struct msm_iommu_pt {
+	u64 *fl_table;
+	u64 **sl_table_shadow;
+	int redirect;
+	u64 *unaligned_fl_table;
+};
+#else
 struct msm_iommu_pt {
 	u32 *fl_table;
 	int redirect;
 	u32 *fl_table_shadow;
 };
-
+#endif
 /**
  * struct msm_iommu_priv - Container for page table attributes and other
  * private iommu domain information.
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
