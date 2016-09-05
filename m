From: Joerg Roede <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/vt-d: Split up get_domain_for_dev function
Date: Mon,  5 Sep 2016 13:02:29 +0200
Message-ID: <1473073350-13591-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Split out the search for an already existing domain and the
context mapping of the device to the new domain.

This allows to map possible RMRR regions into the domain
before it is context mapped.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 76 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ebb5bf3..bcdbe9d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2452,20 +2452,15 @@ static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
 	return 0;
 }
 
-/* domain is initialized */
-static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
+static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 {
 	struct device_domain_info *info = NULL;
-	struct dmar_domain *domain, *tmp;
+	struct dmar_domain *domain = NULL;
 	struct intel_iommu *iommu;
 	u16 req_id, dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
 
-	domain = find_domain(dev);
-	if (domain)
-		return domain;
-
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return NULL;
@@ -2487,9 +2482,9 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 		}
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 
-		/* DMA alias already has a domain, uses it */
+		/* DMA alias already has a domain, use it */
 		if (info)
-			goto found_domain;
+			goto out;
 	}
 
 	/* Allocate and initialize new domain for the device */
@@ -2501,28 +2496,67 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 		return NULL;
 	}
 
-	/* register PCI DMA alias device */
-	if (dev_is_pci(dev) && req_id != dma_alias) {
-		tmp = dmar_insert_one_dev_info(iommu, PCI_BUS_NUM(dma_alias),
-					       dma_alias & 0xff, NULL, domain);
+out:
 
-		if (!tmp || tmp != domain) {
-			domain_exit(domain);
-			domain = tmp;
-		}
+	return domain;
+}
 
-		if (!domain)
-			return NULL;
+static struct dmar_domain *set_domain_for_dev(struct device *dev,
+					      struct dmar_domain *domain)
+{
+	struct intel_iommu *iommu;
+	struct dmar_domain *tmp;
+	u16 req_id, dma_alias;
+	u8 bus, devfn;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return NULL;
+
+	req_id = ((u16)bus << 8) | devfn;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		pci_for_each_dma_alias(pdev, get_last_alias, &dma_alias);
+
+		/* register PCI DMA alias device */
+		if (req_id != dma_alias) {
+			tmp = dmar_insert_one_dev_info(iommu, PCI_BUS_NUM(dma_alias),
+					dma_alias & 0xff, NULL, domain);
+
+			if (!tmp || tmp != domain)
+				return tmp;
+		}
 	}
 
-found_domain:
 	tmp = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
+	if (!tmp || tmp != domain)
+		return tmp;
+
+	return domain;
+}
 
-	if (!tmp || tmp != domain) {
+static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
+{
+	struct dmar_domain *domain, *tmp;
+
+	domain = find_domain(dev);
+	if (domain)
+		goto out;
+
+	domain = find_or_alloc_domain(dev, gaw);
+	if (!domain)
+		goto out;
+
+	tmp = set_domain_for_dev(dev, domain);
+	if (!tmp || domain != tmp) {
 		domain_exit(domain);
 		domain = tmp;
 	}
 
+out:
+
 	return domain;
 }
 
-- 
2.6.6
