From: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] numa,
	iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
	translation tables
Date: Thu, 21 Sep 2017 14:29:20 +0530
Message-ID: <20170921085922.11659-3-ganapatrao.kulkarni@cavium.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170921085922.11659-1-ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: Will.Deacon-5wv7dgnIgG8@public.gmane.org, gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Tomasz.Nowicki-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Robert.Richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, mhocko-IBi9RG/b67k@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

function __arm_lpae_alloc_pages is used to allcoated memory for smmu
translation tables. updating function to allocate memory/pages
from the proximity domain of SMMU device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e8018a3..f6d01f6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -215,8 +215,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 {
 	struct device *dev = cfg->iommu_dev;
 	dma_addr_t dma;
-	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
+	void *pages;
 
+	pages = alloc_pages_exact_nid(dev_to_node(dev), size,
+			gfp | __GFP_ZERO);
 	if (!pages)
 		return NULL;
 
-- 
2.9.4
