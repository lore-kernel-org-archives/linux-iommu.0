From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu/exynos: Don't unconditionally steal bus ops
Date: Tue,  9 Jan 2018 15:34:07 +0000
Message-ID: <da24d31fc6f4be7b44ceef215f672c0ed3c37979.1515511941.git.robin.murphy@arm.com>
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Removing the early device registration hook overlooked the fact that
it only ran conditionally on a compatible device being present in the
DT. With exynos_iommu_init() now running as an unconditional initcall,
problems arise on non-Exynos systems when other IOMMU drivers find
themselves unable to install their ops on the platform bus, or at worst
the Exynos ops get called with someone else's domain and all hell breaks
loose.

The global ops/cache setup could probably all now be triggered from the
first IOMMU probe, as with dma_dev assigment, but for the time being the
simplest fix is to resurrect the logic from commit a7b67cd5d9af
("iommu/exynos: Play nice in multi-platform builds") to explicitly check
the DT for the presence of an Exynos IOMMU before trying anything.

Fixes: 928055a01b3f ("iommu/exynos: Remove custom platform device registration code")
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Use the simpler explicit DT check.

 drivers/iommu/exynos-iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 79c45650f8de..736d4552d96f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1353,8 +1353,15 @@ static const struct iommu_ops exynos_iommu_ops = {
 
 static int __init exynos_iommu_init(void)
 {
+	struct device_node *np;
 	int ret;
 
+	np = of_find_matching_node(NULL, sysmmu_of_match);
+	if (!np)
+		return 0;
+
+	of_node_put(np);
+
 	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
 				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
 	if (!lv2table_kmem_cache) {
-- 
2.13.4.dirty
