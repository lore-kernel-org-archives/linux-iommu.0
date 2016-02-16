From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] iommu: call detach also for default_domain before
	attaching to new one
Date: Tue, 16 Feb 2016 15:40:31 +0100
Message-ID: <1455633632-16873-2-git-send-email-m.szyprowski@samsung.com>
References: <1455633632-16873-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1455633632-16873-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch ensures that devices attached to the default_domain will be
first detached from it before attaching to new domain. To avoid forward
declaration, __iommu_attach_group() function has been moved to new place
in the source code.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/iommu.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0e3b009..db231ad 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1198,22 +1198,6 @@ static int iommu_group_do_attach_device(struct device *dev, void *data)
 	return __iommu_attach_device(domain, dev);
 }
 
-static int __iommu_attach_group(struct iommu_domain *domain,
-				struct iommu_group *group)
-{
-	int ret;
-
-	if (group->default_domain && group->domain != group->default_domain)
-		return -EBUSY;
-
-	ret = __iommu_group_for_each_dev(group, domain,
-					 iommu_group_do_attach_device);
-	if (ret == 0)
-		group->domain = domain;
-
-	return ret;
-}
-
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	int ret;
@@ -1235,6 +1219,28 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 	return 0;
 }
 
+static int __iommu_attach_group(struct iommu_domain *domain,
+				struct iommu_group *group)
+{
+	int ret;
+
+	if (group->default_domain && group->domain != group->default_domain)
+		return -EBUSY;
+
+	if (group->default_domain && group->default_domain == group->domain) {
+		__iommu_group_for_each_dev(group, group->domain,
+					   iommu_group_do_detach_device);
+		group->domain = NULL;
+	}
+
+	ret = __iommu_group_for_each_dev(group, domain,
+					 iommu_group_do_attach_device);
+	if (ret == 0)
+		group->domain = domain;
+
+	return ret;
+}
+
 static void __iommu_detach_group(struct iommu_domain *domain,
 				 struct iommu_group *group)
 {
-- 
1.9.2
