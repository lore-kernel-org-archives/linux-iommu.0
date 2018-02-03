From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 3/5] iommu/vt-d: Add debugfs support to show register
	contents
Date: Fri,  2 Feb 2018 16:49:59 -0800
Message-ID: <1517619001-148586-4-git-send-email-sohil.mehta@intel.com>
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

From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Debugfs extension to dump all the register contents for each IOMMU
device to the user space via debugfs.

Example:
root@OTC-KBLH-01:~# cat /sys/kernel/debug/intel_iommu/iommu_regset
DMAR: dmar0: Register Base Address fed90000
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

Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Co-Developed-by: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

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

 drivers/iommu/intel-iommu-debug.c | 84 +++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h       |  2 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 8253503..38651ad 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -38,6 +38,49 @@ static const struct file_operations __name ## _fops =			\
 	.owner		= THIS_MODULE,					\
 }
 
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
+	IOMMU_REGSET_ENTRY(MTRRDEF)
+};
+
 static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
 			       int bus, bool ext)
 {
@@ -116,6 +159,45 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(dmar_translation_struct);
 
+static int iommu_regset_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	unsigned long long base;
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
+		base = drhd->reg_base_addr;
+		seq_printf(m, "DMAR: %s: Register Base Address %llx\n",
+			   iommu->name, base);
+		seq_puts(m, "Name\t\t\tOffset\t\tContents\n");
+		/*
+		 * Publish the contents of the 64-bit hardware registers
+		 * by adding the offset to the pointer (virtual address).
+		 */
+		for (i = 0 ; i < ARRAY_SIZE(iommu_regs); i++) {
+			value = dmar_readq(iommu->reg + iommu_regs[i].offset);
+			seq_printf(m, "%-8s\t\t0x%02x\t\t0x%016llx\n",
+				   iommu_regs[i].regs, iommu_regs[i].offset,
+				   value);
+		}
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
 	struct dentry *iommu_debug_root;
@@ -126,4 +208,6 @@ void __init intel_iommu_debugfs_init(void)
 
 	debugfs_create_file("dmar_translation_struct", 0444, iommu_debug_root,
 			    NULL, &dmar_translation_struct_fops);
+	debugfs_create_file("iommu_regset", 0444, iommu_debug_root, NULL,
+			    &iommu_regset_fops);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8968afa..1044a14 100644
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
