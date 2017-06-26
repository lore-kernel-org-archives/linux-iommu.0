From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/5] iommu: add a new member unmap_tlb_sync into struct iommu_ops
Date: Mon, 26 Jun 2017 21:38:47 +0800
Message-ID: <1498484330-10840-3-git-send-email-thunder.leizhen@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

An iova range may contain many pages/blocks, especially for the case of
unmap_sg. Currently, for each page/block unmapping, a tlb invalidation
operation will be followed and wait(called tlb_sync) until the operation's
over. But actually we only need one tlb_sync in the last stage. Look at
the loop in function iommu_unmap:
	while (unmapped < size) {
		...
		unmapped_page = domain->ops->unmap(domain, iova, pgsize);
		...
	}
It's not a good idea to add the tlb_sync in domain->ops->unmap.

There are many profits, below actions can be reduced:
1. iommu hardware is a shared resource for cpus, for the tlb_sync operation,
   lock protection is needed.
2. iommu hardware is not inside CPU, to start tlb_sync and check it finished
   may take a lot of time.

Some people might ask: Is it safe to do so? The answer is yes. The standard
processing flow is:
	alloc iova
	map
	process data
	unmap
	tlb invalidation and sync
	free iova

What should be guaranteed is: "free iova" action is behind "unmap" and "tlbi
operation" action, that is what we are doing right now. This ensures that:
all TLBs of an iova-range have been invalidated before the iova reallocated.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iommu.c | 3 +++
 include/linux/iommu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cf7ca7e..01e91a8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1610,6 +1610,9 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		unmapped += unmapped_page;
 	}
 
+	if (domain->ops->unmap_tlb_sync)
+		domain->ops->unmap_tlb_sync(domain);
+
 	trace_unmap(orig_iova, size, unmapped);
 	return unmapped;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54ad..5964121 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -197,6 +197,7 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
+	void (*unmap_tlb_sync)(struct iommu_domain *domain);
 	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
-- 
2.5.0
