From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dma/iommu: Add pgsize_bitmap confirmation in
	__iommu_dma_alloc_pages
Date: Fri, 8 Apr 2016 18:30:03 +0100
Message-ID: <20160408173002.GJ23750@arm.com>
References: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
	<20160329170238.GK6745@arm.com>
	<CAD=FV=XdZwg8usj3bjM6W=A0Yk1AFqKFRadpiS-LGLwxVNxp7A@mail.gmail.com>
	<20160408130733.GD23750@arm.com>
	<CAD=FV=VbekVUHW3=d0icSgUO1M-1cccwCAZ+s=YSzOtEveCQag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=VbekVUHW3=d0icSgUO1M-1cccwCAZ+s=YSzOtEveCQag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 08, 2016 at 09:50:43AM -0700, Doug Anderson wrote:
> On Fri, Apr 8, 2016 at 6:07 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Tue, Apr 05, 2016 at 10:03:32AM -0700, Doug Anderson wrote:
> >> On Tue, Mar 29, 2016 at 10:02 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >> > On Mon, Mar 28, 2016 at 02:32:11PM +0800, Yong Wu wrote:
> >> >> @@ -213,13 +215,16 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
> >> >>               /*
> >> >>                * Higher-order allocations are a convenience rather
> >> >>                * than a necessity, hence using __GFP_NORETRY until
> >> >> -              * falling back to single-page allocations.
> >> >> +              * falling back to min size allocations.
> >> >>                */
> >> >> -             for (order = min_t(unsigned int, order, __fls(count));
> >> >> -                  order > 0; order--) {
> >> >> -                     page = alloc_pages(gfp | __GFP_NORETRY, order);
> >> >> +             for (order = min_t(int, order, __fls(count));
> >> >> +                  order >= min_order; order--) {
> >> >> +                     page = alloc_pages((order == min_order) ? gfp :
> >> >> +                                        gfp | __GFP_NORETRY, order);
> >> >>                       if (!page)
> >> >>                               continue;
> >> >> +                     if (!order)
> >> >> +                             break;
> >> >
> >> > Isn't this handled by the loop condition?
> >>
> >> He changed the loop condition to be ">= min_order" instead of "> 0",
> >> so now we can get here with an order == 0.  This makes sense because
> >> when min_order is not 0 you still want to run the code to split the
> >> pages and it is sane not to duplicate that below.
> >>
> >> Maybe I'm misunderstanding, though.  Perhaps you can explain how you
> >> think this code should look?
> >
> > My reading of the code was that we require order >= min_order to enter
> > the loop. Given that order doesn't change between the loop header and the
> > if (!order) check, then that must mean we can enter the loop body with
> > order == 0 and order >= min_order, which means that min_order is allowed
> > to be negative. That feels weird.
> >
> > Am I barking up the wrong tree?
> 
> I don't think min_order can be negative.  Certainly we could enter the
> loop with order == 0 and min_order == 0, though.

... and in that case, PageCompound will be false, and we'll call split_page
which won't do anything, so we break out.

> 
> Some examples:
> 
> order = 0, min_order = 0
> -> Want alloc_pages _without_ __GFP_NORETRY.  OK
> -> If alloc_pages fails, return NULL.  OK
> -> If alloc pages succeeds, don't need splitting since single page.  OK

[...]

> I think those are all right.  Did I mess up?  You could certainly
> structure the loop in a different way but you need to make sure you
> handle all of those cases.  If you have an alternate structure that
> handles all those, let's consider it.

Right, I don't think the code is broken, I just think the !order check is
confusing and not needed.

Will
