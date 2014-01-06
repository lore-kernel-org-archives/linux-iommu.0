From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 02/20] iommu/vt-d: fix PCI device reference leakage
	on error recovery path
Date: Mon,  6 Jan 2014 14:18:09 +0800
Message-ID: <1388989107-4795-3-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Function dmar_parse_dev_scope() should release the PCI device reference
count gained in function dmar_parse_one_dev_scope() on error recovery,
otherwise it will cause PCI device object leakage.

This patch also introduces dmar_free_dev_scope(), which will be used
to support DMAR device hotplug.

Reviewed-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c |   14 ++++++++++++--
 include/linux/dmar.h |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8b452c9..c17dbf7 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -100,7 +100,6 @@ static int __init dmar_parse_one_dev_scope(struct acpi_dmar_device_scope *scope,
 	if (!pdev) {
 		pr_warn("Device scope device [%04x:%02x:%02x.%02x] not found\n",
 			segment, scope->bus, path->device, path->function);
-		*dev = NULL;
 		return 0;
 	}
 	if ((scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT && \
@@ -151,7 +150,7 @@ int __init dmar_parse_dev_scope(void *start, void *end, int *cnt,
 			ret = dmar_parse_one_dev_scope(scope,
 				&(*devices)[index], segment);
 			if (ret) {
-				kfree(*devices);
+				dmar_free_dev_scope(devices, cnt);
 				return ret;
 			}
 			index ++;
@@ -162,6 +161,17 @@ int __init dmar_parse_dev_scope(void *start, void *end, int *cnt,
 	return 0;
 }
 
+void dmar_free_dev_scope(struct pci_dev ***devices, int *cnt)
+{
+	if (*devices && *cnt) {
+		while (--*cnt >= 0)
+			pci_dev_put((*devices)[*cnt]);
+		kfree(*devices);
+		*devices = NULL;
+		*cnt = 0;
+	}
+}
+
 /**
  * dmar_parse_one_drhd - parses exactly one DMA remapping hardware definition
  * structure which uniquely represent one DMA remapping hardware unit
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index b029d1a..8adfce0 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -159,6 +159,7 @@ extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header);
 extern int dmar_parse_one_atsr(struct acpi_dmar_header *header);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct pci_dev ***devices, u16 segment);
+extern void dmar_free_dev_scope(struct pci_dev ***devices, int *cnt);
 extern int intel_iommu_init(void);
 #else /* !CONFIG_INTEL_IOMMU: */
 static inline int intel_iommu_init(void) { return -ENODEV; }
-- 
1.7.10.4
