From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] swiotlb: drop pointless static qualifier in swiotlb_dma_supported()
Date: Thu, 14 Feb 2019 01:41:47 +0000
Message-ID: <20190214014147.108653-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: YueHaibing <yuehaibing@huawei.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There is no need to have the 'struct dentry *d_swiotlb_usage' variable
static since new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a7b53786db9f..02fa517c47d9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -689,7 +689,7 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 
 static int __init swiotlb_create_debugfs(void)
 {
-	static struct dentry *d_swiotlb_usage;
+	struct dentry *d_swiotlb_usage;
 	struct dentry *ent;
 
 	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
