From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/4] iommu/exynos: Play nice in multi-platform builds
Date: Fri,  6 Feb 2015 11:44:05 +0100
Message-ID: <1423219448-22683-2-git-send-email-thierry.reding@gmail.com>
References: <1423219448-22683-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423219448-22683-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The Exynos System MMU driver unconditionally executes code and registers
a struct iommu_ops with the platform bus irrespective of whether it runs
on an Exynos SoC or not. This causes problems in multi-platform kernels
where drivers for other SoCs will no longer be able to register their
own struct iommu_ops or even try to use a struct iommu_ops for an IOMMU
that obviously isn't there.

The smallest fix I could think of is to check for the existence of any
Exynos System MMU devices in the device tree and skip initialization
otherwise.

This fixes a problem on Tegra20 where the DRM driver will try to use the
obviously non-existent Exynos System MMU.

Reported-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
- drop reference to struct device_node

 drivers/iommu/exynos-iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7ce52737c7a1..dc14fec4ede1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1186,8 +1186,15 @@ static const struct iommu_ops exynos_iommu_ops = {
 
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
2.1.3
