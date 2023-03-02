Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F08C11
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677776051; x=1709312051;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwsJhH9kOHV7GD3CBh4CQOdjsIKuVme3C7GZneWT9P4=;
  b=E4G5OPGPogJUwF77piNy9DrmVR+Pilthmi9p/hCaSnZsP0kUrGSRGFGW
   l0sPnVJ/LfvLMqi5xqml02OAbddRYqCU7BzZqaxvlYY0ylezw3xziMU9a
   TsHhc94XDfg9Z7n+QJCv3mMqoIaCJ+qzMY29vLhlw+Ryh/RDZp1Pepq5c
   mumAoQzpTN0tr6rkfyjgWX9p94gAr0fDZpbualvGSLiF8mVuxN24Tw3//
   NxFQMYsDcgHEoFa6yRV7S8Bh6PoqB97JESeq4ONeyDaFlG6dNap5PcFed
   Otx6RP6iuwYsvgyZqCiURJl6Q0Su97n8BRsB6NaTZB6koxq6xbzQKgtcC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="314438155"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="314438155"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="625014743"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="625014743"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:54:01 -0800
Date: Thu, 2 Mar 2023 08:57:51 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.com>, "Hansen, Dave"
 <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, X86 Kernel
 <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "David Woodhouse"
 <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230302085751.1e7f02bd@jacob-builder>
In-Reply-To: <BN9PR11MB52769D24FF395C1D42F33E2A8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
	<20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB52769D24FF395C1D42F33E2A8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 2 Mar 2023 08:58:21 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 7:57 AM
> > 
> > 
> > -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> > +	if (min == IOMMU_PASID_INVALID || max ==
> > IOMMU_PASID_INVALID ||
> >  	    min == 0 || max < min)
> >  		return -EINVAL;
> >   
> 
> if (!pasid_valid(min) || !pasid_valid(max) || ...)
> 
will do
> with that,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 


Thanks,

Jacob
