From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
Date: Thu, 24 Jan 2019 10:31:32 +0800
Message-ID: <20190124023132.20410-1-baolu.lu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Commit 765b6a98c1de3 ("iommu/vt-d: Enumerate the scalable
mode capability") enables VT-d scalable mode if hardware
advertises the capability. As we will bring up different
features and use cases to upstream in different patch
series, it will leave some intermediate kernel versions
which support partial features. Hence, end user might run
into problems when they use such kernels on bare metals
or virtualization environments.

This leaves scalable mode default off and end users could
turn it on with "intel-iommu=sm_on" only when they have
clear ideas about which scalable features are supported
in the kernel.

Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Suggested-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Suggested-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++----
 drivers/iommu/intel-iommu.c                     | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..858b6c0b9a15 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1696,12 +1696,11 @@
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
 			not be supported.
-		sm_off [Default Off]
-			By default, scalable mode will be supported if the
+		sm_on [Default Off]
+			By default, scalable mode will be disabled even if the
 			hardware advertises that it has support for the scalable
 			mode translation. With this option set, scalable mode
-			will not be used even on hardware which claims to support
-			it.
+			will be used on hardware which claims to support it.
 		tboot_noforce [Default Off]
 			Do not force the Intel IOMMU enabled under tboot.
 			By default, tboot will force Intel IOMMU on, which
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2bd9ac285c0d..8d31d3e25e30 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -363,7 +363,7 @@ static int dmar_map_gfx = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
-static int intel_iommu_sm = 1;
+static int intel_iommu_sm;
 static int iommu_identity_mapping;
 
 #define IDENTMAP_ALL		1
@@ -456,9 +456,9 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "sp_off", 6)) {
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
-		} else if (!strncmp(str, "sm_off", 6)) {
-			pr_info("Intel-IOMMU: disable scalable mode support\n");
-			intel_iommu_sm = 0;
+		} else if (!strncmp(str, "sm_on", 5)) {
+			pr_info("Intel-IOMMU: scalable mode supported\n");
+			intel_iommu_sm = 1;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
-- 
2.17.1
