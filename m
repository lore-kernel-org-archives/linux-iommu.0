Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40764A
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675964394; x=1707500394;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+cpCRNK3m2eAdE04EZsrrPRCT4Hr8oF27Jp5Ga1PTms=;
  b=CmoBfpuxxp+wJxdYw8K4mZg2hyfy2boSvVYE6TCgnVj6s9ohxtNz5Jbf
   dnecPPYOY7zRUJx+a2ATPKGMNDuPVKQIHeUQ/YrRNfY9r7264POMZ0o/h
   B/79xowvZu44ce04NbBHXb+78OtWhHbOQat3ShmpquFOdnoxF3PDhaPln
   Tr2LQ1tJYscnUj6CnZzit7keHTAv92qLpuUDUXYUoUgTmV5Bf0gvSrs/h
   d8QsjO/FzJxSuK/rmCgrIH1NMeTOR2qR+DPIHnNeOwaaepAGvFasGJwd8
   N4u5rnfz2vrLFQ0EfBLI+24EATKlW538CqDJIoGU+ZvP9P+S0RuvdT3/Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328821814"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="328821814"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:39:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="736439370"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="736439370"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:39:52 -0800
Date: Thu, 9 Feb 2023 09:43:30 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Ghorai, Sukumar"
 <sukumar.ghorai@intel.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Avoid superfluous IOTLB tracking in lazy
 mode
Message-ID: <20230209094330.12a94139@jacob-builder>
In-Reply-To: <BN9PR11MB5276A911FAAE4C2F6B670E638CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230208181834.1601211-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276A911FAAE4C2F6B670E638CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 9 Feb 2023 02:09:47 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, February 9, 2023 2:19 AM
> > 
> > -	iommu_iotlb_gather_add_page(domain, gather, iova, size);
> > +	/*
> > +	 * We do not use page-selective IOTLB invalidation in flush
> > queue,
> > +	 * There is no need to track page and sync iotlb.
> > Domain-selective or  
> 
> "in flush queue, so there is ..."
> 
> > +	 * PASID-selective validation are used in the flush queue.  
> 
> the last sentence can be removed. same meaning as the first one.
> 
sounds good.
> > +	 */
> > +	if (!iommu_iotlb_gather_queued(gather))
> > +		iommu_iotlb_gather_add_page(domain, gather, iova,
> > size); 
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 


Thanks,

Jacob
