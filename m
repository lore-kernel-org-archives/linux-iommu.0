From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/core: pass user-provided token when handling faults
Date: Sun, 20 May 2012 12:15:11 +0300
Message-ID: <1337505311-25697-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Fernando Guzman Lugo <fernando.lugo-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Sometimes a single IOMMU user may have to deal with several
different IOMMU devices (e.g. remoteproc).

When an IOMMU fault happens, such users have to regain their
context in order to deal with the fault.

Users can't use the private fields of either the iommu_domain or
the IOMMU device, because those are already used by the IOMMU core
and low level driver (respectively).

This patch just simply allow users to pass a private token (most
notably their own context pointer) to iommu_set_fault_handler(),
and then makes sure it is provided back to the users whenever
IOMMU faults happen.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c |    5 ++++-
 include/linux/iommu.h |    8 +++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2198b2d..8b9ded8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -119,6 +119,7 @@ EXPORT_SYMBOL_GPL(iommu_present);
  * iommu_set_fault_handler() - set a fault handler for an iommu domain
  * @domain: iommu domain
  * @handler: fault handler
+ * @token: user data, will be passed back to the fault handler
  *
  * This function should be used by IOMMU users which want to be notified
  * whenever an IOMMU fault happens.
@@ -127,11 +128,13 @@ EXPORT_SYMBOL_GPL(iommu_present);
  * error code otherwise.
  */
 void iommu_set_fault_handler(struct iommu_domain *domain,
-					iommu_fault_handler_t handler)
+					iommu_fault_handler_t handler,
+					void *token)
 {
 	BUG_ON(!domain);
 
 	domain->handler = handler;
+	domain->handler_token = token;
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d937580..eb72d3b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -35,12 +35,13 @@ struct iommu_domain;
 #define IOMMU_FAULT_WRITE	0x1
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
-				struct device *, unsigned long, int);
+			struct device *, unsigned long, int, void *);
 
 struct iommu_domain {
 	struct iommu_ops *ops;
 	void *priv;
 	iommu_fault_handler_t handler;
+	void *handler_token;
 };
 
 #define IOMMU_CAP_CACHE_COHERENCY	0x1
@@ -95,7 +96,7 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
 				unsigned long cap);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
-					iommu_fault_handler_t handler);
+			iommu_fault_handler_t handler, void *token);
 extern int iommu_device_group(struct device *dev, unsigned int *groupid);
 
 /**
@@ -132,7 +133,8 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 	 * invoke it.
 	 */
 	if (domain->handler)
-		ret = domain->handler(domain, dev, iova, flags);
+		ret = domain->handler(domain, dev, iova, flags,
+						domain->handler_token);
 
 	return ret;
 }
-- 
1.7.5.4
