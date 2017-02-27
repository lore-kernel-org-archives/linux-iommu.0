From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
Date: Mon, 27 Feb 2017 19:54:35 +0000
Message-ID: <20170227195441.5170-25-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Provide a way for device drivers to tell the IOMMU driver about the state
of the PASID they are trying to decommission. When unbinding a task from a
device, the IOMMU driver needs to know whether it can immediately reuse
the PASID for another task, or if there is additional work to be done
before the PASID is safe to re-use.

One hard requirement when calling unbind is that the associated PASID is
not present in any transaction downstream of the IOMMU anymore. In other
words, any read, write, page requests referring to this PASID has
finished.

For PCIe, this means that the driver has successfully executed the
device-specific stop request mechanism described in 6.20.1 (Managing PASID
TLP Prefix Usage). In particular:

* device doesn't issue any new request for this PASID,
* all non-posted requests for this PASID have been completed,
* all posted requests for this PASID (addressing host memory) have been
  flushed to the host.

Address Translation Requests are non-posted, and PRI Page Requests (PPR)
are posted. In addition with PRI, device must implement one of the
following mechanism (ATS spec 4.1.2. - Managing PASID TLP Prefix Usage):

A. Finish transmitting any PPR affecting this PASID and wait for their
   response. In this case, the IOMMU driver can safely reuse the PASID and
   must not wait for a Stop Marker.

B. Finish transmitting any PPR affecting this PASID and send a Stop
   Marker. The driver must wait to receive a Stop Marker for this PASID
   before reusing it.

This patch lets the driver communicate the current state of the PASID with
either IOMMU_PASID_FLUSHED for case A, or IOMMU_PASID_CLEAN for case B.

It is an important distinction because, if the IOMMU driver reassigns a
PASID while the IOMMU still holds pending PPR targeting that PASID
internally, the PPR will trigger a fault in the wrong address space.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu.c |  8 ++++++++
 include/linux/iommu.h | 18 +++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 26c5f6528c69..eed52500d469 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1517,6 +1517,14 @@ EXPORT_SYMBOL_GPL(iommu_bind_task);
  * @dev: device bound to the task
  * @pasid: identifier of the bond
  * @flags: state of the PASID and driver-specific flags
+ *
+ * The caller must informs the IOMMU driver whether the PASID is safe to reuse
+ * immediately or if it needs more invalidation steps, by setting flags to
+ * either IOMMU_PASID_FLUSHED, or IOMMU_PASID_CLEAN.
+ *
+ * Without one of these flags, the device driver must have provided an
+ * invalidate_pasid callback in iommu_svm_ops. Otherwise, iommu_unbind_task
+ * returns an error.
  */
 int iommu_unbind_task(struct device *dev, int pasid, int flags)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9554f45d4305..204943ef38b2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -50,6 +50,21 @@ struct notifier_block;
 #define IOMMU_FAULT_READ	0x0
 #define IOMMU_FAULT_WRITE	0x1
 
+/*
+ * State of a PASID in the system
+ *
+ * IOMMU_PASID_FLUSHED: the device does not generate any traffic for this PASID
+ *   anymore, and all references to the PASID have been flushed; in other words,
+ *   the IOMMU will not receive any transaction referring to this instance of
+ *   the PASID anymore.
+ *
+ * IOMMU_PASID_CLEAN: in addition to IOMMU_PASID_FLUSHED, the PASID isn't
+ *   present in the IOMMU either. For instance when using PRI, the device waited
+ *   for all of its page requests to come back with a response.
+ */
+#define IOMMU_PASID_FLUSHED	0x1
+#define IOMMU_PASID_CLEAN	0x2
+
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
@@ -147,7 +162,8 @@ struct iommu_resv_region {
 
 /*
  * @handle_fault: report or handle a fault from the device (FIXME: imprecise)
- * @invalidate_pasid: stop using a PASID.
+ * @invalidate_pasid: stop using a PASID. Returns one of IOMMU_PASID_FLUSHED or
+ *                    IOMMU_PASID_CLEAN when stopped successfully. 0 otherwise.
  */
 struct iommu_svm_ops {
 	int (*handle_fault)(struct device *dev, int pasid, u64 address,
-- 
2.11.0
