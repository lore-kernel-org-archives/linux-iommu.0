From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 06/13] iommu: exynos: refactor fault handling code
Date: Thu, 18 Feb 2016 15:12:53 +0100
Message-ID: <1455804780-9616-7-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch provides a new implementation for page fault handing code. The
new implementation is ready for future extensions. No functional changes
have been made.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 109 ++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 4275222cead3..3a577a473f3c 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -148,40 +148,25 @@ static sysmmu_pte_t *page_entry(sysmmu_pte_t *sent, sysmmu_iova_t iova)
 				lv2table_base(sent)) + lv2ent_offset(iova);
 }
 
-enum exynos_sysmmu_inttype {
-	SYSMMU_PAGEFAULT,
-	SYSMMU_AR_MULTIHIT,
-	SYSMMU_AW_MULTIHIT,
-	SYSMMU_BUSERROR,
-	SYSMMU_AR_SECURITY,
-	SYSMMU_AR_ACCESS,
-	SYSMMU_AW_SECURITY,
-	SYSMMU_AW_PROTECTION, /* 7 */
-	SYSMMU_FAULT_UNKNOWN,
-	SYSMMU_FAULTS_NUM
-};
-
-static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] = {
-	REG_PAGE_FAULT_ADDR,
-	REG_AR_FAULT_ADDR,
-	REG_AW_FAULT_ADDR,
-	REG_DEFAULT_SLAVE_ADDR,
-	REG_AR_FAULT_ADDR,
-	REG_AR_FAULT_ADDR,
-	REG_AW_FAULT_ADDR,
-	REG_AW_FAULT_ADDR
+/*
+ * IOMMU fault information register
+ */
+struct sysmmu_fault_info {
+	unsigned int bit;	/* bit number in STATUS register */
+	unsigned short addr_reg; /* register to read VA fault address */
+	const char *name;	/* human readable fault name */
+	unsigned int type;	/* fault type for report_iommu_fault */
 };
 
-static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
-	"PAGE FAULT",
-	"AR MULTI-HIT FAULT",
-	"AW MULTI-HIT FAULT",
-	"BUS ERROR",
-	"AR SECURITY PROTECTION FAULT",
-	"AR ACCESS PROTECTION FAULT",
-	"AW SECURITY PROTECTION FAULT",
-	"AW ACCESS PROTECTION FAULT",
-	"UNKNOWN FAULT"
+static const struct sysmmu_fault_info sysmmu_faults[] = {
+	{ 0, REG_PAGE_FAULT_ADDR, "PAGE", IOMMU_FAULT_READ },
+	{ 1, REG_AR_FAULT_ADDR, "AR MULTI-HIT", IOMMU_FAULT_READ },
+	{ 2, REG_AW_FAULT_ADDR, "AW MULTI-HIT", IOMMU_FAULT_WRITE },
+	{ 3, REG_DEFAULT_SLAVE_ADDR, "BUS ERROR", IOMMU_FAULT_READ },
+	{ 4, REG_AR_FAULT_ADDR, "AR SECURITY PROTECTION", IOMMU_FAULT_READ },
+	{ 5, REG_AR_FAULT_ADDR, "AR ACCESS PROTECTION", IOMMU_FAULT_READ },
+	{ 6, REG_AW_FAULT_ADDR, "AW SECURITY PROTECTION", IOMMU_FAULT_WRITE },
+	{ 7, REG_AW_FAULT_ADDR, "AW ACCESS PROTECTION", IOMMU_FAULT_WRITE },
 };
 
 /*
@@ -299,24 +284,19 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 	__sysmmu_tlb_invalidate(data);
 }
 
-static void show_fault_information(const char *name,
-		enum exynos_sysmmu_inttype itype,
-		phys_addr_t pgtable_base, sysmmu_iova_t fault_addr)
+static void show_fault_information(struct sysmmu_drvdata *data,
+				   const struct sysmmu_fault_info *finfo,
+				   sysmmu_iova_t fault_addr)
 {
 	sysmmu_pte_t *ent;
 
-	if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
-		itype = SYSMMU_FAULT_UNKNOWN;
-
-	pr_err("%s occurred at %#x by %s(Page table base: %pa)\n",
-		sysmmu_fault_name[itype], fault_addr, name, &pgtable_base);
-
-	ent = section_entry(phys_to_virt(pgtable_base), fault_addr);
-	pr_err("\tLv1 entry: %#x\n", *ent);
-
+	dev_err(data->sysmmu, "%s FAULT occurred at %#x (page table base: %pa)\n",
+		finfo->name, fault_addr, &data->pgtable);
+	ent = section_entry(phys_to_virt(data->pgtable), fault_addr);
+	dev_err(data->sysmmu, "\tLv1 entry: %#x\n", *ent);
 	if (lv1ent_page(ent)) {
 		ent = page_entry(ent, fault_addr);
-		pr_err("\t Lv2 entry: %#x\n", *ent);
+		dev_err(data->sysmmu, "\t Lv2 entry: %#x\n", *ent);
 	}
 }
 
@@ -324,8 +304,10 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
 	/* SYSMMU is in blocked state when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
-	enum exynos_sysmmu_inttype itype;
-	sysmmu_iova_t addr = -1;
+	const struct sysmmu_fault_info *finfo = sysmmu_faults;
+	int i, n = ARRAY_SIZE(sysmmu_faults);
+	unsigned int itype;
+	sysmmu_iova_t fault_addr = -1;
 	int ret = -ENOSYS;
 
 	WARN_ON(!is_sysmmu_active(data));
@@ -334,29 +316,20 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	clk_enable(data->clk_master);
 
-	itype = (enum exynos_sysmmu_inttype)
-		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
-	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
-		itype = SYSMMU_FAULT_UNKNOWN;
-	else
-		addr = __raw_readl(data->sfrbase + fault_reg_offset[itype]);
+	itype = __ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
+	for (i = 0; i < n; i++, finfo++)
+		if (finfo->bit == itype)
+			break;
+	/* unknown/unsupported fault */
+	BUG_ON(i == n);
 
-	if (itype == SYSMMU_FAULT_UNKNOWN) {
-		pr_err("%s: Fault is not occurred by System MMU '%s'!\n",
-			__func__, dev_name(data->sysmmu));
-		pr_err("%s: Please check if IRQ is correctly configured.\n",
-			__func__);
-		BUG();
-	} else {
-		unsigned int base =
-				__raw_readl(data->sfrbase + REG_PT_BASE_ADDR);
-		show_fault_information(dev_name(data->sysmmu),
-					itype, base, addr);
-		if (data->domain)
-			ret = report_iommu_fault(&data->domain->domain,
-					data->master, addr, itype);
-	}
+	/* print debug message */
+	fault_addr = __raw_readl(data->sfrbase + finfo->addr_reg);
+	show_fault_information(data, finfo, fault_addr);
 
+	if (data->domain)
+		ret = report_iommu_fault(&data->domain->domain,
+					data->master, fault_addr, finfo->type);
 	/* fault is not recovered by fault handler */
 	BUG_ON(ret != 0);
 
-- 
1.9.2
