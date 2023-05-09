Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031EB19900
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683664517; x=1715200517;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zDgUrx46HKYf2WDUcb3OSI439GIUg2nqyHSQb8R/LPM=;
  b=nD68BybdIjLNpuiq8tgOuHCTcDottfMKgtZ+yImSzbu4n2LVCIQe3vlW
   ZZay5VaYrKwGJynQwN83YB0/xmPBzHt1mdeQycE0UYs02wYyU0BjZlad0
   i5k+utyEXtgA0W0yc9YRP3ki8UZTc/cNmFkruIMjRNqPDQPU213pYcNts
   pSqrG9Rle3yOklduDPsIu5wiJt2vcI+wjaOr/8dDFiWcHGilMHlW/KEzd
   Aylk0rGcHOCQuDkb6fIO1KEwFuuygWkoQah308lSkkbvKeL9BdYdq/aTu
   Y7IYFRpYCCBIdX+8mnpOlSEQdU+IDLn04Y/Dda4xVQQOVeiSNvpL9MoIF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="334504620"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="334504620"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 13:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="702004029"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="702004029"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 13:35:15 -0700
Date: Tue, 9 May 2023 13:39:40 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>, Will
 Deacon <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Ranganathan, Narayan" <narayan.ranganathan@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 1/7] iommu: Generalize default PCIe requester ID
 PASID
Message-ID: <20230509133940.6bf0a053@jacob-builder>
In-Reply-To: <BN9PR11MB5276A1CC0B5FF8D9394F22F98C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
	<20230427174937.471668-2-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276FD027EC3D6BAA24046F58C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230428085615.58e437c9@jacob-builder>
	<BN9PR11MB5276A1CC0B5FF8D9394F22F98C729@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Fri, 5 May 2023 08:28:13 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > > >
> > > > By having a common RID_PASID, we can avoid conflicts between
> > > > different use cases in the generic code. e.g. SVA and DMA API with
> > > > PASIDs.  
> > >
> > > You intend it to be generic but in the end only vt-d driver is changed
> > > to use it in this series...  
> > change for SVA is in the patch.  
> 
> My point was that since it is common why there is no change in arm-smmu
> driver to use the common macro?
Got it, I will include changes to SSID 0 in smmu code.

Thanks,

Jacob
