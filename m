From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Thu, 05 Mar 2015 11:16:28 +0000
Message-ID: <54F83B0C.9020606@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>			
	<058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>		
	<1423543151.18280.2.camel@mtksdaap41> <54D9F486.10501@arm.com>	
	<1423901011.27922.7.camel@mhfsdcap03> <54E24D50.408@arm.com>
	<1425353927.4555.10.camel@mhfsdcap03>
	<54F5A5FE.3040506@arm.com> <54F7A121.3050103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54F7A121.3050103-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laura,

On 05/03/15 00:19, Laura Abbott wrote:
[...]
>> Consider that the IOMMU's page table walker is a DMA master in its own
> right, and that is the device you're mapping the page tables for.
> Therefore your IOMMU driver needs to have access to the struct device
> of the IOMMU itself to use for the page-table-related mappings. Also,
> be sure to set the IOMMU's DMA mask correctly to prevent SWIOTLB bounce
> buffers being created in the process (which as I've found generally ends
> in disaster).
>>
>>>           And normally, we always need do cache maintenance only for some
>>> bytes in the pagetable but not whole a page. Then is there a easy way to
>>> do the cache maintenance?
>>
>> For a noncoherent device, dma_map_single() will end up calling
> __dma_map_area() with the page offset and size of the original request, so
> the updated part gets flushed by VA, and the rest of the page isn't touched
> if it doesn't need to be. On the other hand if the page tables were
> allocated with dma_alloc_coherent() in the first place, then just calling
> dma_sync_single_for_device() for the updated region should suffice.
>>
>
> Where exactly would you call the dma_unmap? It seems a bit strange to
> be repeatedly calling dma_map and never calling dma_unmap. I don't see it
> explicitly forbidden in the docs anywhere to do this but it seems like
> it would be violating the implicit handoff of dma_map/dma_unmap.

I think ideally you'd call dma_map_page when you first create the page 
table, dma_sync_single_for_device on any update, and dma_unmap_page when 
you tear it down, and you'd also use the appropriate DMA addresses 
everywhere instead of physical addresses.

I wouldn't compare that with what we do in the ARM SMMU driver, because 
that's a lot more hacky; there we're actually _relying_ on the mapping 
aspect of dma_map_page being a no-op so we just get the implicit sync 
part of it, thus we know an unmap would do absolutely nothing (since the 
SMMU doesn't write to the page tables we've no need to sync them back to 
the CPU), so we can get away with skipping it. Of course, as both Mitch 
and I have apparently discovered recently, things end up going wrong 
when that no-op assumption isn't true and bounce buffers happen...

Robin.
