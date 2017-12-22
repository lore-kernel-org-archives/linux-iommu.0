From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v5 4/5] iommu/vt-d: Add debugfs support to show Pasid table contents
Date: Thu, 21 Dec 2017 16:32:39 -0800
Message-ID: <1513902760-45605-5-git-send-email-sohil.mehta@intel.com>
References: <1513902760-45605-1-git-send-email-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513902760-45605-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Debugfs extension to dump the internals such as pasid table entries for
each IOMMU to the userspace.

Example of such dump in Kabylake:

root@OTC-KBLH-01:~# cat
/sys/kernel/debug/intel_iommu/dmar_translation_struct

IOMMU dmar0: Extended Root Table Addr:402b9e800
Extended Root table entries:
Bus 0 L: 402150001 H: 0
Lower Context table entries for Bus: 0
[entry] DID :B :D .F    Low             High
[80]    0000:00:0a.00   40214fa05       102
Higher Context table entries for Bus: 0
[80]    0000:00:0a.00   40260000c       0
Pasid Table Addr : ffff8e2d42600000
Pasid table entries for domain 0:
[Entry]         Contents
[0]             12c409801

Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

v5: No change

v4: Remove the unused function parameter
    Fix checkpatch.pl warnings

v3: No change

v2: Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/intel-svm.c         |  8 --------
 include/linux/intel-svm.h         |  8 ++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index a62862e..218d767 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -38,6 +38,36 @@ static const struct file_operations __name ## _fops =			\
 	.owner		= THIS_MODULE,					\
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static void pasid_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu)
+{
+	int pasid_size = 0, i;
+
+	if (ecap_pasid(iommu->ecap)) {
+		pasid_size = intel_iommu_get_pts(iommu);
+		seq_printf(m, "Pasid Table Addr : %p\n", iommu->pasid_table);
+
+		if (iommu->pasid_table) {
+			seq_printf(m, "Pasid table entries for domain %d:\n",
+				   iommu->segment);
+			seq_puts(m, "[Entry]\t\tContents\n");
+
+			/* Publish the pasid table entries here */
+			for (i = 0; i < pasid_size; i++) {
+				if (!iommu->pasid_table[i].val)
+					continue;
+				seq_printf(m, "[%d]\t\t%04llx\n", i,
+					   iommu->pasid_table[i].val);
+			}
+		}
+	}
+}
+#else /* CONFIG_INTEL_IOMMU_SVM */
+static void pasid_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu)
+{
+}
+#endif /* CONFIG_INTEL_IOMMU_SVM */
+
 static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
 			       int bus, bool ext, bool new_ext)
 {
@@ -71,6 +101,7 @@ static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
 			}
 		}
 	}
+	pasid_tbl_entry_show(m, iommu);
 out:
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index ed1cf7c..c646724 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -28,14 +28,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-struct pasid_entry {
-	u64 val;
-};
-
-struct pasid_state_entry {
-	u64 val;
-};
-
 int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 {
 	struct page *pages;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 733eaf9..a8abad6 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -18,6 +18,14 @@
 
 struct device;
 
+struct pasid_entry {
+	u64 val;
+};
+
+struct pasid_state_entry {
+	u64 val;
+};
+
 struct svm_dev_ops {
 	void (*fault_cb)(struct device *dev, int pasid, u64 address,
 			 u32 private, int rwxp, int response);
-- 
2.7.4
