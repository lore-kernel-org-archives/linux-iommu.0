From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] iommu: Add range flush operation
Date: Tue, 29 Sep 2015 15:20:38 +0100
Message-ID: <560A9E36.9030903@arm.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443504379-31841-1-git-send-email-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On 29/09/15 06:25, Tomasz Figa wrote:
> Currently the IOMMU subsystem provides 3 basic operations: iommu_map(),
> iommu_map_sg() and iommu_unmap(). iommu_map() can be used to map memory
> page by page, however it involves flushing the caches (CPU and IOMMU) for
> every mapped page separately, which is unsuitable for use cases that
> require low mapping latency. Similarly iommu_unmap(), even though it
> takes a full IOVA range as its argument, performs unmapping in a page
> by page manner.

This isn't necessarily the general case, though. If the IOMMU has a 
coherent page table walk interface and its architecture prohibits 
caching invalid PTEs, then the overhead on an unmap is only a TLB 
invalidation and the overhead on a map is nothing.

> To make mapping operation more suitable for such use cases, iommu_map_sg()
> and .map_sg() callback in iommu_ops struct were introduced, which allowed
> particular IOMMU drivers to directly iterate over SG entries, create
> necessary mappings and flush everything in one go.
>
> This approach, however, has two drawbacks:
>   1) it does not do anything about unmap performance,
>   2) it requires each driver willing to have fast map to implement its
>      own SG iteration code, even though this is a mostly generic operation.
>
> This series tries to mitigate the two issues above, while acknowledging
> the fact that the .map_sg() callback might be still necessary for some
> specific platforms, which could have the need to iterate over SG elements
> inside driver code. Proposed solution introduces a new .flush() callback,
> which expects IOVA range as its argument and is expected to flush all
> respective caches (be it CPU, IOMMU TLB or whatever) to make the given
> IOVA area mapping change visible to IOMMU clients. Then all the 3 basic
> map/unmap operations are modified to call the .flush() callback at the end
> of the operation.
>
> Advantages of proposed approach include:
>   1) ability to use default_iommu_map_sg() helper if all the driver needs
>      for performance optimization is batching the flush,
>   2) completely no effect on existing code - the .flush() callback is made
>      optional and if it isn't implemented drivers are expected to do
>      necessary flushes on a page by page basis in respective (un)mapping
>      callbakcs,
>   3) possibility of exporting the iommu_flush() operation and providing
>      unsynchronized map/unmap operations for subsystems with even higher
>      requirements for performance (e.g. drivers/gpu/drm).

A single callback doesn't really generalise well enough: If we wanted to 
implement this in the ARM SMMU drivers to optimise the unmap() case [ask 
Will how long he spends waiting for a software model to tear down an 
entire VFIO domain invalidating one page at a time ;)], then we'd either 
regress performance in the map() case with an unnecessary TLB flush, or 
have to do a table walk in every flush() call to infer what actually 
needs doing.

Personally I think it would be nicest to have two separate callbacks, 
e.g. .map_sync/.unmap_sync, but at the very least some kind of 
additional 'direction' kind of parameter would be necessary.

> The series includes a generic patch implementing necessary changes in
> IOMMU API and two Tegra-specific patches that demonstrate implementation
> on driver side and which can be used for further testing.
>
> Last, but not least, some performance numbers on Tegra210:
> +-----------+--------------+-------------+------------+
> | Operation | Size [bytes] | Before [us] | After [us] |
> +-----------+--------------+-------------+------------+
> | Map       | 128K         |         139 |         40 |
> |           |              |         136 |         34 |
> |           |              |         137 |         38 |
> |           |              |         136 |         36 |
> |           | 4M           |        3939 |       1163 |
> |           |              |        3730 |       2389 |
> |           |              |        3613 |        997 |
> |           |              |        3622 |       1620 |
> |           | ~18M         |       18635 |       4741 |
> |           |              |       19261 |       6550 |
> |           |              |       18473 |       9304 |
> |           |              |       18125 |       5120 |
> | Unmap     | 128K         |         128 |          7 |
> |           |              |         122 |          8 |
> |           |              |         119 |         10 |
> |           |              |         123 |         12 |
> |           | 4M           |        3829 |        151 |
> |           |              |        3964 |        150 |
> |           |              |        3908 |        145 |
> |           |              |        3875 |        155 |
> |           | ~18M         |       18570 |        683 |
> |           |              |       18473 |        806 |
> |           |              |       21020 |        643 |
> |           |              |       21764 |        652 |
> +-----------+--------------+-------------+------------+
> The values are obtained by surrounding the calls to iommu_map_sg()
> (with default_iommu_map_sg() helper used as .map_sg() callback) and
> iommu_unmap() with ktime-based time measurement code. Taken 4 samples
> of every buffer size. ~18M means around 17-19M due do the variance
> in requested buffer sizes.

It would be interesting to know how much of the gain here is due to 
batching up the TLB maintenance vs. doing the DMA sync in fewer total 
pieces (with correspondingly fewer barriers). For the drivers which use 
the io-pgtable framework, trying to do anything about the latter (where 
it's relevant) looks essentially impossible without rewriting the whole 
thing, but the former is definitely something we should be able to 
handle and benefit from.

It certainly seems like a reasonable way to get closer to the kind of 
iommu_map_range()/iommu_unmap_range() operations proposed before, but 
with less trampling on the external API. Plus it's nicer than the 
alternative workaround of having the driver claim anything larger than 
your basic page size is valid so you can batch up most of your pagetable 
updates behind the API's back.

Robin.

> Tomasz Figa (2):
>    iommu: Add support for out of band flushing
>    iommu/tegra-smmu: Make the driver use out of band flushing
>
> Vince Hsu (1):
>    memory: tegra: add TLB cache line size
>
>   drivers/iommu/iommu.c           | 33 +++++++++++++--
>   drivers/iommu/tegra-smmu.c      | 91 +++++++++++++++++++++++++++++++++++++----
>   drivers/memory/tegra/tegra114.c |  1 +
>   drivers/memory/tegra/tegra124.c |  3 ++
>   drivers/memory/tegra/tegra210.c |  1 +
>   drivers/memory/tegra/tegra30.c  |  1 +
>   include/linux/iommu.h           |  2 +
>   include/soc/tegra/mc.h          |  1 +
>   8 files changed, 122 insertions(+), 11 deletions(-)
>
