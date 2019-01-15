From: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v5 4/8] iommu/vt-d: Aux-domain specific domain
 attach/detach
Date: Tue, 15 Jan 2019 13:31:42 +0000
Message-ID: <20190115133142.0000744c@huawei.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
        <20190110030027.31447-5-baolu.lu@linux.intel.com>
        <20190114122603.00001450@huawei.com>
        <cf37ed74-81ea-9708-8d99-5bc3b64b1f23@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cf37ed74-81ea-9708-8d99-5bc3b64b1f23@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Zeng@mail.linuxfoundation.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 15 Jan 2019 10:10:21 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 1/14/19 8:26 PM, Jonathan Cameron wrote:
> > On Thu, 10 Jan 2019 11:00:23 +0800
> > Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >   
> >> When multiple domains per device has been enabled by the
> >> device driver, the device will tag the default PASID for
> >> the domain to all DMA traffics out of the subset of this
> >> device; and the IOMMU should translate the DMA requests
> >> in PASID granularity.
> >>
> >> This adds the intel_iommu_aux_attach/detach_device() ops
> >> to support managing PASID granular translation structures
> >> when the device driver has enabled multiple domains per
> >> device.
> >>
> >> Cc: Ashok Raj <ashok.raj@intel.com>
> >> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Cc: Kevin Tian <kevin.tian@intel.com>
> >> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> >> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>  
> > 
> > The following is probably a rather naive review given I don't know
> > the driver or hardware well at all.  Still, it seems like things
> > are a lot less balanced than I'd expect and isn't totally obvious
> > to me why that is.  
> 
> Thank you!

You are welcome.

...

> >> +/*
> >> + * Check whether a @domain could be attached to the @dev through the
> >> + * aux-domain attach/detach APIs.
> >> + */
> >> +static inline bool
> >> +is_aux_domain(struct device *dev, struct iommu_domain *domain)  
> > 
> > I'm finding the distinction between an aux domain capability on
> > a given device and whether one is actually in use to be obscured
> > slightly in the function naming.
> > 
> > This one for example is actually checking if we have a domain
> > that is capable of being enabled for aux domain use, but not
> > yet actually in that mode?
> > 
> > Mind you I'm not sure I have a better answer for the naming.
> > can_aux_domain_be_enabled?  is_unattached_aux_domain?
> > 
> >   
> 
> device aux mode vs. normal mode
> ===============================
> 
> When we talk about the auxiliary mode (simply aux-mode), it means "the
> device works in aux-mode or normal mode". "normal mode" means that the
> device (and it's corresponding IOMMU) supports only RID (PCI Request ID)
> based DMA translation; while, aux-mode means the the device (and it's
> IOMMU) supports fine-grained DMA translation, like PASID based DMA
> translation with Intel VT-d scalable mode.
> 
> We are adding below APIs to switch a device between these two modes:
> 
> int iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_AUX)
> 
> And this API (still under discussion) to check which mode the device is
> working in:
> 
> bool iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
> 
> aux-domain
> ==========
> 
> If a device is working in aux-mode and we are going to attach a domain
> to this device, we say "this domain will be attached to the device in
> aux mode", and simply "aux domain". So a domain is "normal" when it is
> going to attach to a device in normal mode; and is "aux-domain" when it
> is going to attach to a device in aux mode.

Hmm.. OK I guess.  It still feels like there is more need to refer to
the docs than there should be.  Still, your code and I may well never
read it again so I don't mind :)

> 
> >   
> >> +{
