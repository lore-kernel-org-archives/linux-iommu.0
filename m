From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] iommu/vt-d: Add Intel IOMMU debugfs to show extended
	context internals
Date: Thu, 12 Oct 2017 17:03:39 -0700
Message-ID: <1507853022-136228-4-git-send-email-sohil.mehta@intel.com>
References: <1507853022-136228-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507853022-136228-1-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Debugfs extension to dump internals such as extended context table
entries for each IOMMU to the userspace.

root@OTC-KBLH-01:~# cat /sys/kernel/debug/intel_iommu/intel_iommu_ctx

IOMMU dmar1: Extended Root Table Addr:4558a1800
Extended Root tbl entries:
Bus 0 L: 4558a6001 H: 0
Lower Context table entries for Bus: 0
[entry] DID :B :D .F    Low             High
[16]    0000:00:02.00   4558a5005       102
Higher Context tbl entries for Bus: 0
[16]    0000:00:02.00   401b0000c       401400000

IOMMU dmar0: Extended Root Table Addr:4558a2800
Extended Root tbl entries:
Bus 0 L: 4016f4001 H: 0
Lower Context table entries for Bus: 0
[entry] DID :B :D .F    Low             High
[80]    0000:00:0a.00   4016f3a05       102
Higher Context tbl entries for Bus: 0
[80]    0000:00:0a.00   40150000c       671b80000000

Cc: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu-debug.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 90872ed..ef46820 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -33,6 +33,38 @@
 
 #define TOTAL_BUS_NR (256) /* full bus range 256 */
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static void ext_ctx_tbl_entry_show(struct seq_file *m, void *unused,
+				   struct intel_iommu *iommu, int bus, int ctx,
+				   struct context_entry *context, bool new_ext)
+{
+	u64 ctx_lo;
+
+	if (new_ext) {
+		seq_printf(m, "Higher Context tbl entries for Bus: %d\n", bus);
+		ctx_lo = context[0].lo;
+
+		if (!(ctx_lo & CONTEXT_PASIDE)) {
+			context[1].hi = (u64)virt_to_phys(
+					iommu->pasid_state_table);
+			context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
+					intel_iommu_get_pts(iommu);
+		}
+
+		seq_printf(m, "[%d]\t%04x:%02x:%02x.%02x\t%llx\t%llx\n", ctx,
+			   iommu->segment, bus, PCI_SLOT(ctx), PCI_FUNC(ctx),
+			   context[1].lo, context[1].hi);
+	}
+}
+#else /* CONFIG_INTEL_IOMMU_SVM */
+static void ext_ctx_tbl_entry_show(struct seq_file *m, void *unused,
+				   struct intel_iommu *iommu, int bus, int ctx,
+				   struct context_entry *context, bool new_ext)
+{
+	return;
+}
+#endif /* CONFIG_INTEL_IOMMU_SVM */
+
 static void ctx_tbl_entry_show(struct seq_file *m, void *unused,
 			       struct intel_iommu *iommu, int bus, bool ext,
 			       bool new_ext)
@@ -56,6 +88,9 @@ static void ctx_tbl_entry_show(struct seq_file *m, void *unused,
 			seq_printf(m, "[%d]\t%04x:%02x:%02x.%02x\t%llx\t%llx\n",
 				   ctx, iommu->segment, bus, PCI_SLOT(ctx),
 				   PCI_FUNC(ctx), context[0].lo, context[0].hi);
+
+			ext_ctx_tbl_entry_show(m, unused, iommu, bus, ctx,
+					       context, new_ext);
 		}
 	}
 out:
-- 
2.7.4
