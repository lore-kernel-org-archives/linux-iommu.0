From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 12/26] iommu/vt-d: Simplify domain_remove_one_dev_info()
Date: Wed,  5 Aug 2015 17:18:43 +0200
Message-ID: <1438787937-7340-13-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Simplify this function as much as possible with the new
iommu_refcnt field.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 50 +++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ae2343c..f59b4ef 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4587,52 +4587,34 @@ static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
 				       struct device *dev)
 {
-	struct device_domain_info *info, *tmp;
+	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	unsigned long flags;
-	bool found = false;
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &domain->devices, link) {
-		if (info->iommu == iommu && info->bus == bus &&
-		    info->devfn == devfn) {
-			unlink_domain_info(info);
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-
-			iommu_disable_dev_iotlb(info);
-			iommu_detach_dev(iommu, info->bus, info->devfn);
-			iommu_detach_dependent_devices(iommu, dev);
-			free_devinfo_mem(info);
-
-			spin_lock_irqsave(&device_domain_lock, flags);
-
-			if (found)
-				break;
-			else
-				continue;
-		}
+	info = dev->archdata.iommu;
 
-		/*
-		 * If there is no other devices under the same iommu owned by
-		 * this domain, clear this iommu in iommu_refcnt update iommu
-		 * count and coherency.
-		 */
-		if (info->iommu == iommu)
-			found = true;
-	}
+	if (WARN_ON(!info))
+		return;
 
+	spin_lock_irqsave(&device_domain_lock, flags);
+	unlink_domain_info(info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
-	if (found == 0) {
-		domain_detach_iommu(domain, iommu);
-		if (!domain_type_is_vm_or_si(domain))
-			iommu_detach_domain(domain, iommu);
-	}
+	iommu_disable_dev_iotlb(info);
+	iommu_detach_dev(iommu, info->bus, info->devfn);
+	iommu_detach_dependent_devices(iommu, dev);
+	free_devinfo_mem(info);
+	domain_detach_iommu(domain, iommu);
+
+	spin_lock_irqsave(&domain->iommu_lock, flags);
+	if (!domain->iommu_refcnt[iommu->seq_id])
+		iommu_detach_domain(domain, iommu);
+	spin_unlock_irqrestore(&domain->iommu_lock, flags);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
-- 
1.9.1
