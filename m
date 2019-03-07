From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] [v2] dma-mapping: work around clang bug
Date: Thu, 7 Mar 2019 10:34:36 +0100
Message-ID: <CAMuHMdXmd9NURXvjVQeUe06QQP=degkY+VNUAXwO5eHDm3Lh0w@mail.gmail.com>
References: <20190307085246.1477426-1-arnd@arndb.de> <86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
 <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Nick Desaulniers <ndesaulniers@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Paul Burton <paul.burton@mips.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 7, 2019 at 10:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 7, 2019 at 10:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > On 2019-03-07 8:52 am, Arnd Bergmann wrote:
> > >
> > > -#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > > +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> > > +#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)
> >
> > I think that now makes DMA_BIT_MASK(0) undefined - that shouldn't matter
> > in most cases, but it could potentially happen at runtime where callers
> > use a non-constant argument. However, it also means we don't need to
> > special-case 64 any more (since that's there to avoid the same thing
> > anyway), so we could simply flip that to handle 0 instead.
>
> Yes, good idea.
>
> > FWIW I'd be very tempted to fold in the second shift as "2ULL<<((n)-1)",
> > but that may not be to everyone's taste.
>
> I like that. So shall we do this?
>
> /*
>  * Shifting '2' instead of '1' because of
>  * https://bugs.llvm.org/show_bug.cgi?id=38789
>  */
> #define DMA_BIT_MASK(n)    (((n) == 0) ? 0ULL : ((2ULL<<((n)-1)))-1)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
