From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Tue, 10 Mar 2015 10:16:31 +0000
Message-ID: <54FEC47F.2040804@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>	<058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>	<1423543151.18280.2.camel@mtksdaap41>
	<54D9F486.10501@arm.com>	<1423901011.27922.7.camel@mhfsdcap03>
	<54E24D50.408@arm.com>	<1425353927.4555.10.camel@mhfsdcap03>	<54F5A5FE.3040506@arm.com>
	<54F7A121.3050103@codeaurora.org>	<54F83B0C.9020606@arm.com>	<20150309175904.GC8656@n2100.arm.linux.org.uk>
	<54FDFE0D.8030807@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54FDFE0D.8030807-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/03/15 20:09, Robin Murphy wrote:
[...]
>>> I think ideally you'd call dma_map_page when you first create the page
>>> table, dma_sync_single_for_device on any update, and dma_unmap_page when you
>>> tear it down, and you'd also use the appropriate DMA addresses everywhere
>>> instead of physical addresses.
>>
>> No.
>>
>> dma_map_page()			ownership changes CPU->DMA
>> dma_sync_single_for_cpu()	ownership changes DMA->CPU
>> dma_sync_single_for_device()	ownership changes CPU->DMA
>> dma_unmap_page()		ownership changes DMA->CPU
>>
>> It's invalid to miss out the pairing that give those ownership changes.
>
> Thanks for the clarification - the wording in DMA-API.txt rather implies
> that in the DMA_TO_DEVICE case you only have to sync the updated data
> /after/ writing it. For the sake of purely getting pages flushed, would
> it be more reasonable then to call dma_map_single() followed immediately
> by dma_unmap_single_attrs() with DMA_ATTR_SKIP_CPU_SYNC? Since we know
> the IOMMU can never write back to memory  (ones that can are a different
> issue) it would be nice to be able to skip the extra invalidations
> somehow, without too heinously abusing the API.

Scratch that, I'm being a massive idiot (again). Of course the actual 
invalidations will only happen if they need to, based on the DMA 
direction. The overhead of dma_sync_*_for_cpu() and dma_unmap() is then 
only a handful of function calls, which is probably an acceptable price 
to pay for making sure things work as correctly as possible.

>
> Robin.
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
