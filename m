From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 7/9] iommu/dmar: notify unrecoverable faults
Date: Wed, 14 Jun 2017 15:23:01 -0700
Message-ID: <1497478983-77580-8-git-send-email-jacob.jun.pan@linux.intel.com>
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

Currently, when device DMA faults are detected by IOMMU the fault
reasons are printed but the offending device is not notified.
This patch allows device drivers to be optionally notified for fault
conditions when device specific handling is needed for more subtle
processing, e.g. request with PASID transactions.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index cbf7763..2c0b80d464 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1587,11 +1587,43 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
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
+	if (!event)
+		return -ENOMEM;
+
+	pci_dev_get(pdev);
+	event->dev = &pdev->dev;
+	event->buf[0] = fault_reason;
+	event->addr = addr;
+	event->length = sizeof(fault_reason);
+	event->flags = IOMMU_FAULT_UNRECOV;
+	ret = iommu_fault_notifier_call_chain(event);
+
+	pci_dev_put(pdev);
+	kfree(event);
+
+	return ret;
+}
+
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		u8 fault_reason, u16 source_id, unsigned long long addr)
 {
 	const char *reason;
 	int fault_type;
+	int ret = 0;
 
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
@@ -1600,11 +1632,14 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 			source_id >> 8, PCI_SLOT(source_id & 0xFF),
 			PCI_FUNC(source_id & 0xFF), addr >> 48,
 			fault_reason, reason);
-	else
+	else {
 		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02d] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
+		ret = dmar_unrecov_fault_notify(fault_reason, source_id, addr);
+	}
+
 	return 0;
 }
 
-- 
2.7.4
