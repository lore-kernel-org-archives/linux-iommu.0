From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Fri, 18 Jan 2019 10:41:06 +0100
Message-ID: <f4222474-0515-c0a2-ef5e-523b56869210@samsung.com>
References: <20190111181731.11782-1-hch@lst.de>
        <CGME20190111181812epcas2p1eeb68a16701631513eaf297073f7299f@epcas2p1.samsung.com>
        <20190111181731.11782-4-hch@lst.de>
        <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com>
        <20190117172152.GA32292@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117172152.GA32292@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Pawel Osciak <pawel@osciak.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 2019-01-17 18:21, Christoph Hellwig wrote:
> On Mon, Jan 14, 2019 at 01:42:26PM +0100, Marek Szyprowski wrote:
>> On 2019-01-11 19:17, Christoph Hellwig wrote:
>>> vb2_dc_get_userptr pokes into arm direct mapping details to get the
>>> resemblance of a dma address for a a physical address that does is
>>> not backed by a page struct.  Not only is this not portable to other
>>> architectures with dma direct mapping offsets, but also not to uses
>>> of IOMMUs of any kind.  Switch to the proper dma_map_resource /
>>> dma_unmap_resource interface instead.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> There are checks for IOMMU presence in other places in vb2-dma-contig,
>> so it was used only when no IOMMU is available, but I agree that the
>> hacky code should be replaced by a generic code if possible.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> V4L2 pipeline works fine on older Exynos-based boards with CMA and IOMMU
>> disabled.
> Do you know if these rely on the offsets?  E.g. would they still work
> with the patch below applied on top.  That would keep the map_resource
> semantics as-is as solve the issue pointed out by Robin for now.

AFAIK that code was only used for sharing buffers between hardware
modules that are a part of the same SoC, usually implemented as platform
devices. AFAIR this never worked for devices on different buses. So far
I wasn't aware on ANY which would require an offset for the DMA access.

The first version of videobuf2-dc code even incorrectly used paddr
instead of dma_addr as a buffer 'address' returned to the client
drivers, because in case of those SoC this was exactly the same (see
commits 472af2b05bdefcaee7e754e22cbf131110017ad6 and
ba7fcb0c954921534707f08ebc4d8beeb2eb17e7).

> If not I can only think of a flag to bypass the offseting for now, but
> that would be pretty ugly.  Or go for the long-term solution of
> discovering the relationship between the two devices, as done by the
> PCIe P2P code..
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8e0359b04957..25bd19974223 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -359,7 +359,7 @@ EXPORT_SYMBOL(dma_direct_map_sg);
>  dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
> +	dma_addr_t dma_addr = paddr;
>  
>  	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
>  		report_addr(dev, dma_addr, size);
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
