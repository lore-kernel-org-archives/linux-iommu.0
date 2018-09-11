From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
	device
Date: Tue, 11 Sep 2018 10:19:52 +0200
Message-ID: <20180911081952.GA17267@kroah.com>
References: <20180910060533.27172-1-hch@lst.de>
	<20180910060533.27172-3-hch@lst.de>
	<20180910161350.GA10380@kroah.com> <20180911064636.GA6214@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180911064636.GA6214-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 11, 2018 at 08:46:36AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 10, 2018 at 06:13:50PM +0200, Greg Kroah-Hartman wrote:
> > > +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> > > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> > > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> > > +	bool			dma_coherent:1;
> > > +#endif
> > 
> > It's just one bit, why not always have it enabled here?  If the arch
> > uses it or doesn't, no big deal.
> > 
> > Or are you using this to "catch" arches that mess something up?
> 
> Yes, that is the intent - I don't want architectures to accidentally
> set it while not selecting the non-coherent infrastructure, as it
> won't have an effect.

Ok, fine with me:
	Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
