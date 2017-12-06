From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v3 2/6] iommu/vt-d: Add Intel IOMMU debugfs to show context internals
Date: Tue,  5 Dec 2017 19:43:23 -0800
Message-ID: <1512531807-24268-3-git-send-email-sohil.mehta@intel.com>
References: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Andriy Shevchenko <andriy.shevchenko@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

IOMMU internals states such as root and context can be exported to the
userspace.

Example of such dump in Kabylake:

root@OTC-KBLH-01:~# cat
/sys/kernel/debug/intel_iommu/dmar_translation_struct

IOMMU dmar2:    Root Table Addr:4558a3000
 Root tbl entries:
Bus 0 L: 4558aa001 H: 0
 Context table entries for Bus: 0
[entry] DID :B :D .F    Low             High
[160]   0000:00:14.00   4558a9001       102
[184]   0000:00:17.00   400eac001       302
[248]   0000:00:1f.00   4558af001       202
[251]   0000:00:1f.03   40070e001       502
[254]   0000:00:1f.06   4467c9001       602
 Root tbl entries:
Bus 1 L: 3fc8c2001 H: 0
 Context table entries for Bus: 1
[entry] DID :B :D .F    Low             High
[0]     0000:01:00.00   3fc8c3001       402

Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

v3: Add a macro for seq file operations 
    Change the intel_iommu_ctx file name to dmar_translation_struct

v2: No change

 drivers/iommu/Makefile            |   1 +
 drivers/iommu/intel-iommu-debug.c | 152 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c       |   4 +
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/iommu/intel-iommu-debug.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb6958..fdbaf46 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
+obj-$(CONFIG_INTEL_IOMMU_DEBUG) += intel-iommu-debug.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
new file mode 100644
index 0000000..8ae0c4d
--- /dev/null
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright © 2017 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * Authors: Gayatri Kammela <gayatri.kammela@intel.com>
+ *          Jacob Pan <jacob.jun.pan@linux.intel.com>
+ *
+ */
+
+#define pr_fmt(fmt)     "INTEL_IOMMU: " fmt
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/pm_runtime.h>
+#include <linux/debugfs.h>
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/intel-iommu.h>
+#include <linux/intel-svm.h>
+#include <linux/dmar.h>
+#include <linux/spinlock.h>
+
+#include "irq_remapping.h"
+
+#define TOTAL_BUS_NR (256) /* full bus range 256 */
+#define DEFINE_SHOW_ATTRIBUTE(__name)					\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}									\
+static const struct file_operations __name ## _fops =			\
+{									\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+	.owner		= THIS_MODULE,					\
+}
+
+static void ctx_tbl_entry_show(struct seq_file *m, void *unused,
+			       struct intel_iommu *iommu, int bus, bool ext,
+			       bool new_ext)
+{
+	struct context_entry *context;
+	int ctx;
+	unsigned long flags;
+
+	seq_printf(m, "%s Context table entries for Bus: %d\n",
+		   ext ? "Lower" : "", bus);
+	seq_printf(m, "[entry]\tDID :B :D .F\tLow\t\tHigh\n");
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Publish either context entries or extended contenxt entries */
+	for (ctx = 0; ctx < (ext ? 128 : 256); ctx++) {
+		context = iommu_context_addr(iommu, bus, ctx, 0);
+		if (!context)
+			goto out;
+		if (context_present(context)) {
+			seq_printf(m, "[%d]\t%04x:%02x:%02x.%02x\t%llx\t%llx\n",
+				   ctx, iommu->segment, bus, PCI_SLOT(ctx),
+				   PCI_FUNC(ctx), context[0].lo, context[0].hi);
+		}
+	}
+out:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
+static void root_tbl_entry_show(struct seq_file *m, void *unused,
+				struct intel_iommu *iommu, u64 rtaddr_reg,
+				bool ext, bool new_ext)
+{
+	int bus;
+
+	seq_printf(m, "\nIOMMU %s: %2s Root Table Addr:%llx\n", iommu->name,
+		   ext ? "Extended" : "", rtaddr_reg);
+	/* Publish extended root table entries or root table entries here */
+	for (bus = 0; bus < TOTAL_BUS_NR; bus++) {
+		if (!iommu->root_entry[bus].lo)
+			continue;
+
+		seq_printf(m, "%s Root tbl entries:\n", ext ? "Extended" : "");
+		seq_printf(m, "Bus %d L: %llx H: %llx\n", bus,
+			   iommu->root_entry[bus].lo, iommu->root_entry[bus].hi
+			  );
+
+		ctx_tbl_entry_show(m, unused, iommu, bus, ext, new_ext);
+	}
+}
+
+static int dmar_translation_struct_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	u64 rtaddr_reg;
+	bool new_ext, ext;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (iommu) {
+			/* Check if root table type is set */
+			rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+			ext        = !!(rtaddr_reg & DMA_RTADDR_RTT);
+			new_ext    = !!ecap_ecs(iommu->ecap);
+			if (new_ext != ext) {
+				seq_printf(m, "IOMMU %s: invalid ecs\n",
+					   iommu->name);
+				rcu_read_unlock();
+				return -EINVAL;
+			}
+			root_tbl_entry_show(m, unused, iommu, rtaddr_reg, ext,
+					    new_ext);
+		}
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(dmar_translation_struct);
+
+void __init intel_iommu_debugfs_init(void)
+{
+	struct dentry *iommu_debug_root;
+
+	iommu_debug_root = debugfs_create_dir("intel_iommu", NULL);
+
+	if (!iommu_debug_root) {
+		pr_err("can't create debugfs dir\n");
+		goto err;
+	}
+
+	if (!debugfs_create_file("dmar_translation_struct", S_IRUGO,
+				 iommu_debug_root, NULL,
+				 &dmar_translation_struct_fops)) {
+		pr_err("Can't create dmar_translation_struct file\n");
+		goto err;
+	}
+
+err:
+	debugfs_remove_recursive(iommu_debug_root);
+
+}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 419a559..7794e0c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4797,6 +4797,10 @@ int __init intel_iommu_init(void)
 			  intel_iommu_cpu_dead);
 	intel_iommu_enabled = 1;
 
+#ifdef CONFIG_INTEL_IOMMU_DEBUG
+	intel_iommu_debugfs_init();
+#endif
+
 	return 0;
 
 out_free_reserved_range:
-- 
2.7.4
