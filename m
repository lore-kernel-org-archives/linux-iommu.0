From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
 IOMMU prot
Date: Thu, 20 Jun 2013 12:34:07 +0200
Message-ID: <20130620.133407.798194318297047071.hdoyu@nvidia.com>
References: <CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw@mail.gmail.com><20130620.125431.1161068035083905855.hdoyu@nvidia.com><201306201213.13644.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201306201213.13644.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote @ Thu, 20 Jun 2013 12:13:13 +0200:

> On Thursday 20 June 2013, Hiroshi Doyu wrote:
> > > If devices allocate via dma-mapping API, physical mem allocation, iova
> > > allocation and iommu mapping happens internally.
> > > Devices may allocate physical memory using any allocator (say ION
> > > including carveout area), use "iommu mapping" API which will do iova
> > > allocation and iommu mapping. The prot flags could be useful in this
> > > case as well - not sure whether we would need dma-attrs here.
> > 
> > I haven't followed ION recently, but can't ION backed by DMA mapping
> > API instead of using IOMMU API directly?
> 
> For a GPU with an IOMMU, you typically want per-process IOMMU contexts,
> which are only available when using the IOMMU API directly, as the
> dma-mapping abstraction uses only one context for kernel space.

Yes, we had some experiment for switching IOMMU context with DMA
mapping API. We needed to add some new DMA mapping API, and didn't
look so nice at that time. What do you think to introduce multiple
context or switching context in dma-mapping abstruction?
