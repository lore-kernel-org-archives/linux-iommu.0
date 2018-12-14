From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Fri, 14 Dec 2018 10:55:27 +0100
Message-ID: <CAMuHMdXzuS3sEZ1LNxhCiNtvzUneGsfPjMNWSh8UfbGEEnPTRA@mail.gmail.com>
References: <20181214082515.14835-1-hch@lst.de>
	<20181214082515.14835-2-hch@lst.de>
	<CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-s390 <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-m68k <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Openrisc <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, alpha <linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sparclinux <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arcml <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 14, 2018 at 10:54 AM Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Fri, Dec 14, 2018 at 9:26 AM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> > If we want to map memory from the DMA allocator to userspace it must be
> > zeroed at allocation time to prevent stale data leaks.   We already do
> > this on most common architectures, but some architectures don't do this
> > yet, fix them up, either by passing GFP_ZERO when we use the normal page
> > allocator or doing a manual memset otherwise.
> >
> > Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
>
> Thanks for your patch!
>
> > --- a/arch/m68k/kernel/dma.c
> > +++ b/arch/m68k/kernel/dma.c
> > @@ -32,7 +32,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> >         size = PAGE_ALIGN(size);
> >         order = get_order(size);
> >
> > -       page = alloc_pages(flag, order);
> > +       page = alloc_pages(flag | GFP_ZERO, order);
> >         if (!page)
> >                 return NULL;
>
> There's second implementation below, which calls __get_free_pages() and
> does an explicit memset().  As __get_free_pages() calls alloc_pages(), perhaps
> it makes sense to replace the memset() by GFP_ZERO, to increase consistency?

Regardless, for m68k:
Acked-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
