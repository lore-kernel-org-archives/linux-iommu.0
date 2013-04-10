From: <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] iommu/amd: Adding new command line option
	"amd-iommu=verbose"
Date: Wed, 10 Apr 2013 10:57:31 -0500
Message-ID: <1365609451-3347-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Adding new command line option "amd-iommu=verbose" to allow verbose print out
in dmesg.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  |    4 ++++
 drivers/iommu/amd_iommu_types.h |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index e3c2d74..1c8770e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -157,6 +157,8 @@ bool amd_iommu_v2_present __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
+bool amd_iommu_verbose __read_mostly;
+
 /*
  * List of protection domains - used during resume
  */
@@ -2092,6 +2094,8 @@ static int __init parse_amd_iommu_options(char *str)
 			amd_iommu_disabled = true;
 		if (strncmp(str, "force_isolation", 15) == 0)
 			amd_iommu_force_isolation = true;
+		if (strncmp(str, "verbose", 7) == 0)
+			amd_iommu_verbose = true;
 	}
 
 	return 1;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e38ab43..9ade4f9 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -694,6 +694,8 @@ extern bool amd_iommu_v2_present;
 
 extern bool amd_iommu_force_isolation;
 
+extern bool amd_iommu_verbose;
+
 /* Max levels of glxval supported */
 extern int amd_iommu_max_glx_val;
 
-- 
1.7.10.4
