From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [PATCH v3 18/19] iommu: exynos: init from
	dt-specific callback instead of initcall
Date: Fri, 19 Dec 2014 00:21:59 +0100
Message-ID: <1793344.bWpPveHxzq@wuerfel>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<5219064.gvW43bShnl@wuerfel> <1518515.QutUfiWrAf@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1518515.QutUfiWrAf@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday 18 December 2014 22:36:14 Laurent Pinchart wrote:
> 
> > (currently only on ARM64, not ARM32, until someone adds support). I can see
> > your point regarding machines that have a mandatory IOMMU with no fallback
> > when there is no driver, but we can support them by making the iommu driver
> > selected through Kconfig for that platform, while still allowing other
> > platforms to work with drivers left out of the kernel.
> 
> The question is how to tell the kernel not to wait for an IOMMU that will 
> never be there. Would a kernel command line argument be an acceptable solution 
> or do we need something more automatic ?

I would hope that we can find an automatic solution without relying on
the command line.

Unfortunately, I also remembered one case in support of what Lucas mentioned
and that would break this: There is at least one SoC that uses cache-coherent
DMA only when the IOMMU (ARM SMMU IIRC)is enabled, but is non-coherent
otherwise. We can't really express that in DT, so we actually do rely on
the IOMMU driver to be present on this machine when any "iommus" properties
are used, as they would always come in combination with "dma-coherent"
properties that are otherwise wrong.

We can still enforce this by requiring the smmu driver to be built into
the kernel on this platform, but simply saying that the device cannot
support DMA as long as there is an iommus property but no driver for
it does make a lot of sense.

Note that there are more than two ways that the kernel could treat
the situation of probing a device with a valid iommus reference but
no driver loaded for the iommu:

a) assume all iommu drivers are initialized early, so use linear or
   swiotlb dma_map_ops, and probe the driver normally. This breaks
   the scenario with conditionally coherent devices, and requires doing
   the iommu init early
b) assume all iommu drivers are initialized early, so disallow any DMA
   by setting a zero dma_mask but allow the driver to be probed using
   polling I/O mode (useful for slow devices like UART or SPI)
   This breaks devices that require DMA but can fall back to linear
   or swiotlb mappings, and requires doing the iommu init early.
c) defer probing until an iommu driver is gets initialized. This breaks
   both the cases where we could fall back to a sane behavior without
   iommu, but it would let us use a proper driver with regular power
   management etc.

	Arnd
