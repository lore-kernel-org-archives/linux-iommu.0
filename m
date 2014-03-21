From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/33] iommu/vt-d: use dmar_insert_dev_info() from
	dma_add_dev_info()
Date: Fri, 21 Mar 2014 17:18:52 +0000
Message-ID: <1395422354-19762-12-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/intel-iommu.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b50d1d6..3342d65 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2452,29 +2452,21 @@ static int domain_add_dev_info(struct dmar_domain *domain,
 			       struct pci_dev *pdev,
 			       int translation)
 {
+	struct dmar_domain *ndomain;
 	struct device_domain_info *info;
 	unsigned long flags;
 	int ret;
 
-	info = alloc_devinfo_mem();
-	if (!info)
-		return -ENOMEM;
-
-	info->segment = pci_domain_nr(pdev->bus);
-	info->bus = pdev->bus->number;
-	info->devfn = pdev->devfn;
-	info->dev = &pdev->dev;
-	info->domain = domain;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_add(&info->link, &domain->devices);
-	list_add(&info->global, &device_domain_list);
-	pdev->dev.archdata.iommu = info;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	ndomain = dmar_insert_dev_info(pci_domain_nr(pdev->bus),
+				       pdev->bus->number, pdev->devfn,
+				       &pdev->dev, domain);
+	if (ndomain != domain)
+		return -EBUSY;
 
 	ret = domain_context_mapping(domain, pdev, translation);
 	if (ret) {
 		spin_lock_irqsave(&device_domain_lock, flags);
+		info = pdev->dev.archdata.iommu;
 		unlink_domain_info(info);
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		free_devinfo_mem(info);
-- 
1.8.5.3
