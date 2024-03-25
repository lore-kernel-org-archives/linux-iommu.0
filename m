Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A415ECE6
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339091; cv=none; b=ZBPSE56v/IWBeXYxHmBBCqfjD5AqMa38UQ6BVikBeGgs4dgw6DFxp50KHILixuP41XRbKL/eNIn6zcZJUQQDjS5ld6Y+vGA9zF77UlALRu2vZBsZDIukUFzjw3LkgXb/E5qHS9yI1Q8hKS4jnDHoBIIBPZp8nKaaRWOehLEAOTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339091; c=relaxed/simple;
	bh=qmHtWDM22Y7Pif9OF/b0d7AyT0SLY8IGS1SO0qYxiss=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O7VloOFY09XTYr/xaAgw0N/7bLxi/7Y0g7O1CrLfRECqxOTgJpHcDAzVmjKNdscrFgf3629ZX0tPmJgXEfLx/Lu+35W9QBMv9azFBaYgaUgs+fFYoDw0Fkv+KtdbPxASaADwuGjqe8RIQsKi2mGcBnjw7b+XEnOc2rsBc1Laefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpJhwLuE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpJhwLuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711339091; x=1742875091;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmHtWDM22Y7Pif9OF/b0d7AyT0SLY8IGS1SO0qYxiss=;
  b=lpJhwLuED+fsrmi6IMPQ0Gu888IQmOiwPE8KaHkk87vlNXsP0m7zSgxs
   0RvOMTGRVljqLukieEVMRxMRQ7fLdxPSn97WSnYxRxYZEENWCWddl8R10
   XQM1jJeJWDeH/UNMUL+4pbRGDwwT+l2324kZpuiEal9SECX2kl8iYTb+s
   f71CRhZP8GQxE4hjNjAnlKI8OBEivUzDX3QOfFrjWJhFICMDJwtBYuUj1
   CJMY4aGfuVIjfeCKFvY1DdOVHI8Kw7fO0zl8YnHzDIemaarPsjtR8gzK+
   LtTVlyhwSu/1qUGD9uf7860pu/VuuIlMBkorYEPZtRFagCVcDQzw5d/Ud
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10094410"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10094410"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="16147457"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 24 Mar 2024 20:58:06 -0700
Message-ID: <2ddd01fb-ec7d-4a7e-984b-31da78211f91@linux.intel.com>
Date: Mon, 25 Mar 2024 11:57:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
 <20240308175007.GW9225@ziepe.ca>
 <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>
 <20240322170410.GH66976@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322170410.GH66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/24 1:04 AM, Jason Gunthorpe wrote:
>>>> +struct iommu_hwpt_pgfault {
>>>> +	__u32 size;
>>>> +	__u32 flags;
>>>> +	__u32 dev_id;
>>>> +	__u32 pasid;
>>>> +	__u32 grpid;
>>>> +	__u32 perm;
>>>> +	__u64 addr;
>>>> +};
>>> Do we need an addr + size here? I've seen a few things where I wonder
>>> if that might become an enhancment someday.
>> I am not sure. The page size is not part of ATS/PRI. Can you please
>> elaborate a bit about how the size could be used? Perhaps I
>> misunderstood here?
> size would be an advice how much data the requestor is expecting to
> fetch. Eg of the PRI initiator knows it is going to do a 10MB transfer
> it could fill in 10MB and the OS could pre-fault in 10MB of IOVA.
> 
> It is not in the spec, it may never be in the spec, but it seems like
> it would be good to consider it, at least make sure we have
> compatability to add it later.

Thanks for the explanation. It sounds reasonable. I will take it and add
some comments to explain the motivation as you described above.

Best regards,
baolu
