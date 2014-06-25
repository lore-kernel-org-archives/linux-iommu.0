From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V3 17/21] iommu/vt-d: search _DSM method for DMAR hotplug
Date: Wed, 25 Jun 2014 17:02:43 +0800
Message-ID: <1403686967-10887-18-git-send-email-jiang.liu@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403686967-10887-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

According to Intel VT-d specification, _DSM method to support DMAR
hotplug should exist directly under corresponding ACPI object
representing PCI host bridge. But some BIOSes doesn't conform to
this, so search for _DSM method in the subtree starting from the
ACPI object representing the PCI host bridge.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c |   35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index ea4771e68e59..8854b070b4bb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1921,21 +1921,48 @@ static int dmar_hotplug_remove(acpi_handle handle)
 	return ret;
 }
 
-static int dmar_device_hotplug(acpi_handle handle, bool insert)
+static acpi_status dmar_get_dsm_handle(acpi_handle handle, u32 lvl,
+				       void *context, void **retval)
+{
+	acpi_handle *phdl = retval;
+
+	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
+		*phdl = handle;
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+int dmar_device_hotplug(acpi_handle handle, bool insert)
 {
 	int ret;
+	acpi_handle tmp = NULL;
+	acpi_status status;
 
 	if (!dmar_in_use())
 		return 0;
 
-	if (!dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD))
+	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
+		tmp = handle;
+	} else {
+		status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
+					     ACPI_UINT32_MAX,
+					     dmar_get_dsm_handle,
+					     NULL, NULL, &tmp);
+		if (ACPI_FAILURE(status)) {
+			pr_warn("Failed to locate _DSM method.\n");
+			return -ENXIO;
+		}
+	}
+	if (tmp == NULL)
 		return 0;
 
 	down_write(&dmar_global_lock);
 	if (insert)
-		ret = dmar_hotplug_insert(handle);
+		ret = dmar_hotplug_insert(tmp);
 	else
-		ret = dmar_hotplug_remove(handle);
+		ret = dmar_hotplug_remove(tmp);
 	up_write(&dmar_global_lock);
 
 	return ret;
-- 
1.7.10.4
