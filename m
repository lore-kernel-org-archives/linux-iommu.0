From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/2] dma/iommu: Add pgsize_bitmap confirmation in
 __iommu_dma_alloc_pages
Date: Fri, 8 Apr 2016 14:07:33 +0100
Message-ID: <20160408130733.GD23750@arm.com>
References: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
 <20160329170238.GK6745@arm.com>
 <CAD=FV=XdZwg8usj3bjM6W=A0Yk1AFqKFRadpiS-LGLwxVNxp7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=XdZwg8usj3bjM6W=A0Yk1AFqKFRadpiS-LGLwxVNxp7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Arnd Bergmann <arnd@arndb.de>, Lucas Stach <l.stach@pengutronix.de>, Marek Szyprowski <m.szyprowski@samsung.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 05, 2016 at 10:03:32AM -0700, Doug Anderson wrote:
> On Tue, Mar 29, 2016 at 10:02 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Mar 28, 2016 at 02:32:11PM +0800, Yong Wu wrote:
> >> @@ -213,13 +215,16 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
> >>               /*
> >>                * Higher-order allocations are a convenience rather
> >>                * than a necessity, hence using __GFP_NORETRY until
> >> -              * falling back to single-page allocations.
> >> +              * falling back to min size allocations.
> >>                */
> >> -             for (order = min_t(unsigned int, order, __fls(count));
> >> -                  order > 0; order--) {
> >> -                     page = alloc_pages(gfp | __GFP_NORETRY, order);
> >> +             for (order = min_t(int, order, __fls(count));
> >> +                  order >= min_order; order--) {
> >> +                     page = alloc_pages((order == min_order) ? gfp :
> >> +                                        gfp | __GFP_NORETRY, order);
> >>                       if (!page)
> >>                               continue;
> >> +                     if (!order)
> >> +                             break;
> >
> > Isn't this handled by the loop condition?
> 
> He changed the loop condition to be ">= min_order" instead of "> 0",
> so now we can get here with an order == 0.  This makes sense because
> when min_order is not 0 you still want to run the code to split the
> pages and it is sane not to duplicate that below.
> 
> Maybe I'm misunderstanding, though.  Perhaps you can explain how you
> think this code should look?

My reading of the code was that we require order >= min_order to enter
the loop. Given that order doesn't change between the loop header and the
if (!order) check, then that must mean we can enter the loop body with
order == 0 and order >= min_order, which means that min_order is allowed
to be negative. That feels weird.

Am I barking up the wrong tree?

Will
