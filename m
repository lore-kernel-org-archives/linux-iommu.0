From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 0/4] Optimise 64-bit IOVA allocations
Date: Fri, 25 Aug 2017 14:52:41 -0400
Message-ID: <633f0432-cab2-7280-555a-7468fc448d2d@codeaurora.org>
References: <cover.1503412074.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1503412074.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 8/22/2017 11:17 AM, Robin Murphy wrote:
> Hi all,
> 
> Just a quick repost of v2[1] with a small fix for the bug reported by Nate.
I tested the series and can confirm that the crash I reported on v2
no longer occurs with this version.

> To recap, whilst this mostly only improves worst-case performance, those
> worst-cases have a tendency to be pathologically bad:
> 
> Ard reports general desktop performance with Chromium on AMD Seattle going
> from ~1-2FPS to perfectly usable.
> 
> Leizhen reports gigabit ethernet throughput going from ~6.5Mbit/s to line
> speed.
> 
> I also inadvertantly found that the HiSilicon hns_dsaf driver was taking ~35s
> to probe simply becuase of the number of DMA buffers it maps on startup (perf
> shows around 76% of that was spent under the lock in alloc_iova()). With this
> series applied it takes a mere ~1s, mostly of unrelated mdelay()s, with
> alloc_iova() entirely lost in the noise.

Are any of these cases PCI devices attached to domains that have run
out of 32-bit IOVAs and have to retry the allocation using dma_limit?

iommu_dma_alloc_iova() {
	[...]
	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))  [<- TRUE]
		iova = alloc_iova_fast(DMA_BIT_MASK(32));     [<- NULL]
	if (!iova)
		iova = alloc_iova_fast(dma_limit);            [<- OK  ]
	[...]	
}

I am asking because, when using 64k pages, the Mellanox CX4 adapter
exhausts the supply 32-bit IOVAs simply allocating per-cpu IOVA space
during 'ifconfig up' so the code path outlined above is taken for
nearly all subsequent allocations. Although I do see a notable (~2x)
performance improvement with this series, I would still characterize it
as "pathologically bad" at < 10% of iommu passthrough performance.

This was a bit surprising to me as I thought the iova_rcache would
have eliminated the need to walk the rbtree for runtime allocations.
Unfortunately, it looks like the failed attempt to allocate a 32-bit
IOVA actually drops the cached IOVAs that we could have used when
subsequently performing the allocation at dma_limit.

alloc_iova_fast() {
	[...]
	iova_pfn = iova_rcache_get(...);     [<- Fail, no 32-bit IOVAs]
	if (iova_pfn)
		return iova_pfn;

retry:
	new_iova = alloc_iova(...);          [<- Fail, no 32-bit IOVAs]
	if (!new_iova) {
		unsigned int cpu;

		if (flushed_rcache)
			return 0;

		/* Try replenishing IOVAs by flushing rcache. */
		flushed_rcache = true;
		for_each_online_cpu(cpu)
			free_cpu_cached_iovas(cpu, iovad);     [<- :( ]
		goto retry;
	}
}

As an experiment, I added code to skip the rcache flushing/retry for
the 32-bit allocations. In this configuration, 100% of passthrough mode
performance was achieved. I made the same change in the baseline and
measured performance at ~95% of passthrough mode.

I also got similar results by altogether removing the 32-bit allocation
from iommu_dma_alloc_iova() which makes me wonder why we even bother.
What (PCIe) workloads have been shown to actually benefit from it?

Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
-Nate

> 
> Robin.
> 
> [1] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg19139.html
> 
> Robin Murphy (1):
>    iommu/iova: Extend rbtree node caching
> 
> Zhen Lei (3):
>    iommu/iova: Optimise rbtree searching
>    iommu/iova: Optimise the padding calculation
>    iommu/iova: Make dma_32bit_pfn implicit
> 
>   drivers/gpu/drm/tegra/drm.c      |   3 +-
>   drivers/gpu/host1x/dev.c         |   3 +-
>   drivers/iommu/amd_iommu.c        |   7 +--
>   drivers/iommu/dma-iommu.c        |  18 +------
>   drivers/iommu/intel-iommu.c      |  11 ++--
>   drivers/iommu/iova.c             | 114 +++++++++++++++++----------------------
>   drivers/misc/mic/scif/scif_rma.c |   3 +-
>   include/linux/iova.h             |   8 +--
>   8 files changed, 62 insertions(+), 105 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
