From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] iommu/amd: Attach and detach complete alias group
Date: Tue, 26 Aug 2014 11:36:13 +0200
Message-ID: <1409045774-32000-4-git-send-email-joro@8bytes.org>
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

Change tha device attach and detach semantic to apply to all
devices in an alias group. This means all devices in an
alias group are now attached and detached at the same time.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8a15256..a5e6b0a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2149,35 +2149,29 @@ static void do_detach(struct iommu_dev_data *dev_data)
 static int __attach_device(struct iommu_dev_data *dev_data,
 			   struct protection_domain *domain)
 {
+	struct iommu_dev_data *head, *entry;
 	int ret;
 
 	/* lock domain */
 	spin_lock(&domain->lock);
 
-	if (dev_data->alias_data != NULL) {
-		struct iommu_dev_data *alias_data = dev_data->alias_data;
-
-		/* Some sanity checks */
-		ret = -EBUSY;
-		if (alias_data->domain != NULL &&
-				alias_data->domain != domain)
-			goto out_unlock;
+	head = dev_data;
 
-		if (dev_data->domain != NULL &&
-				dev_data->domain != domain)
-			goto out_unlock;
+	if (head->alias_data != NULL)
+		head = head->alias_data;
 
-		/* Do real assignment */
-		if (alias_data->domain == NULL)
-			do_attach(alias_data, domain);
+	/* Now we have the root of the alias group, if any */
 
-		atomic_inc(&alias_data->bind);
-	}
+	ret = -EBUSY;
+	if (head->domain != NULL)
+		goto out_unlock;
 
-	if (dev_data->domain == NULL)
-		do_attach(dev_data, domain);
+	/* Attach alias group root */
+	do_attach(head, domain);
 
-	atomic_inc(&dev_data->bind);
+	/* Attach other devices in the alias group */
+	list_for_each_entry(entry, &head->alias_list, alias_list)
+		do_attach(entry, domain);
 
 	ret = 0;
 
@@ -2325,6 +2319,7 @@ static int attach_device(struct device *dev,
  */
 static void __detach_device(struct iommu_dev_data *dev_data)
 {
+	struct iommu_dev_data *head, *entry;
 	struct protection_domain *domain;
 	unsigned long flags;
 
@@ -2334,15 +2329,14 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	if (dev_data->alias_data != NULL) {
-		struct iommu_dev_data *alias_data = dev_data->alias_data;
+	head = dev_data;
+	if (head->alias_data != NULL)
+		head = head->alias_data;
 
-		if (atomic_dec_and_test(&alias_data->bind))
-			do_detach(alias_data);
-	}
+	list_for_each_entry(entry, &head->alias_list, alias_list)
+		do_detach(entry);
 
-	if (atomic_dec_and_test(&dev_data->bind))
-		do_detach(dev_data);
+	do_detach(head);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-- 
1.9.1
