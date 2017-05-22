From: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: unwrap __get_valid_domain_for_dev()
Date: Mon, 22 May 2017 18:28:51 +0800
Message-ID: <1495448931-20382-1-git-send-email-peterx@redhat.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We do find_domain() in __get_valid_domain_for_dev(), while we do the
same thing in get_valid_domain_for_dev().  No need to do it twice.

Signed-off-by: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fc2765c..cb96f1c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2390,7 +2390,7 @@ static struct dmar_domain *find_domain(struct device *dev)
 
 	/* No lock here, assumes no domain exit in normal case */
 	info = dev->archdata.iommu;
-	if (info)
+	if (likely(info))
 		return info->domain;
 	return NULL;
 }
@@ -3478,7 +3478,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
+static struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain, *tmp;
 	struct dmar_rmrr_unit *rmrr;
@@ -3525,18 +3525,6 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 	return domain;
 }
 
-static inline struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
-{
-	struct device_domain_info *info;
-
-	/* No lock here, assumes no domain exit in normal case */
-	info = dev->archdata.iommu;
-	if (likely(info))
-		return info->domain;
-
-	return __get_valid_domain_for_dev(dev);
-}
-
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static int iommu_no_mapping(struct device *dev)
 {
-- 
2.7.4
