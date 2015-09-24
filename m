From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 02/10] iommu/amd: Adjust functons which get first/last devid
	by reading pci config
Date: Thu, 24 Sep 2015 14:37:28 +0800
Message-ID: <1443076656-31776-3-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The old functon find_last_devid_on_pci not only gets the last devid, but calls
update_last_devid(). Now adjust the function definition to make it be consistent
with its name. Meanwhile add a new function find_first_devid_on_pci for later use.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 286da26..be20a56 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -412,14 +412,32 @@ static inline int ivhd_entry_length(u8 *ivhd)
  * This function reads the last device id the IOMMU has to handle from the PCI
  * capability header for this IOMMU
  */
-static int __init find_last_devid_on_pci(int bus, int dev, int fn, int cap_ptr)
+static int __init find_first_devid_on_pci(struct ivhd_header *h)
 {
-	u32 cap;
+	u32 range;
 
-	cap = read_pci_config(bus, dev, fn, cap_ptr+MMIO_RANGE_OFFSET);
-	update_last_devid(PCI_DEVID(MMIO_GET_BUS(cap), MMIO_GET_LD(cap)));
+	range = read_pci_config(PCI_BUS_NUM(h->devid),
+				PCI_SLOT(h->devid),
+				PCI_FUNC(h->devid),
+				h->cap_ptr+MMIO_RANGE_OFFSET);
 
-	return 0;
+	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_FD(range));
+}
+
+/*
+ * This function reads the last device id the IOMMU has to handle from the PCI
+ * capability header for this IOMMU
+ */
+static int __init find_last_devid_on_pci(struct ivhd_header *h)
+{
+	u32 range;
+
+	range = read_pci_config(PCI_BUS_NUM(h->devid),
+				PCI_SLOT(h->devid),
+				PCI_FUNC(h->devid),
+				h->cap_ptr+MMIO_RANGE_OFFSET);
+
+	return PCI_DEVID(MMIO_GET_BUS(range), MMIO_GET_LD(range));
 }
 
 /*
@@ -430,15 +448,14 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 {
 	u8 *p = (void *)h, *end = (void *)h;
 	struct ivhd_entry *dev;
+	u16 devid;
+
+	devid = find_last_devid_on_pci(h);
+	update_last_devid(devid);
 
 	p += sizeof(*h);
 	end += h->length;
 
-	find_last_devid_on_pci(PCI_BUS_NUM(h->devid),
-			PCI_SLOT(h->devid),
-			PCI_FUNC(h->devid),
-			h->cap_ptr);
-
 	while (p < end) {
 		dev = (struct ivhd_entry *)p;
 		switch (dev->type) {
-- 
2.4.0
