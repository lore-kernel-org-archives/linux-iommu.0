From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: add the iommu list for swiotlb and
	xen-swiotlb
Date: Thu, 25 Jan 2018 09:26:18 -0500
Message-ID: <20180125142618.GB25449@char.us.oracle.com>
References: <20180116075624.5191-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180116075624.5191-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 16, 2018 at 08:56:24AM +0100, Christoph Hellwig wrote:
> All other discussions related to the dma mapping interfaces are on the
> iommu list, so let's make it the official list for swiotlb and the
> second list for xen-swiotlb.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

I am so behind emails.. I am not sure if I had replied to this, but just
in case I hadn't:

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

P.S.
I am behind on the review of your dma rework - really sorry it is taking
that long.
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d54e636d625..30dcafd388ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13034,7 +13034,7 @@ F:	arch/x86/boot/video*
>  
>  SWIOTLB SUBSYSTEM
>  M:	Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> -L:	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +L:	iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
>  S:	Supported
>  F:	lib/swiotlb.c
> @@ -14969,6 +14969,7 @@ F:	include/xen/interface/io/vscsiif.h
>  XEN SWIOTLB SUBSYSTEM
>  M:	Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>  L:	xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org (moderated for non-subscribers)
> +L:	iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>  S:	Supported
>  F:	arch/x86/xen/*swiotlb*
>  F:	drivers/xen/*swiotlb*
> -- 
> 2.14.2
> 
