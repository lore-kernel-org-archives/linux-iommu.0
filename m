From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Date: Mon, 7 May 2018 18:51:38 +0300
Message-ID: <a6e26d17-97ac-d02e-7bf4-f009af1a25dc@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
	<f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
	<20180427100202.GO30388@ulmo>
	<716edf58-38a7-21e5-1668-b866bf392e34@arm.com>
	<6827bda3-1aa2-da60-a749-8e2dd2e595f3@gmail.com>
	<20180507080420.GB18595@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180507080420.GB18595-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07.05.2018 11:04, Joerg Roedel wrote:
> On Mon, May 07, 2018 at 12:19:01AM +0300, Dmitry Osipenko wrote:
>> Probably the best variant would be to give an explicit control over syncing to a
>> user of the IOMMU API, like for example device driver may perform multiple
>> mappings / unmappings and then sync/flush in the end. I'm not sure that it's
>> really worth the hassle to shuffle the API right now, maybe we can implement it
>> later if needed. Joerg, do you have objections to a 'compound page' approach?
> 
> Have you measured the performance difference on both variants? The
> compound-page approach only works for cases when the physical memory you
> map contiguous and correctly aligned.

Yes, previously I actually only tested mapping of the contiguous allocations
(used for memory isolation purposes). But now I've re-tested all variants and
got somewhat interesting results.

Firstly it is not that easy to test a really sparse mapping simply because
memory allocator produces sparse allocation only when memory is _really_
fragmented. Pretty much all of the time the sparse allocations are contiguous or
they consist of a very few chunks that do not impose any noticeable performance
impact.

Secondly, the interesting part is that mapping / unmapping of a contiguous
allocation (CMA using DMA API) is slower by ~50% then doing it for a sparse
allocation (get_pages using bare IOMMU API). /I think/ it's a shortcoming of the
arch/arm/mm/dma-mapping.c, which also suffers from other inflexibilities that
Thierry faced recently. Though I haven't really tried to figure out what is the
bottleneck yet and Thierry was going to re-write ARM's dma-mapping
implementation anyway, I'll take a closer look at this issue a bit later.

I've implemented the iotlb_sync_map() and tested things with it. The end result
is the same as for the compound page approach, simply because actual allocations
are pretty much always contiguous.

> If it is really needed I would prefer a separate iotlb_sync_map()
> call-back that is just NULL when not needed. This way all users that
> don't need it only get a minimal penalty in the mapping path and you
> don't have any requirements on the physical memory you map to get good
> performance.
Summarizing, the iotlb_sync_map() is indeed better way. As you rightly noticed,
that approach is also optimal for the non-contiguous cases as we won't have to
flush on mapping of each contiguous chunk of the sparse allocation, but after
the whole mapping is done.

Thierry, Robin and Joerg - thanks for your input, I'll prepare patches
implementing the iotlb_sync_map.
