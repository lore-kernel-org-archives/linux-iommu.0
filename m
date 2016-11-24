From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/5] iommu/exynos: Ensure that SYSMMU is added only once to its
	master device
Date: Thu, 24 Nov 2016 12:20:18 +0100
Message-ID: <1479986420-30859-4-git-send-email-m.szyprowski@samsung.com>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1479986420-30859-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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

This patch prepares Exynos IOMMU driver for deferred probing
support. Once it gets added, of_xlate() callback might be called
more than once for the same SYSMMU controller and master device
(for example it happens when masters device driver fails with
EPROBE_DEFER). This patch adds a check, which ensures that SYSMMU
controller is added to its master device (owner) only once.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e7851cffbbee..426b1534d4d3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1247,7 +1247,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
-	struct sysmmu_drvdata *data;
+	struct sysmmu_drvdata *data, *entry;
 
 	if (!sysmmu)
 		return -ENODEV;
@@ -1266,6 +1266,10 @@ static int exynos_iommu_of_xlate(struct device *dev,
 		dev->archdata.iommu = owner;
 	}
 
+	list_for_each_entry(entry, &owner->controllers, owner_node)
+		if (entry == data)
+			return 0;
+
 	list_add_tail(&data->owner_node, &owner->controllers);
 	data->master = dev;
 
-- 
1.9.1
