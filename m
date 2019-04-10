From: Scott Wood <swood@redhat.com>
Subject: [PATCH] dma-debug: Only skip one stackframe entry
Date: Wed, 10 Apr 2019 16:59:25 -0500
Message-ID: <20190410215925.8458-1-swood@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Scott Wood <swood@redhat.com>
List-Id: iommu@lists.linux-foundation.org

With skip set to 1, I get a traceback like this:

[  106.867637] DMA-API: Mapped at:
[  106.870784]  afu_dma_map_region+0x2cd/0x4f0 [dfl_afu]
[  106.875839]  afu_ioctl+0x258/0x380 [dfl_afu]
[  106.880108]  do_vfs_ioctl+0xa9/0x720
[  106.883688]  ksys_ioctl+0x60/0x90
[  106.887007]  __x64_sys_ioctl+0x16/0x20

With the previous value of 2, afu_dma_map_region was being omitted.  I
suspect that the code paths have simply changed since the value of 2 was
chosen a decade ago, but it's also possible that it varies based on which
mapping function was used, compiler inlining choices, etc.  In any case,
it's best to err on the side of skipping less.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 45d51e8e26f6..a218e43cc382 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -706,7 +706,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 #ifdef CONFIG_STACKTRACE
 	entry->stacktrace.max_entries = DMA_DEBUG_STACKTRACE_ENTRIES;
 	entry->stacktrace.entries = entry->st_entries;
-	entry->stacktrace.skip = 2;
+	entry->stacktrace.skip = 1;
 	save_stack_trace(&entry->stacktrace);
 #endif
 
-- 
1.8.3.1
