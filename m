From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v5 5/5] iommu/vt-d: Add debugfs support for Interrupt remapping
Date: Thu, 21 Dec 2017 16:32:40 -0800
Message-ID: <1513902760-45605-6-git-send-email-sohil.mehta@intel.com>
References: <1513902760-45605-1-git-send-email-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513902760-45605-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Debugfs extension for Intel IOMMU to dump Interrupt remapping table
entries for Interrupt remapping and Interrupt posting.

The file /sys/kernel/debug/intel_iommu/ir_translation_struct provides
detailed information, such as Index, Source Id, Destination Id, Vector
and the raw values for entries with the present bit set, in the format
shown.

Remapped Interrupt supported on IOMMU: dmar5
 IR table address:ffff93e09d54c310
-----------------------------------------------------------
 Index  SID  Dest_ID  Vct Raw_value_high   Raw_value_low
 1      3a00 00000600 2c  0000000000043a00 00000600002c0009
 111    4301 00000900 a2  0000000000044301 0000090000a20009

Posted Interrupt supported on IOMMU: dmar5
 IR table address:ffff93e09d54c310
--------------------------------------------------------------------
 Index  SID  PDA_high PDA_low  Vct Raw_value_high   Raw_value_low
 4      4300 00000010 40c7c880 41  0000001000044300 40c7c88000418001
 5      4300 00000010 40c7c880 51  0000001000044300 40c7c88000518001

Cc: Gayatri Kammela <gayatri.kammela@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

v5: Fix seq_puts formatting and remove leading '\n's

v4: Remove the unused function parameter
    Fix checkpatch.pl warnings
    Remove error reporting for debugfs_create_file function
    Remove redundant IOMMU null check under for_each_active_iommu

v3: Use a macro for seq file operations 
    Change the intel_iommu_interrupt_remap file name to ir_translation_struct

v2: Handle the case when IR is not enabled. Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 98 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 218d767..5019835 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -4,6 +4,7 @@
  *
  * Authors: Gayatri Kammela <gayatri.kammela@intel.com>
  *          Jacob Pan <jacob.jun.pan@linux.intel.com>
+ *          Sohil Mehta <sohil.mehta@intel.com>
  *
  */
 
@@ -230,6 +231,98 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(iommu_regset);
 
+#ifdef CONFIG_IRQ_REMAP
+static void ir_tbl_remap_entry_show(struct seq_file *m,
+				    struct intel_iommu *iommu)
+{
+	int idx;
+	struct irte *ri_entry;
+
+	/* Print the header only once */
+	seq_puts(m, " Index  SID  Dest_ID  Vct Raw_value_high   Raw_value_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		ri_entry = &iommu->ir_table->base[idx];
+		if (!ri_entry->present || ri_entry->p_pst)
+			continue;
+		seq_printf(m, " %d\t%04x %08x %02x  %016llx %016llx\n", idx,
+			   ri_entry->sid, ri_entry->dest_id, ri_entry->vector,
+			   ri_entry->high, ri_entry->low);
+	}
+}
+
+static void ir_tbl_posted_entry_show(struct seq_file *m,
+				     struct intel_iommu *iommu)
+{
+	int idx;
+	struct irte *pi_entry;
+
+	/* Print the header only once */
+	seq_puts(m, " Index  SID  PDA_high PDA_low  Vct Raw_value_high   Raw_value_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		pi_entry = &iommu->ir_table->base[idx];
+		if (!pi_entry->present || !pi_entry->p_pst)
+			continue;
+		seq_printf(m, " %d\t%04x %08x %08x %02x  %016llx %016llx\n",
+			   idx, pi_entry->sid, pi_entry->pda_h,
+			   (pi_entry->pda_l)<<6, pi_entry->vector,
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
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!ecap_ir_support(iommu->ecap))
+			continue;
+
+		seq_printf(m, "Remapped Interrupt supported on IOMMU: %s\n"
+			   " IR table address:%p\n", iommu->name,
+			   iommu->ir_table);
+		seq_puts(m, "-----------------------------------------------------------\n");
+
+		if (iommu->ir_table)
+			ir_tbl_remap_entry_show(m, iommu);
+		else
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		seq_puts(m, "\n");
+	}
+
+	seq_puts(m, "****\t****\t****\t****\t****\t****\t****\t****\n");
+
+	for_each_active_iommu(iommu, drhd) {
+		if (!cap_pi_support(iommu->cap))
+			continue;
+
+		seq_printf(m, "Posted Interrupt supported on IOMMU: %s\n"
+			   " IR table address:%p\n", iommu->name,
+			   iommu->ir_table);
+		seq_puts(m, "--------------------------------------------------------------------\n");
+
+		if (iommu->ir_table)
+			ir_tbl_posted_entry_show(m, iommu);
+		else
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		seq_puts(m, "\n");
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
+#endif
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *iommu_debug_root;
@@ -244,4 +337,9 @@ void __init intel_iommu_debugfs_init(void)
 
 	debugfs_create_file("iommu_regset", 0444, iommu_debug_root, NULL,
 			    &iommu_regset_fops);
+
+#ifdef CONFIG_IRQ_REMAP
+	debugfs_create_file("ir_translation_struct", 0444, iommu_debug_root,
+			    NULL, &ir_translation_struct_fops);
+#endif
 }
-- 
2.7.4
