Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48A156C7
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683235332; x=1714771332;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yoXBNYJ/UPota7gNEgZ5BSyK4zH3Zyhjtbi1BVTh/7U=;
  b=XdzcH32A1kZXyg/+XfaueGdqR6OqvZ0qsWyWHFHdEhExpfa4UjSUyKgZ
   Rr85DWO5hLok9BcX9YOqxOq+WfbQ+Z9O5d3rqEdVbTf7QjE4iPfEbC5c9
   xuS9eTwfNaBR2PzKFcidudgw/7nvOyoWEXzEvyytg35P45qWO1K3/hO1g
   mqH5Vo++CXWFakyK7SxBPAjLx+7oxcx+eUKQkckTX9WdTa6iFJH5KSn3+
   tOORcAR2XnoFs0b2CgYHqw0Ngg/eIcKQm3FNJU2u/zmo56BLfK6Yuiiw9
   PLSQ15kSeRonr8yS4V4ltkBxe40Nx4/DJPb311guiRvV6yOgQOG65oVlo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435378033"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="435378033"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="762115908"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="762115908"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:22:10 -0700
Date: Thu, 4 May 2023 14:26:33 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon
 <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>, "Zanussi, Tom"
 <tom.zanussi@intel.com>, narayan.ranganathan@intel.com,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 3/7] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230504142633.1a7e78ae@jacob-builder>
In-Reply-To: <db3be8a2-6520-9652-6bee-dbceb320cfc2@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
	<20230427174937.471668-4-jacob.jun.pan@linux.intel.com>
	<db3be8a2-6520-9652-6bee-dbceb320cfc2@linux.intel.com>
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

Hi Baolu,

On Wed, 3 May 2023 14:32:15 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/28/23 1:49 AM, Jacob Pan wrote:
> > +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > +{
> > +	int ret;
> > +	ioasid_t max;
> > +
> > +	max = dev_iommu_get_max_pasids(dev);  
> 
> Perhaps you can use dev->iommu->max_pasids. It's static, so no need to
> recalculate it.
> 
sounds good!


Thanks,

Jacob
