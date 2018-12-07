From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
	and improve debugging
Date: Fri, 7 Dec 2018 16:48:54 +0800
Message-ID: <CANMq1KABLMgvGcP-KwKhxmZnO-GuRAKJHf0sBtFaYLnCuHMJOQ@mail.gmail.com>
References: <20181207061620.107881-1-drinkcat@chromium.org>
	<20181207061620.107881-3-drinkcat@chromium.org>
	<20181207080551.GA15120@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181207080551.GA15120-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Levin Alexander <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Christoph Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pekka Enberg <penberg-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 7, 2018 at 4:05 PM Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
> On Fri, Dec 07, 2018 at 02:16:19PM +0800, Nicolas Boichat wrote:
> > +#ifdef CONFIG_ZONE_DMA32
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
>
> This name doesn't make any sense.  Why not ARM_V7S_TABLE_SLAB_FLAGS ?

Sure, will fix in v6 then.

> > +#else
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
>
> Can you remind me again why it is, on machines which don't support
> ZONE_DMA32, why we have to allocate from ZONE_DMA?  My understanding
> is that 64-bit machines have ZONE_DMA32 and 32-bit machines don't.
> So shouldn't this rather be GFP_KERNEL?

Sorry I mean to reply on the v4 thread, Christoph raised the same
question (https://patchwork.kernel.org/patch/10713025/).

I don't know, and I don't have all the hardware needed to test this
,-( Robin and Will both didn't seem sure.

I'd rather not introduce a new regression, this patch series tries to
fix a known arm64 regression, where we _need_ tables to be in DMA32.
If we want to change 32-bit hardware to use GFP_KERNEL, and we're sure
it works, that's fine by me, but it should be in another patch set.

Hope this makes sense,

Thanks,

> Actually, maybe we could centralise this in gfp.h:
>
> #ifdef CONFIG_64BIT
> # ifdef CONFIG_ZONE_DMA32
> #define GFP_32BIT       GFP_DMA32
> # else
> #define GFP_32BIT       GFP_DMA
> #else /* 32-bit */
> #define GFP_32BIT       GFP_KERNEL
> #endif
>
