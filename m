From: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] iommu/s390: fix sparse warnings
Date: Fri, 6 Nov 2015 17:26:24 +0100 (CET)
Message-ID: <alpine.LFD.2.11.1511061723260.2646@denkbrett>
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
To: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Fix these warnings:
  CHECK   drivers/iommu/s390-iommu.c
drivers/iommu/s390-iommu.c:52:21: warning: symbol 's390_domain_alloc' was not declared. Should it be static?
drivers/iommu/s390-iommu.c:76:6: warning: symbol 's390_domain_free' was not declared. Should it be static?

Signed-off-by: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 drivers/iommu/s390-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index cbe198c..030e94c 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -49,7 +49,7 @@ static bool s390_iommu_capable(enum iommu_cap cap)
 	}
 }
 
-struct iommu_domain *s390_domain_alloc(unsigned domain_type)
+static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 {
 	struct s390_domain *s390_domain;
 
@@ -73,7 +73,7 @@ struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 	return &s390_domain->domain;
 }
 
-void s390_domain_free(struct iommu_domain *domain)
+static void s390_domain_free(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 
-- 
2.3.0
