From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 07/20] iommu/vt-d,
	trivial: check suitable flag in function detect_intel_iommu()
Date: Mon,  6 Jan 2014 14:18:14 +0800
Message-ID: <1388989107-4795-8-git-send-email-jiang.liu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Flag irq_remapping_enabled is only set by intel_enable_irq_remapping(),
which is called after detect_intel_iommu(). So moving pr_info() from
detect_intel_iommu() to intel_enable_irq_remapping(), which also
slightly simplifies implementation.

Reviewed-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c                |    8 --------
 drivers/iommu/intel_irq_remapping.c |    2 ++
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index c17dbf7..5e7ba3b 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -556,14 +556,6 @@ int __init detect_intel_iommu(void)
 	if (ret)
 		ret = check_zero_address();
 	{
-		struct acpi_table_dmar *dmar;
-
-		dmar = (struct acpi_table_dmar *) dmar_tbl;
-
-		if (ret && irq_remapping_enabled && cpu_has_x2apic &&
-		    dmar->flags & 0x1)
-			pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
-
 		if (ret && !no_iommu && !iommu_detected && !dmar_disabled) {
 			iommu_detected = 1;
 			/* Make sure ACS will be enabled */
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index deef3d4..2616e8a 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -561,6 +561,8 @@ static int __init intel_enable_irq_remapping(void)
 	}
 
 	if (x2apic_present) {
+		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
+
 		eim = !dmar_x2apic_optout();
 		if (!eim)
 			printk(KERN_WARNING
-- 
1.7.10.4
