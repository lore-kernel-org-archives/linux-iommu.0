From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/5] iommu/amd: Use iommu core for passthrough mode
Date: Tue, 28 Jul 2015 16:58:48 +0200
Message-ID: <1438095531-26777-3-git-send-email-joro@8bytes.org>
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

Remove the AMD IOMMU driver implementation for passthrough
mode and rely on the new iommu core features for that.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      | 58 ++----------------------------------------
 drivers/iommu/amd_iommu_init.c | 10 +-------
 2 files changed, 3 insertions(+), 65 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a57e9b7..89e6d4b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -76,8 +76,6 @@ LIST_HEAD(hpet_map);
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
  */
-static struct protection_domain *pt_domain;
-
 static const struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
@@ -96,7 +94,7 @@ struct iommu_dev_data {
 	struct protection_domain *domain; /* Domain the device is bound to */
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
-	bool passthrough;		  /* Default for device is pt_domain */
+	bool passthrough;		  /* Device is identity mapped */
 	struct {
 		bool enabled;
 		int qdep;
@@ -116,7 +114,6 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
-static int alloc_passthrough_domain(void);
 static int protection_domain_init(struct protection_domain *domain);
 
 /****************************************************************************
@@ -2221,15 +2218,6 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 	do_detach(head);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
-
-	/*
-	 * If we run in passthrough mode the device must be assigned to the
-	 * passthrough domain if it is detached from any other domain.
-	 * Make sure we can deassign from the pt_domain itself.
-	 */
-	if (dev_data->passthrough &&
-	    (dev_data->domain == NULL && domain != pt_domain))
-		__attach_device(dev_data, pt_domain);
 }
 
 /*
@@ -2287,7 +2275,7 @@ static int amd_iommu_add_device(struct device *dev)
 
 	BUG_ON(!dev_data);
 
-	if (dev_data->iommu_v2)
+	if (iommu_pass_through || dev_data->iommu_v2)
 		iommu_request_dm_for_dev(dev);
 
 	/* Domains are initialized for this device - have a look what we ended up with */
@@ -2947,21 +2935,6 @@ out_err:
 	return NULL;
 }
 
-static int alloc_passthrough_domain(void)
-{
-	if (pt_domain != NULL)
-		return 0;
-
-	/* allocate passthrough domain */
-	pt_domain = protection_domain_alloc();
-	if (!pt_domain)
-		return -ENOMEM;
-
-	pt_domain->mode = PAGE_MODE_NONE;
-
-	return 0;
-}
-
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *pdomain;
@@ -3222,33 +3195,6 @@ static const struct iommu_ops amd_iommu_ops = {
  *
  *****************************************************************************/
 
-int __init amd_iommu_init_passthrough(void)
-{
-	struct iommu_dev_data *dev_data;
-	struct pci_dev *dev = NULL;
-	int ret;
-
-	ret = alloc_passthrough_domain();
-	if (ret)
-		return ret;
-
-	for_each_pci_dev(dev) {
-		if (!check_device(&dev->dev))
-			continue;
-
-		dev_data = get_dev_data(&dev->dev);
-		dev_data->passthrough = true;
-
-		attach_device(&dev->dev, pt_domain);
-	}
-
-	amd_iommu_stats_init();
-
-	pr_info("AMD-Vi: Initialized for Passthrough Mode\n");
-
-	return 0;
-}
-
 /* IOMMUv2 specific functions */
 int amd_iommu_register_ppr_notifier(struct notifier_block *nb)
 {
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index dbda9ae..a24495e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2026,14 +2026,6 @@ static bool detect_ivrs(void)
 	return true;
 }
 
-static int amd_iommu_init_dma(void)
-{
-	if (iommu_pass_through)
-		return amd_iommu_init_passthrough();
-	else
-		return amd_iommu_init_dma_ops();
-}
-
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -2073,7 +2065,7 @@ static int __init state_next(void)
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_INTERRUPTS_EN;
 		break;
 	case IOMMU_INTERRUPTS_EN:
-		ret = amd_iommu_init_dma();
+		ret = amd_iommu_init_dma_ops();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_DMA_OPS;
 		break;
 	case IOMMU_DMA_OPS:
-- 
1.9.1
