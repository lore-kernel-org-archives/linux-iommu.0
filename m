From: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v13 13/19] iommu/exynos: use exynos-iommu specific typedef
Date: Mon, 12 May 2014 11:44:58 +0530
Message-ID: <1399875304-19948-14-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1399875304-19948-1-git-send-email-shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This commit introduces sysmmu_pte_t for page table entries and
sysmmu_iova_t vor I/O virtual address that is manipulated by
exynos-iommu driver. The purpose of the typedef is to remove
dependencies to the driver code from the change of CPU architecture
from 32 bit to 64 bit.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |  101 ++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d89ad5f..3291619 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -29,6 +29,9 @@
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 
+typedef u32 sysmmu_iova_t;
+typedef u32 sysmmu_pte_t;
+
 /* We does not consider super section mapping (16MB) */
 #define SECT_ORDER 20
 #define LPAGE_ORDER 16
@@ -50,20 +53,32 @@
 #define lv2ent_small(pent) ((*(pent) & 2) == 2)
 #define lv2ent_large(pent) ((*(pent) & 3) == 1)
 
+static u32 sysmmu_page_offset(sysmmu_iova_t iova, u32 size)
+{
+	return iova & (size - 1);
+}
+
 #define section_phys(sent) (*(sent) & SECT_MASK)
-#define section_offs(iova) ((iova) & 0xFFFFF)
+#define section_offs(iova) sysmmu_page_offset((iova), SECT_SIZE)
 #define lpage_phys(pent) (*(pent) & LPAGE_MASK)
-#define lpage_offs(iova) ((iova) & 0xFFFF)
+#define lpage_offs(iova) sysmmu_page_offset((iova), LPAGE_SIZE)
 #define spage_phys(pent) (*(pent) & SPAGE_MASK)
-#define spage_offs(iova) ((iova) & 0xFFF)
-
-#define lv1ent_offset(iova) ((iova) >> SECT_ORDER)
-#define lv2ent_offset(iova) (((iova) & 0xFF000) >> SPAGE_ORDER)
+#define spage_offs(iova) sysmmu_page_offset((iova), SPAGE_SIZE)
 
 #define NUM_LV1ENTRIES 4096
-#define NUM_LV2ENTRIES 256
+#define NUM_LV2ENTRIES (SECT_SIZE / SPAGE_SIZE)
 
-#define LV2TABLE_SIZE (NUM_LV2ENTRIES * sizeof(long))
+static u32 lv1ent_offset(sysmmu_iova_t iova)
+{
+	return iova >> SECT_ORDER;
+}
+
+static u32 lv2ent_offset(sysmmu_iova_t iova)
+{
+	return (iova >> SPAGE_ORDER) & (NUM_LV2ENTRIES - 1);
+}
+
+#define LV2TABLE_SIZE (NUM_LV2ENTRIES * sizeof(sysmmu_pte_t))
 
 #define SPAGES_PER_LPAGE (LPAGE_SIZE / SPAGE_SIZE)
 
@@ -101,14 +116,14 @@
 
 static struct kmem_cache *lv2table_kmem_cache;
 
-static unsigned long *section_entry(unsigned long *pgtable, unsigned long iova)
+static sysmmu_pte_t *section_entry(sysmmu_pte_t *pgtable, sysmmu_iova_t iova)
 {
 	return pgtable + lv1ent_offset(iova);
 }
 
-static unsigned long *page_entry(unsigned long *sent, unsigned long iova)
+static sysmmu_pte_t *page_entry(sysmmu_pte_t *sent, sysmmu_iova_t iova)
 {
-	return (unsigned long *)phys_to_virt(
+	return (sysmmu_pte_t *)phys_to_virt(
 				lv2table_base(sent)) + lv2ent_offset(iova);
 }
 
@@ -150,7 +165,7 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 
 struct exynos_iommu_domain {
 	struct list_head clients; /* list of sysmmu_drvdata.node */
-	unsigned long *pgtable; /* lv1 page table, 16KB */
+	sysmmu_pte_t *pgtable; /* lv1 page table, 16KB */
 	short *lv2entcnt; /* free lv2 entry counter for each section */
 	spinlock_t lock; /* lock for this structure */
 	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
@@ -215,7 +230,7 @@ static void __sysmmu_tlb_invalidate(void __iomem *sfrbase)
 }
 
 static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
-				unsigned long iova, unsigned int num_inv)
+				sysmmu_iova_t iova, unsigned int num_inv)
 {
 	unsigned int i;
 	for (i = 0; i < num_inv; i++) {
@@ -226,7 +241,7 @@ static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
 }
 
 static void __sysmmu_set_ptbase(void __iomem *sfrbase,
-				       unsigned long pgd)
+				       phys_addr_t pgd)
 {
 	__raw_writel(0x1, sfrbase + REG_MMU_CFG); /* 16KB LV1, LRU */
 	__raw_writel(pgd, sfrbase + REG_PT_BASE_ADDR);
@@ -236,22 +251,22 @@ static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 
 static void show_fault_information(const char *name,
 		enum exynos_sysmmu_inttype itype,
-		phys_addr_t pgtable_base, unsigned long fault_addr)
+		phys_addr_t pgtable_base, sysmmu_iova_t fault_addr)
 {
-	unsigned long *ent;
+	sysmmu_pte_t *ent;
 
 	if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
 		itype = SYSMMU_FAULT_UNKNOWN;
 
-	pr_err("%s occurred at %#lx by %s(Page table base: %pa)\n",
+	pr_err("%s occurred at %#x by %s(Page table base: %pa)\n",
 		sysmmu_fault_name[itype], fault_addr, name, &pgtable_base);
 
 	ent = section_entry(phys_to_virt(pgtable_base), fault_addr);
-	pr_err("\tLv1 entry: 0x%lx\n", *ent);
+	pr_err("\tLv1 entry: %#x\n", *ent);
 
 	if (lv1ent_page(ent)) {
 		ent = page_entry(ent, fault_addr);
-		pr_err("\t Lv2 entry: 0x%lx\n", *ent);
+		pr_err("\t Lv2 entry: %#x\n", *ent);
 	}
 }
 
@@ -260,7 +275,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	/* SYSMMU is in blocked when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
 	enum exynos_sysmmu_inttype itype;
-	unsigned long addr = -1;
+	sysmmu_iova_t addr = -1;
 	int ret = -ENOSYS;
 
 	WARN_ON(!is_sysmmu_active(data));
@@ -284,7 +299,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 			__func__);
 		BUG();
 	} else {
-		unsigned long base =
+		unsigned int base =
 				__raw_readl(data->sfrbase + REG_PT_BASE_ADDR);
 		show_fault_information(dev_name(data->sysmmu),
 					itype, base, addr);
@@ -349,7 +364,7 @@ finish:
  * enabled before.
  */
 static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
-			unsigned long pgtable, struct iommu_domain *domain)
+			phys_addr_t pgtable, struct iommu_domain *domain)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -390,7 +405,7 @@ finish:
 	return ret;
 }
 
