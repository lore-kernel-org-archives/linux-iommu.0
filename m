From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 4/6] iommu/vt-d: Add debugfs extension to show register
	contents
Date: Wed, 22 Nov 2017 11:25:44 -0800
Message-ID: <1511378746-109275-5-git-send-email-sohil.mehta@intel.com>
References: <1511378746-109275-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1511378746-109275-1-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andriy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Debugfs extension to dump all the register contents for each IOMMU
device to the user space via debugfs.

example:
root@OTC-KBLH-01:~# cat /sys/kernel/debug/intel_iommu/intel_iommu_regset

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

Cc: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

v2: Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 96 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index ef46820..3e1ce7d 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -161,6 +161,93 @@ static const struct file_operations intel_iommu_debug_fops = {
 	.owner		= THIS_MODULE,
 };
 
+static int intel_iommu_debugfs_regs_show(struct seq_file *m, void *unused)
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
+					       {DMAR_PEUADDR_REG, "PEUADDR"} };
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
+static int intel_iommu_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, intel_iommu_debugfs_regs_show,
+			   inode->i_private);
+}
+
+static const struct file_operations intel_iommu_regs_fops = {
+	.open		= intel_iommu_regs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *iommu_debug_root;
@@ -178,6 +265,15 @@ void __init intel_iommu_debugfs_init(void)
 		goto err;
 	}
 
+	if (!debugfs_create_file("intel_iommu_regset", S_IRUGO,
+				 iommu_debug_root, NULL, &intel_iommu_regs_fops
+				)) {
+		pr_err("Can't create intel_iommu_regset file\n");
+		goto err;
+	}
+
+	return;
+
 err:
 	debugfs_remove_recursive(iommu_debug_root);
 
-- 
2.7.4
