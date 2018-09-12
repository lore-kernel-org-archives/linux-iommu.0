From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v8 4/6] iommu/vt-d: Add debugfs support to show register contents
Date: Tue, 11 Sep 2018 17:11:39 -0700
Message-ID: <20180912001141.64025-5-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912001141.64025-1-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Add Intel IOMMU debugfs extension to dump all the register contents for
each IOMMU device.

Example:
root@OTC-KBLH-01:~# cat /sys/kernel/debug/iommu/intel/iommu_regset
IOMMU: dmar0 Register Base Address: fed90000
Name            Offset          Contents
VER             0x00            0x0000000000000010
CAP             0x08            0x01c0000c40660462
ECAP            0x10            0x0000000000f0101a
GCMD            0x18            0x0000000000000000
GSTS            0x1c            0x00000000c7000000
RTADDR          0x20            0x00000004071d3800
CCMD            0x28            0x0800000000000000
FSTS            0x34            0x0000000000000000
FECTL           0x38            0x0000000000000000
FEDATA          0x3c            0xfee0100400004021

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-Developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

v8: Add MTRR and Virtual command register support
    Use the iommu register lock to protect register access

v7: Use macro for register set definitions
    Fix compiler warning for readq with 32bit architecture
    Remove leading '\n'

v6: No change

v5: No change

v4: Fix checkpatch.pl warnings
    Remove error reporting for debugfs_create_file function
    Remove redundant IOMMU null check under for_each_active_iommu

v3: Use a macro for seq file operations 
    Change the intel_iommu_regset file name to iommu_regset
    Add information for MTRR registers

v2: Fix seq_printf formatting

 drivers/iommu/intel-iommu-debugfs.c | 123 +++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 33e0a6c12d92..57af2f774312 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -14,7 +14,128 @@
 
 #include <asm/irq_remapping.h>
 
+struct iommu_regset {
+	int offset;
+	const char *regs;
+};
+
+#define IOMMU_REGSET_ENTRY(_reg_)					\
+	{ DMAR_##_reg_##_REG, __stringify(_reg_) }
+static const struct iommu_regset iommu_regs[] = {
+	IOMMU_REGSET_ENTRY(VER),
+	IOMMU_REGSET_ENTRY(CAP),
+	IOMMU_REGSET_ENTRY(ECAP),
+	IOMMU_REGSET_ENTRY(GCMD),
+	IOMMU_REGSET_ENTRY(GSTS),
+	IOMMU_REGSET_ENTRY(RTADDR),
+	IOMMU_REGSET_ENTRY(CCMD),
+	IOMMU_REGSET_ENTRY(FSTS),
+	IOMMU_REGSET_ENTRY(FECTL),
+	IOMMU_REGSET_ENTRY(FEDATA),
+	IOMMU_REGSET_ENTRY(FEADDR),
+	IOMMU_REGSET_ENTRY(FEUADDR),
+	IOMMU_REGSET_ENTRY(AFLOG),
+	IOMMU_REGSET_ENTRY(PMEN),
+	IOMMU_REGSET_ENTRY(PLMBASE),
+	IOMMU_REGSET_ENTRY(PLMLIMIT),
+	IOMMU_REGSET_ENTRY(PHMBASE),
+	IOMMU_REGSET_ENTRY(PHMLIMIT),
+	IOMMU_REGSET_ENTRY(IQH),
+	IOMMU_REGSET_ENTRY(IQT),
+	IOMMU_REGSET_ENTRY(IQA),
+	IOMMU_REGSET_ENTRY(ICS),
+	IOMMU_REGSET_ENTRY(IRTA),
+	IOMMU_REGSET_ENTRY(PQH),
+	IOMMU_REGSET_ENTRY(PQT),
+	IOMMU_REGSET_ENTRY(PQA),
+	IOMMU_REGSET_ENTRY(PRS),
+	IOMMU_REGSET_ENTRY(PECTL),
+	IOMMU_REGSET_ENTRY(PEDATA),
+	IOMMU_REGSET_ENTRY(PEADDR),
+	IOMMU_REGSET_ENTRY(PEUADDR),
+	IOMMU_REGSET_ENTRY(MTRRCAP),
+	IOMMU_REGSET_ENTRY(MTRRDEF),
+	IOMMU_REGSET_ENTRY(MTRR_FIX64K_00000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX16K_80000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX16K_A0000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_C0000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_C8000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_D0000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_D8000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_E0000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_E8000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_F0000),
+	IOMMU_REGSET_ENTRY(MTRR_FIX4K_F8000),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE0),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK0),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE1),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK1),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE2),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK2),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE3),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK3),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE4),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK4),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE5),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK5),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE6),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK6),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE7),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK7),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE8),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK8),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE9),
+	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK9),
+	IOMMU_REGSET_ENTRY(VCCAP),
+	IOMMU_REGSET_ENTRY(VCMD),
+	IOMMU_REGSET_ENTRY(VCRSP),
+};
+
+static int iommu_regset_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	unsigned long flag;
+	int i, ret = 0;
+	u64 value;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!drhd->reg_base_addr) {
+			seq_puts(m, "IOMMU: Invalid base address\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
+			   iommu->name, drhd->reg_base_addr);
+		seq_puts(m, "Name\t\t\tOffset\t\tContents\n");
+		/*
+		 * Publish the contents of the 64-bit hardware registers
+		 * by adding the offset to the pointer (virtual address).
+		 */
+		raw_spin_lock_irqsave(&iommu->register_lock, flag);
+		for (i = 0 ; i < ARRAY_SIZE(iommu_regs); i++) {
+			value = dmar_readq(iommu->reg + iommu_regs[i].offset);
+			seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
+				   iommu_regs[i].regs, iommu_regs[i].offset,
+				   value);
+		}
+		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+		seq_putc(m, '\n');
+	}
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_regset);
+
 void __init intel_iommu_debugfs_init(void)
 {
-	debugfs_create_dir("intel", iommu_debugfs_dir);
+	struct dentry *intel_iommu_debug = debugfs_create_dir("intel",
+						iommu_debugfs_dir);
+
+	debugfs_create_file("iommu_regset", 0444, intel_iommu_debug, NULL,
+			    &iommu_regset_fops);
 }
-- 
2.18.0
