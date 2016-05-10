From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] iommu/amd: Set AMD iommu callbacks for platform bus driver
Date: Tue, 10 May 2016 09:21:01 -0400
Message-ID: <1462886461-3149-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

AMD has more drivers will use ACPI to platform bus driver later,
all those devices need iommu support, for example: eMMC driver.

For latest AMD eMMC controller, it will utilize sdhci-acpi.c driver,
which will rely on platform bus to match device and driver, where we
will set 'dev' of struct platform_device as map_sg parameter passing
to iommu driver for DMA request, so the iommu-ops are needed on the
platform bus.

Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

---
changes from v1: Add comment why the iommu-ops are needed on platform bus.
---
 drivers/iommu/amd_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c430c10..547cdd4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/amba/bus.h>
+#include <linux/platform_device.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -2980,6 +2981,9 @@ int __init amd_iommu_init_api(void)
 	if (err)
 		return err;
 #endif
+	err = bus_set_iommu(&platform_bus_type, &amd_iommu_ops);
+	if (err)
+		return err;
 	return 0;
 }
 
-- 
1.9.1
