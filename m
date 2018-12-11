From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] dma-debug: fix soft lockup when a lot of debug are enabled
Date: Tue, 11 Dec 2018 11:36:16 +0100
Message-ID: <20181211103616.22137-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: iommu@lists.linux-foundation.org

When running a kernel in qemu with enough debugging options (slub-debug,
ftrace, kcov, kasan, ubsan, ...) enabled together, that results in a
slow initcall. So a 'watchdog: BUG: soft lockup' happens:

[   44.105619] Call trace:
[   44.106709]  __slab_alloc+0x70/0x88
[   44.107757]  kmem_cache_alloc_trace+0x13c/0x590
[   44.108764]  prealloc_memory+0xb8/0x240
[   44.109768]  dma_debug_init+0x174/0x1f0
[   44.110725]  do_one_initcall+0x430/0x8b0
[   44.111719]  do_initcall_level+0x548/0x5b4
[   44.112672]  do_initcalls+0x28/0x4c
[   44.113628]  do_basic_setup+0x34/0x3c
[   44.114559]  kernel_init_freeable+0x194/0x24c
[   44.115570]  kernel_init+0x24/0x18c
[   44.116498]  ret_from_fork+0x10/0x18

Rework to call cond_resched(), in the function prealloc_memory()'s
for-loop.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/dma/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..2abdc265aec4 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -767,6 +767,7 @@ static int prealloc_memory(u32 num_entries)
 	int i;
 
 	for (i = 0; i < num_entries; ++i) {
+		cond_resched();
 		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 		if (!entry)
 			goto out_err;
-- 
2.19.2
