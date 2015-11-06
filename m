From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 1/9] iommu/amd: Use standard bitmap operation to set bitmap
Date: Fri,  6 Nov 2015 20:10:43 +0800
Message-ID: <1446811851-20623-2-git-send-email-bhe@redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446811851-20623-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

It will be more readable then the old setting.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      | 2 +-
 drivers/iommu/amd_iommu_init.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 532e2a2..b01006d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1900,7 +1900,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	 * mark the first page as allocated so we never return 0 as
 	 * a valid dma-address. So we can use 0 as error value
 	 */
-	dma_dom->aperture[0]->bitmap[0] = 1;
+	__set_bit(0, dma_dom->aperture[0]->bitmap);
 	dma_dom->next_address = 0;
 
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 9f86ecf..1dcd8e3 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/list.h>
+#include <linux/bitmap.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
@@ -1941,8 +1942,7 @@ static int __init early_amd_iommu_init(void)
 	 * never allocate domain 0 because its used as the non-allocated and
 	 * error value placeholder
 	 */
-	amd_iommu_pd_alloc_bitmap[0] = 1;
-
+	 __set_bit(0, amd_iommu_pd_alloc_bitmap);
 	spin_lock_init(&amd_iommu_pd_lock);
 
 	/*
-- 
2.4.0
