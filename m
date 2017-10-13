From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH 6/6] iommu/vt-d: Debugfs support for Intel IOMMU Interrupt remapping
Date: Thu, 12 Oct 2017 17:03:42 -0700
Message-ID: <1507853022-136228-7-git-send-email-sohil.mehta@intel.com>
References: <1507853022-136228-1-git-send-email-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507853022-136228-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Debugfs extension for Intel IOMMU to dump Interrupt remapping table
entries for Interrupt remapping and Interrupt posting.

The file /sys/kernel/debug/intel_iommu/intel_iommu_interrupt_remap
provides detailed information, such as Index, Source Id, Destination Id,
Vector and the raw values for entries with the present bit set, in the
format shown.

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
 drivers/iommu/intel-iommu-debug.c | 115 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 2de4f1b..102aca6 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -12,6 +12,7 @@
  *
  * Authors: Gayatri Kammela <gayatri.kammela@intel.com>
  *          Jacob Pan <jacob.jun.pan@linux.intel.com>
+ *          Sohil Mehta <sohil.mehta@intel.com>
  *
  */
 
@@ -282,6 +283,111 @@ static const struct file_operations intel_iommu_regs_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_IRQ_REMAP
+static void ir_tbl_remap_entry_show(struct seq_file *m, void *unused,
+			       struct intel_iommu *iommu)
+{
+	int idx;
+	struct irte *ri_entry;
+
+	/* Print the header only once */
+	seq_printf(m, " Index  SID  Dest_ID  Vct"
+		   " Raw_value_high   Raw_value_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		ri_entry = &iommu->ir_table->base[idx];
+		if (!ri_entry->present || ri_entry->p_pst)
+			continue;
+		seq_printf(m,
+			   " %d\t%04x %08x %02x  %016llx %016llx\n",
+			   idx, ri_entry->sid,
+			   ri_entry->dest_id, ri_entry->vector,
+			   ri_entry->high, ri_entry->low);
+	}
+}
+
+static void ir_tbl_posted_entry_show(struct seq_file *m, void *unused,
+				struct intel_iommu *iommu)
+{
+	int idx;
+	struct irte *pi_entry;
+
+	/* Print the header only once */
+	seq_printf(m, " Index  SID  PDA_high PDA_low  Vct"
+		   " Raw_value_high   Raw_value_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		pi_entry = &iommu->ir_table->base[idx];
+		if (!pi_entry->present || !pi_entry->p_pst)
+			continue;
+		seq_printf(m,
+			   " %d\t%04x %08x %08x %02x  %016llx %016llx\n",
+			   idx, pi_entry->sid,
+			   pi_entry->pda_h, (pi_entry->pda_l)<<6,
+			   pi_entry->vector, pi_entry->high,
+			   pi_entry->low);
+	}
+}
+
+/*
+ * For active IOMMUs go through the Interrupt remapping
+ * table and print valid entries in a table format for
+ * Remapped and Posted Interrupts.
+ */
+static int intel_iommu_ir_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!iommu || !ecap_ir_support(iommu->ecap))
+			continue;
+
+		seq_printf(m,
+			   "\nRemapped Interrupt supported on IOMMU: %s"
+			   "\n IR table address:%llx\n",
+			   iommu->name, (long long)iommu->ir_table);
+
+		seq_printf(m, "---------------------------------------"
+			   "--------------------\n");
+		ir_tbl_remap_entry_show(m, unused, iommu);
+	}
+
+	seq_printf(m, "\n****\t****\t****\t****\t****\t****\t****\t****\n");
+
+	for_each_active_iommu(iommu, drhd) {
+		if (!iommu || !cap_pi_support(iommu->cap))
+			continue;
+
+		seq_printf(m,
+			   "\nPosted Interrupt supported on IOMMU: %s"
+			   "\n IR table address:%llx\n",
+			   iommu->name, (long long)iommu->ir_table);
+
+		seq_printf(m, "---------------------------------------"
+			   "-----------------------------\n");
+		ir_tbl_posted_entry_show(m, unused, iommu);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int intel_iommu_ir_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, intel_iommu_ir_show, inode->i_private);
+}
+
+static const struct file_operations intel_iommu_ir_fops = {
+	.open		= intel_iommu_ir_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.owner		= THIS_MODULE,
+};
+#endif
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *iommu_debug_root;
@@ -306,6 +412,15 @@ void __init intel_iommu_debugfs_init(void)
 		goto err;
 	}
 
+#ifdef CONFIG_IRQ_REMAP
+	if (!debugfs_create_file("intel_iommu_interrupt_remap", S_IRUGO,
+				 iommu_debug_root, NULL,
+				 &intel_iommu_ir_fops)) {
+		pr_err("Can't create intel_iommu_interrupt_remap file\n");
+		goto err;
+	}
+#endif
+
 	return;
 
 err:
-- 
2.7.4
