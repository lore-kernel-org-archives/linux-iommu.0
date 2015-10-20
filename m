From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/12] iommu/amd: Do not iterate over alias-list in
	__[attach|detach]_device
Date: Tue, 20 Oct 2015 17:33:35 +0200
Message-ID: <1445355225-17557-3-git-send-email-joro@8bytes.org>
References: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445355225-17557-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

The alias list is handled aleady by iommu core code. No need
anymore to handle it in this part of the AMD IOMMU code

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bde87be..b86c5f0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2037,29 +2037,17 @@ static void do_detach(struct iommu_dev_data *dev_data)
 static int __attach_device(struct iommu_dev_data *dev_data,
 			   struct protection_domain *domain)
 {
-	struct iommu_dev_data *head, *entry;
 	int ret;
 
 	/* lock domain */
 	spin_lock(&domain->lock);
 
-	head = dev_data;
-
-	if (head->alias_data != NULL)
-		head = head->alias_data;
-
-	/* Now we have the root of the alias group, if any */
-
 	ret = -EBUSY;
-	if (head->domain != NULL)
+	if (dev_data->domain != NULL)
 		goto out_unlock;
 
 	/* Attach alias group root */
-	do_attach(head, domain);
-
-	/* Attach other devices in the alias group */
-	list_for_each_entry(entry, &head->alias_list, alias_list)
-		do_attach(entry, domain);
+	do_attach(dev_data, domain);
 
 	ret = 0;
 
@@ -2209,7 +2197,6 @@ static int attach_device(struct device *dev,
  */
 static void __detach_device(struct iommu_dev_data *dev_data)
 {
-	struct iommu_dev_data *head, *entry;
 	struct protection_domain *domain;
 	unsigned long flags;
 
@@ -2220,14 +2207,7 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	head = dev_data;
-	if (head->alias_data != NULL)
-		head = head->alias_data;
-
-	list_for_each_entry(entry, &head->alias_list, alias_list)
-		do_detach(entry);
-
-	do_detach(head);
+	do_detach(dev_data);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
-- 
1.9.1
