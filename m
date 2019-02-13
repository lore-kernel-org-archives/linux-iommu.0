From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
 PASID  in PRG Response.
Date: Wed, 13 Feb 2019 10:10:46 -0800
Message-ID: <20190213181046.GA16999@araj-mobl1.jf.intel.com>
References: <cover.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <787d13ae22ae07c708b06180241f4f2b71031f84.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Busch, Keith" <keith.busch@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 13, 2019 at 12:26:33AM -0800, Tian, Kevin wrote:
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 1457f931218e..af2e4a011787 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1399,7 +1399,8 @@ static void iommu_enable_dev_iotlb(struct
> > device_domain_info *info)
> >  	   undefined. So always enable PASID support on devices which
> >  	   have it, even if we can't yet know if we're ever going to
> >  	   use it. */
> > -	if (info->pasid_supported && !pci_enable_pasid(pdev, info-
> > >pasid_supported & ~1))
> > +	if (info->pasid_supported && pci_prg_resp_pasid_required(pdev)
> > &&
> > +	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
> >  		info->pasid_enabled = 1;
> 
> Above logic looks problematic. As Dave commented in another thread,
> PRI and PASID are orthogonal capabilities. Especially with introduction
> of VT-d scalable mode, PASID will be used alone even w/o PRI...
> 
> Why not doing the check when PRI is actually enabled? At that point
> you can fail the request if above condition is false. 
> 

That makes sense. 
