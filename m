Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F6156C7
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683235385; x=1714771385;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Q0HgYS8fBg0x+XSACWujM6Ax818ZMRS1g2rWv1t5c0=;
  b=VbX4G0eValgis9ZvdBzJFmgw0r0HNm0dSU1hCX+ixa1JTquMN5fyeO3Y
   fSWtaxLr82+X97rpje5uFXyGxOpYTGVm7jWsTnRIEbmEnJ5+esfVVceg7
   EON9DrOYzaBXFwk9NlLSAPDbN+gyWAP4mJMQFb58keIuUHugu3FhB0HjD
   YACZ47Xtk8FIXFzVBLHHPS7bFDkxLHzR3rl9GJ7JgG3q6+16E0MtMSCpf
   6o+Fus84toCimHOJnHyqqGN8scyeVHJPHrD45lkDT8lwDis/WuYbQV1/I
   V3hahTScsD1Eq1tODm3NMtZ+29KhhB1zWdqptCP2EiSRpt9b3jDGwBtaE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="351187042"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="351187042"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="697233794"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="697233794"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:23:05 -0700
Date: Thu, 4 May 2023 14:27:27 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>, Will
 Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Ranganathan, Narayan" <narayan.ranganathan@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper
 function
Message-ID: <20230504142727.4bd2206a@jacob-builder>
In-Reply-To: <BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
	<20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Fri, 28 Apr 2023 09:47:45 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, April 28, 2023 1:50 AM
> > 
> > 
> > +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> > +					   struct intel_iommu *iommu,
> > +					   struct device *dev,
> > ioasid_t pasid) +{
> > +	int ret;
> > +
> > +	/* PASID table is mandatory for a PCI device in scalable mode.
> > */
> > +	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
> > +		return -EOPNOTSUPP;  
> 
> "&&" should be "||"
> 
good catch,

Thanks,

Jacob
