From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 19/20] iommu/amd: Flush iova queue before releasing dma_ops_domain
Date: Fri,  8 Jul 2016 13:45:10 +0200
Message-ID: <1467978311-28322-20-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Vincent.Wan@amd.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Before a dma_ops_domain can be freed, we need to make sure
it is not longer referenced by the flush queue. So empty the
queue before a dma_ops_domain can be freed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index dc3dbb4..4052997 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2162,12 +2162,10 @@ static void __queue_flush(struct flush_queue *queue)
 	queue->next = 0;
 }
 
-void queue_flush_timeout(unsigned long unsused)
+static void queue_flush_all(void)
 {
 	int cpu;
 
-	atomic_set(&queue_timer_on, 0);
-
 	for_each_possible_cpu(cpu) {
 		struct flush_queue *queue;
 		unsigned long flags;
@@ -2180,6 +2178,12 @@ void queue_flush_timeout(unsigned long unsused)
 	}
 }
 
+static void queue_flush_timeout(unsigned long unsused)
+{
+	atomic_set(&queue_timer_on, 0);
+	queue_flush_all();
+}
+
 static void queue_add(struct dma_ops_domain *dma_dom,
 		      unsigned long address, unsigned long pages)
 {
@@ -2850,6 +2854,13 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 
 	switch (dom->type) {
 	case IOMMU_DOMAIN_DMA:
+		/*
+		 * First make sure the domain is no longer referenced from the
+		 * flush queue
+		 */
+		queue_flush_all();
+
+		/* Now release the domain */
 		dma_dom = domain->priv;
 		dma_ops_domain_free(dma_dom);
 		break;
-- 
1.9.1
