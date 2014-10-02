From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/vt-d: Store bus information in RMRR PCI device path
Date: Thu,  2 Oct 2014 12:09:07 +0200
Message-ID: <1412244548-27617-2-git-send-email-joro@8bytes.org>
References: <1412244548-27617-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1412244548-27617-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This will be used later to match broken RMRR entries.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/dmar.c | 1 +
 include/linux/dmar.h | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 06d268a..6ba28b0 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -155,6 +155,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 	if (event == BUS_NOTIFY_ADD_DEVICE) {
 		for (tmp = dev; tmp; tmp = tmp->bus->self) {
 			level--;
+			info->path[level].bus = tmp->bus->number;
 			info->path[level].device = PCI_SLOT(tmp->devfn);
 			info->path[level].function = PCI_FUNC(tmp->devfn);
 			if (pci_is_root_bus(tmp->bus))
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 1deece4..593fff9 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -56,13 +56,19 @@ struct dmar_drhd_unit {
 	struct intel_iommu *iommu;
 };
 
+struct dmar_pci_path {
+	u8 bus;
+	u8 device;
+	u8 function;
+};
+
 struct dmar_pci_notify_info {
 	struct pci_dev			*dev;
 	unsigned long			event;
 	int				bus;
 	u16				seg;
 	u16				level;
-	struct acpi_dmar_pci_path	path[];
+	struct dmar_pci_path		path[];
 }  __attribute__((packed));
 
 extern struct rw_semaphore dmar_global_lock;
-- 
1.9.1
