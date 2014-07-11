From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V4 11/21] iommu/vt-d: Introduce helper
	domain_pfn_within_range() to simplify code
Date: Fri, 11 Jul 2014 14:19:35 +0800
Message-ID: <1405059585-10620-12-git-send-email-jiang.liu@linux.intel.com>
References: <1405059585-10620-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1405059585-10620-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Introduce helper function domain_pfn_within_range() to simplify code
and improve readability.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0852b7021e4a..c9e65edaa2ad 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -549,6 +549,14 @@ static inline int domain_type_is_vm_or_si(struct dmar_domain *domain)
 				DOMAIN_FLAG_STATIC_IDENTITY);
 }
 
+static inline int domain_pfn_supported(struct dmar_domain *domain,
+				       unsigned long pfn)
+{
+	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
+
+	return !(addr_width < BITS_PER_LONG && pfn >> addr_width);
+}
+
 static int __iommu_calculate_agaw(struct intel_iommu *iommu, int max_gaw)
 {
 	unsigned long sagaw;
@@ -822,14 +830,13 @@ out:
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 				      unsigned long pfn, int *target_level)
 {
-	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
 	struct dma_pte *parent, *pte = NULL;
 	int level = agaw_to_level(domain->agaw);
 	int offset;
 
 	BUG_ON(!domain->pgd);
 
-	if (addr_width < BITS_PER_LONG && pfn >> addr_width)
+	if (!domain_pfn_supported(domain, pfn))
 		/* Address beyond IOMMU's addressing capabilities. */
 		return NULL;
 
@@ -912,12 +919,11 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 				unsigned long start_pfn,
 				unsigned long last_pfn)
 {
-	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
 	unsigned int large_page = 1;
 	struct dma_pte *first_pte, *pte;
 
-	BUG_ON(addr_width < BITS_PER_LONG && start_pfn >> addr_width);
-	BUG_ON(addr_width < BITS_PER_LONG && last_pfn >> addr_width);
+	BUG_ON(!domain_pfn_supported(domain, start_pfn));
+	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	/* we don't need lock here; nobody else touches the iova range */
@@ -978,10 +984,8 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 				   unsigned long start_pfn,
 				   unsigned long last_pfn)
 {
-	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
-
-	BUG_ON(addr_width < BITS_PER_LONG && start_pfn >> addr_width);
-	BUG_ON(addr_width < BITS_PER_LONG && last_pfn >> addr_width);
+	BUG_ON(!domain_pfn_supported(domain, start_pfn));
+	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	dma_pte_clear_range(domain, start_pfn, last_pfn);
@@ -1083,11 +1087,10 @@ struct page *domain_unmap(struct dmar_domain *domain,
 			  unsigned long start_pfn,
 			  unsigned long last_pfn)
 {
-	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
 	struct page *freelist = NULL;
 
-	BUG_ON(addr_width < BITS_PER_LONG && start_pfn >> addr_width);
-	BUG_ON(addr_width < BITS_PER_LONG && last_pfn >> addr_width);
+	BUG_ON(!domain_pfn_supported(domain, start_pfn));
+	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	/* we don't need lock here; nobody else touches the iova range */
@@ -1974,12 +1977,11 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 {
 	struct dma_pte *first_pte = NULL, *pte = NULL;
 	phys_addr_t uninitialized_var(pteval);
-	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
 	unsigned long sg_res;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
 
-	BUG_ON(addr_width < BITS_PER_LONG && (iov_pfn + nr_pages - 1) >> addr_width);
+	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
 
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
-- 
1.7.10.4
