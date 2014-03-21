From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 25/33] iommu/vt-d: Remove some pointless to_pci_dev() calls
Date: Fri, 21 Mar 2014 17:19:06 +0000
Message-ID: <1395422354-19762-26-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Mostly made redundant by using dev_name() instead of pci_name(), and one
instance of using *dev->dma_mask instead of pdev->dma_mask.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 41eafc3..cfe08ea 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2835,7 +2835,6 @@ static struct iova *intel_alloc_iova(struct device *dev,
 				     struct dmar_domain *domain,
 				     unsigned long nrpages, uint64_t dma_mask)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iova *iova = NULL;
 
 	/* Restrict dma_mask to the width that the iommu can handle */
@@ -2855,7 +2854,7 @@ static struct iova *intel_alloc_iova(struct device *dev,
 	iova = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
 	if (unlikely(!iova)) {
 		printk(KERN_ERR "Allocating %ld-page iova for %s failed",
-		       nrpages, pci_name(pdev));
+		       nrpages, dev_name(dev));
 		return NULL;
 	}
 
@@ -2959,7 +2958,6 @@ static int iommu_no_mapping(struct device *dev)
 static dma_addr_t __intel_map_single(struct device *hwdev, phys_addr_t paddr,
 				     size_t size, int dir, u64 dma_mask)
 {
-	struct pci_dev *pdev = to_pci_dev(hwdev);
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
 	struct iova *iova;
@@ -3018,7 +3016,7 @@ error:
 	if (iova)
 		__free_iova(&domain->iovad, iova);
 	printk(KERN_ERR"Device %s request: %zx@%llx dir %d --- failed\n",
-		pci_name(pdev), size, (unsigned long long)paddr, dir);
+		dev_name(hwdev), size, (unsigned long long)paddr, dir);
 	return 0;
 }
 
@@ -3115,7 +3113,6 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     struct dma_attrs *attrs)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
 	struct iova *iova;
@@ -3139,7 +3136,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 	last_pfn = mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
 
 	pr_debug("Device %s unmapping: pfn %lx-%lx\n",
-		 pci_name(pdev), start_pfn, last_pfn);
+		 dev_name(dev), start_pfn, last_pfn);
 
 	freelist = domain_unmap(domain, start_pfn, last_pfn);
 
@@ -3264,7 +3261,6 @@ static int intel_map_sg(struct device *hwdev, struct scatterlist *sglist, int ne
 			enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	int i;
-	struct pci_dev *pdev = to_pci_dev(hwdev);
 	struct dmar_domain *domain;
 	size_t size = 0;
 	int prot = 0;
@@ -3288,7 +3284,7 @@ static int intel_map_sg(struct device *hwdev, struct scatterlist *sglist, int ne
 		size += aligned_nrpages(sg->offset, sg->length);
 
 	iova = intel_alloc_iova(hwdev, domain, dma_to_mm_pfn(size),
-				pdev->dma_mask);
+				*hwdev->dma_mask);
 	if (!iova) {
 		sglist->dma_length = 0;
 		return 0;
-- 
1.8.5.3
