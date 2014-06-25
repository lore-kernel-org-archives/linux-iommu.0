From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch Part3 V3 02/21] iommu/vt-d: use correct domain id to flush virtual machine domains
Date: Wed, 25 Jun 2014 17:02:28 +0800
Message-ID: <1403686967-10887-3-git-send-email-jiang.liu@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Yijing Wang <wangyijing@huawei.com>, Tony Luck <tony.luck@intel.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

For virtual machine domains, domain->id is a virtual id, and the real
domain id written into context entry is dynamically allocated.
So use the real domain id instead of domain->id when flushing iotlbs
for virtual machine domains.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e29d963f3967..64a3c37d5cfa 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1825,7 +1825,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 					   (((u16)bus) << 8) | devfn,
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, domain->id, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.flush_iotlb(iommu, id, 0, 0, DMA_TLB_DSI_FLUSH);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
-- 
1.7.10.4
