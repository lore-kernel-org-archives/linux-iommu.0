From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] IOMMU: Use list_for_each_entry_safe() for
	dmar_domain->devices traversal
Date: Thu, 31 Oct 2013 17:26:04 +0800
Message-ID: <1383211564-39716-1-git-send-email-wangyijing@huawei.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Replace list_for_each_safe() + list_entry() with the simpler
list_for_each_entry_safe().

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 15e9b57..98faa1d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3777,11 +3777,10 @@ static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
 					  struct pci_dev *pdev)
 {
-	struct device_domain_info *info;
+	struct device_domain_info *info, *tmp;
 	struct intel_iommu *iommu;
 	unsigned long flags;
 	int found = 0;
-	struct list_head *entry, *tmp;
 
 	iommu = device_to_iommu(pci_domain_nr(pdev->bus), pdev->bus->number,
 				pdev->devfn);
@@ -3789,8 +3788,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_safe(entry, tmp, &domain->devices) {
-		info = list_entry(entry, struct device_domain_info, link);
+	list_for_each_entry_safe(info, tmp, &domain->devices, link) {
 		if (info->segment == pci_domain_nr(pdev->bus) &&
 		    info->bus == pdev->bus->number &&
 		    info->devfn == pdev->devfn) {
-- 
1.7.1
