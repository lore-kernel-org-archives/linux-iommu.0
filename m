From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 5/5] iommu/vt-d: Add debugfs support for Interrupt remapping
Date: Fri,  2 Feb 2018 16:50:01 -0800
Message-ID: <1517619001-148586-6-git-send-email-sohil.mehta@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Debugfs extension for Intel IOMMU to dump Interrupt remapping table
entries for Interrupt remapping and Interrupt posting.

The file /sys/kernel/debug/intel_iommu/ir_translation_struct provides
detailed information, such as Index, Source Id, Destination Id, Vector
and the IRTE values for entries with the present bit set, in the format
shown.

Remapped Interrupt supported on IOMMU: dmar7
 IR table address:85e500000
 Index  SrcID DstID    Vct IRTE_high            IRTE_low
 1      f0f8  00000100 30  000000000004f0f8     000001000030000d
 7      f0f8  00000400 22  000000000004f0f8     000004000022000d

Posted Interrupt supported on IOMMU: dmar5
 IR table address:85ec00000
 Index  SrcID PDA_high PDA_low  Vct IRTE_high           IRTE_low
 4      4300  0000000f ff765980 41  0000000f00044300    ff76598000418001
 5      4300  0000000f ff765980 51  0000000f00044300    ff76598000518001

Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Co-Developed-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

v7: Print the IR table physical base address
    Simplify IR table formatting

v6: Change a couple of seq_puts to seq_putc

v5: Fix seq_puts formatting and remove leading '\n's

v4: Remove the unused function parameter
    Fix checkpatch.pl warnings
    Remove error reporting for debugfs_create_file function
    Remove redundant IOMMU null check under for_each_active_iommu

v3: Use a macro for seq file operations 
    Change the intel_iommu_interrupt_remap file name to ir_translation_struct

v2: Handle the case when IR is not enabled. Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index a9a99aa..b66a073 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -229,6 +229,96 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_regset);
 
+#ifdef CONFIG_IRQ_REMAP
+static void ir_tbl_remap_entry_show(struct seq_file *m,
+				    struct intel_iommu *iommu)
+{
+	struct irte *ri_entry;
+	int idx;
+
+	seq_puts(m, " Index  SrcID DstID    Vct IRTE_high\t\tIRTE_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		ri_entry = &iommu->ir_table->base[idx];
+		if (!ri_entry->present || ri_entry->p_pst)
+			continue;
+
+		seq_printf(m, " %d\t%04x  %08x %02x  %016llx\t%016llx\n", idx,
+			   ri_entry->sid, ri_entry->dest_id, ri_entry->vector,
+			   ri_entry->high, ri_entry->low);
+	}
+}
+
+static void ir_tbl_posted_entry_show(struct seq_file *m,
+				     struct intel_iommu *iommu)
+{
+	struct irte *pi_entry;
+	int idx;
+
+	seq_puts(m, " Index  SrcID PDA_high PDA_low  Vct IRTE_high\t\tIRTE_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		pi_entry = &iommu->ir_table->base[idx];
+		if (!pi_entry->present || !pi_entry->p_pst)
+			continue;
+
+		seq_printf(m, " %d\t%04x  %08x %08x %02x  %016llx\t%016llx\n",
+			   idx, pi_entry->sid, pi_entry->pda_h,
+			   pi_entry->pda_l << 6, pi_entry->vector,
+			   pi_entry->high, pi_entry->low);
+	}
+}
+
+/*
+ * For active IOMMUs go through the Interrupt remapping
+ * table and print valid entries in a table format for
+ * Remapped and Posted Interrupts.
+ */
+static int ir_translation_struct_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	u64 irta;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!ecap_ir_support(iommu->ecap))
+			continue;
+
+		irta = dmar_readq(iommu->reg + DMAR_IRTA_REG) & VTD_PAGE_MASK;
+		seq_printf(m, "Remapped Interrupt supported on IOMMU: %s\n"
+			      " IR table address:%llx\n", iommu->name, irta);
+
+		if (iommu->ir_table && irta)
+			ir_tbl_remap_entry_show(m, iommu);
+		else
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		seq_putc(m, '\n');
+	}
+
+	seq_puts(m, "****\n\n");
+
+	for_each_active_iommu(iommu, drhd) {
+		if (!cap_pi_support(iommu->cap))
+			continue;
+
+		irta = dmar_readq(iommu->reg + DMAR_IRTA_REG) & VTD_PAGE_MASK;
+		seq_printf(m, "Posted Interrupt supported on IOMMU: %s\n"
+			      " IR table address:%llx\n", iommu->name, irta);
+
+		if (iommu->ir_table && irta)
+			ir_tbl_posted_entry_show(m, iommu);
+		else
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		seq_putc(m, '\n');
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
+#endif
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *iommu_debug_root;
@@ -241,4 +331,8 @@ void __init intel_iommu_debugfs_init(void)
 			    NULL, &dmar_translation_struct_fops);
 	debugfs_create_file("iommu_regset", 0444, iommu_debug_root, NULL,
 			    &iommu_regset_fops);
+#ifdef CONFIG_IRQ_REMAP
+	debugfs_create_file("ir_translation_struct", 0444, iommu_debug_root,
+			    NULL, &ir_translation_struct_fops);
+#endif
 }
-- 
2.7.4
