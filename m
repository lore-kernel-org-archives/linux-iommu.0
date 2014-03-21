From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 15/33] iommu/vt-d: Remove device_to_iommu() call from
	domain_remove_dev_info()
Date: Fri, 21 Mar 2014 17:18:56 +0000
Message-ID: <1395422354-19762-16-git-send-email-David.Woodhouse@intel.com>
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

This was problematic because it works by domain/bus/devfn and we want
to make device_to_iommu() use only a struct device * (for handling non-PCI
devices). Now that the iommu pointer is reliably stored in the
device_domain_info, we don't need to look it up.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7e540a0..75ff1a1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2084,7 +2084,6 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	unsigned long flags, flags2;
-	struct intel_iommu *iommu;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	while (!list_empty(&domain->devices)) {
@@ -2094,16 +2093,15 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 
 		iommu_disable_dev_iotlb(info);
-		iommu = device_to_iommu(info->segment, info->bus, info->devfn);
-		iommu_detach_dev(iommu, info->bus, info->devfn);
+		iommu_detach_dev(info->iommu, info->bus, info->devfn);
 
 		if (domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) {
-			iommu_detach_dependent_devices(iommu, info->dev);
+			iommu_detach_dependent_devices(info->iommu, info->dev);
 			/* clear this iommu in iommu_bmp, update iommu count
 			 * and capabilities
 			 */
 			spin_lock_irqsave(&domain->iommu_lock, flags2);
-			if (test_and_clear_bit(iommu->seq_id,
+			if (test_and_clear_bit(info->iommu->seq_id,
 					       domain->iommu_bmp)) {
 				domain->iommu_count--;
 				domain_update_iommu_cap(domain);
-- 
1.8.5.3
