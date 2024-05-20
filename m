Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC211CBD
	for <iommu@lists.linux.dev>; Mon, 20 May 2024 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716177467; cv=none; b=lKBHgTFT0DE+cvG4KfSF0tIL6gZl/OaxwE7f6oHmidxvScFWadFBDErWoPSSpY4RIhbEqSD6d/IgVJVrqoX3+BotM3BKqLsWm21dlqUE0K6yaMKEaMQ9wcMY/WnUB/xKIfkOim6i8xv+WfSf64o3+8mE78bBROxb+RKqyBGUR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716177467; c=relaxed/simple;
	bh=LTlMRByhd4F+euVmK6Ked5hunQivRpLdxW4sWjwAKcY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fkpim1LyDFFFLqIcRmM/IVCvQM9C1SgL8zyFc630qUwnRoaUSXAsxLc03lvLIsPGK4l8HxfRxakUjlyvODnh5Ul12H++jSIHrqLvJGgA+jmR6QyOSikbvQbaVSHp0B50kqDC3U7LnmIyqJwUDPKGNLoFIgmoYZtUMoyaEFFxk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYBt5alD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYBt5alD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716177466; x=1747713466;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LTlMRByhd4F+euVmK6Ked5hunQivRpLdxW4sWjwAKcY=;
  b=RYBt5alDbUN3Ve2JGylC963VXzaAse5b61DVUpm4ihbuocshrfYRMLw7
   sVACdpRReCtnWkoxW/7EB56mL2atD7RrWLC586Q1y+zz1McfX/nytirte
   UD++7ufL83C7+E+8BMTCtmmP75iWhfMSBuSsmmlVKm3NGSO1RNwyPpdUs
   c04b6eoe3HjLPv2nOoGz/B8dQA3NZwoQsTdQuj0qLpdmeX2+a4J6meYNZ
   zU3Gjmbsb8aOMCZaQffpIJHgla+DTbAJJiigu/6rd3CmJMYfp8JLJaSBO
   uL97KnuSanRYi8Sii4WfvnqjibMi13a87Pqp2kuCwEZiYRPffpBrOnOno
   g==;
X-CSE-ConnectionGUID: 2e5hgYMrTW2LwoIvnZOcDw==
X-CSE-MsgGUID: pOjI2JwfTLOU9i8W9yOtEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23691837"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="23691837"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:57:46 -0700
X-CSE-ConnectionGUID: xhpZf/slTFm12oszjVwKKQ==
X-CSE-MsgGUID: g+zZGbeoR+icujyl1mlkuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32824611"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 May 2024 20:57:42 -0700
Message-ID: <868a67fa-b5b5-439b-a906-57cdddeb1053@linux.intel.com>
Date: Mon, 20 May 2024 11:55:51 +0800
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
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D582749AD8B619B11B688CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bd08d2b0-f226-4b42-8d3b-099c46435aa2@linux.intel.com>
 <BN9PR11MB527642EC35E6B925100D0AEA8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527642EC35E6B925100D0AEA8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 11:35 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 20, 2024 10:10 AM
>>
>> On 5/15/24 4:43 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, April 30, 2024 10:57 PM
>>>> +
>>>> +int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
>>>> +				     struct iommufd_hw_pagetable *hwpt,
>>>> +				     struct iommufd_hw_pagetable *old)
>>>> +{
>>>> +	struct iommu_attach_handle *handle;
>>>> +	int ret;
>>>> +
>>>> +	if (hwpt->fault)
>>>> +		ret = iommufd_fault_iopf_enable(idev);
>>>> +	else
>>>> +		iommufd_fault_iopf_disable(idev);
>>>> +
>>>> +	ret = iommu_group_replace_domain(idev->igroup->group, hwpt-
>>>>> domain);
>>>> +	if (ret)
>>>> +		goto out_cleanup;
>>>> +
>>>> +	iommufd_auto_response_faults(old, idev);
>>>> +	handle = iommu_attach_handle_get(idev->igroup->group,
>>>> IOMMU_NO_PASID, 0);
>>>> +	handle->idev = idev;
>>>
>>> why is auto response required in replace? new requests can come
>>> after the auto response anyway...
>>>
>>> The user should prepare for faults delivered to the old or new hwpt
>>> in the transition window.
>>
>> The current design of replace allows switching between one that is not
>> IOPF-capable and one that is. This implies that if we switch from an
>> IOPF-capable hwpt to a non-IOPF-capable one, the response queue needs to
>> be auto responded.
>>
> 
> then do it only for that scenario?

Yes. Will do this in the new version.

Best regards,
baolu
