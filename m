From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 V2 06/17] iommu/vt-d: simplify function
	get_domain_for_dev()
Date: Wed, 19 Feb 2014 14:07:26 +0800
Message-ID: <1392790057-32434-7-git-send-email-jiang.liu@linux.intel.com>
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392790057-32434-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Function get_domain_for_dev() is a little complex, simplify it
by factoring out dmar_search_domain_by_dev_info() and
dmar_insert_dev_info().

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  142 ++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fffe3d1..67b114e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1957,18 +1957,71 @@ find_domain(struct pci_dev *pdev)
 	return NULL;
 }
 
+static inline struct dmar_domain *
+dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
+{
+	struct device_domain_info *info;
+
+	list_for_each_entry(info, &device_domain_list, global)
+		if (info->segment == segment && info->bus == bus &&
+		    info->devfn == devfn)
+			return info->domain;
+
+	return NULL;
+}
+
+static int dmar_insert_dev_info(int segment, int bus, int devfn,
+				struct pci_dev *dev, struct dmar_domain **domp)
+{
+	struct dmar_domain *found, *domain = *domp;
+	struct device_domain_info *info;
+	unsigned long flags;
+
+	info = alloc_devinfo_mem();
+	if (!info)
+		return -ENOMEM;
+
+	info->segment = segment;
+	info->bus = bus;
+	info->devfn = devfn;
+	info->dev = dev;
+	info->domain = domain;
+	if (!dev)
+		domain->flags |= DOMAIN_FLAG_P2P_MULTIPLE_DEVICES;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	if (dev)
+		found = find_domain(dev);
+	else
+		found = dmar_search_domain_by_dev_info(segment, bus, devfn);
+	if (found) {
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		free_devinfo_mem(info);
+		if (found != domain) {
+			domain_exit(domain);
+			*domp = found;
+		}
+	} else {
+		list_add(&info->link, &domain->devices);
+		list_add(&info->global, &device_domain_list);
+		if (dev)
+			dev->dev.archdata.iommu = info;
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+	}
+
+	return 0;
+}
+
 /* domain is initialized */
 static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 {
-	struct dmar_domain *domain, *found = NULL;
+	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
 	struct dmar_drhd_unit *drhd;
-	struct device_domain_info *info, *tmp;
 	struct pci_dev *dev_tmp;
 	unsigned long flags;
 	int bus = 0, devfn = 0;
 	int segment;
-	int ret;
 
 	domain = find_domain(pdev);
 	if (domain)
@@ -1986,41 +2039,29 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 			devfn = dev_tmp->devfn;
 		}
 		spin_lock_irqsave(&device_domain_lock, flags);
-		list_for_each_entry(info, &device_domain_list, global) {
-			if (info->segment == segment &&
-			    info->bus == bus && info->devfn == devfn) {
-				found = info->domain;
-				break;
-			}
-		}
+		domain = dmar_search_domain_by_dev_info(segment, bus, devfn);
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		/* pcie-pci bridge already has a domain, uses it */
-		if (found) {
-			domain = found;
+		if (domain)
 			goto found_domain;
-		}
 	}
 
-	domain = alloc_domain();
-	if (!domain)
-		goto error;
-
-	/* Allocate new domain for the device */
 	drhd = dmar_find_matched_drhd_unit(pdev);
 	if (!drhd) {
 		printk(KERN_ERR "IOMMU: can't find DMAR for device %s\n",
 			pci_name(pdev));
-		free_domain_mem(domain);
 		return NULL;
 	}
 	iommu = drhd->iommu;
 
-	ret = iommu_attach_domain(domain, iommu);
-	if (ret) {
+	/* Allocate and intialize new domain for the device */
+	domain = alloc_domain();
+	if (!domain)
+		goto error;
+	if (iommu_attach_domain(domain, iommu)) {
 		free_domain_mem(domain);
 		goto error;
 	}
-
 	if (domain_init(domain, gaw)) {
 		domain_exit(domain);
 		goto error;
@@ -2028,67 +2069,16 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 	/* register pcie-to-pci device */
 	if (dev_tmp) {
-		info = alloc_devinfo_mem();
-		if (!info) {
+		if (dmar_insert_dev_info(segment, bus, devfn, NULL, &domain)) {
 			domain_exit(domain);
 			goto error;
 		}
-		info->segment = segment;
-		info->bus = bus;
-		info->devfn = devfn;
-		info->dev = NULL;
-		info->domain = domain;
-		/* This domain is shared by devices under p2p bridge */
-		domain->flags |= DOMAIN_FLAG_P2P_MULTIPLE_DEVICES;
-
-		/* pcie-to-pci bridge already has a domain, uses it */
-		found = NULL;
-		spin_lock_irqsave(&device_domain_lock, flags);
-		list_for_each_entry(tmp, &device_domain_list, global) {
-			if (tmp->segment == segment &&
-			    tmp->bus == bus && tmp->devfn == devfn) {
-				found = tmp->domain;
-				break;
-			}
-		}
-		if (found) {
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			free_devinfo_mem(info);
-			domain_exit(domain);
-			domain = found;
-		} else {
-			list_add(&info->link, &domain->devices);
-			list_add(&info->global, &device_domain_list);
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-		}
 	}
 
 found_domain:
-	info = alloc_devinfo_mem();
-	if (!info)
-		goto error;
-	info->segment = segment;
-	info->bus = pdev->bus->number;
-	info->devfn = pdev->devfn;
-	info->dev = pdev;
-	info->domain = domain;
-	spin_lock_irqsave(&device_domain_lock, flags);
-	/* somebody is fast */
-	found = find_domain(pdev);
-	if (found != NULL) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
-		if (found != domain) {
-			domain_exit(domain);
-			domain = found;
-		}
-		free_devinfo_mem(info);
+	if (dmar_insert_dev_info(segment, pdev->bus->number, pdev->devfn,
+				 pdev, &domain) == 0)
 		return domain;
-	}
-	list_add(&info->link, &domain->devices);
-	list_add(&info->global, &device_domain_list);
-	pdev->dev.archdata.iommu = info;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-	return domain;
 error:
 	/* recheck it here, maybe others set it */
 	return find_domain(pdev);
-- 
1.7.10.4
