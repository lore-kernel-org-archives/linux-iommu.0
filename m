From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 13/16] iommu/intel-svm: notify page request to guest
Date: Thu,  5 Oct 2017 16:03:41 -0700
Message-ID: <1507244624-39189-14-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

If the source device of a page request has its PASID table pointer
bond to a guest, the first level page tables are owned by the guest.
In this case, we shall let guest OS to manage page fault.

This patch uses the IOMMU fault notification API to send notifications,
possibly via VFIO, to the guest OS. Once guest pages are fault in, guest
will issue page response which will be passed down via the invalidation
passdown APIs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-svm.c | 87 +++++++++++++++++++++++++++++++++++++++++++----
 include/linux/iommu.h     |  1 +
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f6697e5..ea7c455 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -555,6 +555,78 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
+static int prq_to_iommu_prot(struct page_req_dsc *req)
+{
+	int prot = 0;
+
+	if (req->rd_req)
+		prot |= IOMMU_READ;
+	if (req->wr_req)
+		prot |= IOMMU_WRITE;
+	if (req->exe_req)
+		prot |= IOMMU_EXEC;
+	if (req->priv_req)
+		prot |= IOMMU_PRIV;
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
+	/**
+	 * Make sure PASID table pointer is bound to guest, if yes notify
+	 * handler in the guest, e.g. via VFIO.
+	 */
+	if (!dev->iommu_fault_param->pasid_tbl_bound) {
+		pr_debug("PRQ device pasid table not bound.\n");
+		ret = -EINVAL;
+		goto exit_put_dev;
+	}
+	/* Fill in event data for device specific processing */
+	event.type = IOMMU_FAULT_PAGE_REQ;
+	event.paddr = desc->addr;
+	event.pasid = desc->pasid;
+	event.page_req_group_id = desc->prg_index;
+	event.prot = prq_to_iommu_prot(desc);
+	event.last_req = desc->lpig;
+	event.pasid_valid = 1;
+	event.private_data = desc->private;
+	ret = iommu_report_device_fault(&pdev->dev, &event);
+
+exit_put_dev:
+	pci_dev_put(pdev);
+
+	return ret;
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -578,7 +650,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
@@ -649,11 +726,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
@@ -679,7 +752,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 			qi_submit_sync(&resp, iommu);
 		}
-
+	prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 44d2ada..a675775 100644
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
