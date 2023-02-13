Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFC290B
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315294; x=1707851294;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rEZn1HNF1pwFcnYLItVTRWNXypbJQGpnhpvtfKy2o20=;
  b=bDHLB+8c26PXdsNNE6ygOorrLGWukIHlna3nMPs9jjgbRAkEq/hCsj1L
   rifc4yFhaakyA6f5wwT6O49Rp5TbDpwSk0yuiq3Zhu08ngv7hix0iaATy
   cnSsYZTF06f/6epx8yd1thuaFXJS0aml/C41ajLl+oPTnnVtw6tbVYq2v
   bc33SXA8EX3L49URergh9zB+C7fY9i//sHLi/6yZWkFnI96GrIhdoO5IO
   rT4S6mR89LxPbVEKkPyklei5bhSbqQhnIj8MYpdsDJVgHf1+KVFTP/nyr
   1HNL3eIeiHSuitN4obdBOXnEB7dYAlTdv5tZ7f0LbDmOzhIzNQZtluBpS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328682751"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328682751"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="646489422"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="646489422"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:12 -0800
Date: Mon, 13 Feb 2023 11:11:52 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, LKML
 <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <20230213111152.5ecf734b@jacob-builder>
In-Reply-To: <Y+pkL5b6mGv40nZy@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
	<20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
	<Y+pjTR80bnl9rMK1@myrica>
	<Y+pkL5b6mGv40nZy@nvidia.com>
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

On Mon, 13 Feb 2023 12:24:15 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > We could also merge ioasid.c into iommu-sva.c at this point, since I
> > haven't seen any interest for having multiple IOASID sets on Arm, but
> > I'm not sure what the current plan is for vSVA on x86.  
> 
> Once the customer allocator is removed this is bascially a thin
> wrapper around xarray
> 
> So anything that needs multiple pasid spaces should just create it on
> its own directly with xarray
> 
Just wanted to double check that for devices on VT-d platforms that support
both SVA and DMA API with PASID, we will still need a single global pasid
space (due to IOTLB tagging). So this is not the "multiple pasid spaces"
case here, right?

As I replied to Jean as well, we could use the ioasid_set to separate SVA
and DMA API PASIDs.

Thanks,

Jacob
