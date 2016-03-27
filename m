From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH] drivers/iommu: don't select DEBUG_FS for AMD_IOMMU_STATS
Date: Sat, 26 Mar 2016 21:18:44 -0400
Message-ID: <1459041524-30929-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Steven Rostedt (Red Hat)" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

We have at least one big banner telling people that they should
not deploy production kernels with DEBUG options enabled, but
at the same time, we make it hard for people to turn DEBUG_FS
off when we select (vs. depend on) the CONFIG_DEBUG_FS option.

Since we actively discourage people using debug-like features
on any builds that are production oriented (see trace_printk
banner for one example), so a generic sounding option should
not select DEBUG_FS.

Since this is not a system critical option, convert it from a
select to a depend -- this makes it nicer for us old school folk
who edit .config and then run "make oldconfig" as a (bad?) habit.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Steven Rostedt (Red Hat)" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Signed-off-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---
 drivers/iommu/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dd1dc39f84ff..959032bdbe12 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -126,8 +126,7 @@ config AMD_IOMMU
 
 config AMD_IOMMU_STATS
 	bool "Export AMD IOMMU statistics to debugfs"
-	depends on AMD_IOMMU
-	select DEBUG_FS
+	depends on AMD_IOMMU && DEBUG_FS
 	---help---
 	  This option enables code in the AMD IOMMU driver to collect various
 	  statistics about whats happening in the driver and exports that
-- 
2.6.1
