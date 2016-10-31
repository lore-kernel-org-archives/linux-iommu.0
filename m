From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] swiotlb: Add swiotlb=nobounce debug option
Date: Mon, 31 Oct 2016 17:41:58 +0000
Message-ID: <86c57a18-cb28-8aee-9edb-96da73d4f829@arm.com>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
 <1477928704-10611-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1477928704-10611-3-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On 31/10/16 15:45, Geert Uytterhoeven wrote:
> On architectures like arm64, swiotlb is tied intimately to the core
> architecture DMA support. In addition, ZONE_DMA cannot be disabled.

To be fair, that only takes a single-character change in
arch/arm64/Kconfig - in fact, I'm amused to see my stupid patch to fix
the build if you do just that (86a5906e4d1d) has just had its birthday ;)

> To aid debugging and catch devices not supporting DMA to memory outside
> the 32-bit address space, add a kernel command line option
> "swiotlb=nobounce", which disables the use of bounce buffers.
> If specified, trying to map memory that cannot be used with DMA will
> fail, and a warning will be printed (rate-limited).

This rationale seems questionable - how useful is non-deterministic
behaviour for debugging really? What you end up with is DMA sometimes
working or sometimes not depending on whether allocations happen to
naturally fall below 4GB or not. In my experience, that in itself can be
a pain in the arse to debug.

Most of the things you might then do to make things more deterministic
again (like making the default DMA mask tiny or hacking out all the
system's 32-bit addressable RAM) are also generally sufficient to make
DMA fail earlier and make this option moot anyway. What's the specific
use case motivating this?

Robin.

> Note that io_tlb_nslabs is set to 1, which is the minimal supported
> value.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/kernel-parameters.txt |  3 ++-
>  lib/swiotlb.c                       | 19 +++++++++++++++++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 37babf91f2cb6de2..38556cdceabaf087 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -3998,10 +3998,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			it if 0 is given (See Documentation/cgroup-v1/memory.txt)
>  
>  	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
> -			Format: { <int> | force }
> +			Format: { <int> | force | nobounce }
>  			<int> -- Number of I/O TLB slabs
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
> +			nobounce -- Never use bounce buffers (for debugging)
>  
>  	switches=	[HW,M68k]
>  
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 6ce764410ae475cc..4550e6b516c2a4c0 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -54,6 +54,7 @@
>  #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
>  
>  int swiotlb_force;
> +static int swiotlb_nobounce;
>  
>  /*
>   * Used to do a quick range check in swiotlb_tbl_unmap_single and
> @@ -106,8 +107,12 @@
>  	}
>  	if (*str == ',')
>  		++str;
> -	if (!strcmp(str, "force"))
> +	if (!strcmp(str, "force")) {
>  		swiotlb_force = 1;
> +	} else if (!strcmp(str, "nobounce")) {
> +		swiotlb_nobounce = 1;
> +		io_tlb_nslabs = 1;
> +	}
>  
>  	return 0;
>  }
> @@ -541,8 +546,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  map_single(struct device *hwdev, phys_addr_t phys, size_t size,
>  	   enum dma_data_direction dir)
>  {
> -	dma_addr_t start_dma_addr = phys_to_dma(hwdev, io_tlb_start);
> +	dma_addr_t start_dma_addr;
> +
> +	if (swiotlb_nobounce) {
> +		dev_warn_ratelimited(hwdev, "Cannot do DMA to address %pa\n",
> +				     &phys);
> +		return SWIOTLB_MAP_ERROR;
> +	}
>  
> +	start_dma_addr = phys_to_dma(hwdev, io_tlb_start);
>  	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size, dir);
>  }
>  
> @@ -707,6 +719,9 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>  swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
>  	     int do_panic)
>  {
> +	if (swiotlb_nobounce)
> +		return;
> +
>  	/*
>  	 * Ran out of IOMMU space for this operation. This is very bad.
>  	 * Unfortunately the drivers cannot handle this operation properly.
> 

