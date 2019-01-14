From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] dma-mapping: remove the default map_resource
 implementation
Date: Mon, 14 Jan 2019 18:08:55 +0100
Message-ID: <20190114170855.GA7485@lst.de>
References: <20190111181731.11782-1-hch@lst.de> <20190111181731.11782-2-hch@lst.de> <c882430e-1dbd-df86-d686-0381dcaa668e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c882430e-1dbd-df86-d686-0381dcaa668e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 14, 2019 at 01:12:33PM +0000, Robin Murphy wrote:
> Ignoring the offset was kind of intentional there, because at the time I 
> was primarily thinking about it in terms of the Keystone 2 platform where 
> the peripherals are all in the same place (0-2GB) in both the bus and CPU 
> physical address maps, and only the view of RAM differs between the two 
> (2-4GB vs. 32-34GB). However, on something like BCM283x, the peripherals 
> region is also offset from its bus address in the CPU view, but at a 
> *different* offset relative to that of RAM.

I was more thinking of the PCIe P2P case, where we need to apply a
consistent offset to translate between the CPU and the bus view.

But this isn't really used for PCIe P2P, so I guess keeping the original
sematics might be a better idea.  That being said the videobuf code seems
to rely on these offsets, so we might be between a rock and a hard place.

> Fortunately, I'm not aware of any platform which has a DMA engine behind an 
> IOMMU (and thus *needs* to use dma_map_resource() to avoid said IOMMU 
> blocking the slave device register reads/writes) and also has any nonzero 
> offsets, and AFAIK the IOMMU-less platforms above aren't using 
> dma_map_resource() at all, so this change shouldn't actually break 
> anything, but I guess we have a bit of a problem making it truly generic 
> and robust :(

Note that we don't actually use the code in this patch for ARM/ARM64
platforms with IOMMUs, as both the ARM and the ARM64 iommu code have
their own implementations of ->map_resource that actually program
the iommu (which at least for the PCIe P2P case would be wrong).

> Is this perhaps another shove in the direction of overhauling 
> dma_pfn_offset into an arbitrary "DMA ranges" lookup table?

It is long overdue anyway.

>>   		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
>
> Might it be reasonable to do:
>
> 	if (!dma_is_direct(ops) && ops->map_resource)
> 		addr = ops->map_resource(...);
> 	else
> 		addr = dma_direct_map_resource(...);
>
> and avoid having to explicitly wire up the dma_direct callback elsewhere?

No, I absolutely _want_ the callback explicitly wired up.  That is the
only way to ensure we actually intentionally support it and don't just
get a default that often won't work.  Same issue for ->mmap and
->get_sgtable.
