From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/33] iommu/vt-d: Pass iommu to domain_context_mapping_one()
	and iommu_support_dev_iotlb()
Date: Fri, 21 Mar 2014 17:18:50 +0000
Message-ID: <1395422354-19762-10-git-send-email-David.Woodhouse@intel.com>
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

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ccef436..1ab7c18 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1240,13 +1240,13 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 			(unsigned long long)DMA_TLB_IAIG(val));
 }
 
-static struct device_domain_info *iommu_support_dev_iotlb(
-	struct dmar_domain *domain, int segment, u8 bus, u8 devfn)
+static struct device_domain_info *
+iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
+			 u8 bus, u8 devfn)
 {
 	int found = 0;
 	unsigned long flags;
 	struct device_domain_info *info;
-	struct intel_iommu *iommu = device_to_iommu(segment, bus, devfn);
 	struct pci_dev *pdev;
 
 	if (!ecap_dev_iotlb_support(iommu->ecap))
@@ -1700,12 +1700,12 @@ static void domain_exit(struct dmar_domain *domain)
 	free_domain_mem(domain);
 }
 
-static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
-				 u8 bus, u8 devfn, int translation)
+static int domain_context_mapping_one(struct dmar_domain *domain,
+				      struct intel_iommu *iommu,
+				      u8 bus, u8 devfn, int translation)
 {
 	struct context_entry *context;
 	unsigned long flags;
-	struct intel_iommu *iommu;
 	struct dma_pte *pgd;
 	unsigned long num;
 	unsigned long ndomains;
@@ -1720,10 +1720,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 	BUG_ON(translation != CONTEXT_TT_PASS_THROUGH &&
 	       translation != CONTEXT_TT_MULTI_LEVEL);
 
-	iommu = device_to_iommu(segment, bus, devfn);
-	if (!iommu)
-		return -ENODEV;
-
 	context = device_to_context_entry(iommu, bus, devfn);
 	if (!context)
 		return -ENOMEM;
@@ -1781,7 +1777,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 	context_set_domain_id(context, id);
 
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
-		info = iommu_support_dev_iotlb(domain, segment, bus, devfn);
+		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 		translation = info ? CONTEXT_TT_DEV_IOTLB :
 				     CONTEXT_TT_MULTI_LEVEL;
 	}
@@ -1836,8 +1832,14 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 {
 	int ret;
 	struct pci_dev *tmp, *parent;
+	struct intel_iommu *iommu;
+
+	iommu = device_to_iommu(pci_domain_nr(pdev->bus), pdev->bus->number,
+				pdev->devfn);
+	if (!iommu)
+		return -ENODEV;
 
-	ret = domain_context_mapping_one(domain, pci_domain_nr(pdev->bus),
+	ret = domain_context_mapping_one(domain, iommu,
 					 pdev->bus->number, pdev->devfn,
 					 translation);
 	if (ret)
@@ -1850,8 +1852,7 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 	/* Secondary interface's bus number and devfn 0 */
 	parent = pdev->bus->self;
 	while (parent != tmp) {
-		ret = domain_context_mapping_one(domain,
-						 pci_domain_nr(parent->bus),
+		ret = domain_context_mapping_one(domain, iommu,
 						 parent->bus->number,
 						 parent->devfn, translation);
 		if (ret)
@@ -1859,13 +1860,11 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 		parent = parent->bus->self;
 	}
 	if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
-		return domain_context_mapping_one(domain,
-					pci_domain_nr(tmp->subordinate),
+		return domain_context_mapping_one(domain, iommu,
 					tmp->subordinate->number, 0,
 					translation);
 	else /* this is a legacy PCI bridge */
-		return domain_context_mapping_one(domain,
-						  pci_domain_nr(tmp->bus),
+		return domain_context_mapping_one(domain, iommu,
 						  tmp->bus->number,
 						  tmp->devfn,
 						  translation);
-- 
1.8.5.3
