From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/5] iommu/amd: Don't access IOMMUv2 state_table directly
Date: Tue, 20 May 2014 23:18:22 +0200
Message-ID: <1400620706-21031-2-git-send-email-joro@8bytes.org>
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

This is a preparation for converting the state_table into a
state_list.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 5208828..8c3086a 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -111,13 +111,18 @@ static u16 device_id(struct pci_dev *pdev)
 	return devid;
 }
 
+static struct device_state *__get_device_state(u16 devid)
+{
+	return state_table[devid];
+}
+
 static struct device_state *get_device_state(u16 devid)
 {
 	struct device_state *dev_state;
 	unsigned long flags;
 
 	spin_lock_irqsave(&state_lock, flags);
-	dev_state = state_table[devid];
+	dev_state = __get_device_state(devid);
 	if (dev_state != NULL)
 		atomic_inc(&dev_state->count);
 	spin_unlock_irqrestore(&state_lock, flags);
@@ -839,7 +844,7 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 
 	spin_lock_irqsave(&state_lock, flags);
 
-	dev_state = state_table[devid];
+	dev_state = __get_device_state(devid);
 	if (dev_state == NULL) {
 		spin_unlock_irqrestore(&state_lock, flags);
 		return;
@@ -872,7 +877,7 @@ int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
 	spin_lock_irqsave(&state_lock, flags);
 
 	ret = -EINVAL;
-	dev_state = state_table[devid];
+	dev_state = __get_device_state(devid);
 	if (dev_state == NULL)
 		goto out_unlock;
 
@@ -903,7 +908,7 @@ int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
 	spin_lock_irqsave(&state_lock, flags);
 
 	ret = -EINVAL;
-	dev_state = state_table[devid];
+	dev_state = __get_device_state(devid);
 	if (dev_state == NULL)
 		goto out_unlock;
 
-- 
1.7.9.5
