Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7064C70
	for <iommu@lists.linux.dev>; Mon, 20 May 2024 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716167853; cv=none; b=dT+q75A9oAlvIqiMLxLE49K/McXDSFT3UfNSAEI9eBuYtPqiS1wXjNanUnEs+c/zTA3V2WmgMM1JS8cglOCYCyDzgzLt5iKYlRhjDugPYmyDF92Woso9w3E0iU7VrU6+xbV4N6vWxO3UlFErGLORBtSQfxjFXaz80MUhBxoOY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716167853; c=relaxed/simple;
	bh=OBsVYV9d4GvPqYKGWaHDECvr5gkFQ/7IA+nKs2nXEZ8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=apNQ+xRKtVm56rbAKlTzT0r/ADDeRLLBSgDIV83C5aLWE0Z7g2vlAhOhhQjMPS5nXPhMQqOOVY9gzxj27S+l0GsbQVZmGf+6TMl+efi+HWNRIHbhV6c2zEQsfYcNUQP8gC/Bw4gMbX2tUOO6PitsK1LzJW4TECChFlaZ2liVJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7Nn/q5S; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7Nn/q5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716167852; x=1747703852;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OBsVYV9d4GvPqYKGWaHDECvr5gkFQ/7IA+nKs2nXEZ8=;
  b=f7Nn/q5STYIeQDuIiAHktoKwkcdZejOD40tTK4Lv1Efqb8Xj5jwh46Yl
   2vpPg+KYcVC9k076pUH9XNI2OOml4yJJl7Ibkn7fhPaq8vQBoQCOoJTLF
   WnRqIdsaITkjfjlhjyyWRzkQv6XiMA/NG/hgnXeqhheiXg19iNPpf6fiq
   nkbqj8fSNE8EkK0pF1Q/8YO5v506JNivpN+5Mhtygd0G8ipqS0OsA7TgD
   rGtdKe1cIXo4f9MrpR0R+SwU9yR+foBXURReFL9q3Ipmzu+RE6I7frP0D
   /EkIIjdg74ssgQ/IWPcWvMH77USwYZmZjTOxQloBJKKxgP5msHR9FFrOY
   g==;
X-CSE-ConnectionGUID: 8oLNxg6gSEKS7k7rgr4OYA==
X-CSE-MsgGUID: kCJqR6/aQOiMXsBdLLSAlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12398677"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12398677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:17:31 -0700
X-CSE-ConnectionGUID: ZxRdiSnpQ7+C2n7WWTY8JA==
X-CSE-MsgGUID: TEqOrygfTx+PwakUljXaig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="69805798"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 19 May 2024 18:17:26 -0700
Message-ID: <2dbfb49b-3d2e-4a3b-ad1b-e53062edbbd4@linux.intel.com>
Date: Mon, 20 May 2024 09:15:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:37 PM, Tian, Kevin wrote:
>> @@ -395,6 +396,8 @@ struct iommufd_device {
>>   	/* always the physical device */
>>   	struct device *dev;
>>   	bool enforce_cache_coherency;
>> +	/* outstanding faults awaiting response indexed by fault group id */
>> +	struct xarray faults;
> this...
> 
>> +struct iommufd_fault {
>> +	struct iommufd_object obj;
>> +	struct iommufd_ctx *ictx;
>> +	struct file *filep;
>> +
>> +	/* The lists of outstanding faults protected by below mutex. */
>> +	struct mutex mutex;
>> +	struct list_head deliver;
>> +	struct list_head response;
> ...and here worth a discussion.
> 
> First the response list is not used. If continuing the choice of queueing
> faults per device it should be removed.

You are right. I have removed the response list in the new version.

> 
> But I wonder whether it makes more sense to keep this response
> queue per fault object. sounds simpler to me.
> 
> Also it's unclear why we need the response message to carry the
> same info as the request while only id/code/cookie are used.
> 
> +struct iommu_hwpt_page_response {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 code;
> +	__u32 cookie;
> +	__u32 reserved;
> +};
> 
> If we keep the response queue in the fault object, the response message
> only needs to carry size/flags/code/cookie and cookie can identify the
> pending message uniquely in the response queue.

It seems fine from the code's point of view. Let's wait and see whether
there are any concerns from the uAPI's perspective.

Best regards,
baolu
