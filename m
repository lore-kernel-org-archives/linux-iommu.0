From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 3/7] dma-mapping: pci: add pci_(un)map_resource
Date: Wed, 1 Jul 2015 13:31:27 -0500
Message-ID: <20150701183127.GD13409@google.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
	<1432919686-32306-4-git-send-email-wdavis@nvidia.com>
	<20150701160606.GA13409@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150701160606.GA13409-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 01, 2015 at 11:06:06AM -0500, Bjorn Helgaas wrote:
> On Fri, May 29, 2015 at 12:14:42PM -0500, wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> > From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > 
> > Simply route these through to the new dma_(un)map_resource APIs.
> > 
> > Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Reviewed-by: Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Reviewed-by: John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  include/asm-generic/pci-dma-compat.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
> > index c110843..ac4a4ad 100644
> > --- a/include/asm-generic/pci-dma-compat.h
> > +++ b/include/asm-generic/pci-dma-compat.h
> > @@ -61,6 +61,20 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
> >  	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> >  }
> >  
> > +static inline dma_addr_t
> > +pci_map_resource(struct pci_dev *hwdev, struct resource *resource,
> > +		 unsigned long offset, size_t size, int direction)
> 
> After 3a9ad0b4fdcd ("PCI: Add pci_bus_addr_t"), which will appear in
> v4.2-rc1, there is a pci_bus_addr_t, and I think you need that instead
> of dma_addr_t.
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3a9ad0b4fdcd

This wasn't a very good response, sorry.  I don't think just
changing dma_addr_t to pci_bus_addr_t is a good resolution.

Isn't there an implicit assumption here that either you're using an IOMMU
driver that always returns bus addresses that fit in a dma_addr_t, or
you're not using an IOMMU and dma_addr_t is big enough for any bus address?

What happens on a system with 64-bit PCI bus addresses, 32-bit dma_addr_t,
and no IOMMU?  Would this return failure somehow?

> > +{
> > +	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
> > +}
> > +
> > +static inline void
> > +pci_unmap_resource(struct pci_dev *hwdev, dma_addr_t dma_address, size_t size,
> > +		   int direction)
> > +{
> > +	dma_unmap_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> > +}
> > +
> >  static inline int
> >  pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
> >  	   int nents, int direction)
> > -- 
> > 2.4.0
> > 
