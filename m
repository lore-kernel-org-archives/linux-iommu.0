From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v7 6/8] iommu,
	x86: Setup Posted-Interrupts capability for Intel iommu
Date: Mon, 25 May 2015 13:28:52 +0800
Message-ID: <1432531734-25978-7-git-send-email-feng.wu@intel.com>
References: <1432531734-25978-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432531734-25978-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Set Posted-Interrupts capability for Intel iommu when IR is enabled,
clear it when IR is disabled.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c       |  2 ++
 drivers/iommu/irq_remapping.h       |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 646f4cf..9f7f378 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -572,6 +572,26 @@ error:
 	return -ENODEV;
 }
 
+/*
+ * Set Posted-Interrupts capability.
+ */
+static inline void set_irq_posting_cap(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	if (!disable_irq_post) {
+		intel_irq_remap_ops.capability |= 1 << IRQ_POSTING_CAP;
+
+		for_each_iommu(iommu, drhd)
+			if (!cap_pi_support(iommu->cap)) {
+				intel_irq_remap_ops.capability &=
+						~(1 << IRQ_POSTING_CAP);
+				break;
+			}
+	}
+}
+
 static int __init intel_enable_irq_remapping(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -647,6 +667,8 @@ static int __init intel_enable_irq_remapping(void)
 
 	irq_remapping_enabled = 1;
 
+	set_irq_posting_cap();
+
 	pr_info("Enabled IRQ remapping in %s mode\n", eim ? "x2apic" : "xapic");
 
 	return eim ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
@@ -847,6 +869,12 @@ static void disable_irq_remapping(void)
 
 		iommu_disable_irq_remapping(iommu);
 	}
+
+	/*
+	 * Clear Posted-Interrupts capability.
+	 */
+	if (!disable_irq_post)
+		intel_irq_remap_ops.capability &= ~(1 << IRQ_POSTING_CAP);
 }
 
 static int reenable_irq_remapping(int eim)
@@ -874,6 +902,8 @@ static int reenable_irq_remapping(int eim)
 	if (!setup)
 		goto error;
 
+	set_irq_posting_cap();
+
 	return 0;
 
 error:
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index fc78b0d..ed605a9 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -22,6 +22,8 @@ int irq_remap_broken;
 int disable_sourceid_checking;
 int no_x2apic_optout;
 
+int disable_irq_post = 1;
+
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index b6ca30d..039c7af 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -34,6 +34,8 @@ extern int disable_sourceid_checking;
 extern int no_x2apic_optout;
 extern int irq_remapping_enabled;
 
+extern int disable_irq_post;
+
 struct irq_remap_ops {
 	/* The supported capabilities */
 	int capability;
@@ -69,6 +71,7 @@ extern void ir_ack_apic_edge(struct irq_data *data);
 
 #define irq_remapping_enabled 0
 #define irq_remap_broken      0
+#define disable_irq_post      1
 
 #endif /* CONFIG_IRQ_REMAP */
 
-- 
2.1.0
