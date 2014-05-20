From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/5] iommu/amd: Convert IOMMUv2 state_table into state_list
Date: Tue, 20 May 2014 23:18:23 +0200
Message-ID: <1400620706-21031-3-git-send-email-joro@8bytes.org>
References: <1400620706-21031-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400620706-21031-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The state_table consumes 512kb of memory and is only sparsly
populated. Convert it into a list to save memory. There
should be no measurable performance impact.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 8c3086a..05e93f1 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -56,6 +56,8 @@ struct pasid_state {
 };
 
 struct device_state {
+	struct list_head list;
+	u16 devid;
 	atomic_t count;
 	struct pci_dev *pdev;
 	struct pasid_state **states;
@@ -81,7 +83,7 @@ struct fault {
 	u16 flags;
 };
 
-static struct device_state **state_table;
+static LIST_HEAD(state_list);
 static spinlock_t state_lock;
 
 /* List and lock for all pasid_states */
@@ -113,7 +115,14 @@ static u16 device_id(struct pci_dev *pdev)
 
 static struct device_state *__get_device_state(u16 devid)
 {
-	return state_table[devid];
+	struct device_state *dev_state;
+
+	list_for_each_entry(dev_state, &state_list, list) {
+		if (dev_state->devid == devid)
+			return dev_state;
+	}
+
+	return NULL;
 }
 
 static struct device_state *get_device_state(u16 devid)
@@ -776,7 +785,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	spin_lock_init(&dev_state->lock);
 	init_waitqueue_head(&dev_state->wq);
-	dev_state->pdev = pdev;
+	dev_state->pdev  = pdev;
+	dev_state->devid = devid;
 
 	tmp = pasids;
 	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
@@ -806,13 +816,13 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	spin_lock_irqsave(&state_lock, flags);
 
-	if (state_table[devid] != NULL) {
+	if (__get_device_state(devid) != NULL) {
 		spin_unlock_irqrestore(&state_lock, flags);
 		ret = -EBUSY;
 		goto out_free_domain;
 	}
 
-	state_table[devid] = dev_state;
+	list_add_tail(&dev_state->list, &state_list);
 
 	spin_unlock_irqrestore(&state_lock, flags);
 
@@ -850,7 +860,7 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 		return;
 	}
 
-	state_table[devid] = NULL;
+	list_del(&dev_state->list);
 
 	spin_unlock_irqrestore(&state_lock, flags);
 
@@ -925,7 +935,6 @@ EXPORT_SYMBOL(amd_iommu_set_invalidate_ctx_cb);
 
 static int __init amd_iommu_v2_init(void)
 {
-	size_t state_table_size;
 	int ret;
 
 	pr_info("AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>\n");
@@ -941,16 +950,10 @@ static int __init amd_iommu_v2_init(void)
 
 	spin_lock_init(&state_lock);
 
-	state_table_size = MAX_DEVICES * sizeof(struct device_state *);
-	state_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					       get_order(state_table_size));
-	if (state_table == NULL)
-		return -ENOMEM;
-
 	ret = -ENOMEM;
 	iommu_wq = create_workqueue("amd_iommu_v2");
 	if (iommu_wq == NULL)
-		goto out_free;
+		goto out;
 
 	ret = -ENOMEM;
 	empty_page_table = (u64 *)get_zeroed_page(GFP_KERNEL);
@@ -965,16 +968,13 @@ static int __init amd_iommu_v2_init(void)
 out_destroy_wq:
 	destroy_workqueue(iommu_wq);
 
-out_free:
-	free_pages((unsigned long)state_table, get_order(state_table_size));
-
+out:
 	return ret;
 }
 
 static void __exit amd_iommu_v2_exit(void)
 {
 	struct device_state *dev_state;
-	size_t state_table_size;
 	int i;
 
 	if (!amd_iommu_v2_supported())
@@ -1003,9 +1003,6 @@ static void __exit amd_iommu_v2_exit(void)
 
 	destroy_workqueue(iommu_wq);
 
-	state_table_size = MAX_DEVICES * sizeof(struct device_state *);
-	free_pages((unsigned long)state_table, get_order(state_table_size));
-
 	free_page((unsigned long)empty_page_table);
 }
 
-- 
1.7.9.5
