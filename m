From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] xen-swiotlb: Make two functions static
Date: Tue, 16 Apr 2019 22:49:50 +0800
Message-ID: <20190416144950.37952-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, YueHaibing <yuehaibing@huawei.com>
List-Id: iommu@lists.linux-foundation.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/xen/swiotlb-xen.c:489:1: warning:
 symbol 'xen_swiotlb_sync_single_for_cpu' was not declared. Should it be static?
drivers/xen/swiotlb-xen.c:496:1: warning:
 symbol 'xen_swiotlb_sync_single_for_device' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2..e741df4 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -485,14 +485,14 @@ xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 		xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
 }
 
-void
+static void
 xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 				size_t size, enum dma_data_direction dir)
 {
 	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
 
-void
+static void
 xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 				   size_t size, enum dma_data_direction dir)
 {
-- 
2.7.4
