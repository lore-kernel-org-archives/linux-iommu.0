From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 17/20] iommu/vt-d: fix wrong return value of
	dmar_table_init()
Date: Mon,  6 Jan 2014 14:18:24 +0800
Message-ID: <1388989107-4795-18-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

If dmar_table_init() fails to detect DMAR table on the first call,
it will return wrong result on following calls because it always
sets dmar_table_initialized no matter if succeeds or fails to
detect DMAR table.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index bb635fb..c4b271d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -472,24 +472,23 @@ int __init dmar_table_init(void)
 	static int dmar_table_initialized;
 	int ret;
 
-	if (dmar_table_initialized)
-		return 0;
-
-	dmar_table_initialized = 1;
-
-	ret = parse_dmar_table();
-	if (ret) {
-		if (ret != -ENODEV)
-			pr_info("parse DMAR table failure.\n");
-		return ret;
-	}
+	if (dmar_table_initialized == 0) {
+		ret = parse_dmar_table();
+		if (ret < 0) {
+			if (ret != -ENODEV)
+				pr_info("parse DMAR table failure.\n");
+		} else  if (list_empty(&dmar_drhd_units)) {
+			pr_info("No DMAR devices found\n");
+			ret = -ENODEV;
+		}
 
-	if (list_empty(&dmar_drhd_units)) {
-		pr_info("No DMAR devices found\n");
-		return -ENODEV;
+		if (ret < 0)
+			dmar_table_initialized = ret;
+		else
+			dmar_table_initialized = 1;
 	}
 
-	return 0;
+	return dmar_table_initialized < 0 ? dmar_table_initialized : 0;
 }
 
 static void warn_invalid_dmar(u64 addr, const char *message)
-- 
1.7.10.4
