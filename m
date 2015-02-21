From: "Fenghua Yu" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] driver/iommu/intel_irq_remapping: Print x2apic opt out info
	instead of printing a warning
Date: Sat, 21 Feb 2015 13:07:27 -0800
Message-ID: <1424552847-40775-1-git-send-email-fenghua.yu@intel.com>
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

BIOS can set up x2apic_opt_out bit on some platforms. This is not a BIOS
problem. A user can either disable the x2apic_opt_out bit in BIOS or by kernel
parameter "no_x2apic_optout". Instead of printing a warning, we just print
information of x2apic opt out.

Signed-off-by: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 14de1ab..cd3c4d6 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -637,10 +637,7 @@ static int __init intel_enable_irq_remapping(void)
 	if (x2apic_supported()) {
 		eim = !dmar_x2apic_optout();
 		if (!eim)
-			printk(KERN_WARNING
-				"Your BIOS is broken and requested that x2apic be disabled.\n"
-				"This will slightly decrease performance.\n"
-				"Use 'intremap=no_x2apic_optout' to override BIOS request.\n");
+			pr_info("x2apic is disabled because BIOS sets x2apic opt out bit. You can use 'intremap=no_x2apic_optout' to override the BIOS setting.\n");
 	}
 
 	for_each_iommu(iommu, drhd) {
-- 
1.8.1.2
