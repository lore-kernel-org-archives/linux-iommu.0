From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 7/9] iommu/dmar: notify unrecoverable faults
Date: Tue, 27 Jun 2017 12:48:01 -0700
Message-ID: <1498592883-56224-8-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Currently, when device DMA faults are detected by IOMMU the fault
reasons are printed but the offending device is not notified.
This patch allows device drivers to be optionally notified for fault
conditions when device specific handling is needed for more subtle
processing, e.g. request with PASID transactions.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/dmar.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index cbf7763..459a472 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1587,6 +1587,39 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
+static int dmar_unrecov_fault_notify(u8 fault_reason, u16 source_id,
+			unsigned long long addr)
+{
+	int ret;
+	struct pci_dev *pdev;
+	struct iommu_fault_event *event;
+
+	pdev = pci_get_bus_and_slot(source_id >> 8, source_id & 0xFF);
+	if (!pdev)
+		return -ENODEV;
+	pr_debug("Notify PCI device fault [%02x:%02x.%d]\n",
+		source_id >> 8, PCI_SLOT(source_id & 0xff),
+		PCI_FUNC(source_id & 0xff));
+	event = kzalloc(sizeof(*event) + sizeof(fault_reason), GFP_KERNEL);
+	if (!event) {
+		ret = -ENOMEM;
+		goto exit_dev_put;
+	}
+
+	event->dev = &pdev->dev;
+	event->buf[0] = fault_reason;
+	event->addr = addr;
+	event->length = sizeof(fault_reason);
+	event->flags = IOMMU_FAULT_UNRECOV;
+	ret = iommu_fault_notifier_call_chain(event);
+
+	kfree(event);
+exit_dev_put:
+	pci_dev_put(pdev);
+
+	return ret;
+}
+
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		u8 fault_reason, u16 source_id, unsigned long long addr)
 {
@@ -1600,11 +1633,14 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 			source_id >> 8, PCI_SLOT(source_id & 0xFF),
 			PCI_FUNC(source_id & 0xFF), addr >> 48,
 			fault_reason, reason);
-	else
+	else {
 		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02d] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
+		dmar_unrecov_fault_notify(fault_reason, source_id, addr);
+	}
+
 	return 0;
 }
 
-- 
2.7.4
