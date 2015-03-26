From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/16] iommu/tegra-smmu: Make use of domain_alloc and
	domain_free
Date: Thu, 26 Mar 2015 13:43:12 +0100
Message-ID: <1427373799-18662-10-git-send-email-joro@8bytes.org>
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
 drivers/iommu/tegra-smmu.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6e134c7..7208297 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -31,7 +31,7 @@ struct tegra_smmu {
 };
 
 struct tegra_smmu_as {
-	struct iommu_domain *domain;
+	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
 	struct page *count;
@@ -40,6 +40,11 @@ struct tegra_smmu_as {
 	u32 attr;
 };
 
+static struct tegra_smmu_as *to_smmu_as(struct iommu_domain *dom)
+{
+	return container_of(dom, struct tegra_smmu_as, domain);
+}
+
 static inline void smmu_writel(struct tegra_smmu *smmu, u32 value,
 			       unsigned long offset)
 {
@@ -224,30 +229,32 @@ static bool tegra_smmu_capable(enum iommu_cap cap)
 	return false;
 }
 
-static int tegra_smmu_domain_init(struct iommu_domain *domain)
+static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
 	unsigned int i;
 	uint32_t *pd;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
 	as = kzalloc(sizeof(*as), GFP_KERNEL);
 	if (!as)
-		return -ENOMEM;
+		return NULL;
 
 	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
-	as->domain = domain;
 
 	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA);
 	if (!as->pd) {
 		kfree(as);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	as->count = alloc_page(GFP_KERNEL);
 	if (!as->count) {
 		__free_page(as->pd);
 		kfree(as);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	/* clear PDEs */
@@ -264,14 +271,12 @@ static int tegra_smmu_domain_init(struct iommu_domain *domain)
 	for (i = 0; i < SMMU_NUM_PDE; i++)
 		pd[i] = 0;
 
-	domain->priv = as;
-
-	return 0;
+	return &as->domain;
 }
 
-static void tegra_smmu_domain_destroy(struct iommu_domain *domain)
+static void tegra_smmu_domain_free(struct iommu_domain *domain)
 {
-	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu_as *as = to_smmu_as(domain);
 
 	/* TODO: free page directory and page tables */
 	ClearPageReserved(as->pd);
@@ -395,7 +400,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct tegra_smmu *smmu = dev->archdata.iommu;
-	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu_as *as = to_smmu_as(domain);
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
 	unsigned int index = 0;
@@ -428,7 +433,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 
 static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu_as *as = to_smmu_as(domain);
 	struct device_node *np = dev->of_node;
 	struct tegra_smmu *smmu = as->smmu;
 	struct of_phandle_args args;
@@ -524,7 +529,7 @@ static void as_put_pte(struct tegra_smmu_as *as, dma_addr_t iova)
 static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot)
 {
-	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu_as *as = to_smmu_as(domain);
 	struct tegra_smmu *smmu = as->smmu;
 	unsigned long offset;
 	struct page *page;
@@ -548,7 +553,7 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t size)
 {
-	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu_as *as = to_smmu_as(domain);
 	struct tegra_smmu *smmu = as->smmu;
 	unsigned long offset;
 	struct page *page;
@@ -572,7 +577,7 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu_as *as = to_smmu_as(domain);
 	struct page *page;
 	unsigned long pfn;
 	u32 *pte;
@@ -633,8 +638,8 @@ static void tegra_smmu_remove_device(struct device *dev)
 
 static const struct iommu_ops tegra_smmu_ops = {
 	.capable = tegra_smmu_capable,
-	.domain_init = tegra_smmu_domain_init,
-	.domain_destroy = tegra_smmu_domain_destroy,
+	.domain_alloc = tegra_smmu_domain_alloc,
+	.domain_free = tegra_smmu_domain_free,
 	.attach_dev = tegra_smmu_attach_dev,
 	.detach_dev = tegra_smmu_detach_dev,
 	.add_device = tegra_smmu_add_device,
-- 
1.9.1
