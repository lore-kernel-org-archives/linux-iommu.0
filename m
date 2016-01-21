From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH V2 0/4]IOMMU: avoid lock contention in iova allocation
Date: Fri, 22 Jan 2016 01:14:56 +0200
Message-ID: <20160121231326.GA16905@cs.technion.ac.il>
References: <cover.1452297604.git.shli@fb.com>
	<20160110225610.GA16778@cs.technion.ac.il>
	<20160111033749.GA1811285@devbig084.prn1.facebook.com>
	<20160120122103.GE18805@8bytes.org>
	<20160120180956.GA230160@devbig084.prn1.facebook.com>
	<CAHMfzJmAUWT8X4492_84smUgQMW9pW1yNfOxC6e7ur9TitA2cA@mail.gmail.com>
	<20160120211421.GA684235@devbig084.prn1.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160120211421.GA684235-tb7CFzD8y5b7E6g3fPdp/g2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 20, 2016 at 01:14:35PM -0800, Shaohua Li wrote:

> > My understanding from the above is that the only issue with our
> > patchset was not dealing with pfn_limit.  I can just fix that and
> > repost, sounds good?
> 
> Sure, please do it. For the patches, I'm not comformatable about the
> per-cpu deferred invalidation. One important benefit of IOMMU is
> isolation. Deferred invalidation already loose the isolation, per-cpu
> invalidation loose further. It would be better we can flush all per-cpu
> invalidation entries if one cpu hits its per-cpu limit. Also you'd
> better look at CPU hotplug. We don't want to lose the invalidation
> entries if one cpu is hot removed.

I'll look into these.

> The per-cpu iova implementation looks unnecessary complicated. I know
> you are referring the paper, but the whole point is batch
> allocation/free.

Batched allocation/free isn't enough.  It still creates spinlock
contention, even if there is per-cpu invalidation (that gets rid of
async_umap_flush_lock).  Here are sample results from our memcached
test (throughput of querying 16 memcached instances on a 16-core box
with an Intel XL710 NIC):

      batched alloc/free, iommu=on:
      313,161 memcached transactions/sec (= 29% of iommu=off)

      batched alloc/free + per-cpu invalidations, iommu=on:
      434,590 memcached transactions/sec (= 40% of iommu=off)

      perf report:
      61.15%     0.33%  swapper         [kernel.kallsyms]      [k] _raw_spin_lock_irqsave
                     |
                     ---_raw_spin_lock_irqsave
                        |
                        |--87.81%-- free_iova_array
                        |--11.71%-- alloc_iova

In contrast, the per-cpu magazine cache in our patchset enables iova
allocation/free to complete without accessing the iova allocator at
all.  So we don't touch the rbtree spinlock, and also complete iova
allocation in constant time, which avoids the linear-time allocations
that the iova allocator suffers from.  (These were described in the
paper "Efficient intra-operating system protection against harmful
DMAs", presented at the USENIX FAST 2015 conference.)  The end result:

      magazines cache + per-cpu invalidations, iommu=on:
      1,067,586 memcached transactions/sec (= 98% of iommu=off)
