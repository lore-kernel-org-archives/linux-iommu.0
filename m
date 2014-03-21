From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 17/33] iommu/vt-d: Remove segment from struct
	device_domain_info()
Date: Fri, 21 Mar 2014 17:18:58 +0000
Message-ID: <1395422354-19762-18-git-send-email-David.Woodhouse@intel.com>
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

It's accessible via info->iommu->segment so this is redundant.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 75ff1a1..81f52d3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -369,7 +369,6 @@ struct dmar_domain {
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
 	struct list_head global; /* link to global list */
-	int segment;		/* PCI domain */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
@@ -2136,7 +2135,7 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 	struct device_domain_info *info;
 
 	list_for_each_entry(info, &device_domain_list, global)
-		if (info->segment == segment && info->bus == bus &&
+		if (info->iommu->segment == segment && info->bus == bus &&
 		    info->devfn == devfn)
 			return info;
 
@@ -2144,7 +2143,7 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 }
 
 static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
-						int segment, int bus, int devfn,
+						int bus, int devfn,
 						struct device *dev,
 						struct dmar_domain *domain)
 {
@@ -2156,7 +2155,6 @@ static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
 	if (!info)
 		return NULL;
 
-	info->segment = segment;
 	info->bus = bus;
 	info->devfn = devfn;
 	info->dev = dev;
@@ -2170,7 +2168,7 @@ static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
 		found = find_domain(dev);
 	else {
 		struct device_domain_info *info2;
-		info2 = dmar_search_domain_by_dev_info(segment, bus, devfn);
+		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
 		if (info2)
 			found = info2->domain;
 	}
@@ -2250,14 +2248,14 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 	/* register pcie-to-pci device */
 	if (dev_tmp) {
-		domain = dmar_insert_dev_info(iommu, segment, bus, devfn, NULL,
+		domain = dmar_insert_dev_info(iommu, bus, devfn, NULL,
 					      domain);
 		if (!domain)
 			goto error;
 	}
 
 found_domain:
-	domain = dmar_insert_dev_info(iommu, segment, pdev->bus->number,
+	domain = dmar_insert_dev_info(iommu, pdev->bus->number,
 				      pdev->devfn, &pdev->dev, domain);
 error:
 	if (free != domain)
@@ -2468,8 +2466,7 @@ static int domain_add_dev_info(struct dmar_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
-	ndomain = dmar_insert_dev_info(iommu, pci_domain_nr(pdev->bus),
-				       pdev->bus->number, pdev->devfn,
+	ndomain = dmar_insert_dev_info(iommu, pdev->bus->number, pdev->devfn,
 				       &pdev->dev, domain);
 	if (ndomain != domain)
 		return -EBUSY;
@@ -4031,7 +4028,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &domain->devices, link) {
-		if (info->segment == pci_domain_nr(pdev->bus) &&
+		if (info->iommu->segment == pci_domain_nr(pdev->bus) &&
 		    info->bus == pdev->bus->number &&
 		    info->devfn == pdev->devfn) {
 			unlink_domain_info(info);
-- 
1.8.5.3
