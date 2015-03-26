From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/16] iommu/exynos: Make use of domain_alloc and domain_free
Date: Thu, 26 Mar 2015 13:43:11 +0100
Message-ID: <1427373799-18662-9-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427373799-18662-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Implement domain_alloc and domain_free iommu-ops as a
replacement for domain_init/domain_destroy.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index dc14fec4..3e89850 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -200,6 +200,7 @@ struct exynos_iommu_domain {
 	short *lv2entcnt; /* free lv2 entry counter for each section */
 	spinlock_t lock; /* lock for this structure */
 	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
+	struct iommu_domain domain; /* generic domain data structure */
 };
 
 struct sysmmu_drvdata {
@@ -214,6 +215,11 @@ struct sysmmu_drvdata {
 	phys_addr_t pgtable;
 };
 
+static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct exynos_iommu_domain, domain);
+}
+
 static bool set_sysmmu_active(struct sysmmu_drvdata *data)
 {
 	/* return true if the System MMU was not active previously
@@ -696,58 +702,60 @@ static inline void pgtable_flush(void *vastart, void *vaend)
 				virt_to_phys(vaend));
 }
 
-static int exynos_iommu_domain_init(struct iommu_domain *domain)
+static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 {
-	struct exynos_iommu_domain *priv;
+	struct exynos_iommu_domain *exynos_domain;
 	int i;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	exynos_domain = kzalloc(sizeof(*exynos_domain), GFP_KERNEL);
+	if (!exynos_domain)
+		return NULL;
 
-	priv->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
-	if (!priv->pgtable)
+	exynos_domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
+	if (!exynos_domain->pgtable)
 		goto err_pgtable;
 
-	priv->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
-	if (!priv->lv2entcnt)
+	exynos_domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	if (!exynos_domain->lv2entcnt)
 		goto err_counter;
 
 	/* Workaround for System MMU v3.3 to prevent caching 1MiB mapping */
 	for (i = 0; i < NUM_LV1ENTRIES; i += 8) {
-		priv->pgtable[i + 0] = ZERO_LV2LINK;
-		priv->pgtable[i + 1] = ZERO_LV2LINK;
-		priv->pgtable[i + 2] = ZERO_LV2LINK;
-		priv->pgtable[i + 3] = ZERO_LV2LINK;
-		priv->pgtable[i + 4] = ZERO_LV2LINK;
-		priv->pgtable[i + 5] = ZERO_LV2LINK;
-		priv->pgtable[i + 6] = ZERO_LV2LINK;
-		priv->pgtable[i + 7] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 0] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 1] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 2] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 3] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 4] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 5] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 6] = ZERO_LV2LINK;
+		exynos_domain->pgtable[i + 7] = ZERO_LV2LINK;
 	}
 
-	pgtable_flush(priv->pgtable, priv->pgtable + NUM_LV1ENTRIES);
+	pgtable_flush(exynos_domain->pgtable, exynos_domain->pgtable + NUM_LV1ENTRIES);
 
-	spin_lock_init(&priv->lock);
-	spin_lock_init(&priv->pgtablelock);
-	INIT_LIST_HEAD(&priv->clients);
+	spin_lock_init(&exynos_domain->lock);
+	spin_lock_init(&exynos_domain->pgtablelock);
+	INIT_LIST_HEAD(&exynos_domain->clients);
 
-	domain->geometry.aperture_start = 0;
-	domain->geometry.aperture_end   = ~0UL;
-	domain->geometry.force_aperture = true;
+	exynos_domain->domain.geometry.aperture_start = 0;
+	exynos_domain->domain.geometry.aperture_end   = ~0UL;
+	exynos_domain->domain.geometry.force_aperture = true;
 
-	domain->priv = priv;
-	return 0;
+	return &exynos_domain->domain;
 
 err_counter:
-	free_pages((unsigned long)priv->pgtable, 2);
+	free_pages((unsigned long)exynos_domain->pgtable, 2);
 err_pgtable:
-	kfree(priv);
-	return -ENOMEM;
+	kfree(exynos_domain);
+	return NULL;
 }
 
-static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
+static void exynos_iommu_domain_free(struct iommu_domain *domain)
 {
-	struct exynos_iommu_domain *priv = domain->priv;
+	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
 	struct exynos_iommu_owner *owner;
 	unsigned long flags;
 	int i;
@@ -773,15 +781,14 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	free_pages((unsigned long)priv->pgtable, 2);
 	free_pages((unsigned long)priv->lv2entcnt, 1);
-	kfree(domain->priv);
-	domain->priv = NULL;
+	kfree(priv);
 }
 
 static int exynos_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct exynos_iommu_domain *priv = domain->priv;
+	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
 	int ret;
@@ -812,7 +819,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
 	struct exynos_iommu_owner *owner;
-	struct exynos_iommu_domain *priv = domain->priv;
+	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
 
@@ -988,7 +995,7 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
-	struct exynos_iommu_domain *priv = domain->priv;
+	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
 	sysmmu_pte_t *entry;
 	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
 	unsigned long flags;
@@ -1042,7 +1049,7 @@ static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *priv,
 static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 					unsigned long l_iova, size_t size)
 {
-	struct exynos_iommu_domain *priv = domain->priv;
+	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
 	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
 	sysmmu_pte_t *ent;
 	size_t err_pgsize;
@@ -1119,7 +1126,7 @@ err:
 static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
-	struct exynos_iommu_domain *priv = domain->priv;
+	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
 	sysmmu_pte_t *entry;
 	unsigned long flags;
 	phys_addr_t phys = 0;
@@ -1171,8 +1178,8 @@ static void exynos_iommu_remove_device(struct device *dev)
 }
 
 static const struct iommu_ops exynos_iommu_ops = {
-	.domain_init = exynos_iommu_domain_init,
-	.domain_destroy = exynos_iommu_domain_destroy,
+	.domain_alloc = exynos_iommu_domain_alloc,
+	.domain_free = exynos_iommu_domain_free,
 	.attach_dev = exynos_iommu_attach_device,
 	.detach_dev = exynos_iommu_detach_device,
 	.map = exynos_iommu_map,
-- 
1.9.1
