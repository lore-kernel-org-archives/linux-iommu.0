From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Date: Tue, 17 Jul 2018 16:57:25 +0200
Message-ID: <20180717145725.GA22109@lst.de>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com> <20180705193613.GA28905@lst.de> <20180715122826.GB2342@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180715122826.GB2342@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Fredrik Noring <noring@nocrew.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, JuergenUrban@gmx.de
List-Id: iommu@lists.linux-foundation.org

On Sun, Jul 15, 2018 at 02:28:27PM +0200, Fredrik Noring wrote:
> Hi Christoph, Robin,
> 
> On Thu, Jul 05, 2018 at 09:36:13PM +0200, Christoph Hellwig wrote:
> > > -	BUG_ON(!ops);
> > > -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> > > -
> > >  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
> > >  		return cpu_addr;
> > >  
> > > +	BUG_ON(!ops);
> > > +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> > 
> > I think doing dma on a device without ops is completely broken no matter
> > what you think of it, so I very much disagree with that part of the change.
> > 
> > Also while I don't think not having a dma mask is a good idea even for
> > a driver purely using dma coherent pools.  If the pools really are on
> > the device itself I can see why it might not matter, but for the case
> > commonly used on some ARM SOCs where we just reserve memory for certain
> > devices from a system pool it very much does matter.
> > 
> > There really is no good excuse to not set a coherent mask in the drivers.
> 
> Here are three other regressions related to the coherent mask WARN_ON_ONCE:

They are a pretty strong indication that yes, you should really set
the coherent mask if you ever do coherent allocations..
