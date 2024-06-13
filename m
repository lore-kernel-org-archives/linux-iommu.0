Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AD132804
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254600; cv=none; b=eUSizenpcCcJt41anT0Ed+MMgCzbNzdy0gncA1bWZRTLaIzQ7YvrcmlS/chqkmlZLdx2I04SgEIbgNmoA7Z6sNtHaCXNno6gO5lrpxxC/Qg0dCoswuEUI84+DHcPHIS8BdJ78Qi/le39qHVrYYr6M/NozGGZqNCGQS8JsWgLYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254600; c=relaxed/simple;
	bh=iK1p+Q+knm8MizqNtiUBP6wYZDPbo3vXshptVmdVlII=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O0niUvXorSyz/FUtjKi0pbwvr9QIKxiEZT3bNLDOvXoPK5/TvDqsjgQTFITvzuc4AxvVlHcRcKiINclpEwzYe4agm8OEfJpyWaEORIPNC38pg5hcN/ELyYQUe0aK8dG6BhxLsH1kQLB9l4DRBFqSue4msYmgVWgUDlHZsFhiGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLFcGBSN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLFcGBSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718254599; x=1749790599;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iK1p+Q+knm8MizqNtiUBP6wYZDPbo3vXshptVmdVlII=;
  b=gLFcGBSNPUT2balpF2hCzYjfrr4c0tHj1QrZjxoeUu3rdVGxuSUpA1ro
   btIeiEKTYTnb2acs/PnsCkjwP9ZRpgin5ELGw2oc6RCQeWxPccarYQKIB
   tqL6NHL/lvOsHjzXghOtrNPqlioPclgCRPS3MRxBrJAjYI6fFhwJNyn04
   7buXX99CW7lEi0Ezb+kqFumdtP5lx5ksBbVGKLpqocOjaCNKVPSqtwORK
   DESTNA4DClkko6TX6fWloO3NOELvcDDKw5ho9n68sTPTWLFjKYqh389h3
   Hp5qgQ+6pLlMBxifZdJs1MAxMHkTDJUIa5Z6J109H9banVUkQmprKah7H
   A==;
X-CSE-ConnectionGUID: Y1cv9XnqSuqX0ian1gSDlw==
X-CSE-MsgGUID: Q5MqHgKCS0WTHNPLYJ7S3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25689773"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25689773"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:56:38 -0700
X-CSE-ConnectionGUID: wTJ39ElpRuCl6fhbamiwjg==
X-CSE-MsgGUID: KZQcRNa9REyHMABay2tsYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40652741"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2024 21:56:35 -0700
Message-ID: <c1c689b7-84fd-4aec-83fb-2fb4244472e0@linux.intel.com>
Date: Thu, 13 Jun 2024 12:54:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612131946.GT791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612131946.GT791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:19 PM, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2024 at 09:38:38AM +0000, Tian, Kevin wrote:
>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>> Sent: Thursday, June 6, 2024 2:28 PM
>>>
>>> On 6/5/24 4:28 PM, Tian, Kevin wrote:
>>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>>> Sent: Monday, May 27, 2024 12:05 PM
>>>>>
>>>>> +
>>>>> +/**
>>>>> + * struct iommu_hwpt_page_response - IOMMU page fault response
>>>>> + * @size: sizeof(struct iommu_hwpt_page_response)
>>>>> + * @flags: Must be set to 0
>>>>> + * @dev_id: device ID of target device for the response
>>>>> + * @pasid: Process Address Space ID
>>>>> + * @grpid: Page Request Group Index
>>>>> + * @code: One of response code in enum
>>> iommufd_page_response_code.
>>>>> + * @cookie: The kernel-managed cookie reported in the fault message.
>>>>> + */
>>>>> +struct iommu_hwpt_page_response {
>>>>> +	__u32 size;
>>>>> +	__u32 flags;
>>>>> +	__u32 dev_id;
>>>>> +	__u32 pasid;
>>>>> +	__u32 grpid;
>>>>> +	__u32 code;
>>>>> +	__u32 cookie;
>>>>> +	__u32 reserved;
>>>>> +};
>>>> with the response queue per fault object we don't need all fields here,
>>>> e.g. dev_id, pasid, etc. Cookie is sufficient.
> Wait, why did we make it per object? The fault FD is supposed to be
> sharable across HWPTs.

The fault FD is shareable across HWPTs. Kevin was suggesting that the
response queue (for all outstanding IOPFs awaiting responses) could be
put in the fault structure.

Best regards,
baolu
