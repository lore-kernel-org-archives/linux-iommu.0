From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/20] iommu/amd: Set up data structures for flush queue
Date: Fri,  8 Jul 2016 13:45:02 +0200
Message-ID: <1467978311-28322-12-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The flush queue is the equivalent to defered-flushing in the
Intel VT-d driver. This patch sets up the data structures
needed for this.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b91843c..4e27c57 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -88,6 +88,22 @@ LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
 
+#define FLUSH_QUEUE_SIZE 256
+
+struct flush_queue_entry {
+	unsigned long iova_pfn;
+	unsigned long pages;
+	struct dma_ops_domain *dma_dom;
+};
+
+struct flush_queue {
+	spinlock_t lock;
+	unsigned next;
+	struct flush_queue_entry *entries;
+};
+
+DEFINE_PER_CPU(struct flush_queue, flush_queue);
+
 /*
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
@@ -2516,7 +2532,7 @@ static int init_reserved_iova_ranges(void)
 
 int __init amd_iommu_init_api(void)
 {
-	int ret, err = 0;
+	int ret, cpu, err = 0;
 
 	ret = iova_cache_get();
 	if (ret)
@@ -2526,6 +2542,18 @@ int __init amd_iommu_init_api(void)
 	if (ret)
 		return ret;
 
+	for_each_possible_cpu(cpu) {
+		struct flush_queue *queue = per_cpu_ptr(&flush_queue, cpu);
+
+		queue->entries = kzalloc(FLUSH_QUEUE_SIZE *
+					 sizeof(*queue->entries),
+					 GFP_KERNEL);
+		if (!queue->entries)
+			goto out_put_iova;
+
+		spin_lock_init(&queue->lock);
+	}
+
 	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
 	if (err)
 		return err;
@@ -2535,6 +2563,15 @@ int __init amd_iommu_init_api(void)
 		return err;
 #endif
 	return 0;
+
+out_put_iova:
+	for_each_possible_cpu(cpu) {
+		struct flush_queue *queue = per_cpu_ptr(&flush_queue, cpu);
+
+		kfree(queue->entries);
+	}
+
+	return -ENOMEM;
 }
 
 int __init amd_iommu_init_dma_ops(void)
@@ -2557,6 +2594,7 @@ int __init amd_iommu_init_dma_ops(void)
 		pr_info("AMD-Vi: Lazy IO/TLB flushing enabled\n");
 
 	return 0;
+
 }
 
 /*****************************************************************************
-- 
1.9.1
