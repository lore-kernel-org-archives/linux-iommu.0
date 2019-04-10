From: Thomas Hellstrom via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: revert dma direct internals abuse
Date: Wed, 10 Apr 2019 15:01:14 +0000
Message-ID: <0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
	<466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
	<20190409152538.GA12816@lst.de>
	<da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
	<20190410064359.GC5543@lst.de>
Reply-To: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190410064359.GC5543-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <5D2AB352DE7A2F4BB71CA19FEF5367B8-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Deepak Singh Rawat <drawat-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2019-04-10 at 08:43 +0200, hch-jcswGhMUV9g@public.gmane.org wrote:
> On Tue, Apr 09, 2019 at 05:24:48PM +0000, Thomas Hellstrom wrote:
> > > Note that this only affects external, untrusted devices.  But
> > > that
> > > may include eGPU,
> > 
> > What about discrete graphics cards, like Radeon and Nvidia? Who
> > gets to
> > determine what's trusted?
> 
> Based on firmware tables.  discrete graphics would not qualify unless
> they are attached through thunderbolt bridges or external PCIe ports.
> 
> > GPU libraries traditionally have been taking care of the CPU
> > mapping
> > caching modes since the first AGP drivers. GPU MMU ptes commonly
> > support various caching options and pages are changing caching mode
> > dynamically.
> > So even if the DMA layer needs to do the remapping, couldn't we do
> > that
> > on-demand when needed with a simple interface?
> 
> The problem is that there is no "simple" interface as the details
> depend on the architecture.  We have the following base variants
> to create coherent memory:
> 
>   1) do nothing - this works on x86-like platforms where I/O is
> always
>      coherent
>   2) use a special kernel segment, after flushing the caches for the
>      normal segment, done on platforms like mips that have this
>      special segment
>   3) remap the existing kernel direct mapping, after flushing the
>      caches, done by openrisc and in some cases arm32
>   4) create a new mapping in vmap or ioremap space after flushing the
>      caches - done by most architectures with an MMU and non-coherent
>      devices
>   5) use a special pool of uncached memory set aside by the hardware
>      or firmware - done by most architectures without an MMU but with
>      non-coherent devices
> 

Understood. Unfortunately IMO this severly limits the use of the
dma_alloc_coherent() method.

> So that is just five major variants with a lot of details on how
> it is done in practice.  Add to that that many of the operations
> are fairly expensive and need to be pre-loaded.
> 
> > > That being said: your driver already uses the dma coherent API
> > > under various circumstances, so you already have the above
> > > issues.
> > 
> > Yes, but they are hidden behind driver options. We can't have
> > someone
> > upgrade their kernel and suddenly things don't work anymore, That
> > said,
> > I think the SWIOTLB case is rare enough for the below solution to
> > be
> > acceptable, although the TTM check for the coherent page pool being
> > available still needs to remain.
> 
> So can you please respin a version acceptable to you and submit it
> for 5.1 ASAP?  Otherwise I'll need to move ahead with the simple
> revert.

I will. 
I need to do some testing to investigate how to best choose between the
options, but will have something ready for 5.1.

/Thomas
