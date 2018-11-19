From: Ramon Fried <ramon.fried@gmail.com>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
Date: Mon, 19 Nov 2018 16:18:02 +0200
Message-ID: <CA+Kvs9kPtTZavq91NXs-7edVO5Fxp8gPO=FD35i9_izAdGMkKw@mail.gmail.com>
References: <20180927223539.28449-1-hch@lst.de> <20180927223539.28449-6-hch@lst.de>
 <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com> <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: alexander.duyck@gmail.com, hch@lst.de, linux@roeck-us.net, iommu@lists.linux-foundation.org, robin.murphy@arm.com, open list <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 9, 2018 at 8:02 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
> > > -        * Because 32-bit DMA masks are so common we expect every architecture
> > > -        * to be able to satisfy them - either by not supporting more physical
> > > -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > > -        * architecture needs to use an IOMMU instead of the direct mapping.
> > > -        */
> > > -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > > +       u64 min_mask;
> > > +
> > > +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> > > +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > > +       else
> > > +               min_mask = DMA_BIT_MASK(32);
> > > +
> > > +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> > > +
> > > +       if (mask >= phys_to_dma(dev, min_mask))
> > >                  return 0;
> > > -#endif
> > >          return 1;
> > >   }
> >
> > So I believe I have run into the same issue that Guenter reported. On
> > an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
> > all probe attempts for various devices were failing with -EIO errors.
> >
> > I believe the last mask check should be "if (mask < phys_to_dma(dev,
> > min_mask))" not a ">=" check.
>
> Right, that test is backwards. I needed to change it here too (powermac
> with the rest of the powerpc series).
>
> Cheers,
> Ben.
>
>

Hi, I'm working on a MIPS64 soc with PCIe root complex on it, and it
appears that this series of patches are causing all PCI drivers that
request 64bit mask to fail with -5.
It's broken in 4.19. However, I just checked, it working on master.
We may need to backport a couple of patches to 4.19. I'm not sure
though which patches should be backported as there were at least 10
patches resolving this dma_direct area recently.
Christoph, Robin.
Can we ask Greg to backport all these changes ? What do you think ?

Thanks,
Ramon.
