From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 4/4] iommu/exynos: Properly release device from the default
	domain in ->remove
Date: Mon, 09 Jan 2017 13:03:56 +0100
Message-ID: <1483963436-29803-5-git-send-email-m.szyprowski@samsung.com>
References: <1483963436-29803-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20170109120413eucas1p19721a17d6e81e75e8f6e93ec2528f1b6@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1483963436-29803-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

IOMMU core doesn't detach device from the default domain before calling
->iommu_remove_device, so check that and do the proper cleanup or
warn if device is still attached to non-default domain.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8bf5a06a6c01..37d9738bd023 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1242,9 +1242,21 @@ static int exynos_iommu_add_device(struct device *dev)
 
 static void exynos_iommu_remove_device(struct device *dev)
 {
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+
 	if (!has_sysmmu(dev))
 		return;
 
+	if (owner->domain) {
+		struct iommu_group *group = iommu_group_get(dev);
+
+		if (group) {
+			WARN_ON(owner->domain !=
+				iommu_group_default_domain(group));
+			exynos_iommu_detach_device(owner->domain, dev);
+			iommu_group_put(group);
+		}
+	}
 	iommu_group_remove_device(dev);
 }
 
-- 
1.9.1
