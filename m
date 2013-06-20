From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
 IOMMU prot
Date: Thu, 20 Jun 2013 11:54:31 +0200
Message-ID: <20130620.125431.1161068035083905855.hdoyu@nvidia.com>
References: <CAMcxFTRnnCnPnvMi89r7rUsN4xeYzZGqy9s5v5ukm_fJ_d_RGg@mail.gmail.com><20130620.112439.1330557591655135630.hdoyu@nvidia.com><CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Nishanth Peethambaran <nishanth.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Thu, 20 Jun 2013 10:55:32 +0200:

> Thinking again on it, I feel the translation of dma-attr should happen
> when dma-mapping code makes calls to " iommu mapping" API.
> "iommu mapping" API which does iova management and make iommu API
> calls could be taken out from dma-mapping.c, for which I see
> discussion already happening for arm64.

According to the discussion ARM64:dma-mapping, I got an implression
that IOVA management part in ARM:dma-mapping API would be a new common
module(ie: /lib/iommu-helper.c), but still IOMMU API itself would
reamin as primitive as what they are.

+---------------------------------
|     DMA mapping API
|                            +-----------------
+--------------+-----------+ | DMA mapping API($ARCH)
|   IOMMU API  |  IOVA MGT | +------------------
+--------------+-----------+
|IOMMU API(H/W)|
+--------------+
|  IOMMU H/W   |
+--------------+

> If devices allocate via dma-mapping API, physical mem allocation, iova
> allocation and iommu mapping happens internally.
> Devices may allocate physical memory using any allocator (say ION
> including carveout area), use "iommu mapping" API which will do iova
> allocation and iommu mapping. The prot flags could be useful in this
> case as well - not sure whether we would need dma-attrs here.

I haven't followed ION recently, but can't ION backed by DMA mapping
API instead of using IOMMU API directly?
