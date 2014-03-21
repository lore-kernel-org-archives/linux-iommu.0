From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/33] iommu/vt-d: Stop dmar_insert_dev_info() freeing domains
	on losing race
Date: Fri, 21 Mar 2014 17:18:51 +0000
Message-ID: <1395422354-19762-11-git-send-email-David.Woodhouse@intel.com>
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

By moving this into get_domain_for_dev() we can make dmar_insert_dev_info()
suitable for use with "special" domains such as the si_domain, which
currently use domain_add_dev_info().

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1ab7c18..b50d1d6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2147,16 +2147,17 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 	return NULL;
 }
 
-static int dmar_insert_dev_info(int segment, int bus, int devfn,
-				struct device *dev, struct dmar_domain **domp)
+static struct dmar_domain *dmar_insert_dev_info(int segment, int bus, int devfn,
+						struct device *dev,
+						struct dmar_domain *domain)
 {
-	struct dmar_domain *found, *domain = *domp;
+	struct dmar_domain *found;
 	struct device_domain_info *info;
 	unsigned long flags;
 
 	info = alloc_devinfo_mem();
 	if (!info)
-		return -ENOMEM;
+		return NULL;
 
 	info->segment = segment;
 	info->bus = bus;
@@ -2174,19 +2175,17 @@ static int dmar_insert_dev_info(int segment, int bus, int devfn,
 	if (found) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		free_devinfo_mem(info);
-		if (found != domain) {
-			domain_exit(domain);
-			*domp = found;
-		}
-	} else {
-		list_add(&info->link, &domain->devices);
-		list_add(&info->global, &device_domain_list);
-		if (dev)
-			dev->archdata.iommu = info;
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+		/* Caller must free the original domain */
+		return found;
 	}
 
-	return 0;
+	list_add(&info->link, &domain->devices);
+	list_add(&info->global, &device_domain_list);
+	if (dev)
+		dev->archdata.iommu = info;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return domain;
 }
 
 /* domain is initialized */
@@ -2245,21 +2244,19 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 	/* register pcie-to-pci device */
 	if (dev_tmp) {
-		if (dmar_insert_dev_info(segment, bus, devfn, NULL, &domain))
+		domain = dmar_insert_dev_info(segment, bus, devfn, NULL, domain);
+		if (!domain)
 			goto error;
-		else
-			free = NULL;
 	}
 
 found_domain:
-	if (dmar_insert_dev_info(segment, pdev->bus->number, pdev->devfn,
-				 &pdev->dev, &domain) == 0)
-		return domain;
+	domain = dmar_insert_dev_info(segment, pdev->bus->number, pdev->devfn,
+				      &pdev->dev, domain);
 error:
-	if (free)
+	if (free != domain)
 		domain_exit(free);
-	/* recheck it here, maybe others set it */
-	return find_domain(&pdev->dev);
+
+	return domain;
 }
 
 static int iommu_identity_mapping;
-- 
1.8.5.3
