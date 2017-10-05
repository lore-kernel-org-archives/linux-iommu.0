From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 12/16] iommu/vt-d: report unrecoverable device faults
Date: Thu,  5 Oct 2017 16:03:40 -0700
Message-ID: <1507244624-39189-13-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507244624-39189-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently, when device DMA faults are detected by IOMMU the fault
reasons are printed but the driver of the offending device is
involved in fault handling.
This patch uses per device fault reporting API to send fault event
data for further processing.
Offending device is identified by the source ID in VT-d fault reason
report registers.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index ae33d61..43ea7ab 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1554,6 +1554,31 @@ static const char *irq_remap_fault_reasons[] =
 	"Blocked an interrupt request due to source-id verification failure",
 };
 
+/* fault data and status */
+enum intel_iommu_fault_reason {
+	INTEL_IOMMU_FAULT_REASON_SW,
+	INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT,
+	INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT,
+	INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID,
+	INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH,
+	INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS,
+	INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS,
+	INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID,
+	INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID,
+	INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID,
+	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_RTP,
+	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_CTP,
+	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_PTE,
+	NR_INTEL_IOMMU_FAULT_REASON,
+};
+
+/* fault reasons that are allowed to be reported outside IOMMU subsystem */
+#define INTEL_IOMMU_FAULT_REASON_ALLOWED			\
+	((1ULL << INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH) |	\
+		(1ULL << INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS) |	\
+		(1ULL << INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS))
+
+
 static const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
 {
 	if (fault_reason >= 0x20 && (fault_reason - 0x20 <
@@ -1634,6 +1659,70 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
+static enum iommu_fault_reason to_iommu_fault_reason(u8 reason)
+{
+	if (reason >= NR_INTEL_IOMMU_FAULT_REASON) {
+		pr_warn("unknown DMAR fault reason %d\n", reason);
+		return IOMMU_FAULT_REASON_UNKNOWN;
+	}
+	switch (reason) {
+	case INTEL_IOMMU_FAULT_REASON_SW:
+	case INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT:
+	case INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT:
+	case INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID:
+	case INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH:
+	case INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID:
+	case INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID:
+		return IOMMU_FAULT_REASON_CTX;
+	case INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID:
+	case INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS:
+	case INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS:
+		return IOMMU_FAULT_REASON_ACCESS;
+	default:
+		return IOMMU_FAULT_REASON_UNKNOWN;
+	}
+}
+
+static void report_fault_to_device(struct intel_iommu *iommu, u64 addr, int type,
+				int fault_type, enum intel_iommu_fault_reason reason, u16 sid)
+{
+	struct iommu_fault_event event;
+	struct pci_dev *pdev;
+	u8 bus, devfn;
+
+	/* check if fault reason is worth reporting outside IOMMU */
+	if (!((1 << reason) & INTEL_IOMMU_FAULT_REASON_ALLOWED)) {
+		pr_debug("Fault reason %d not allowed to report to device\n",
+			reason);
+		return;
+	}
+
+	bus = PCI_BUS_NUM(sid);
+	devfn = PCI_DEVFN(PCI_SLOT(sid), PCI_FUNC(sid));
+	/*
+	 * we need to check if the fault reporting is requested for the
+	 * offending device.
+	 */
+	pdev = pci_get_bus_and_slot(bus, devfn);
+	if (!pdev) {
+		pr_warn("No PCI device found for source ID %x\n", sid);
+		return;
+	}
+	/*
+	 * unrecoverable fault is reported per IOMMU, notifier handler can
+	 * resolve PCI device based on source ID.
+	 */
+	event.reason = to_iommu_fault_reason(reason);
+	event.paddr = addr;
+	event.rid = sid;
+	event.type = IOMMU_FAULT_DMA_UNRECOV;
+	event.prot = type ? IOMMU_READ : IOMMU_WRITE;
+	dev_warn(&pdev->dev, "report device unrecoverable fault: %d, %x, %d\n",
+		event.reason, event.rid, event.type);
+	iommu_report_device_fault(&pdev->dev, &event);
+	pci_dev_put(pdev);
+}
+
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		u8 fault_reason, u16 source_id, unsigned long long addr)
 {
@@ -1647,11 +1736,15 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 			source_id >> 8, PCI_SLOT(source_id & 0xFF),
 			PCI_FUNC(source_id & 0xFF), addr >> 48,
 			fault_reason, reason);
-	else
+	else {
 		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02d] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
+	}
+	report_fault_to_device(iommu, addr, type, fault_type,
+			fault_reason, source_id);
+
 	return 0;
 }
 
-- 
2.7.4
