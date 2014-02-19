From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 V2 04/17] iommu/vt-d: factor out dmar_alloc_dev_scope()
	for later reuse
Date: Wed, 19 Feb 2014 14:07:24 +0800
Message-ID: <1392790057-32434-5-git-send-email-jiang.liu@linux.intel.com>
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392790057-32434-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Factor out function dmar_alloc_dev_scope() from dmar_parse_dev_scope()
for later reuse.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c |   28 ++++++++++++++++------------
 include/linux/dmar.h |    1 +
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 1581565..58dde75 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -117,13 +117,9 @@ static int __init dmar_parse_one_dev_scope(struct acpi_dmar_device_scope *scope,
 	return 0;
 }
 
-int __init dmar_parse_dev_scope(void *start, void *end, int *cnt,
-				struct pci_dev ***devices, u16 segment)
+void *dmar_alloc_dev_scope(void *start, void *end, int *cnt)
 {
 	struct acpi_dmar_device_scope *scope;
-	void * tmp = start;
-	int index;
-	int ret;
 
 	*cnt = 0;
 	while (start < end) {
@@ -138,15 +134,24 @@ int __init dmar_parse_dev_scope(void *start, void *end, int *cnt,
 		start += scope->length;
 	}
 	if (*cnt == 0)
-		return 0;
+		return NULL;
+
+	return kcalloc(*cnt, sizeof(struct pci_dev *), GFP_KERNEL);
+}
+
+int __init dmar_parse_dev_scope(void *start, void *end, int *cnt,
+				struct pci_dev ***devices, u16 segment)
+{
+	struct acpi_dmar_device_scope *scope;
+	int index, ret;
 
-	*devices = kcalloc(*cnt, sizeof(struct pci_dev *), GFP_KERNEL);
-	if (!*devices)
+	*devices = dmar_alloc_dev_scope(start, end, cnt);
+	if (*cnt == 0)
+		return 0;
+	else if (!*devices)
 		return -ENOMEM;
 
-	start = tmp;
-	index = 0;
-	while (start < end) {
+	for (index = 0; start < end; start += scope->length) {
 		scope = start;
 		if (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT ||
 		    scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE) {
@@ -158,7 +163,6 @@ int __init dmar_parse_dev_scope(void *start, void *end, int *cnt,
 			}
 			index ++;
 		}
-		start += scope->length;
 	}
 
 	return 0;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index eccb0c0..1b08ce8 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -69,6 +69,7 @@ extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct pci_dev ***devices, u16 segment);
+extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
 extern void dmar_free_dev_scope(struct pci_dev ***devices, int *cnt);
 
 /* Intel IOMMU detection */
-- 
1.7.10.4
