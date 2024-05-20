Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2A79D3
	for <iommu@lists.linux.dev>; Mon, 20 May 2024 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171133; cv=none; b=PFp6tQx0oCFQqrM/AIpU39NN2njpOoVyBxW3iJr0jptKe0H/Kddtg/lsJgrSRFIxc7kf8iVVSooPMp5BrlRGB9TcwVrKCjBurUw88a3/0Ur1AwTp0mja4bD6pHLA7k0rPiv0fwmzaXlNHxb3ztNrXWCcZ3KmwSvNgOeeZzSeWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171133; c=relaxed/simple;
	bh=Ha4KtTkxo2LtB5iAREJLY/pM9skq832IrCDpRKv09Wg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JvKBN5md+pa31Wu+2rvAPJucz7bcxm3jN6PIoN1xhiqkm5dl3umKQJKeLKqvJ2BBWp9F49yRDmsD9NFla3pP63WqDmm0ZKd71StjblyqqGdigjxS7PZ2ZCD7xtUp8SvUCUTM03MhNHDcLtm1cTCw5DH4ctTkjuruLpBdfXcluzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4BBsE8D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4BBsE8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716171131; x=1747707131;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ha4KtTkxo2LtB5iAREJLY/pM9skq832IrCDpRKv09Wg=;
  b=J4BBsE8DGcBNQDvsm1BqaCOMAV9G8TjzbsrQW4+KlvKNexQqNDCovgqt
   CGQGnokxR/j2Hrm8RVtL60HQjy+zEdvfia6Bt9p/jqEFWmn6c5nNkNha9
   OApQz9yHkzavRqUbqVQo1TVPWdesOyCo5qwyy8AGt5myX/7Re7Lhf24JN
   cOwIpgQUaDLToWfvy/PS2X+rpTjXeos8vjNCV0LX6jJKIUrXJASrutke+
   te0Ns36G3RvpwhXC0+hYVuCrdnJMjawKOGkmuVHGl5r/gGOSVu/wnQs18
   j+nxqXzBH3VFs4oJZsYf89kXJtBbwarOdZsMX1lPwhGS/6ChhtcNUekNO
   w==;
X-CSE-ConnectionGUID: kOvk5QD7R5aYbHsQJnNRMg==
X-CSE-MsgGUID: +2iorbJZRLq2RMGJHJs6Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12151801"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12151801"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 19:12:11 -0700
X-CSE-ConnectionGUID: cdKakuEwSomHxfTKKygSEw==
X-CSE-MsgGUID: GQDhQmlMQKmedbhhYr28Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32397584"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 19 May 2024 19:12:07 -0700
Message-ID: <bd08d2b0-f226-4b42-8d3b-099c46435aa2@linux.intel.com>
Date: Mon, 20 May 2024 10:10:16 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D582749AD8B619B11B688CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:43 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>> +
>> +int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
>> +				     struct iommufd_hw_pagetable *hwpt,
>> +				     struct iommufd_hw_pagetable *old)
>> +{
>> +	struct iommu_attach_handle *handle;
>> +	int ret;
>> +
>> +	if (hwpt->fault)
>> +		ret = iommufd_fault_iopf_enable(idev);
>> +	else
>> +		iommufd_fault_iopf_disable(idev);
>> +
>> +	ret = iommu_group_replace_domain(idev->igroup->group, hwpt-
>>> domain);
>> +	if (ret)
>> +		goto out_cleanup;
>> +
>> +	iommufd_auto_response_faults(old, idev);
>> +	handle = iommu_attach_handle_get(idev->igroup->group,
>> IOMMU_NO_PASID, 0);
>> +	handle->idev = idev;
> 
> why is auto response required in replace? new requests can come
> after the auto response anyway...
> 
> The user should prepare for faults delivered to the old or new hwpt
> in the transition window.

The current design of replace allows switching between one that is not
IOPF-capable and one that is. This implies that if we switch from an
IOPF-capable hwpt to a non-IOPF-capable one, the response queue needs to
be auto responded.

Best regards,
baolu
