From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] swiotlb: Introduce swiotlb_max_mapping_size()
Date: Tue, 15 Jan 2019 14:22:55 +0100
Message-ID: <20190115132257.6426-2-joro@8bytes.org>
References: <20190115132257.6426-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115132257.6426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The function returns the maximum size that can be remapped
by the SWIOTLB implementation. This function will be later
exposed to users through the DMA-API.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 5 +++++
 kernel/dma/swiotlb.c    | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..ceb623321f38 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -62,6 +62,7 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 
 extern int
 swiotlb_dma_supported(struct device *hwdev, u64 mask);
+extern size_t swiotlb_max_mapping_size(struct device *dev);
 
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
@@ -95,6 +96,10 @@ static inline unsigned int swiotlb_max_segment(void)
 {
 	return 0;
 }
+static inline size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return SIZE_MAX;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d6361776dc5c..c950b3e9f683 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -660,3 +660,8 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
+
+size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
+}
-- 
2.17.1
