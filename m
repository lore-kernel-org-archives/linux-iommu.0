From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC 2/9] iommu/vt-d: add bind_pasid_table function
Date: Fri, 23 Jun 2017 13:21:51 -0700
Message-ID: <20170623132151.6d623c48@jacob-builder>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1497478983-77580-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20170622165215.5989e02c@w520.home>
        <20170623111952.09915a6d@jacob-builder>
        <20170623125900.61091315@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170623125900.61091315@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Yi L <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 23 Jun 2017 12:59:00 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 23 Jun 2017 11:19:52 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > On Thu, 22 Jun 2017 16:52:15 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Wed, 14 Jun 2017 15:22:56 -0700
> > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:  
> > > > +static int intel_iommu_unbind_pasid_table(struct iommu_domain
> > > > *domain,
> > > > +					struct device *dev)
> > > > +{
> > > > +	struct intel_iommu *iommu;
> > > > +	struct dmar_domain *dmar_domain =
> > > > to_dmar_domain(domain);
> > > > +	u8 bus, devfn;
> > > > +
> > > > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > > > +	if (!iommu)
> > > > +		return -ENODEV;
> > > > +	/*
> > > > +	 * REVISIT: we might want to clear the PASID table
> > > > pointer
> > > > +	 * as part of context clear operation. Currently, it
> > > > leaves
> > > > +	 * stale data but should be ignored by hardware since
> > > > PASIDE
> > > > +	 * is clear.
> > > > +	 */
> > > > +	/* ATS will be reenabled when remapping is restored */
> > > > +	pci_disable_ats(to_pci_dev(dev));      
> > > 
> > > dev_is_pci()?
> > >     
> > good to check, even thought intel iommu supports PCI only.  
> 
> That's not true, intel-iommu supports non-PCI devices defined in ACPI
> as well.  Thanks,
> 
For non-pci device, there is still a pci BDF allocated for it (shown in
ACPI) such that it can have its own IOMMU context, right? e.g. HPET

> Alex

[Jacob Pan]
