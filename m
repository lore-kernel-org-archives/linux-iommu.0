From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v3 4/6] iommu/vt-d: Add debugfs extension to show register contents
Date: Tue,  5 Dec 2017 19:43:25 -0800
Message-ID: <1512531807-24268-5-git-send-email-sohil.mehta@intel.com>
References: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Andriy Shevchenko <andriy.shevchenko@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Debugfs extension to dump all the register contents for each IOMMU
device to the user space via debugfs.

example:
root@OTC-KBLH-01:~# cat /sys/kernel/debug/intel_iommu/iommu_regset

DMAR: dmar1: reg_base_addr fed90000
Name         Offset     Contents
VER          0x00       0x0000000000000010
CAP          0x08       0x01c0000c40660462
ECAP         0x10       0x0000019e2ff0505e
GCMD         0x18       0x0000000000000000
GSTS         0x1c       0x00000000c7000000
RTADDR       0x20       0x00000004558d6800
CCMD         0x28       0x0800000000000000
FSTS         0x34       0x0000000000000000
FECTL        0x38       0x0000000000000000
FEDATA       0x3c       0xfee0100c00004141

Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

v3: Use a macro for seq file operations 
    Change the intel_iommu_regset file name to iommu_regset
    Add information for MTRR registers

v2: Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 86 +++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h       |  2 +
 2 files changed, 88 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 8e7f5d2..0951d58 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -163,6 +163,84 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(dmar_translation_struct);
 
+static int iommu_regset_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	unsigned long long base;
+	int i;
+	struct regset {
+		int offset;
+		char *regs;
+	};
+
+	static const struct regset regstr[] = {{DMAR_VER_REG, "VER"},
+					       {DMAR_CAP_REG, "CAP"},
+					       {DMAR_ECAP_REG, "ECAP"},
+					       {DMAR_GCMD_REG, "GCMD"},
+					       {DMAR_GSTS_REG, "GSTS"},
+					       {DMAR_RTADDR_REG, "RTADDR"},
+					       {DMAR_CCMD_REG, "CCMD"},
+					       {DMAR_FSTS_REG, "FSTS"},
+					       {DMAR_FECTL_REG, "FECTL"},
+					       {DMAR_FEDATA_REG, "FEDATA"},
+					       {DMAR_FEADDR_REG, "FEADDR"},
+					       {DMAR_FEUADDR_REG, "FEUADDR"},
+					       {DMAR_AFLOG_REG, "AFLOG"},
+					       {DMAR_PMEN_REG, "PMEN"},
+					       {DMAR_PLMBASE_REG, "PLMBASE"},
+					       {DMAR_PLMLIMIT_REG, "PLMLIMIT"},
+					       {DMAR_PHMBASE_REG, "PHMBASE"},
+					       {DMAR_PHMLIMIT_REG,  "PHMLIMIT"},
+					       {DMAR_IQH_REG, "IQH"},
+					       {DMAR_IQT_REG, "IQT"},
+					       {DMAR_IQ_SHIFT, "IQ"},
+					       {DMAR_IQA_REG, "IQA"},
+					       {DMAR_ICS_REG, "ICS"},
+					       {DMAR_IRTA_REG, "IRTA"},
+					       {DMAR_PQH_REG, "PQH"},
+					       {DMAR_PQT_REG, "PQT"},
+					       {DMAR_PQA_REG, "PQA"},
+					       {DMAR_PRS_REG, "PRS"},
+					       {DMAR_PECTL_REG, "PECTL"},
+					       {DMAR_PEDATA_REG, "PEDATA"},
+					       {DMAR_PEADDR_REG, "PEADDR"},
+					       {DMAR_PEUADDR_REG, "PEUADDR"},
+					       {DMAR_MTRRCAP_REG, "MTRRCAP"},
+					       {DMAR_MTRRDEF_REG, "MTRRDEF"} };
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (iommu) {
+			if (!drhd->reg_base_addr) {
+				seq_printf(m, "IOMMU: Invalid base address\n");
+				rcu_read_unlock();
+				return -EINVAL;
+			}
+
+			base = drhd->reg_base_addr;
+			seq_printf(m, "\nDMAR: %s: reg_base_addr %llx\n",
+				   iommu->name, base);
+			seq_printf(m, "Name\t\t\tOffset\t\tContents\n");
+			/*
+			 * Publish the contents of the 64-bit hardware registers
+			 * by adding the offset to the pointer(virtual addr)
+			 */
+			for (i = 0 ; i < ARRAY_SIZE(regstr); i++) {
+				seq_printf(m, "%-8s\t\t0x%02x\t\t0x%016lx\n",
+					   regstr[i].regs, regstr[i].offset,
+					   readq(iommu->reg + regstr[i].offset)
+					  );
+			}
+		}
+	}
+
+	rcu_read_unlock();
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(iommu_regset);
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *iommu_debug_root;
@@ -181,6 +259,14 @@ void __init intel_iommu_debugfs_init(void)
 		goto err;
 	}
 
+	if (!debugfs_create_file("iommu_regset", S_IRUGO,
+				 iommu_debug_root, NULL, &iommu_regset_fops)) {
+		pr_err("Can't create iommu_regset file\n");
+		goto err;
+	}
+
+	return;
+
 err:
 	debugfs_remove_recursive(iommu_debug_root);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index defbc32..c2c147b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -71,6 +71,8 @@
 #define	DMAR_PEDATA_REG	0xe4	/* Page request event interrupt data register */
 #define	DMAR_PEADDR_REG	0xe8	/* Page request event interrupt addr register */
 #define	DMAR_PEUADDR_REG 0xec	/* Page request event Upper address register */
+#define	DMAR_MTRRCAP_REG 0x100	/* Memory type range register capability register */
+#define	DMAR_MTRRDEF_REG 0x108	/* Memory type range register default type register */
 
 #define OFFSET_STRIDE		(9)
 
-- 
2.7.4
