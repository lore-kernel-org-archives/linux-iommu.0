From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] arm64/dma-mapping: Add DMA_ATTR_ALLOC_SINGLE_PAGES support
Date: Thu, 24 Mar 2016 21:25:07 -0700
Message-ID: <CAD=FV=VBvdLqabE0h=+hRChY4G0=1dzH1z8eE7ukMC+wbnQT9w@mail.gmail.com>
References: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
	<20160321180147.GR23397@arm.com>
	<CAD=FV=WL-OgE6D+8m3A8ZSJ8HgVZJw_+7uBce=qPh80LaxQKbg@mail.gmail.com>
	<20160324115008.GE9323@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160324115008.GE9323-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Thu, Mar 24, 2016 at 4:50 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > I have a slight snag with this, in that you don't consult the IOMMU
>> > pgsize_bitmap at any point, and assume that it can map pages at the
>> > same granularity as the CPU. The documentation for
>> > DMA_ATTR_ALLOC_SINGLE_PAGES seems to be weaker than that.
>>
>> Interesting.  Is that something that exists in the real world?  ...or
>> something you think is coming soon?
>
> All it would take is for an IOMMU driver to choose a granule size that
> differs from the CPU. For example, if the SMMU driver chose 64k pages
> and the CPU was using 4k pages, then you'd have this problem.
>
>> I'd argue that such a case existed in the real world then probably
>> we're already broken.  Unless I'm misreading, existing code will
>> already fall all the way back to order 0 allocations.  ...so while
>> existing code might could work if it was called on a totally
>> unfragmented system, it would already break once some fragmentation
>> was introduced.
>
> I disagree. For example, in the case I described previously, they may
> well settle on a common supported granule (e.g. 2M), assuming that
> contiguous pages were implemented in the page table code.

I'm still a little confused how existing code could have worked if
IOMMU has 64K pages and CPU has 4K pages if memory is fragmented.
Presumably existing code in __iommu_dma_alloc_pages() would keep
failing the "alloc_pages(gfp | __GFP_NORETRY, order);" call until
order got down to 0.  Then we'd allocate order 0 (4K) pages and we'd
hit a bug.


>> I'm not saying that we shouldn't fix the code to handle this, I'm just
>> saying that Yong Wu's patch doesn't appear to break any code that
>> wasn't already broken.  That might be reason to land his code first,
>> then debate the finer points of whether IOMMUs with less granularity
>> are likely to exist and whether we need to add complexity to the code
>> to handle them (or just detect this case and return an error).
>>
>> From looking at a WIP patch provided to me by Yong Wu, it looks as if
>> he thinks several more functions need to change to handle this need
>> for IOMMUs that can't handle small pages.  That seems to be further
>> evidence that the work should be done in a separate patch.
>
> Sure, my observations weren't intended to hold up this patch, but we
> should double-check that we're no regressing any of the existing IOMMU
> drivers/platforms by going straight to order 0 allocations.

Argh.  I see why I was confused and thought it got complicated.  When
I looked at diffs I thought Yong Wu's patch was more complicated
because he rebased it and my diff showed some other unrelated patches.
Dumb.

OK, you're right that this is pretty simple.

In any case, you're right that we should fix this.  ...though assuming
my argument above isn't wrong, then existing code is already broken or
has a latent bug if you've got an IOMMU that can't map at least as
granular as the CPU.  To me that means adding that new feature (or
fixing that latent bug) should be done in a separate patch.  It could
come in sequence either before or after this one.  Of course, if
everyone else thinks it should be one patch I won't block that...

-Doug
