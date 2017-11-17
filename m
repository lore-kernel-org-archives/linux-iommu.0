From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 13/16] iommu/intel-svm: notify page request to guest
Date: Fri, 17 Nov 2017 10:55:11 -0800
Message-ID: <1510944914-54430-14-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1510944914-54430-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

If the source device of a page request has its PASID table pointer
bond to a guest, the first level page tables are owned by the guest.
In this case, we shall let guest OS to manage page fault.

This patch uses the IOMMU fault notification API to send notifications,
possibly via VFIO, to the guest OS. Once guest pages are fault in, guest
will issue page response which will be passed down via the invalidation
passdown APIs.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-svm.c | 80 ++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/iommu.h     |  1 +
 2 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f6697e5..77c25d8 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -555,6 +555,71 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
+static int prq_to_iommu_prot(struct page_req_dsc *req)
+{
+	int prot = 0;
+
+	if (req->rd_req)
+		prot |= IOMMU_FAULT_READ;
+	if (req->wr_req)
+		prot |= IOMMU_FAULT_WRITE;
+	if (req->exe_req)
+		prot |= IOMMU_FAULT_EXEC;
+	if (req->priv_req)
+		prot |= IOMMU_FAULT_PRIV;
+
+	return prot;
+}
+
+static int intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
+{
+	int ret = 0;
+	struct iommu_fault_event event;
+	struct pci_dev *pdev;
+
+	/**
+	 * If caller does not provide struct device, this is the case where
+	 * guest PASID table is bound to the device. So we need to retrieve
+	 * struct device from the page request descriptor then proceed.
+	 */
+	if (!dev) {
+		pdev = pci_get_bus_and_slot(desc->bus, desc->devfn);
+		if (!pdev) {
+			pr_err("No PCI device found for PRQ [%02x:%02x.%d]\n",
+				desc->bus, PCI_SLOT(desc->devfn),
+				PCI_FUNC(desc->devfn));
+			return -ENODEV;
+		}
+		dev = &pdev->dev;
+	} else if (dev_is_pci(dev)) {
+		pdev = to_pci_dev(dev);
+		pci_dev_get(pdev);
+	} else
+		return -ENODEV;
+
+	pr_debug("Notify PRQ device [%02x:%02x.%d]\n",
+		desc->bus, PCI_SLOT(desc->devfn),
+		PCI_FUNC(desc->devfn));
+
+	/* invoke device fault handler if registered */
+	if (iommu_has_device_fault_handler(dev)) {
+		/* Fill in event data for device specific processing */
+		event.type = IOMMU_FAULT_PAGE_REQ;
+		event.addr = desc->addr;
+		event.pasid = desc->pasid;
+		event.page_req_group_id = desc->prg_index;
+		event.prot = prq_to_iommu_prot(desc);
+		event.last_req = desc->lpig;
+		event.pasid_valid = 1;
+		event.iommu_private = desc->private;
+		ret = iommu_report_device_fault(&pdev->dev, &event);
+	}
+
+	pci_dev_put(pdev);
+
+	return ret;
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -578,7 +643,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		handled = 1;
 
 		req = &iommu->prq[head / sizeof(*req)];
-
+		/**
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		if (!intel_svm_prq_report(NULL, req))
+			goto prq_advance;
 		result = QI_RESP_FAILURE;
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 		if (!req->pasid_present) {
@@ -649,11 +719,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (WARN_ON(&sdev->list == &svm->devs))
 			sdev = NULL;
 
-		if (sdev && sdev->ops && sdev->ops->fault_cb) {
-			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
-				(req->exe_req << 1) | (req->priv_req);
-			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req->private, rwxp, result);
-		}
+		intel_svm_prq_report(sdev->dev, req);
 		/* We get here in the error case where the PASID lookup failed,
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
@@ -679,7 +745,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 			qi_submit_sync(&resp, iommu);
 		}
-
+	prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 841c044..3083796b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
+#define IOMMU_EXEC	(1 << 6)
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.7.4
