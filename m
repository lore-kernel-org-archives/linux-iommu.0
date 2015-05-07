From: William Davis <wdavis@nvidia.com>
Subject: RE: [PATCH 6/6] x86: add pci-nommu implementation of map_resource
Date: Thu, 7 May 2015 16:07:45 +0000
Message-ID: <29f8d3a0ed1b436d9473e1ba312adbbe@HQMAIL106.nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <1430505138-2877-7-git-send-email-wdavis@nvidia.com>
 <20150507150804.GJ24643@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150507150804.GJ24643@google.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Terence Ripperda <TRipperda@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, "jglisse@redhat.com" <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Thursday, May 7, 2015 10:08 AM
> To: William Davis
> Cc: joro@8bytes.org; iommu@lists.linux-foundation.org; linux-
> pci@vger.kernel.org; Terence Ripperda; John Hubbard; jglisse@redhat.com
> Subject: Re: [PATCH 6/6] x86: add pci-nommu implementation of map_resource
> 
> On Fri, May 01, 2015 at 01:32:18PM -0500, wdavis@nvidia.com wrote:
> > From: Will Davis <wdavis@nvidia.com>
> >
> > diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
> > index da15918..6e9e66d 100644
> > --- a/arch/x86/kernel/pci-nommu.c
> > +++ b/arch/x86/kernel/pci-nommu.c
> > @@ -38,6 +38,22 @@ static dma_addr_t nommu_map_page(struct device *dev,
> struct page *page,
> >  	return bus;
> >  }
> >
> > +static dma_addr_t nommu_map_resource(struct device *dev, struct resource
> *res,
> > +				     unsigned long offset, size_t size,
> > +				     enum dma_data_direction dir,
> > +				     struct dma_attrs *attrs)
> > +{
> > +	dma_addr_t bus = res->start + offset;
> 
> "res->start" is the CPU physical address, not the bus address.  There is a
> pci_bus_address() interface to get the bus address.
> 
> On many, but not all, x86 platforms the CPU physical address is identical
> to the PCI bus address.
> 

Thanks for pointing that out. Since we already have the resource here (and not the BAR index), I'll use pcibios_resource_to_bus(), as pci_bus_address() does.

Thanks,
Will

--
nvpublic
