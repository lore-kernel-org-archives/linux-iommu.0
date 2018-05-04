From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 3/3] iommu/amd: Do not flush when device is busy
Date: Fri,  4 May 2018 18:22:33 +0200
Message-ID: <20180504162233.11283-4-bigeasy@linutronix.de>
References: <20180504162233.11283-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180504162233.11283-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

When device is already attached to a domain, there is no need to execute
the domain_flush_tlb_pde(). Therefore move the check if the domain is set
into attach_device().

Signed-off-by: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f66a5d0b7c62..a801678ae1b4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1878,8 +1878,11 @@ static void clear_dte_entry(u16 devid)
 	amd_iommu_apply_erratum_63(devid);
 }
 
-static void do_attach(struct iommu_dev_data *dev_data,
-		      struct protection_domain *domain)
+/*
+ * This function does assigns the device visible for the hardware
+ */
+static void __attach_device(struct iommu_dev_data *dev_data,
+			    struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
 	u16 alias;
@@ -1932,23 +1935,6 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 	device_flush_dte(dev_data);
 }
 
-/*
- * If a device is not yet associated with a domain, this function does
- * assigns it visible for the hardware
- */
-static int __attach_device(struct iommu_dev_data *dev_data,
-			   struct protection_domain *domain)
-{
-	if (dev_data->domain != NULL)
-		return -EBUSY;
-
-	/* Attach alias group root */
-	do_attach(dev_data, domain);
-
-	return 0;
-}
-
-
 static void pdev_iommuv2_disable(struct pci_dev *pdev)
 {
 	pci_disable_ats(pdev);
@@ -2045,7 +2031,6 @@ static int attach_device(struct device *dev,
 	struct pci_dev *pdev;
 	struct iommu_dev_data *dev_data;
 	unsigned long flags;
-	int ret;
 
 	dev_data = get_dev_data(dev);
 
@@ -2073,8 +2058,11 @@ static int attach_device(struct device *dev,
 
 skip_ats_check:
 
+	if (dev_data->domain != NULL)
+		return -EBUSY;
+
 	spin_lock_irqsave(&domain->lock, flags);
-	ret = __attach_device(dev_data, domain);
+	__attach_device(dev_data, domain);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
 	/*
@@ -2084,7 +2072,7 @@ static int attach_device(struct device *dev,
 	 */
 	domain_flush_tlb_pde(domain);
 
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.17.0
