Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578863D74
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680024099; x=1711560099;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0TfcPjksoLAS4Lgr8pbWYVIORpk7kQ3431tuOunQDOM=;
  b=iAMYvNhlWE30CVCmqyNQ8G7nQtKdp63GdStyPHb+sSK8tDwVI/jwgJ0j
   yK8zMewpKVc1GYSRBZQspCDXiAkLqBn2Fsv9y+0XrP3YAzFW3ByS1FPM2
   Wk8k1vV8sDPbcEqi0dwN27wL4AxAkG1fGwK6nMpy4kyFLYwgB447hFYwp
   JtGRDE442QBE/7NMps2kozcHkFMHF74gkJLevOdiwfkvtlHbDJJVWbKnI
   2uB0wTz9FHvdN4TYgZELzQO7fPc1HFG09JMwiasxqI5jSG25rG18kn3Q4
   Q+1rmbRCDm2Yugw2w5jmDjJXTAJtbMGa5iyJZQj0UMgxL8GjQ4tjwJaex
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320288996"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="320288996"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714333438"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="714333438"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:21:36 -0700
Date: Tue, 28 Mar 2023 10:25:40 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Message-ID: <20230328102540.6158e642@jacob-builder>
In-Reply-To: <ZCMTf5RwebmELsoT@nvidia.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
	<e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
	<BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230328084822.4b46e649@jacob-builder>
	<ZCMTf5RwebmELsoT@nvidia.com>
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

On Tue, 28 Mar 2023 13:19:11 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 28, 2023 at 08:48:22AM -0700, Jacob Pan wrote:
> 
> > > Agree. The kernel driver managing the device wants to get the current 
> > > domain of the device then iommu_get_domain_for_dev() is the right
> > > interface. It knows the domain is the dma domain.  
> > This goes back to v1 then :)
> > 
> > I thought the comments from v1 is that we don't want to check the domain
> > type is DMA domain returned by iommu_get_domain_for_dev()
> > 
> > If the driver "knows" the domain is dma domain, why can't it use
> > iommu_get_dma_domain()? seems paradoxical.  
> 
> Huh?
> 
> The DMA API operates on the current domain of the device, be it
> IDENTITY or UNMANAGED.
> 
> You have to copy whatever the current domain is to the PASID and you
> should definately not check if it is DMA or something.
> 
right, the PASID works for IOVA, passthrough. I misunderstood the v1
review comments. I will go back to use iommu_get_domain_for_dev() but w/o
checking domain types.

Thanks all,

Jacob