-int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
+int exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 	int ret;
@@ -426,7 +441,7 @@ static bool exynos_sysmmu_disable(struct device *dev)
 	return disabled;
 }
 
-static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
+static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 					size_t size)
 {
 	unsigned long flags;
@@ -577,7 +592,7 @@ static int exynos_iommu_domain_init(struct iommu_domain *domain)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->pgtable = (unsigned long *)__get_free_pages(
+	priv->pgtable = (sysmmu_pte_t *)__get_free_pages(
 						GFP_KERNEL | __GFP_ZERO, 2);
 	if (!priv->pgtable)
 		goto err_pgtable;
@@ -716,19 +731,19 @@ finish:
 		pm_runtime_put(data->sysmmu);
 }
 
-static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
+static sysmmu_pte_t *alloc_lv2entry(sysmmu_pte_t *sent, sysmmu_iova_t iova,
 					short *pgcounter)
 {
 	if (lv1ent_section(sent)) {
-		WARN(1, "Trying mapping on %#08lx mapped with 1MiB page", iova);
+		WARN(1, "Trying mapping on %#08x mapped with 1MiB page", iova);
 		return ERR_PTR(-EADDRINUSE);
 	}
 
 	if (lv1ent_fault(sent)) {
-		unsigned long *pent;
+		sysmmu_pte_t *pent;
 
 		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
-		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
+		BUG_ON((unsigned int)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
 
@@ -741,18 +756,18 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 	return page_entry(sent, iova);
 }
 
-static int lv1set_section(unsigned long *sent, unsigned long iova,
+static int lv1set_section(sysmmu_pte_t *sent, sysmmu_iova_t iova,
 			  phys_addr_t paddr, short *pgcnt)
 {
 	if (lv1ent_section(sent)) {
-		WARN(1, "Trying mapping on 1MiB@%#08lx that is mapped",
+		WARN(1, "Trying mapping on 1MiB@%#08x that is mapped",
 			iova);
 		return -EADDRINUSE;
 	}
 
 	if (lv1ent_page(sent)) {
 		if (*pgcnt != NUM_LV2ENTRIES) {
-			WARN(1, "Trying mapping on 1MiB@%#08lx that is mapped",
+			WARN(1, "Trying mapping on 1MiB@%#08x that is mapped",
 				iova);
 			return -EADDRINUSE;
 		}
@@ -768,7 +783,7 @@ static int lv1set_section(unsigned long *sent, unsigned long iova,
 	return 0;
 }
 
-static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_t size,
+static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 								short *pgcnt)
 {
 	if (size == SPAGE_SIZE) {
@@ -800,11 +815,12 @@ static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_t size,
 	return 0;
 }
 
-static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
+static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	unsigned long *entry;
+	sysmmu_pte_t *entry;
+	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
 	unsigned long flags;
 	int ret = -ENOMEM;
 
@@ -818,7 +834,7 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		ret = lv1set_section(entry, iova, paddr,
 					&priv->lv2entcnt[lv1ent_offset(iova)]);
 	} else {
-		unsigned long *pent;
+		sysmmu_pte_t *pent;
 
 		pent = alloc_lv2entry(entry, iova,
 					&priv->lv2entcnt[lv1ent_offset(iova)]);
@@ -831,7 +847,7 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	if (ret)
-		pr_debug("%s: Failed to map iova 0x%lx/0x%x bytes\n",
+		pr_debug("%s: Failed to map iova %#x/%#zx bytes\n",
 							__func__, iova, size);
 
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
@@ -840,13 +856,14 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t exynos_iommu_unmap(struct iommu_domain *domain,
-					       unsigned long iova, size_t size)
+					unsigned long l_iova, size_t size)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
 	struct sysmmu_drvdata *data;
-	unsigned long flags;
-	unsigned long *ent;
+	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
+	sysmmu_pte_t *ent;
 	size_t err_pgsize;
+	unsigned long flags;
 
 	BUG_ON(priv->pgtable == NULL);
 
@@ -913,7 +930,7 @@ err:
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
 	WARN(1,
-	"%s: Failed due to size(%#x) @ %#08lx is smaller than page size %#x\n",
+	"%s: Failed due to size(%#zx) @ %#x is smaller than page size %#zx\n",
 	__func__, size, iova, err_pgsize);
 
 	return 0;
@@ -923,7 +940,7 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	unsigned long *entry;
+	sysmmu_pte_t *entry;
 	unsigned long flags;
 	phys_addr_t phys = 0;
 
-- 
1.7.9.5
