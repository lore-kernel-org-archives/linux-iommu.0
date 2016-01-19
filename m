From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/dma: Avoid unlikely high-order allocations
Date: Tue, 19 Jan 2016 10:55:00 +0800
Message-ID: <1453172100.17894.9.camel@mhfsdcap03>
References: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
	<8014a146e90282b8cbc5868cee0d01776670d9a6.1450457730.git.robin.murphy@arm.com>
	<CAD=FV=WqJHjb3zoZn=8OPO2iKH1k1sMvXkVBkyM6pAyvo6PgDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAD=FV=WqJHjb3zoZn=8OPO2iKH1k1sMvXkVBkyM6pAyvo6PgDQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-12-18 at 14:35 -0800, Doug Anderson wrote:
> Robin,
> 
> On Fri, Dec 18, 2015 at 9:01 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> > Doug reports that the equivalent page allocator on 32-bit ARM exhibits
> > particularly pathalogical behaviour under memory pressure when
> > fragmentation is high, where allocating a 4MB buffer takes tens of
> > seconds and the number of calls to alloc_pages() is over 9000![1]
> >
> > We can drastically improve that situation without losing the other
> > benefits of high-order allocations when they would succeed, by assuming
> > memory pressure is relatively constant over the course of an allocation,
> > and not retrying allocations at orders we know to have failed before.
> > This way, the best-case behaviour remains unchanged, and in the worst
> > case we should see at most a dozen or so (MAX_ORDER - 1) failed attempts
> > before falling back to single pages for the remainder of the buffer.
> >
> > [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394660.html
> >
> > Reported-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  drivers/iommu/dma-iommu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Presumably it makes sense to update this based on v2 of my patch to
> the original code?  AKA: <https://patchwork.kernel.org/patch/7888851/>
> ?

Hi Robin,

    Thanks very much for this patch.

    And Douglas has sent his v2 which improve the flow of alloc_pages.
Do you have any plan to update this patch according to this v2, or any
concern about it?


> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
