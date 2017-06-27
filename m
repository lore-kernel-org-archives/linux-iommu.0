From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 8/9] iommu/intel-svm: notify page request to guest
Date: Tue, 27 Jun 2017 12:48:02 -0700
Message-ID: <1498592883-56224-9-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
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
 drivers/iommu/intel-svm.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  1 +
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 23c4276..98fca35 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -525,6 +525,88 @@ static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
 	return (requested & ~vma->vm_flags) != 0;
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
+static int intel_svm_prq_notify(struct device *dev, struct page_req_dsc *desc)
+{
+	int ret = 0;
+	struct iommu_fault_event *event;
+	struct pci_dev *pdev;
+	struct device_domain_info *info;
+	unsigned long buf_offset;
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
+		/**
+		 * Make sure PASID table pointer is bound to guest, if yes notify
+		 * handler in the guest, e.g. via VFIO.
+		 */
+		info = pdev->dev.archdata.iommu;
+		if (!info || !info->pasid_tbl_bound) {
+			pr_debug("PRQ device pasid table not bound.\n");
+			ret = -EINVAL;
+			goto exit_put_dev;
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
+	event = kzalloc(sizeof(*event) + sizeof(*desc), GFP_KERNEL);
+	if (!event) {
+		ret = -ENOMEM;
+		goto exit_put_dev;
+	}
+
+	/* Fill in event data for device specific processing */
+	event->dev = dev;
+	buf_offset = offsetofend(struct iommu_fault_event, length);
+	memcpy(buf_offset + event, desc, sizeof(*desc));
+	event->addr = desc->addr;
+	event->pasid = desc->pasid;
+	event->prot = prq_to_iommu_prot(desc);
+	event->length = sizeof(*desc);
+	event->flags = IOMMU_FAULT_PAGE_REQ;
+
+	ret = iommu_fault_notifier_call_chain(event);
+	kfree(event);
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
@@ -548,7 +630,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		handled = 1;
 
 		req = &iommu->prq[head / sizeof(*req)];
-
+		/**
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		if (!intel_svm_prq_notify(NULL, req))
+			continue;
 		result = QI_RESP_FAILURE;
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 		if (!req->pasid_present) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ed2f804..d0f28cd 100644
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
