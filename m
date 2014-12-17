From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v1 11/17] iommu/vt-d: Allow IR works in XAPIC mode though CPU
	works in X2APIC mode
Date: Wed, 17 Dec 2014 12:35:42 +0800
Message-ID: <1418790948-22804-12-git-send-email-jiang.liu@linux.intel.com>
References: <1418790948-22804-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418790948-22804-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently if CPU supports X2APIC, IR hardware must work in X2APIC mode
or disabled. Change the code to support IR working in XAPIC mode when
CPU supports X2APIC. Then the CPU APIC driver will decide how to handle
such as configuration by:
1) Disabling X2APIC mode
2) Forcing X2APIC physical mode

This change also fixes a live locking when
1) BIOS enables CPU X2APIC
2) DMAR table disables X2APIC mode or IR hardware doesn't support X2APIC
with following messages:
[   37.863463] dmar: INTR-REMAP: Request device [[f0:1f.7] fault index 2
[   37.863463] INTR-REMAP:[fault reason 36] Detected reserved fields in the IRTE entry
[   37.879372] dmar: INTR-REMAP: Request device [[f0:1f.7] fault index 2
[   37.879372] INTR-REMAP:[fault reason 36] Detected reserved fields in the IRTE entry
[   37.895282] dmar: INTR-REMAP: Request device [[f0:1f.7] fault index 2
[   37.895282] INTR-REMAP:[fault reason 36] Detected reserved fields in the IRTE entry
[   37.911192] dmar: INTR-REMAP: Request device [[f0:1f.7] fault index 2

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index a47cb31f198e..caf803ab1abc 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -32,8 +32,9 @@ struct hpet_scope {
 };
 
 #define IR_X2APIC_MODE(mode) (mode ? (1 << 11) : 0)
-#define IRTE_DEST(dest) ((x2apic_mode) ? dest : dest << 8)
+#define IRTE_DEST(dest) ((eim_mode) ? dest : dest << 8)
 
+static int __read_mostly eim_mode;
 static struct ioapic_scope ir_ioapic[MAX_IO_APICS];
 static struct hpet_scope ir_hpet[MAX_HPET_TBS];
 
@@ -644,8 +645,6 @@ static int __init intel_enable_irq_remapping(void)
 	int eim = 0;
 
 	if (x2apic_supported()) {
-		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
-
 		eim = !dmar_x2apic_optout();
 		if (!eim)
 			printk(KERN_WARNING
@@ -683,8 +682,11 @@ static int __init intel_enable_irq_remapping(void)
 		if (eim && !ecap_eim_support(iommu->ecap)) {
 			printk(KERN_INFO "DRHD %Lx: EIM not supported by DRHD, "
 			       " ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
-			goto error;
+			eim = 0;
 		}
+	eim_mode = eim;
+	if (eim)
+		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
 	/*
 	 * Enable queued invalidation for all the DRHD's.
-- 
1.7.10.4
