Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D32C1FA1
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677861085; x=1709397085;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/kvVu8XIUvkR96Nr+xnjCp5r6slkD+5sLn+iA7nJBw=;
  b=ZtDNe4Pr92JvV+KuJl4jhtnV+GuxrYsPi4B167BH92ZIrFpFHK+pnjLp
   wIqnhBAR/fofASrbkhCjpLm2nGU++tzMuxfNh2osvTHVMCibKU6PoMGL1
   3InU939utbuolxpRjE88SR/TXzM0pFAAU5TEEz4IZ7P/dRN/rBo05PKzw
   44BJJn34tmjJWkZzlwb8X5k5mw6/aT6v9DOptVdWQuiwzfcb4mRbVK7XA
   Q2QWvgpjltSQhU1wc2b6W+yUfIfvmAXQYFtB+YFW4wokjYwheB7nfGPpf
   N6D8iuVT5460+odGSFsnjn+tiGp/X4/Euj5Kcrcxtu23WVvNz+UUiTcEj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="323379971"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="323379971"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 08:31:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="785315906"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="785315906"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 08:31:23 -0800
Date: Fri, 3 Mar 2023 08:35:12 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230303083512.663ce758@jacob-builder>
In-Reply-To: <BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
	<fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
	<BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Fri, 3 Mar 2023 05:38:19 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, March 2, 2023 10:07 PM
> >   
> > > +
> > > +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> > > +		ret = intel_pasid_setup_pass_through(iommu,
> > > dmar_domain,
> > > +						     dev, pasid);
> > > +	else if (dmar_domain->use_first_level)
> > > +		ret = domain_setup_first_level(iommu, dmar_domain,
> > > +					       dev, pasid);
> > > +	else
> > > +		ret = intel_pasid_setup_second_level(iommu,
> > > dmar_domain,
> > > +						     dev, pasid);
> > > +
> > > +	return ret;
> > > +}  
> > 
> > Do you need to consider pasid cache invalidation?
> >   
> 
> To avoid confusion this is not about invalidation of pasid cache itself
> which should be covered by above setup functions already.
> 
> Here actually means per-PASID invalidation in iotlb and devtlb. Today
> only RID is tracked per domain for invalidation. it needs extension to
> walk attached pasid too.

Yes, will add.

For the set up path, there is no need to flush IOTLBs,  because we're going
from non present to present.

On the remove path, IOTLB flush should be covered when device driver
calls iommu_detach_device_pasid(). Covered with this patch.


Thanks,

Jacob
