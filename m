From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v8 5/6] iommu/vt-d: Add debugfs support for Interrupt remapping
Date: Tue, 11 Sep 2018 17:11:40 -0700
Message-ID: <20180912001141.64025-6-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912001141.64025-1-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Debugfs extension for Intel IOMMU to dump Interrupt remapping table
entries for Interrupt remapping and Interrupt posting.

The file /sys/kernel/debug/iommu/intel/ir_translation_struct provides
detailed information, such as Index, Source Id, Destination Id, Vector
and the IRTE values for entries with the present bit set, in the format
shown.

Remapped Interrupt supported on IOMMU: dmar1
 IR table address:85e500000
 Entry SrcID   DstID    Vct IRTE_high           IRTE_low
 24    01:00.0 00000001 24  0000000000040100    000000010024000d
 25    01:00.0 00000004 22  0000000000040100    000000040022000d

Posted Interrupt supported on IOMMU: dmar5
 IR table address:85ec00000
 Entry SrcID   PDA_high PDA_low  Vct IRTE_high          IRTE_low
 4     43:00.0 0000000f ff765980 41  0000000f00044300   ff76598000418001
 5     43:00.0 0000000f ff765980 51  0000000f00044300   ff76598000518001

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Co-Developed-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

v8: Improve IR table formatting
    Use irq lock to proctect IRTE access 

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

 drivers/iommu/intel-iommu-debugfs.c | 108 ++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 57af2f774312..2becbd78620f 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -131,6 +131,110 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_regset);
 
+#ifdef CONFIG_IRQ_REMAP
+static void ir_tbl_remap_entry_show(struct seq_file *m,
+				    struct intel_iommu *iommu)
+{
+	struct irte *ri_entry;
+	unsigned long flags;
+	int idx;
+
+	seq_puts(m, " Entry SrcID   DstID    Vct IRTE_high\t\tIRTE_low\n");
+
+	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		ri_entry = &iommu->ir_table->base[idx];
+		if (!ri_entry->present || ri_entry->p_pst)
+			continue;
+
+		seq_printf(m, " %-5d %02x:%02x.%01x %08x %02x  %016llx\t%016llx\n",
+			   idx, PCI_BUS_NUM(ri_entry->sid),
+			   PCI_SLOT(ri_entry->sid), PCI_FUNC(ri_entry->sid),
+			   ri_entry->dest_id, ri_entry->vector,
+			   ri_entry->high, ri_entry->low);
+	}
+	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
+}
+
+static void ir_tbl_posted_entry_show(struct seq_file *m,
+				     struct intel_iommu *iommu)
+{
+	struct irte *pi_entry;
+	unsigned long flags;
+	int idx;
+
+	seq_puts(m, " Entry SrcID   PDA_high PDA_low  Vct IRTE_high\t\tIRTE_low\n");
+
+	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		pi_entry = &iommu->ir_table->base[idx];
+		if (!pi_entry->present || !pi_entry->p_pst)
+			continue;
+
+		seq_printf(m, " %-5d %02x:%02x.%01x %08x %08x %02x  %016llx\t%016llx\n",
+			   idx, PCI_BUS_NUM(pi_entry->sid),
+			   PCI_SLOT(pi_entry->sid), PCI_FUNC(pi_entry->sid),
+			   pi_entry->pda_h, pi_entry->pda_l << 6,
+			   pi_entry->vector, pi_entry->high,
+			   pi_entry->low);
+	}
+	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
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
+		seq_printf(m, "Remapped Interrupt supported on IOMMU: %s\n",
+			   iommu->name);
+
+		if (iommu->ir_table) {
+			irta = virt_to_phys(iommu->ir_table->base);
+			seq_printf(m, " IR table address:%llx\n", irta);
+			ir_tbl_remap_entry_show(m, iommu);
+		} else {
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		}
+		seq_putc(m, '\n');
+	}
+
+	seq_puts(m, "****\n\n");
+
+	for_each_active_iommu(iommu, drhd) {
+		if (!cap_pi_support(iommu->cap))
+			continue;
+
+		seq_printf(m, "Posted Interrupt supported on IOMMU: %s\n",
+			   iommu->name);
+
+		if (iommu->ir_table) {
+			irta = virt_to_phys(iommu->ir_table->base);
+			seq_printf(m, " IR table address:%llx\n", irta);
+			ir_tbl_posted_entry_show(m, iommu);
+		} else {
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		}
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
 	struct dentry *intel_iommu_debug = debugfs_create_dir("intel",
@@ -138,4 +242,8 @@ void __init intel_iommu_debugfs_init(void)
 
 	debugfs_create_file("iommu_regset", 0444, intel_iommu_debug, NULL,
 			    &iommu_regset_fops);
+#ifdef CONFIG_IRQ_REMAP
+	debugfs_create_file("ir_translation_struct", 0444, intel_iommu_debug,
+			    NULL, &ir_translation_struct_fops);
+#endif
 }
-- 
2.18.0
