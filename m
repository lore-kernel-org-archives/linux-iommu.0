From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date: Fri, 28 Sep 2018 09:19:14 -0700
Message-ID: <153815155438.119890.4863330936629381207@swboyd.mtv.corp.google.com>
References: <20180920223559.136915-1-swboyd@chromium.org>
 <ef22f1b4-a2c5-25a4-451e-9191b3579a26@arm.com>
 <153755159334.119890.13825040401066852769@swboyd.mtv.corp.google.com>
 <f513d72b-3eec-1ddc-a318-9f3d17efe16e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f513d72b-3eec-1ddc-a318-9f3d17efe16e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Quoting Robin Murphy (2018-09-26 06:24:42)
> On 21/09/18 18:39, Stephen Boyd wrote:
> > Quoting Robin Murphy (2018-09-21 04:09:50)
> >> Hi Stephen,
> >>
> >> On 20/09/18 23:35, Stephen Boyd wrote:
> >>> I recently debugged a DMA mapping oops where a driver was trying to m=
ap
> >>> a buffer returned from request_firmware() with dma_map_single(). Memo=
ry
> >>> returned from request_firmware() is mapped into the vmalloc region and
> >>> this isn't a valid region to map with dma_map_single() per the DMA
> >>> documentation's "What memory is DMA'able?" section.
> >>>
> >>> Unfortunately, we don't really check that in the DMA debugging code, =
so
> >>> enabling DMA debugging doesn't help catch this problem. Let's add a n=
ew
> >>> DMA debug function to check for a vmalloc address and print a warning=
 if
> >>> this happens. This makes it a little easier to debug these sorts of
> >>> problems, instead of seeing odd behavior or crashes when drivers atte=
mpt
> >>> to map the vmalloc space for DMA.
> >>
> >> Good idea!
> >>
> >>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >>> ---
> >>>    include/linux/dma-debug.h   |  8 ++++++++
> >>>    include/linux/dma-mapping.h |  1 +
> >>>    kernel/dma/debug.c          | 12 ++++++++++++
> >>>    3 files changed, 21 insertions(+)
> >>
> >> However I can't help thinking this looks a little heavyweight for a
> >> single specific check. It seems like it would be enough to simply pass
> >> the VA as an extra argument to debug_dma_map_page(), since we already
> >> have the map_single argument which would indicate when it's valid. What
> >> do you reckon?
> > =

> > I thought about augmenting debug_dma_map_page() but that has another
> > problem where those checks are done after the page has been mapped. The
> > kernel can oops when it's operating on the incorrect page so we need to
> > check things before calling the dma ops.
> =

> Oh, right, as usual I've managed to overlook a subtlety :)
> =

> In fact, with memory now jogged, I think the virt_to_page() itself is =

> allowed to blow up if !virt_addr_valid(), so we probably do need =

> something like your original idea to be properly robust. I guess it =

> probably makes sense to implement that as debug_dma_map_single() then, =

> since the purpose is really to cover any VA checks specific to that case =

> which debug_dma_map_page() can't be expected to do after the fact.
> =


Ok. I can rename it to dma_debug_map_single() and throw in a
virt_addr_valid() check too. Thanks for the suggestion.
