From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 8/9] iommu/intel-svm: notify page request to guest
Date: Wed, 14 Jun 2017 15:23:02 -0700
Message-ID: <1497478983-77580-9-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1497478983-77580-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
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
 drivers/iommu/intel-svm.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 23c4276..d1d2d23 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -525,6 +525,80 @@ static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
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
+	 * guest PASID table is bond to the device. So we need to retrieve
+	 * struct device from the page request deescriptor then proceed.
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
+		 * Make sure PASID table pointer is bond to guest, if yes notify
+		 * handler in the guest, e.g. via VFIO.
+		 */
+		info = pdev->dev.archdata.iommu;
+		if (!info || !info->pasid_tbl_bond) {
+			pr_debug("PRQ device pasid table not bond.\n");
+			return -EINVAL;
+		}
+		dev = &pdev->dev;
+	}
+
+	pr_debug("Notify PRQ device [%02x:%02x.%d]\n",
+		desc->bus, PCI_SLOT(desc->devfn),
+		PCI_FUNC(desc->devfn));
+	event = kzalloc(sizeof(*event) + sizeof(*desc), GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
+
+	get_device(dev);
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
+	put_device(dev);
+	kfree(event);
+
+	return ret;
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -548,7 +622,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
-- 
2.7.4
