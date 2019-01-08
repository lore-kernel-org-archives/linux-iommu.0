From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 3/3] dma-mapping: remove dma_zalloc_coherent()
Date: Tue, 8 Jan 2019 15:29:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1901081528350.6130@hadrien>
References: <20190108130701.14161-1-hch@lst.de>
	<20190108130701.14161-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190108130701.14161-4-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On Tue, 8 Jan 2019, Christoph Hellwig wrote:

> From: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> dma_zalloc_coherent() is no longer needed as it has no users because
> dma_alloc_coherent() already zeroes out memory for us.
>
> The Coccinelle grammar rule that used to check for dma_alloc_coherent()
> + memset() is modified so that it just tells the user that the memset is
> not needed anymore.
>
> Suggested-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Signed-off-by: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  include/linux/dma-mapping.h                      |  9 ---------
>  scripts/coccinelle/api/alloc/alloc_cast.cocci    |  8 ++++----
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 11 +----------
>  3 files changed, 5 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index cef2127e1d70..f6ded992c183 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -717,15 +717,6 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>  }
>  #endif
>
> -/*
> - * Please always use dma_alloc_coherent instead as it already zeroes the memory!
> - */
> -static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
> -					dma_addr_t *dma_handle, gfp_t flag)
> -{
> -	return dma_alloc_coherent(dev, size, dma_handle, flag);
> -}
> -
>  static inline int dma_get_cache_alignment(void)
>  {
>  #ifdef ARCH_DMA_MINALIGN
> diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> index 408ee3879f9b..18fedf7c60ed 100644
> --- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
> +++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> @@ -32,7 +32,7 @@ type T;
>    (T *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> @@ -55,7 +55,7 @@ type r1.T;
>  * (T *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> @@ -78,7 +78,7 @@ type r1.T;
>  - (T *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> @@ -95,7 +95,7 @@ position p;
>   (T@p *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index d819275b7fde..5cd1991c582e 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -69,15 +69,6 @@ statement S;
>  - x = (T)vmalloc(E1);
>  + x = (T)vzalloc(E1);
>  |
> -- x = dma_alloc_coherent(E2,E1,E3,E4);
> -+ x = dma_zalloc_coherent(E2,E1,E3,E4);
> -|
> -- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
> -+ x = dma_zalloc_coherent(E2,E1,E3,E4);
> -|
> -- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> -+ x = (T)dma_zalloc_coherent(E2,E1,E3,E4);

Perhaps it would be better to make a separate rule that removed the
memset?  It wouldn't need the three cases.
x = (T)dma_alloc_coherent(E2,E1,E3,E4); would take care of everything.

julia

> -|
>  - x = kmalloc_node(E1,E2,E3);
>  + x = kzalloc_node(E1,E2,E3);
>  |
> @@ -225,7 +216,7 @@ p << r2.p;
>  x << r2.x;
>  @@
>
> -msg="WARNING: dma_zalloc_coherent should be used for %s, instead of dma_alloc_coherent/memset" % (x)
> +msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
>  coccilib.report.print_report(p[0], msg)
>
>  //-----------------------------------------------------------------
> --
> 2.20.1
>
>
