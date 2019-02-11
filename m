From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] dma-mapping: Move debug configuration options to
 kernel/dma
Date: Mon, 11 Feb 2019 18:08:30 +0200
Message-ID: <20190211160830.GF9224@smile.fi.intel.com>
References: <20190211155409.41465-1-andriy.shevchenko@linux.intel.com>
 <20190211155450.GA27697@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211155450.GA27697@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 11, 2019 at 04:54:50PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 11, 2019 at 05:54:09PM +0200, Andy Shevchenko wrote:
> > This is a follow up to the commit cf65a0f6f6ff
> > 
> >   ("dma-mapping: move all DMA mapping code to kernel/dma")
> > 
> > which moved source code of DMA API to kernel/dma folder. Since there is
> > no file left in the lib that require DMA API debugging options move the
> > latter to kernel/dma as well.
> 
> Can we do this without the separate Kconfig.debug file?

Sure.

> 
> Otherwise this looks good to me.

-- 
With Best Regards,
Andy Shevchenko
