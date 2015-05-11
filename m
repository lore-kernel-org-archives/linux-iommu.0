From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/6] dma-mapping: pci: add pci_(un)map_resource
Date: Mon, 11 May 2015 10:30:25 -0400
Message-ID: <20150511143025.GD20282@l.oracle.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
	<1430505138-2877-4-git-send-email-wdavis@nvidia.com>
	<20150507151905.GL24643@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150507151905.GL24643-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, May 07, 2015 at 10:19:05AM -0500, Bjorn Helgaas wrote:
> [+cc Dave for sparc64, Yinghai]
> 
> On Fri, May 01, 2015 at 01:32:15PM -0500, wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
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
> > +{
> > +	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
> > +}
> 
> On sparc64, PCI bus addresses, e.g., raw BAR values, can be 64 bits wide,
> but dma_addr_t is only 32 bits [1].  So dma_addr_t is a bit of a problem
> here.  It's likely that we will add a pci_bus_addr_t, but that hasn't
> happened yet [2].

Why not just expand the 'dma_addr_t' to be unsigned long (if to support
the T5-8 box)?
> 
> We do have existing problems already, e.g,. pci_bus_address() returns a
> dma_addr_t, so it has the same problem.  So I guess this is just a heads-up
> that this needs to be fixed eventually.
> 
> Bjorn
> 
> [1] http://lkml.kernel.org/r/20150327.145016.86183910134380870.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
> [2] http://lkml.kernel.org/r/1427857069-6789-2-git-send-email-yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
