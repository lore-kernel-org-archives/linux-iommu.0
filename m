From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] iommu: simplify init function
Date: Tue, 28 Jun 2016 20:38:36 +0200
Message-ID: <eb8426b8-d601-af6e-170f-1a29eb8e1d56@gmail.com>
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
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu_group_ida and iommu_group_mutex can be initialized statically.
There's no need to do this dynamically in the init function.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/iommu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3000051..debce45 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -34,8 +34,8 @@
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
-static struct ida iommu_group_ida;
-static struct mutex iommu_group_mutex;
+static DEFINE_IDA(iommu_group_ida);
+static DEFINE_MUTEX(iommu_group_mutex);
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -1483,9 +1483,6 @@ static int __init iommu_init(void)
 {
 	iommu_group_kset = kset_create_and_add("iommu_groups",
 					       NULL, kernel_kobj);
-	ida_init(&iommu_group_ida);
-	mutex_init(&iommu_group_mutex);
-
 	BUG_ON(!iommu_group_kset);
 
 	return 0;
-- 
2.9.0
