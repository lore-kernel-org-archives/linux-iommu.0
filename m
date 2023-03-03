Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2AD945D
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879934; x=1709415934;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGV5bJjDHw2ZzOUEb+Ljo+MxhpwEmK8AGP04i4kgrdk=;
  b=Xme8cgEdgp7HfWK53BZntsooPlMtI/7LcrcHH9SIEpD9uHYfUmoIWMor
   aO5fLGgFJLAUp9Y3S1kTU7lBu9KDmWYmDfaXGl3YSKSM617YECx+rTO5K
   TrSjcWJUQlzYj+1dugWm5bmsHLO6LW/3nu6lxWtPV3hFz7o2IRkEBM8Bj
   HrjC1zSta6Ch5QQDL+dMwxDQPzbMPfQQ+EPtDgyMRDVqv8pztRHJWnRvL
   pBfr9mtrJJvkdjV4SY2wp68+3vwNVL8q/cV7SHdfvNkayBXixURmVRTGk
   IM3dgDv08A12/aevnwTf5Fp3cD0fSh5PoOQyehHRT60K3iOnU6NnOQ46x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="397753655"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="397753655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="707993274"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="707993274"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:45:33 -0800
Date: Fri, 3 Mar 2023 13:49:23 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230303134923.22b7686f@jacob-builder>
In-Reply-To: <ZACdTG4QZSHF2QRj@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
	<ZACdTG4QZSHF2QRj@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Thu, 2 Mar 2023 08:57:48 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 02, 2023 at 09:47:00AM +0000, Tian, Kevin wrote:
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Thursday, March 2, 2023 9:00 AM
> > > 
> > >  static int idxd_enable_system_pasid(struct idxd_device *idxd)
> > >  {
> > > -	return -EOPNOTSUPP;
> > > +	struct pci_dev *pdev = idxd->pdev;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct iommu_domain *domain;
> > > +	union gencfg_reg gencfg;
> > > +	ioasid_t pasid;
> > > +	int ret;
> > > +
> > > +	domain = iommu_get_domain_for_dev(dev);
> > > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > > +		return -EPERM;  
> > 
> > what about UNMANAGED?  
> 
> Why are we checking this anyhow?
> 
> Get the domain the DMA API is using and feed it to
> iommu_attach_device_pasid(). If the driver can't mirror the DMA API's
> domain onto the PASID then it will just fail the attach. A domain
> cannot even be NULL on x86.
makes sense,

Thanks,

Jacob
