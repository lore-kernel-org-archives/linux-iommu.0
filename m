From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal
	memory size
Date: Tue, 09 Oct 2018 16:01:18 +1100
Message-ID: <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
References: <20180927223539.28449-1-hch@lst.de>
	<20180927223539.28449-6-hch@lst.de>
	<CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "open list:LINUX FOR POWERPC (32-BIT
	AND 64-BIT)" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
> > -        * Because 32-bit DMA masks are so common we expect every architecture
> > -        * to be able to satisfy them - either by not supporting more physical
> > -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > -        * architecture needs to use an IOMMU instead of the direct mapping.
> > -        */
> > -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > +       u64 min_mask;
> > +
> > +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > +       else
> > +               min_mask = DMA_BIT_MASK(32);
> > +
> > +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> > +
> > +       if (mask >= phys_to_dma(dev, min_mask))
> >                  return 0;
> > -#endif
> >          return 1;
> >   }
> 
> So I believe I have run into the same issue that Guenter reported. On
> an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
> all probe attempts for various devices were failing with -EIO errors.
> 
> I believe the last mask check should be "if (mask < phys_to_dma(dev,
> min_mask))" not a ">=" check.

Right, that test is backwards. I needed to change it here too (powermac
with the rest of the powerpc series).

Cheers,
Ben.
