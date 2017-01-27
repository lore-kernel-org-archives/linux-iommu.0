From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC] iommu/dma: Per-domain flag to control size-alignment
Date: Fri, 27 Jan 2017 17:38:05 +0000
Message-ID: <464656f9-970e-1271-0d9e-b62a0673e1dd@arm.com>
References: <148549826507.23190.1460689571069015835.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148549826507.23190.1460689571069015835.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On 27/01/17 06:24, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Introduce the flag "no_size_align" to allow disabling size-alignment
> on a per-domain basis. This follows the suggestion by the comment
> in the code, however a per-device control may be preferred?
> 
> Needed to make virtual space contiguous for certain devices.

That sounds very suspicious - a single allocation is contiguous with
itself by definition, and anyone relying on multiple allocations being
contiguous with one another is doing it wrong, because there's no way we
could ever guarantee that (with this allocator, at any rate). I'd be
very reticent to touch this without a specific example of what problem
it solves.

Since I understand all this stuff a lot more deeply now that back when I
first wrote that comment, I'd say that if there really is some real need
to implement this feature, it should be a dma_attr flag, i.e. not even
per-device, but per-allocation. We'd be breaking a behaviour currently
guaranteed by the DMA API, so we need to be really sure the caller is OK
with that - having it be their responsibility to explicitly ask is
definitely safest.

Robin.

> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
>  drivers/iommu/dma-iommu.c |    6 +++++-
>  include/linux/iommu.h     |    1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> --- 0001/drivers/iommu/dma-iommu.c
> +++ work/drivers/iommu/dma-iommu.c	2017-01-27 15:17:50.280607110 +0900
> @@ -209,14 +209,18 @@ static struct iova *__alloc_iova(struct
>  	struct iova_domain *iovad = cookie_iovad(domain);
>  	unsigned long shift = iova_shift(iovad);
>  	unsigned long length = iova_align(iovad, size) >> shift;
> +	bool size_aligned = true;
>  
>  	if (domain->geometry.force_aperture)
>  		dma_limit = min(dma_limit, domain->geometry.aperture_end);
> +
> +	if (domain->no_size_align)
> +		size_aligned = false;
>  	/*
>  	 * Enforce size-alignment to be safe - there could perhaps be an
>  	 * attribute to control this per-device, or at least per-domain...
>  	 */
> -	return alloc_iova(iovad, length, dma_limit >> shift, true);
> +	return alloc_iova(iovad, length, dma_limit >> shift, size_aligned);
>  }
>  
>  /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
> --- 0001/include/linux/iommu.h
> +++ work/include/linux/iommu.h	2017-01-27 15:16:37.630607110 +0900
> @@ -83,6 +83,7 @@ struct iommu_domain {
>  	iommu_fault_handler_t handler;
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
> +	bool no_size_align;
>  	void *iova_cookie;
>  };
>  
> 
