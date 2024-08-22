Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882479C8
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291681; cv=none; b=qQUcSUt6vdyE2CQNZchEBxkcITgHGhABqYs+kOQmNlq8eD51P6lGxvQ9MnkjzdwSqlChz0VkOeXXY/ta36klRVHxwIqmd26GL72aQqnk+aFFOeZVl6GSohi8ewu+XZji4t4oQX4o7Ug+mMNahky4QwEN69ap7MAeA8hzmYDNSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291681; c=relaxed/simple;
	bh=D1l5aNHb/dywsZOGglo+w/XkAhuUtNNSGsx0bvu7NDc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lsG5fv82ASIrAjwuTdQw5fj9HjXtj3Ydo5sSormbxNIQq7OYltfjc0SSRbAHkvFnUKndMbmwnAnSOi+XRRftT582U6lUU90c4Yk6tCizi67QhFs/17aae2bOgSYIFXpiLFzabezQcYYXP8HmL1+soNMnLDVt7SIrsmuXqrE6r40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWUZN6HR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWUZN6HR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724291681; x=1755827681;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D1l5aNHb/dywsZOGglo+w/XkAhuUtNNSGsx0bvu7NDc=;
  b=lWUZN6HRh6MrCGjPmoSf2YD2BgQ/+CMEWY9lhJO6zIsckN6ChziQjmlu
   rHUpy8FNcluKiiMt9Fq6jCsbhbD69kZTHaYXE+fT6j0b/CbIV+WLJoqdt
   MvlDdBisH8+FIH5KH8shz8elf3mWSA+KYdIQIo89/FC4qgr5FN+SW47P4
   NH6ISaW9BxwpbS0XjJuvTq3ahkXbWmTNIQOlzxjpZglan6kqWQwPIZDb4
   sk4MI33jd+i8fYRzlkM8zsuGLvr7SKq8Q/RE5rgdzYAm12LZnTyLVNkDr
   eKULg38hfhfPl/dbj3Jhy6TOdAE8+TI/6nUAVaejcoeBjJkIcqxql4vOD
   g==;
X-CSE-ConnectionGUID: lqaNLkknQO+1Cu1fcmy7Xw==
X-CSE-MsgGUID: cdMuLglVTQWaZ67joWLURw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22818038"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22818038"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:54:40 -0700
X-CSE-ConnectionGUID: p235hYkYR+eCnIGOjWq/FQ==
X-CSE-MsgGUID: LOEw1bZxTJ+03ubf1hnOXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="84451837"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2024 18:54:37 -0700
Message-ID: <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
Date: Thu, 22 Aug 2024 09:50:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 yi.l.liu@intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240821163147.GZ3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 12:31 AM, Jason Gunthorpe wrote:
>>    I think instead of having separate function it may be better to
>>    enhance __iommu_domain_alloc() such that:
>>      - Keep below changes from this patch
>>        - iommu_domain_init()
>>        - iommu_get_dma_cookie call inside iommu_setup_default_domain()
>>      - modify __iommu_domain_alloc() to additional param (flags)
>>      - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()
> My expectation was to basically remove iommu_domain_alloc() entirely
> once Lu's work is merged.
> 
> Instead we'd have these direct APIs:
>    iommu_domain_alloc_paging_flags()

Is it possible to use different domain allocation APIs for kernel DMA
and user-space DMA? Right now, we differentiate between these two types
of domains using IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED.

I'm thinking about this because the Intel iommu driver has a similar
need to AMD. They both recommend using different page table formats for
IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED, which is currently stopping
us from implementing domain_alloc_paging in the Intel iommu driver.

Thanks,
baolu
