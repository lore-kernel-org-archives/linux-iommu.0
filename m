From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Tue, 03 Mar 2015 12:15:58 +0000
Message-ID: <54F5A5FE.3040506@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>			
	<058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>		
	<1423543151.18280.2.camel@mtksdaap41> <54D9F486.10501@arm.com>	
	<1423901011.27922.7.camel@mhfsdcap03> <54E24D50.408@arm.com>
	<1425353927.4555.10.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425353927.4555.10.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/03/15 03:38, Yong Wu wrote:
> On Mon, 2015-02-16 at 20:04 +0000, Robin Murphy wrote:
>
>>>        2)int (*domain_init)(struct iommu_domain *domain);
>>>          About this function, it will alloc pagetable for the iommu
>>> domain. And We expect the pagetable memory is uncacheable, so try to
>>> call "dma_alloc_coherent", unfortunately the "struct device *" can't be
>>> passed into this function. so is it possible if adding a parameter in
>>> this function.
>>
>> ...one of the ideas of the new of_iommu_configure framework is that
>> iommu_ops structures can represent individual IOMMU devices if
>> necessary. The ops->priv pointer was included for that purpose, but
>> isn't very clean so Will has plans to remove it again - it's easy enough
>> to achieve the same effect by having the driver embed the ops in its
>> private instance data instead. I've done that with the ARM SMMU driver
>> which has a similar issue of needing hardware details at domain_init()
>> time (no patches ready yet but I have an iommu/dev branch on top of the
>> iommu/dma branch with some current work-in-progress bits)
>>
>> Thanks,
>> Robin.
>>
> Dear Robin,
>          Thanks very much for your suggestion.
>
>          I have a more question: how to do cache maintenance in arm64.
>
>          a) "__dma_flush_range" can not be expected to used directly.
>          b) Following Documentation\DMA-API.txt, section: Streaming DMA
> mappings. dma_map_single should be used, But I am not sure how to pass
> the first "struct device *".
>           We have a device which call arch_setup_dma_ops to create the
> iommu domain, if we use this device, it will enter __iommu_map_page;
>          If we input NULL for dmap_map_single, it will assert at
> dma_capable in swiotlb_map_page...

Consider that the IOMMU's page table walker is a DMA master in its own 
right, and that is the device you're mapping the page tables for. 
Therefore your IOMMU driver needs to have access to the struct device of 
the IOMMU itself to use for the page-table-related mappings. Also, be 
sure to set the IOMMU's DMA mask correctly to prevent SWIOTLB bounce 
buffers being created in the process (which as I've found generally ends 
in disaster).

>          And normally, we always need do cache maintenance only for some
> bytes in the pagetable but not whole a page. Then is there a easy way to
> do the cache maintenance?

For a noncoherent device, dma_map_single() will end up calling 
__dma_map_area() with the page offset and size of the original request, 
so the updated part gets flushed by VA, and the rest of the page isn't 
touched if it doesn't need to be. On the other hand if the page tables 
were allocated with dma_alloc_coherent() in the first place, then just 
calling dma_sync_single_for_device() for the updated region should suffice.

Robin.
