From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Wed, 18 Apr 2012 08:44:48 +0200
Message-ID: <20120418.094448.2234414220947028341.hdoyu@nvidia.com>
References: <201204161534.20089.arnd@arndb.de><20120418081746.995724e27bdc726049cd4965@nvidia.com><20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418054140.GA17506-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Wed, 18 Apr 2012 07:41:40 +0200
Message-ID: <20120418054140.GA17506-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>

> * PGP Signed by an unknown key
> 
> * Hiroshi Doyu wrote:
> > On Mon, 16 Apr 2012 17:34:19 +0200
> > Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > 
> > > On Monday 16 April 2012, Hiroshi Doyu wrote:
> > > > What about using "dma-window" property to specify IOVA range in dtsi as below?
> > > > 
> > > > arch/powerpc/platforms/cell/iommu.c:
> > > > 
> > > > 698 static int __init cell_iommu_get_window(struct device_node *np,
> > > > 699                                          unsigned long *base,
> > > > 700                                          unsigned long *size)
> > > > 701 {
> > > > 702         const void *dma_window;
> > > > 703         unsigned long index;
> > > > 704
> > > > 705         /* Use ibm,dma-window if available, else, hard code ! */
> > > > 706         dma_window = of_get_property(np, "ibm,dma-window", NULL);
> > > > 707         if (dma_window == NULL) {          ^^^^^^^^^^^^^^
> > > > 708                 *base = 0;
> > > > 709                 *size = 0x80000000u;
> > > > 710                 return -ENODEV;
> > > > 711         }
> > > > 712
> > > > 713         of_parse_dma_window(np, dma_window, &index, base, size);
> > > > 714         return 0;
> > > > 715 }
> > > > 
> > > 
> > > Yes, that's the right way to do it, but I would use the more generic
> > > "dma-window" name rather than "ibm,dma-window", which was originally
> > > introduced for pseries and for some reason copied into the cell qs2x
> > > firmware.
> > 
> > Which name is better, "dma-window" or "iova-window"?
> > Considering DMA IOMMU mapping API, "dma-window" may sound appropriate to me.
> 
> But the window isn't necessarily used for DMA transfers. I was going to
> propose "aperture", but that doesn't seem quite right since it is a very
> GART-specific term. "iova-window" sounds like the best fit for what it
> really is.

If we can consider IOMMU as one of the implementation of DMA(Direct
Memory Access), the prefix "dma-(window)" may make sense here. Then,
we don't have to introduce a new concept "IO virtual address(iova)" in
addition to the existing "bus address"(?)

Anyway, either name would be ok for me;)
