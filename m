From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iommu/dma-iommu: properly respect configured address space
	size
Date: Tue, 08 Nov 2016 14:41:40 +0100
Message-ID: <8286728f-fab3-8179-5215-e156da426244@samsung.com>
References: <CGME20161107130625eucas1p2dd23c07010b4f3eddb6c6540ed802246@eucas1p2.samsung.com>
	<1478523973-8828-1-git-send-email-m.szyprowski@samsung.com>
	<68e7a18b-739e-b73e-eacf-3cb6c1bd279a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <68e7a18b-739e-b73e-eacf-3cb6c1bd279a-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,


On 2016-11-08 12:37, Robin Murphy wrote:
> On 07/11/16 13:06, Marek Szyprowski wrote:
>> When one called iommu_dma_init_domain() with size smaller than device's
>> DMA mask, the alloc_iova() will not respect it and always assume that all
>> IOVA addresses will be allocated from the the (base ... dev->dma_mask) range.
> Is that actually a problem for anything?

Yes, I found this issue while working on next version of ARM & ARM64
DMA-mapping/IOMMU integration patchset and adapting Exynos drivers for the
new IOMMU/DMA-mapping glue.

Some Exynos devices (codec and camera isp) operate only on the limited (and
really small: 256M for example) DMA window. They use non-standard way of
addressing memory: an offset from the firmware base. However they still have
32bit DMA mask, as the firmware can be located basically everywhere in the
real DMA address space, but then they can access only next 256M from that
firmware base.

>
>> This patch fixes this issue by taking the configured address space size
>> parameter into account (if it is smaller than the device's dma_mask).
> TBH I've been pondering ripping the size stuff out of dma-iommu, as it
> all stems from me originally failing to understand what dma_32bit_pfn is
> actually for. The truth is that iova_domains just don't have a size or
> upper limit; however if devices with both large and small DMA masks
> share a domain, then the top-down nature of the allocator means that
> allocating for the less-capable devices would involve walking through
> every out-of-range entry in the tree every time. Having cached32_node
> based on dma_32bit_pfn just provides an optimised starting point for
> searching within the smaller mask.

Right, this dma_32bit_pfn was really misleading at the first glance,
but then I found that this was something like end_pfn in case of dma-iommu
code.

> Would it hurt any of your use-cases to relax/rework the reinitialisation
> checks in iommu_dma_init_domain()? Alternatively if we really do have a
> case for wanting a hard upper limit, it might make more sense to add an
> end_pfn to the iova_domain and handle it in the allocator itself.

The proper support for end_pfn would be a better approach probably,
especially if we consider readability of the code.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
