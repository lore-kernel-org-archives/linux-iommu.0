From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu/io-pgtable-armv7s: Fix kmem_cache_alloc() flags
Date: Tue,  1 Mar 2016 19:07:03 +0000
Message-ID: <526555051e63e72a4b1e68461e51a7b6e33df352.1456859025.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst the default SLUB allocator happily just merges the original
allocation flags from kmem_cache_create() with those passed through
kmem_cache_alloc(), there is a code path in the SLAB allocator which
will aggressively BUG_ON() if the cache was created with SLAB_CACHE_DMA
but GFP_DMA is not specified for an allocation:

  kernel BUG at mm/slab.c:2536!
  Internal error: Oops - BUG: 0 [#1] SMP ARM
  Modules linked in:[    1.299311] Modules linked in:

  CPU: 1 PID: 1 Comm: swapper/0 Not tainted
  4.5.0-rc6-koelsch-05892-ge7e45ad53ab6795e #2270
  Hardware name: Generic R8A7791 (Flattened Device Tree)
  task: ef422040 ti: ef442000 task.ti: ef442000
  PC is at cache_alloc_refill+0x2a0/0x530
  LR is at _raw_spin_unlock+0x8/0xc
...
  [<c02c6928>] (cache_alloc_refill) from [<c02c6630>] (kmem_cache_alloc+0x7c/0xd4)
  [<c02c6630>] (kmem_cache_alloc) from [<c04444bc>]
  (__arm_v7s_alloc_table+0x5c/0x278)
  [<c04444bc>] (__arm_v7s_alloc_table) from [<c0444e1c>]
  (__arm_v7s_map.constprop.6+0x68/0x25c)
  [<c0444e1c>] (__arm_v7s_map.constprop.6) from [<c0445044>]
  (arm_v7s_map+0x34/0xa4)
  [<c0445044>] (arm_v7s_map) from [<c0c18ee4>] (arm_v7s_do_selftests+0x140/0x418)
  [<c0c18ee4>] (arm_v7s_do_selftests) from [<c0201760>]
  (do_one_initcall+0x100/0x1b4)
  [<c0201760>] (do_one_initcall) from [<c0c00d4c>]
  (kernel_init_freeable+0x120/0x1e8)
  [<c0c00d4c>] (kernel_init_freeable) from [<c067a364>] (kernel_init+0x8/0xec)
  [<c067a364>] (kernel_init) from [<c0206b68>] (ret_from_fork+0x14/0x2c)
  Code: 1a000003 e7f001f2 e3130001 0a000000 (e7f001f2)
  ---[ end trace 190f6f6b84352efd ]---

Keep the peace by adding GFP_DMA when allocating a table.

Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Add the backtrace to the commit log, add Will's ack.
 
 drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 9fcceb1..9488e3c 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -192,7 +192,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	if (lvl == 1)
 		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp);
+		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
 	if (table && !selftest_running) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
-- 
2.7.2.333.g70bd996.dirty
