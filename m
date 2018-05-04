From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 1/3] iommu/amd: Prevent possible null pointer dereference and
	infinite loop
Date: Fri,  4 May 2018 18:22:31 +0200
Message-ID: <20180504162233.11283-2-bigeasy@linutronix.de>
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

The check for !dev_data->domain in __detach_device() emits a warning and
returns. The calling code in detach_device() dereferences dev_data->domain
afterwards unconditionally, so in case that dev_data->domain is NULL the
warning will be immediately followed by a NULL pointer dereference.

The calling code in cleanup_domain() loops infinite when !dev_data->domain
and the check in __detach_device() returns immediately because dev_list is
not changed.

do_detach() duplicates this check without throwing a warning.

Move the check with the explanation of the do_detach() code into the caller
detach_device() and return immediately. Throw an error, when hitting the
condition in cleanup_domain().

Signed-off-by: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c737fffe..e484275a4c69 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1911,15 +1911,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct amd_iommu *iommu;
 	u16 alias;
 
-	/*
-	 * First check if the device is still attached. It might already
-	 * be detached from its domain because the generic
-	 * iommu_detach_group code detached it and we try again here in
-	 * our alias handling.
-	 */
-	if (!dev_data->domain)
-		return;
-
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 	alias = dev_data->alias;
 
@@ -2124,9 +2115,6 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 	 */
 	WARN_ON(!irqs_disabled());
 
-	if (WARN_ON(!dev_data->domain))
-		return;
-
 	domain = dev_data->domain;
 
 	spin_lock(&domain->lock);
@@ -2148,6 +2136,15 @@ static void detach_device(struct device *dev)
 	dev_data = get_dev_data(dev);
 	domain   = dev_data->domain;
 
+	/*
+	 * First check if the device is still attached. It might already
+	 * be detached from its domain because the generic
+	 * iommu_detach_group code detached it and we try again here in
+	 * our alias handling.
+	 */
+	if (WARN_ON(!dev_data->domain))
+		return;
+
 	/* lock device table */
 	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	__detach_device(dev_data);
@@ -2793,6 +2790,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
+		BUG_ON(!entry->domain);
 		__detach_device(entry);
 	}
 
-- 
2.17.0
