From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/5] iommu/amd: Use iommu_attach_group()
Date: Tue, 28 Jul 2015 16:58:47 +0200
Message-ID: <1438095531-26777-2-git-send-email-joro@8bytes.org>
References: <1438095531-26777-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438095531-26777-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

Since the conversion to default domains the
iommu_attach_device function only works for devices with
their own group. But this isn't always true for current
IOMMUv2 capable devices, so use iommu_attach_group instead.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 3465faf..f7b875b 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -132,11 +132,19 @@ static struct device_state *get_device_state(u16 devid)
 
 static void free_device_state(struct device_state *dev_state)
 {
+	struct iommu_group *group;
+
 	/*
 	 * First detach device from domain - No more PRI requests will arrive
 	 * from that device after it is unbound from the IOMMUv2 domain.
 	 */
-	iommu_detach_device(dev_state->domain, &dev_state->pdev->dev);
+	group = iommu_group_get(&dev_state->pdev->dev);
+	if (WARN_ON(!group))
+		return;
+
+	iommu_detach_group(dev_state->domain, group);
+
+	iommu_group_put(group);
 
 	/* Everything is down now, free the IOMMUv2 domain */
 	iommu_domain_free(dev_state->domain);
@@ -731,6 +739,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
 int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 {
 	struct device_state *dev_state;
+	struct iommu_group *group;
 	unsigned long flags;
 	int ret, tmp;
 	u16 devid;
@@ -776,10 +785,16 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (ret)
 		goto out_free_domain;
 
-	ret = iommu_attach_device(dev_state->domain, &pdev->dev);
-	if (ret != 0)
+	group = iommu_group_get(&pdev->dev);
+	if (!group)
 		goto out_free_domain;
 
+	ret = iommu_attach_group(dev_state->domain, group);
+	if (ret != 0)
+		goto out_drop_group;
+
+	iommu_group_put(group);
+
 	spin_lock_irqsave(&state_lock, flags);
 
 	if (__get_device_state(devid) != NULL) {
@@ -794,6 +809,9 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	return 0;
 
+out_drop_group:
+	iommu_group_put(group);
+
 out_free_domain:
 	iommu_domain_free(dev_state->domain);
 
-- 
1.9.1
