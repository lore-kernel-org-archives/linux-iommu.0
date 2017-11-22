From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 5/6] iommu/vt-d: Add debugfs extension to show Pasid table
	contents
Date: Wed, 22 Nov 2017 11:25:45 -0800
Message-ID: <1511378746-109275-6-git-send-email-sohil.mehta@intel.com>
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

Debugfs extension to dump the internals such as pasid table entries for
each IOMMU to the userspace.

Example of such dump in Kabylake:

root@OTC-KBLH-01:~# cat /sys/kernel/debug/intel_iommu/intel_iommu_ctx

IOMMU dmar0: Extended Root Table Addr:4310c4800
Extended Root tbl entries:
Bus 0 L: 3ff5a8001 H: 0
Lower Context table entries for Bus: 0
[entry] DID :B :D .F    Low             High
[80]    0000:00:0a.00   3ff5a9a05       102
Higher Context tbl entries for Bus: 0
[80]    0000:00:0a.00   40160000c       725140000000
Pasid Table Addr : ffff8db2c1600000
Pasid table entries for domain: 0000
[Entry]         Contents
[0]             26a609801

Cc: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

v2: Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 32 ++++++++++++++++++++++++++++++++
 drivers/iommu/intel-svm.c         |  8 --------
 include/linux/intel-svm.h         |  8 ++++++++
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 3e1ce7d..22a0683 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -34,6 +34,31 @@
 #define TOTAL_BUS_NR (256) /* full bus range 256 */
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
+static void pasid_tbl_entry_show(struct seq_file *m, void *unused,
+				 struct intel_iommu *iommu)
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
+			seq_printf(m, "[Entry]\t\tContents\n");
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
+
 static void ext_ctx_tbl_entry_show(struct seq_file *m, void *unused,
 				   struct intel_iommu *iommu, int bus, int ctx,
 				   struct context_entry *context, bool new_ext)
@@ -57,6 +82,12 @@ static void ext_ctx_tbl_entry_show(struct seq_file *m, void *unused,
 	}
 }
 #else /* CONFIG_INTEL_IOMMU_SVM */
+static void pasid_tbl_entry_show(struct seq_file *m, void *unused,
+				 struct intel_iommu *iommu)
+{
+	return;
+}
+
 static void ext_ctx_tbl_entry_show(struct seq_file *m, void *unused,
 				   struct intel_iommu *iommu, int bus, int ctx,
 				   struct context_entry *context, bool new_ext)
@@ -93,6 +124,7 @@ static void ctx_tbl_entry_show(struct seq_file *m, void *unused,
 					       context, new_ext);
 		}
 	}
+	pasid_tbl_entry_show(m, unused, iommu);
 out:
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f6697e5..2003f23 100644
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
