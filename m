Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C739FEF
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655393; cv=none; b=m16Y4NzkYfCBqTPJKjnxjNIHeK5gi/i4SpDquTF9AW+pQ4HSvVCduoMhPzWQks5Gz1dWtmGLR1eRlbga1HKpaO094+Uh1hHmPRYzWFbUvTogWNTSeXtPeLLGo/eXxo/R+bJTL7ogzN9WlYn/XqURY5Np/9KKDJJNuYhMniqkQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655393; c=relaxed/simple;
	bh=O27iO+wy7mzIj32SyajX2niEXAj8Sxq6fC5HgmpcLk0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XjUp907FLWbxmAYJRnwVUzmuMtEIniG4ggzh2gIbPxE9nyNNioZ0jBnm85Sc5M07L3evW7de08m4ShJFHGndG6DxrKwq89V8Z3TNIrgdGyDDH+1SWap0U5uTu0XFi4uXXJXL84ECUZfkc1eMEzguuX0M70nkKajuSUhwbTA0AB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M61Lga4T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M61Lga4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717655392; x=1749191392;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O27iO+wy7mzIj32SyajX2niEXAj8Sxq6fC5HgmpcLk0=;
  b=M61Lga4TXza7yaIE9f/GudJqC5b4EhjTnkSCOgd8/Gxo4g5K8vZluZ4Q
   pREkVw4Se1rQ8VLsfKAZkt9A2gOlVHavu1wXsFps3//INcRFX16P6msBB
   uxMBdvP/R5M9we8b5m84oYVH5gXZnP92uFB6doUA1TEQbYXktHsb+rlmj
   Bd5rEWW3+uhaw7gjpomsWowJmv+223sSuTx+bHixD/RhmgJP9Obeeml0F
   g8BCYtzZRbCOMNzzp6hWBPyWQ7Ml9iXE8uyMA2spotudjqY/DwQspW0fV
   Ifv20ucGJLvSal+9OL7fk3F0MlPYvx9grK5qriiLvWRy8h6rsKgOyggWd
   A==;
X-CSE-ConnectionGUID: j3uHwwwPTLeBtMMKEmntyQ==
X-CSE-MsgGUID: tlrnG344QLm1zkPa10tqOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25707943"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="25707943"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 23:29:51 -0700
X-CSE-ConnectionGUID: v9Cu+/S3SPeBJgzh0+M12A==
X-CSE-MsgGUID: DwOXGjBlShunYlNvt+UtqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="38527016"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 05 Jun 2024 23:29:47 -0700
Message-ID: <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
Date: Thu, 6 Jun 2024 14:27:37 +0800
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
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 4:28 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> +
>> +/**
>> + * struct iommu_hwpt_page_response - IOMMU page fault response
>> + * @size: sizeof(struct iommu_hwpt_page_response)
>> + * @flags: Must be set to 0
>> + * @dev_id: device ID of target device for the response
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @code: One of response code in enum iommufd_page_response_code.
>> + * @cookie: The kernel-managed cookie reported in the fault message.
>> + */
>> +struct iommu_hwpt_page_response {
>> +	__u32 size;
>> +	__u32 flags;
>> +	__u32 dev_id;
>> +	__u32 pasid;
>> +	__u32 grpid;
>> +	__u32 code;
>> +	__u32 cookie;
>> +	__u32 reserved;
>> +};
> 
> with the response queue per fault object we don't need all fields here,
> e.g. dev_id, pasid, etc. Cookie is sufficient.

I prefer not to mess the definition of user API data and the kernel
driver implementation. The kernel driver may change in the future, but
the user API will remain stable for a long time.

I am neutral about whether we could remove above fields, but I need all
maintainers to agree on this, given that this has undergone five rounds
of review. :-)

Best regards,
baolu
