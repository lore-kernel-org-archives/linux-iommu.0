From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: Re: [PATCH v3 0/7] Intel IOMMU scalability improvements
Date: Tue, 19 Apr 2016 13:47:06 -0700
Message-ID: <20160419204705.GA1134028@devbig084.prn1.facebook.com>
References: <cover.1460733778.git.mad@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1460733778.git.mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
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

On Tue, Apr 19, 2016 at 07:48:16PM +0300, Adam Morrison wrote:
> This patchset improves the scalability of the Intel IOMMU code by
> resolving two spinlock bottlenecks, yielding up to ~5x performance
> improvement and approaching iommu=off performance.
> 
> For example, here's the throughput obtained by 16 memcached instances
> running on a 16-core Sandy Bridge system, accessed using memslap on
> another machine that has iommu=off, using the default memslap config
> (64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):
> 
>     stock iommu=off:
>        990,803 memcached transactions/sec (=100%, median of 10 runs).
>     stock iommu=on:
>        221,416 memcached transactions/sec (=22%).
>        [61.70%    0.63%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]
>     patched iommu=on:
>        963,159 memcached transactions/sec (=97%).
>        [1.29%     1.10%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]
> 
> The two resolved spinlocks:
> 
>  - Deferred IOTLB invalidations are batched in a global data structure
>    and serialized under a spinlock (add_unmap() & flush_unmaps()); this
>    patchset batches IOTLB invalidations in a per-CPU data structure.
> 
>  - IOVA management (alloc_iova() & __free_iova()) is serialized under
>    the rbtree spinlock; this patchset adds per-CPU caches of allocated
>    IOVAs so that the rbtree doesn't get accessed frequently. (Adding a
>    cache above the existing IOVA allocator is less intrusive than dynamic
>    identity mapping and helps keep IOMMU page table usage low; see
>    Patch 7.)
> 
> The paper "Utilizing the IOMMU Scalably" (presented at the 2015 USENIX
> Annual Technical Conference) contains many more details and experiments:
> 
>   https://urldefense.proofpoint.com/v2/url?u=https-3A__www.usenix.org_system_files_conference_atc15_atc15-2Dpaper-2Dpeleg.pdf&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=X13hAPkxmvBro1Ug8vcKHw&m=O-p7wCR-G4eXQJOhyiio_pLUyJGkaFCUv4CNBrTdMPs&s=T7ynyUVZWcBkslPyKJqEUUggCmFDrsglpKRu0I3EXhQ&e= 
> 
> v3:
>  * Patch 7/7: Respect the caller-passed limit IOVA when satisfying an IOVA
>    allocation from the cache.

Thanks, looks good. I'm still thinking to have 2 caches, one for DMA32
and the other for DMA64. Mixing them in one cache might make allocation
from cache have more failure. But we can do this later if it is a real
problem. So for the the whole series
Reviewed-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
