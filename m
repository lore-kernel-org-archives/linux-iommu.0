From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: Re: [PATCH V2 0/4]IOMMU: avoid lock contention in iova allocation
Date: Sun, 10 Jan 2016 19:37:59 -0800
Message-ID: <20160111033749.GA1811285@devbig084.prn1.facebook.com>
References: <cover.1452297604.git.shli@fb.com>
	<20160110225610.GA16778@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160110225610.GA16778-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 11, 2016 at 12:56:12AM +0200, Adam Morrison wrote:
> Hi,
> 
> > iova alloc/free causes big lock contention, which could be easily demonstrated
> > with iperf workload. Previously I posted a patchset:
> > https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.linuxfoundation.org_pipermail_iommu_2015-2DNovember_014984.html&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=X13hAPkxmvBro1Ug8vcKHw&m=i-Y1E3oSPFHeeKufBaG6XLhWgcShO1zrKIdjlpP2AYo&s=iNOUfc0u4NPOZoGmz6B7zCJdYEE8jkrlTtZq7JG2vjc&e= 
> > 
> > the concern is it's not generic. This is another try for the issue. This
> > version implements a per-cpu iova cache for small size DMA allocation (<= 64k),
> > which should be generic enough and so we can do batch allocation. iova free
> > could be easily batched too. With batch alloc/free, iova lock contention
> > disappears. Performance result with this patchset is nearly the same as the
> > previous one in the same test.
> > 
> > After this patchset, async_umap_flush_lock becomes the hotest lock in
> > intel-iommu, but not very bad. That will be something we need work on in the
> > future.
> 
> There can still be significant spinlock contention with this patchset.
> For example, here's the throughput obtained when accessing 16 memcached
> instances running on a 16-core Sandy Bridge with an Intel XL710 NIC.
> The client machine has iommu=off and runs memslap with the default
> config (64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):
> 
>   stock (4.4.0-rc5) iommu=off:
>    1,088,996 memcached transactions/sec (=100%, median of 10 runs).
> 
>   this patch, iommu=on:
>    313,161 memcached transactions/sec (=29%).
>    perf: 21.87%    0.57%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave
>                     |
>                     ---_raw_spin_lock_irqsave
>                        |
>                        |--67.84%-- intel_unmap  (async_umap_flush_lock)
>                        |--17.54%-- alloc_iova
>                        |--12.85%-- free_iova_array

Yes, mine doesn't remove the async_unmap_flush_lock contention yet.
Should be easy with a percpu stuff or atomic based ring management.
 
> For reference, the patchset I posted two weeks ago gets almost the same
> throughput as with iommu=off:
> 
>   https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.linuxfoundation.org_pipermail_iommu_2015-2DDecember_015271.html-3A&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=X13hAPkxmvBro1Ug8vcKHw&m=i-Y1E3oSPFHeeKufBaG6XLhWgcShO1zrKIdjlpP2AYo&s=eBeKYSequdm8wso0jsaRPjeKsKup7p5Tv_CDT2O0ZEs&e= 
>    1,067,586 memcached transactions/sec (=98%).
>    perf: 0.75%     0.75%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]

I don't know you already posted one. Roughly looked at the patches. We
are using exactly the same idea. I'm happy we pursue your patches. At
the first look, the per-cpu allocation in your patch doesn't check
pfn_limit, that could be wrong, but should be easy to fix. I'll take a
close look tomorrow.

Thanks,
Shaohua
