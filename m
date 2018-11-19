From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
Date: Mon, 19 Nov 2018 15:22:13 -0800
Message-ID: <CALAqxLVMW2sYkaQvggZ-LhvkzpuF2rssQJ4thZkkAkROk=wVVw@mail.gmail.com>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de> <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
 <20181114141311.GA26677@lst.de> <20181114161239.GA29462@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114161239.GA29462@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, Valentin Schneider <valentin.schneider@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 14, 2018 at 8:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 14, 2018 at 03:13:11PM +0100, Christoph Hellwig wrote:
> > Does the patch below make a difference for you?  Assigning an
> > address to the S/G list is the only functional difference I could
> > spot.  Drivers really should never look at the S/G list on an
> > error return, but..
>
> And that was obviously just the second half of the patch, so here
> is the full one:
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 5731daa09a32..a896f46d0c31 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -786,10 +786,13 @@ swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
>         int i;
>
>         for_each_sg(sgl, sg, nelems, i) {
> -               sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
> +               dma_addr_t dma_addr;
> +
> +               dma_addr = swiotlb_map_page(dev, sg_page(sg), sg->offset,
>                                 sg->length, dir, attrs);
> -               if (sg->dma_address == DIRECT_MAPPING_ERROR)
> +               if (dma_addr == DIRECT_MAPPING_ERROR)
>                         goto out_error;
> +               sg->dma_address = dma_addr;
>                 sg_dma_len(sg) = sg->length;
>         }

I know Robin has already replied with more detailed info, but just to
close the loop as I'm finally home, applying this patch didn't seem to
help with the IO hangs I'm seeing w/ HiKey960.

thanks
-john
