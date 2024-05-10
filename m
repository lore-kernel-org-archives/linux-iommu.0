Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771CA13BC14
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311535; cv=none; b=BTI6LzgvcK5iQfBfe0lDHhKorrNsaU/mIpLM1IacTHALHscKTiTPIOYgfKf9eebmnvYRr/e4WiJvLYHXTZOM8esQ+StGm3aDLvlRKieOgEVBm/S43x/sMsJf0llKRr/yBtdVkZtpIlw28ViRmwD6OsV/hnHPW7oSHq0MS1yttP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311535; c=relaxed/simple;
	bh=+60/R6ZelmCn2D21Wc5U/v/CxzPMEwJYHz3a+CsKrH0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HM/qn32QZJLsL63Xs2qrqg2kqNHghQ3TlrKFNK462iaCjoJjEtRk50GpnUekCZbR5wfbXlKC1LMtxXxEu/iqVH3UeUx1ZC5FVfBzwRXkUVQTDNgrr2SxxV2veEfb08YA21xCAyMOh3YfdWwjIwCXY92ZY+A7UkOEpK9aHkyYASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0DLyvda; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0DLyvda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715311533; x=1746847533;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+60/R6ZelmCn2D21Wc5U/v/CxzPMEwJYHz3a+CsKrH0=;
  b=P0DLyvdaWHmnUz18kcZymcrjW3y6yekJ9mxMw/Y6f96r+/2hwiuLyAV1
   lrheaQRsgN8IBjdqqI3fHC84x+XpGVX4UzwazhN/s+0q2TSaV1nRz78J4
   YvX3jH3IyBPe8bVsj1iU/tW4VkdfbjIWWUDNQcBruryyFWgFY8qTLUiqM
   DJ5mr/RkZVA4OvshJjqjCg+VN2aApRbwrdjnfISgl0Txdyr0J5X1GfGk3
   ZUHrpoIJ/5IyZ4KYiuLwca7MUvq3Q4xN/XPRXxd9AW1efszuBmbsfCedh
   e45TvhmR/LTDiQHdxukrXXTUcs8DmSjNumoHcZ592T0qYfgfEn534hSg0
   Q==;
X-CSE-ConnectionGUID: EqxIaVrkQk+lxvUPbSS31w==
X-CSE-MsgGUID: zYR7tl9qR9uCiP1MFCnAog==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11439976"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11439976"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:25:33 -0700
X-CSE-ConnectionGUID: 4+6y3HM2QO+Ic3I0KZ0M1Q==
X-CSE-MsgGUID: cZN55lAqTSaJNzDeu+BCvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="66919206"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 09 May 2024 20:25:29 -0700
Message-ID: <134825df-bbf7-4666-b4e7-cbadf9c2b27e@linux.intel.com>
Date: Fri, 10 May 2024 11:23:49 +0800
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
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <20240508002508.GQ4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508002508.GQ4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 8:25 AM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:08PM +0800, Lu Baolu wrote:
>>   /**
>> @@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
>>    * @data_type: One of enum iommu_hwpt_data_type
>>    * @data_len: Length of the type specific data
>>    * @data_uptr: User pointer to the type specific data
>> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
>> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>> + * @__reserved2: Padding to 64-bit alignment. Must be 0.
>>    *
>>    * Explicitly allocate a hardware page table object. This is the same object
>>    * type that is returned by iommufd_device_attach() and represents the
>> @@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
>>   	__u32 data_type;
>>   	__u32 data_len;
>>   	__aligned_u64 data_uptr;
>> +	__u32 fault_id;
>> +	__u32 __reserved2;
>>   };
>>   #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
> [..]
> 
>> @@ -359,7 +359,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>   	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
>>   		 __reserved),
>>   	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
>> -		 __reserved),
>> +		 __reserved2),
> This is now how the back compat mechanism works. The value here is the
> absolute minimum size, it should never increase. The first __reserved
> is always the right value.
> 
> If you change it then old userspace that doesn't include the fault_id
> will stop working.

Yeah! I will remove this change.

Best regards,
baolu
