From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] iommu/amd: Remove device binding reference count
Date: Tue, 26 Aug 2014 11:36:14 +0200
Message-ID: <1409045774-32000-5-git-send-email-joro@8bytes.org>
References: <1409045774-32000-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409045774-32000-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This reference count is not used anymore, as all devices in
an alias group are now attached and detached together.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a5e6b0a..989c1ae 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -96,7 +96,6 @@ struct iommu_dev_data {
 	struct list_head alias_list;      /* Link alias-groups together */
 	struct iommu_dev_data *alias_data;/* The alias dev_data */
 	struct protection_domain *domain; /* Domain the device is bound to */
-	atomic_t bind;			  /* Domain attach reference count */
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
 	bool passthrough;		  /* Default for device is pt_domain */
@@ -139,7 +138,6 @@ static struct iommu_dev_data *alloc_dev_data(u16 devid)
 	INIT_LIST_HEAD(&dev_data->alias_list);
 
 	dev_data->devid = devid;
-	atomic_set(&dev_data->bind, 0);
 
 	spin_lock_irqsave(&dev_data_list_lock, flags);
 	list_add_tail(&dev_data->dev_data_list, &dev_data_list);
@@ -3179,7 +3177,6 @@ static void cleanup_domain(struct protection_domain *domain)
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
 		__detach_device(entry);
-		atomic_set(&entry->bind, 0);
 	}
 
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
-- 
1.9.1
