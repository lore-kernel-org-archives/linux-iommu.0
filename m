From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/5] sh: introduce a sh_cacheop_vaddr helper
Date: Thu, 19 Jul 2018 06:05:13 -0700
Message-ID: <20180719130516.1989-3-hch@lst.de>
References: <20180719130516.1989-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719130516.1989-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

And use it in the maple bus code to avoid a dma API dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/cacheflush.h | 7 +++++++
 arch/sh/mm/consistent.c          | 6 +-----
 drivers/sh/maple/maple.c         | 7 ++++---
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index d103ab5a4e4b..b932e42ef028 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -101,5 +101,12 @@ void kunmap_coherent(void *kvaddr);
 
 void cpu_cache_init(void);
 
+static inline void *sh_cacheop_vaddr(void *vaddr)
+{
+	if (__in_29bit_mode())
+		vaddr = (void *)CAC_ADDR((unsigned long)vaddr);
+	return vaddr;
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_CACHEFLUSH_H */
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index e9d422bd42a5..1622ae6b9dbd 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -74,10 +74,7 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 void sh_sync_dma_for_device(void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
-	void *addr;
-
-	addr = __in_29bit_mode() ?
-	       (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;
+	void *addr = sh_cacheop_vaddr(vaddr);
 
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
@@ -93,7 +90,6 @@ void sh_sync_dma_for_device(void *vaddr, size_t size,
 		BUG();
 	}
 }
-EXPORT_SYMBOL(sh_sync_dma_for_device);
 
 static int __init memchunk_setup(char *str)
 {
diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 2e45988d1259..e5d7fb81ad66 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -300,8 +300,8 @@ static void maple_send(void)
 	mutex_unlock(&maple_wlist_lock);
 	if (maple_packets > 0) {
 		for (i = 0; i < (1 << MAPLE_DMA_PAGES); i++)
-			sh_sync_dma_for_device(maple_sendbuf + i * PAGE_SIZE,
-				       PAGE_SIZE, DMA_BIDIRECTIONAL);
+			__flush_purge_region(maple_sendbuf + i * PAGE_SIZE,
+					PAGE_SIZE);
 	}
 
 finish:
@@ -642,7 +642,8 @@ static void maple_dma_handler(struct work_struct *work)
 		list_for_each_entry_safe(mq, nmq, &maple_sentq, list) {
 			mdev = mq->dev;
 			recvbuf = mq->recvbuf->buf;
-			sh_sync_dma_for_device(recvbuf, 0x400, DMA_FROM_DEVICE);
+			__flush_invalidate_region(sh_cacheop_vaddr(recvbuf),
+					0x400);
 			code = recvbuf[0];
 			kfree(mq->sendbuf);
 			list_del_init(&mq->list);
-- 
2.18.0
