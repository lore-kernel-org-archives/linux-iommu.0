From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus
 for aliased devices
Date: Tue, 5 Feb 2019 11:19:39 -0800
Message-ID: <20190205111939.6f91739e@jacob-builder>
References: <20190131185656.17972-1-logang@deltatee.com>
        <20190131185656.17972-2-logang@deltatee.com>
        <20190201164401.GT32526@8bytes.org>
        <398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-ntb@googlegroups.com, David Woodhouse <dwmw2@infradead.org>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 1 Feb 2019 10:27:29 -0700
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 2019-02-01 9:44 a.m., Joerg Roedel wrote:
> > On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe wrote:  
> >> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte,
> >> struct pci_dev *dev) set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
> >>  			     PCI_DEVID(PCI_BUS_NUM(data.alias),
> >>  				       dev->bus->number));
I guess devfn can be removed also. but that is separate cleanup.
 
> >> +	else if (data.count >= 2 && data.busmatch_count ==
> >> data.count)
> >> +		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
> >> +			     PCI_DEVID(dev->bus->number,
> >> +				       dev->bus->number));  
> > 
> > The dev->bus->number argument for the devfn parameter of PCI_DEVID
> > is not needed, right?  
> 
> Oh, yes. I think you are right.
> 
> > Also, this requires at least a comment to document that special
> > case.  
> 
> I'll add a comment for v2.
> 
> Thanks for the review!
> 
> Logan
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
