From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] iommu: fix default domain handling in
	__iommu_detach_group()
Date: Tue, 16 Feb 2016 15:40:32 +0100
Message-ID: <1455633632-16873-3-git-send-email-m.szyprowski@samsung.com>
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

This patch ensures that all devices will be first detached from the
provided domain and then attached to the default_domain if such has been
provided.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index db231ad..045efb0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1246,14 +1246,14 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (!group->default_domain) {
-		__iommu_group_for_each_dev(group, domain,
-					   iommu_group_do_detach_device);
-		group->domain = NULL;
+	if (group->domain == group->default_domain)
 		return;
-	}
 
-	if (group->domain == group->default_domain)
+	__iommu_group_for_each_dev(group, domain,
+				   iommu_group_do_detach_device);
+	group->domain = NULL;
+
+	if (!group->default_domain)
 		return;
 
 	/* Detach by re-attaching to the default domain */
-- 
1.9.2
