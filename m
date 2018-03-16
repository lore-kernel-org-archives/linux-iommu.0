From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 02/10] iommu/amd: turn dev_data_list into a lock less list
Date: Fri, 16 Mar 2018 21:18:28 +0100
Message-ID: <20180316201836.7864-3-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180316201836.7864-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

alloc_dev_data() adds new items to dev_data_list and search_dev_data()
is searching for items in this list. Both protect the access to the list
with a spinlock.
There is no need to navigate forth and back within the list and there is
also no deleting of a specific item. This qualifies the list to become a
lock less list and as part of this, the spinlock can be removed.
With this change the ordering of those items within the list is changed:
before the change new items were added to the end of the list, now they
are added to the front. I don't think it matters but wanted to mention
it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 28 ++++++++++------------------
 drivers/iommu/amd_iommu_types.h |  2 +-
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b50dcb17c68f..0e57ce2c258b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -83,8 +83,7 @@
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
 
 /* List of all available dev_data structures */
-static LIST_HEAD(dev_data_list);
-static DEFINE_SPINLOCK(dev_data_list_lock);
+static LLIST_HEAD(dev_data_list);
 
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
@@ -203,40 +202,33 @@ static struct dma_ops_domain* to_dma_ops_domain(struct protection_domain *domain
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
 
 	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
 	if (!dev_data)
 		return NULL;
 
 	dev_data->devid = devid;
-
-	spin_lock_irqsave(&dev_data_list_lock, flags);
-	list_add_tail(&dev_data->dev_data_list, &dev_data_list);
-	spin_unlock_irqrestore(&dev_data_list_lock, flags);
-
 	ratelimit_default_init(&dev_data->rs);
 
+	llist_add(&dev_data->dev_data_list, &dev_data_list);
 	return dev_data;
 }
 
 static struct iommu_dev_data *search_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
+	struct llist_node *node;
 
-	spin_lock_irqsave(&dev_data_list_lock, flags);
-	list_for_each_entry(dev_data, &dev_data_list, dev_data_list) {
+	if (llist_empty(&dev_data_list))
+		return NULL;
+
+	node = dev_data_list.first;
+	llist_for_each_entry(dev_data, node, dev_data_list) {
 		if (dev_data->devid == devid)
-			goto out_unlock;
+			return dev_data;
 	}
 
-	dev_data = NULL;
-
-out_unlock:
-	spin_unlock_irqrestore(&dev_data_list_lock, flags);
-
-	return dev_data;
+	return NULL;
 }
 
 static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index da886b0095aa..1c9b080276c9 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -627,7 +627,7 @@ struct devid_map {
  */
 struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
-	struct list_head dev_data_list;	  /* For global dev_data_list */
+	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	u16 devid;			  /* PCI Device ID */
 	u16 alias;			  /* Alias Device ID */
-- 
2.16.2
