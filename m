Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C52A935
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680557761; x=1712093761;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k67qiSJzMqb6GJ9f62wxYrHLBFePY+0rcdIS9x9sYq0=;
  b=k4ojyT25PUOu9pbUdPQb1uxAG19WiME+JNvkxrIZYIw30SX6ZsRK/At9
   hGu21UPznW1NWPtQAi2wDiGHWof09u+pEfcdfpbXwr3UZVBagIXIvjoop
   F/SyLRenMnoEj01fEEhT9G5n4yIUxyhKDzeSGMRFtDx7iXOGzX+1INeuI
   I1kgLFohia+sjfpdGni5StFyVHSRdfozeDstoEu+nvLKDcxlqay3W3EV3
   u8vhLlETLTePW7zEY3XeJu394VF1PwiJls4zQ8BuL/rqbyT9rSm3ve1xv
   wFvdbfJJ2br8VAxxUACvMnVzw19fReIiqNxdd3igyb7XGW0jq8NCGjUKN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="340751495"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="340751495"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688640235"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="688640235"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:35:59 -0700
Date: Mon, 3 Apr 2023 14:40:05 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon
 <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>, "Zanussi, Tom"
 <tom.zanussi@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Reserve RID_PASID from global PASID
 space
Message-ID: <20230403144005.71d63a9d@jacob-builder>
In-Reply-To: <13bf4050-7563-798a-1776-dd6c948bc1f8@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
	<20230331231137.1947675-5-jacob.jun.pan@linux.intel.com>
	<13bf4050-7563-798a-1776-dd6c948bc1f8@linux.intel.com>
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

On Sat, 1 Apr 2023 21:43:13 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2023/4/1 7:11, Jacob Pan wrote:
> > On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> > should not treat RID_PASID special instead let it be allocated from the
> > global PASID number space. Non-zero value can be used in RID_PASID on
> > Intel VT-d.
> > 
> > For ARM, AMD and others that _always_ use 0 as RID_PASID, there is no
> > impact in that SVA PASID allocation base is 1.
> > 
> > With this change, devices do both DMA with PASID and SVA will not worry
> > about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 9f737ef55463..cbb2670f88ca 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
> >   
> >   	intel_iommu_enabled = 1;
> >   
> > +	/* Reserved RID_PASID from the global namespace for legacy DMA
> > */
> > +	WARN_ON(iommu_alloc_global_pasid(PASID_RID2PASID,
> > PASID_RID2PASID) !=
> > +		PASID_RID2PASID);  
> 
> This looks odd. With the previous patch unchanged,
> iommu_alloc_global_pasid() will always return IOMMU_PASID_INVALID if
> CONFIG_IOMMU_SVA is not set.
right, will move out of CONFIG_IOMMU_SVA. good point!

Thanks,

Jacob
