From: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA
 more precisely
Date: Wed, 19 Sep 2012 18:44:25 -0700
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E379FDC1EEB@HQMAIL04.nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
 <20120918124918.GK2505@amd.com>
 <20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
 <201209190759.46174.arnd@arndb.de> <20120919125020.GQ2505@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120919125020.GQ2505-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> When a device driver would only use the IOMMU-API and needs small DMA-
> able areas it has to re-implement something like the DMA-API (basically an
> address allocator) for that. So I don't see a reason why both can't be used in a
> device driver.

On Tegra, the following use cases need specific IOVA mapping.
1. Few MMIO blocks need IOVA=PA mapping setup.
2. CPU side loads the firmware into physical memory, which has to be
mapped to a specific IOVA address, as  firmware is statically linked based
 on specific IOVA address. 

DMA api's allow specifying only one address space per platform device.

For #1, DMA API can't be used as it doesn't allow mapping specific IOVA to PA.
IOMMU API can be used for mapping specific IOVA to PA. But, in order to use
 IOMMU API, the driver has to  dereference the dev pointer, get domain ptr,
 take lock, and allocate memory from dma_iommu_mapping.  This breaks
 the abstraction for struct device. Each device driver that need IOVA=PA has to
 do this, which is redundant.

For #2, physical memory allocations alone can be done through DMA as it also 
allocates IOVA space Implicitly. Even after allocating physical memory through
DMA API's, it would have same problem as #1 for IOVA to PA mapping.

If a fake device is expected to be created for specific IOVA allocation, then it
may  lead to creating multiple fake devices per specific IOVA and per 
ASID(unique IOVA address space).  As domain init would be done based on
device name, the fake device should have the same name as of original platform
device.

If DMA API allows allocating specific IOVA address and mapping IOVA to specific PA,
 device driver don't need to know any details of struct device and specifying
 one mapping per device is enough and no  need for fake devices.

Comments are much appreciated.

-KR


> -----Original Message-----
> From: Joerg Roedel [mailto:joerg.roedel-5C7GfCeVMHo@public.gmane.org]
> Sent: Wednesday, September 19, 2012 5:50 AM
> To: Arnd Bergmann
> Cc: Hiroshi Doyu; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org;
> minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org;
> linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Krishna Reddy; linux-
> tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
> pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA
> more precisely
> 
> On Wed, Sep 19, 2012 at 07:59:45AM +0000, Arnd Bergmann wrote:
> > On Wednesday 19 September 2012, Hiroshi Doyu wrote:
> > > I guess that it would work. Originally I thought that using DMA-API
> > > and IOMMU-API together in driver might be kind of layering violation
> > > since IOMMU-API itself is used in DMA-API. Only DMA-API used in
> > > driver might be cleaner. Considering that DMA API traditionally
> > > handling anonymous {bus,iova} address only, introducing the concept
> > > of specific address in DMA API may not be so encouraged, though.
> > >
> > > It would be nice to listen how other SoCs have solved similar needs.
> >
> > In general, I would recommend using only the IOMMU API when you have a
> > device driver that needs to control the bus virtual address space and
> > that manages a device that resides in its own IOMMU context. I would
> > recommend using only the dma-mapping API when you have a device that
> > lives in a shared bus virtual address space with other devices, and
> > then never ask for a specific bus virtual address.
> >
> > Can you explain what devices you see that don't fit in one of those
> > two categories?
> 
> Well, I don't think that a driver should limit to one of these 2 APIs. A driver can
> very well use the IOMMU-API during initialization (for example to map the
> firmware to an address the device expects it to be) and use the DMA-API later
> during normal operation to exchange data with the device.
> 
> When a device driver would only use the IOMMU-API and needs small DMA-
> able areas it has to re-implement something like the DMA-API (basically an
> address allocator) for that. So I don't see a reason why both can't be used in a
> device driver.
> 
> Regards,
> 
> 	Joerg
> 
> --
> AMD Operating System Research Center
> 
> Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach General
> Managers: Alberto Bozzo
> Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.
> 43632
