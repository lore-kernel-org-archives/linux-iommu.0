From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] dma-mapping: work around clang bug
Date: Thu, 7 Mar 2019 09:50:27 +0100
Message-ID: <CAK8P3a3=GcE1bN1HNwoMVG5heKfAipFP7+a4pRgnF=QbfiBBGA@mail.gmail.com>
References: <20190307080038.3727426-1-arnd@arndb.de>
	<CAMuHMdVBBaV8UPqUZUZXy3c9E3zUmVUEZyEEbDs4LaJ9OHncDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdVBBaV8UPqUZUZXy3c9E3zUmVUEZyEEbDs4LaJ9OHncDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 7, 2019 at 9:28 AM Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, Mar 7, 2019 at 9:01 AM Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > Clang has a rather annoying behavior of checking for integer
> > arithmetic problems in code paths that are discarded by gcc
> > before that perfoms the same checks.
> >
> > For DMA_BIT_MASK(64), this leads to a warning despite the
> > result of the macro being completely sensible:
> >
> > arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >                 .coherent_dma_mask = DMA_BIT_MASK(64),
> >
> > The best workaround I could come up with is to shift the
> > value twice, which makes the macro way less readable but
> > always has the same result.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > ---
> >  include/linux/dma-mapping.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 75e60be91e5f..380d3a95d02e 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -138,7 +138,8 @@ struct dma_map_ops {
> >  extern const struct dma_map_ops dma_virt_ops;
> >  extern const struct dma_map_ops dma_dummy_ops;
> >
> > -#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> > +#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : (((1ULL<<((n)-1))-1) << 1))
>
> The second "-1" should be done on the final result, not on the
> intermediate value.

Ah, of course. I'll send an update patch in a bit, sorry about this.

      Arnd
