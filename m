From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Wed, 13 Apr 2016 13:43:41 -0700
Message-ID: <20160413204332.GB2034274@devbig084.prn1.facebook.com>
References: <cover.1460548546.git.mad@cs.technion.ac.il>
	<b208a304d83088aae7ecac10a3062dc57c0a2f79.1460548546.git.mad@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b208a304d83088aae7ecac10a3062dc57c0a2f79.1460548546.git.mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 13, 2016 at 09:52:33PM +0300, Adam Morrison wrote:
> From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> 
> IOVA allocation has two problems that impede high-throughput I/O.
> First, it can do a linear search over the allocated IOVA ranges.
> Second, the rbtree spinlock that serializes IOVA allocations becomes
> contended.
> 
> Address these problems by creating an API for caching allocated IOVA
> ranges, so that the IOVA allocator isn't accessed frequently.  This
> patch adds a per-CPU cache, from which CPUs can alloc/free IOVAs
> without taking the rbtree spinlock.  The per-CPU caches are backed by
> a global cache, to avoid invoking the (linear-time) IOVA allocator
> without needing to make the per-CPU cache size excessive.  This design
> is based on magazines, as described in "Magazines and Vmem: Extending
> the Slab Allocator to Many CPUs and Arbitrary Resources" (currently
> available at https://www.usenix.org/legacy/event/usenix01/bonwick.html)
> 
> Adding caching on top of the existing rbtree allocator maintains the
> property that IOVAs are densely packed in the IO virtual address space,
> which is important for keeping IOMMU page table usage low.
> 
> To keep the cache size reasonable, we limit caching to ranges of
> size <= 128 KB.  Overall, a CPU can cache at most 32 MB and the global
> cache is bounded by 4 MB.

So the cached case still ignores the limit_pfn as I pointed out before.
This can break drivers if the cached pfn is out of dma range the device
can handle or impact performance for devices because of DAC. I think we
could have 2 caches. One for DMA32 and the other for DMA64. Choose
corresponding cache according to limit_pfn. For devices with special DMA
mask, for example, DMA24, just fallback to slow path.

Thanks,
Shaohua
