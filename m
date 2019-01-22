From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dma: debug: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 19:48:47 +0100
Message-ID: <20190122184847.GA32627@kroah.com>
References: <20190122152151.16139-39-gregkh@linuxfoundation.org>
 <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 22, 2019 at 06:44:38PM +0000, Robin Murphy wrote:
> Hi Greg,
> 
> On 22/01/2019 15:21, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Also delete the variables for the file dentries for the debugfs entries
> > as they are never used at all once they are created.
> 
> Modulo one nit below, I certainly approve of the cleanup :)
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   kernel/dma/debug.c | 81 ++++++----------------------------------------
> >   1 file changed, 10 insertions(+), 71 deletions(-)
> > 
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 23cf5361bcf1..2f5fc8b9d39f 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -136,14 +136,6 @@ static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> >   /* debugfs dentry's for the stuff above */
> >   static struct dentry *dma_debug_dent        __read_mostly;
> 
> Does this actually need to be at file scope, or could it be punted to a
> local in dma_debug_fs_init() while we're here?

It can be moved to the function scope if you want me to, I was trying to
do the least needed here :)

thanks,

greg k-h
