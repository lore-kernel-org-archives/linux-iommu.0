From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
	tables
Date: Fri, 23 Nov 2018 11:04:36 +0800
Message-ID: <CANMq1KALUmxkhE8aaYzEbd7YodF1296KdVympOP+2mWVQ9zmDA@mail.gmail.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
	<0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
	<20181121213853.GL3065@bombadil.infradead.org>
	<c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
	<20181122082336.GA2049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181122082336.GA2049-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: Pekka Enberg <penberg-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Levin Alexander <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Christoph Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 22, 2018 at 4:23 PM Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
> On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
> > TBH, if this DMA32 stuff is going to be contentious we could possibly just
> > rip out the offending kmem_cache - it seemed like good practice for the
> > use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
> > give the same 1KB alignment and chance of succeeding as the equivalent
> > kmem_cache_alloc(), then we could quite easily make do with that instead.
>
> Neither is the slab support for kmalloc, not do kmalloc allocations
> have useful alignment apparently (at least if you use slub debug).
>
> But I do agree with the sentiment of not wanting to spread GFP_DMA32
> futher into the slab allocator.
>
> I think you want a simple genalloc allocator for this rather special
> use case.

So I had a look at genalloc, we'd need to add pre-allocated memory
using gen_pool_add [1]. There can be up to 4096 L2 page tables, so we
may need to pre-allocate 4MB of memory (1KB per L2 page table). We
could add chunks on demand, but then it'd be difficult to free them up
(genalloc does not have a "gen_pool_remove" call). So basically if the
full 4MB end up being requested, we'd be stuck with that until the
iommu domain is freed (on the arm64 Mediatek platforms I looked at,
there is only one iommu domain, and it never gets freed).

page_frag would at least have a chance to reclaim those pages (if I
understand Christoph's statement correctly)

Robin: Do you have some ideas of the lifetime/usage of L2 tables? If
they are usually few of them, or if they don't get reclaimed easily,
some on demand genalloc allocation would be ok (or even 4MB allocation
on init, if we're willing to take that hit). If they get allocated and
freed together, maybe page_frag is a better option?

Thanks,

[1] https://www.kernel.org/doc/html/v4.19/core-api/genalloc.html
