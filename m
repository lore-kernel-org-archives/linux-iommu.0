From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dma: debug: no need to check return value of
 debugfs_create functions
Date: Fri, 1 Feb 2019 10:12:15 +0100
Message-ID: <20190201091215.GB30619@kroah.com>
References: <20190122152151.16139-39-gregkh@linuxfoundation.org>
 <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com>
 <20190122184847.GA32627@kroah.com>
 <20190201090402.GA16244@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201090402.GA16244@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 10:04:02AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 22, 2019 at 07:48:47PM +0100, Greg Kroah-Hartman wrote:
> > > Does this actually need to be at file scope, or could it be punted to a
> > > local in dma_debug_fs_init() while we're here?
> > 
> > It can be moved to the function scope if you want me to, I was trying to
> > do the least needed here :)
> 
> I've folded the scope move in when applying the patch to the
> dma-mapping for-next tree.

Wonderful, thanks!

greg k-h
