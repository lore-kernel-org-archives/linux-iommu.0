From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH v4] dma-debug: fix incorrect pfn calculation
Date: Thu, 16 Nov 2017 16:13:50 -0800
Message-ID: <20171116161350.3b8bd1fbcaae8e032441d3e7@linux-foundation.org>
References: <1510872972-23919-1-git-send-email-miles.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1510872972-23919-1-git-send-email-miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 17 Nov 2017 06:56:12 +0800 <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:

> From: Miles Chen <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> dma-debug reports the following warning:
> 
> [name:panic&]WARNING: CPU: 3 PID: 298 at kernel-4.4/lib/dma-debug.c:604
> debug _dma_assert_idle+0x1a8/0x230()
> DMA-API: cpu touching an active dma mapped cacheline [cln=0x00000882300]
> CPU: 3 PID: 298 Comm: vold Tainted: G        W  O    4.4.22+ #1
> Hardware name: MT6739 (DT)
> Call trace:
> [<ffffff800808acd0>] dump_backtrace+0x0/0x1d4
> [<ffffff800808affc>] show_stack+0x14/0x1c
> [<ffffff800838019c>] dump_stack+0xa8/0xe0
> [<ffffff80080a0594>] warn_slowpath_common+0xf4/0x11c
> [<ffffff80080a061c>] warn_slowpath_fmt+0x60/0x80
> [<ffffff80083afe24>] debug_dma_assert_idle+0x1a8/0x230
> [<ffffff80081dca9c>] wp_page_copy.isra.96+0x118/0x520
> [<ffffff80081de114>] do_wp_page+0x4fc/0x534
> [<ffffff80081e0a14>] handle_mm_fault+0xd4c/0x1310
> [<ffffff8008098798>] do_page_fault+0x1c8/0x394
> [<ffffff800808231c>] do_mem_abort+0x50/0xec
> 
> I found that debug_dma_alloc_coherent() and debug_dma_free_coherent()
> assume that dma_alloc_coherent() always returns a linear address.  However
> it's possible that dma_alloc_coherent() returns a non-linear address.  In
> this case, page_to_pfn(virt_to_page(virt)) will return an incorrect pfn.
> If the pfn is valid and mapped as a COW page, we will hit the warning when
> doing wp_page_copy().
> 
> Fix this by calculating pfn for linear and non-linear addresses.
> 

It's a shame you didn't Cc Christoph, who was the sole reviewer of the
earlier version.

And it's a shame you didn't capture the result of that review
discussion in the v3 changelog.

And it's a shame that you didn't describe how this patch differs from
earlier versions.


Oh well, here's the incremental patch:

--- a/lib/dma-debug.c~dma-debug-fix-incorrect-pfn-calculation-v4
+++ a/lib/dma-debug.c
@@ -1495,15 +1495,22 @@ void debug_dma_alloc_coherent(struct dev
 	if (!entry)
 		return;
 
+	/* handle vmalloc and linear addresses */
+	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
+		return;
+
 	entry->type      = dma_debug_coherent;
 	entry->dev       = dev;
-	entry->pfn	 = is_vmalloc_addr(virt) ? vmalloc_to_pfn(virt) :
-						page_to_pfn(virt_to_page(virt));
 	entry->offset	 = offset_in_page(virt);
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
 
+	if (is_vmalloc_addr(virt))
+		entry->pfn = vmalloc_to_pfn(virt);
+	else
+		entry->pfn = page_to_pfn(virt_to_page(virt));
+
 	add_dma_entry(entry);
 }
 EXPORT_SYMBOL(debug_dma_alloc_coherent);
@@ -1514,14 +1521,21 @@ void debug_dma_free_coherent(struct devi
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_coherent,
 		.dev            = dev,
-		.pfn		= is_vmalloc_addr(virt) ? vmalloc_to_pfn(virt) :
-						page_to_pfn(virt_to_page(virt)),
 		.offset		= offset_in_page(virt),
 		.dev_addr       = addr,
 		.size           = size,
 		.direction      = DMA_BIDIRECTIONAL,
 	};
 
+	/* handle vmalloc and linear addresses */
+	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
+		return;
+
+	if (is_vmalloc_addr(virt))
+		ref.pfn = vmalloc_to_pfn(virt);
+	else
+		ref.pfn = page_to_pfn(virt_to_page(virt));
+
 	if (unlikely(dma_debug_disabled()))
 		return;
 
_
