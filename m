From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 6/6] dmaengine: pl330: Make sure microcode is
 privileged-executable
Date: Mon, 11 Jul 2016 16:23:53 +0100
Message-ID: <5783BA09.1020303@arm.com>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
 <20160709020919.6760-7-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160709020919.6760-7-mitchelh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mitchel Humpherys <mitchelh@codeaurora.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>, Jeremy Gebben <jgebben@codeaurora.org>, Patrick Daly <pdaly@codeaurora.org>, Pratik Patel <pratikp@codeaurora.org>, Dan Williams <dan.j.williams@intel.com>, Jassi Brar <jassi.brar@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 09/07/16 03:09, Mitchel Humpherys wrote:
> The PL330 can perform privileged instruction fetches.  This can result

Nit: "can" is a bit of an understatement. Instruction fetches on both
the manager and channel threads have the "privileged" and "instruction"
AxPROT bits hard-coded whether you like it or not. It's only the data
accesses by the channel threads which are in any way configurable.

Robin.

> in SMMU permission faults on SMMUs that implement the ARMv8 VMSA, which
> specifies that mappings that are writeable at one execution level shall
> not be executable at any higher-privileged level.  Fix this by using the
> DMA_ATTR_PRIVILEGED_EXECUTABLE attribute, which will ensure that the
> microcode IOMMU mapping is not writeable.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jassi Brar <jassi.brar@samsung.com>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  drivers/dma/pl330.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 372b4359da97..25bc49d47c45 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1854,14 +1854,17 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
>  {
>  	int chans = pl330->pcfg.num_chan;
>  	int ret;
> +	DEFINE_DMA_ATTRS(attrs);
>  
> +	dma_set_attr(DMA_ATTR_PRIVILEGED_EXECUTABLE, &attrs);
>  	/*
>  	 * Alloc MicroCode buffer for 'chans' Channel threads.
>  	 * A channel's buffer offset is (Channel_Id * MCODE_BUFF_PERCHAN)
>  	 */
> -	pl330->mcode_cpu = dma_alloc_coherent(pl330->ddma.dev,
> +	pl330->mcode_cpu = dma_alloc_attrs(pl330->ddma.dev,
>  				chans * pl330->mcbufsz,
> -				&pl330->mcode_bus, GFP_KERNEL);
> +				&pl330->mcode_bus, GFP_KERNEL,
> +				&attrs);
>  	if (!pl330->mcode_cpu) {
>  		dev_err(pl330->ddma.dev, "%s:%d Can't allocate memory!\n",
>  			__func__, __LINE__);
> 
