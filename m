From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/19] iommu/vt-d: Don't do early domain assignment if kdump
	kernel
Date: Sat, 13 Jun 2015 08:47:17 +0200
Message-ID: <1434178047-17809-10-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

When we copied over context tables from an old kernel, we
need to defer assignment of devices to domains until the
device driver takes over. So skip this part of
initialization when we copied over translation tables from
the old kernel.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bf87236..39bc3d6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2981,6 +2981,7 @@ static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct dmar_rmrr_unit *rmrr;
+	bool copied_tables = false;
 	struct device *dev;
 	struct intel_iommu *iommu;
 	int i, ret;
@@ -3071,6 +3072,7 @@ static int __init init_dmars(void)
 			} else {
 				pr_info("Copied translation tables from previous kernel for %s\n",
 					iommu->name);
+				copied_tables = true;
 			}
 		}
 
@@ -3099,6 +3101,15 @@ static int __init init_dmars(void)
 	check_tylersburg_isoch();
 
 	/*
+	 * If we copied translations from a previous kernel in the kdump
+	 * case, we can not assign the devices to domains now, as that
+	 * would eliminate the old mappings. So skip this part and defer
+	 * the assignment to device driver initialization time.
+	 */
+	if (copied_tables)
+		goto domains_done;
+
+	/*
 	 * If pass through is not set or not enabled, setup context entries for
 	 * identity mappings for rmrr, gfx, and isa and may fall back to static
 	 * identity mapping if iommu_identity_mapping is set.
@@ -3137,6 +3148,8 @@ static int __init init_dmars(void)
 
 	iommu_prepare_isa();
 
+domains_done:
+
 	/*
 	 * for each drhd
 	 *   enable fault log
-- 
1.9.1
