From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: DMA mapping API(IOMMU) for ARM64?
Date: Tue, 18 Jun 2013 14:51:50 +0200
Message-ID: <201306181451.50820.arnd@arndb.de>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com> <5159282.rrJMaZuYMv@wuerfel> <20130618.140137.1551430695673122122.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130618.140137.1551430695673122122.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Catalin.Marinas-5wv7dgnIgG8@public.gmane.org" <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 18 June 2013, Hiroshi Doyu wrote:
> I'm guessing that this kind of unification usually takes some time
> since we need to factor out the common code from the different
> ${ARCH}/mm/dma-mapping.c. Also some of ${ARCH} has IOMMU support in
> it. So if we want to develop our 64-bit ARM with working DMA mapping
> API during this transition, the step to take would be:
> 
> 1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c(+swiotlb)

Please don't.

> 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
> 3, Factor out the common code from them into mm/dma-mapping.c

I would suggest moving the ARM dma-mapping.c code to /mm or /lib
right away and then generalizing it there. Whoever wants to add
support for their architecture can modify the code to add whatever
changes they require.

	Arnd
