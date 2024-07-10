Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE012A16D
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600573; cv=none; b=mJqm0QFN0R1niz9s3MQq4cpJFj1aSLGNv0DJ51e6BjfM4TtPYQrbkbZFb2PLSuQt410JZAqfnQBDKEeoGpfn+IwR1MCUPkJy1MUztxnT/LHX59CNHebA3ryoj/MHVxg2+tkcnguzdsaK6G/CcS5iYzMDcavA5Iu3s/oDAbmOzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600573; c=relaxed/simple;
	bh=b/dygOvp0wyogHXGzt0P/JA3Psilj/juRjotDTNSf2M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iSuwYMlBE4PNxQhR8LbzLP4Hvu+gHuWjVokpb0OXBCEITm4TkOrg7NHHd5QO5/CIrekNaA3SlWuoJjPDPgoQxnu2VeLCmKcuq+Q+VDo4pCbch+yrdbZmDN440NHaUlob62z7tBXMjlEwk6APQCtLQSus+JVm+UG2T+X1jCqdMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5VzJF2d; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5VzJF2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600572; x=1752136572;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b/dygOvp0wyogHXGzt0P/JA3Psilj/juRjotDTNSf2M=;
  b=l5VzJF2dJ+CHM1wAZn0ojwqSHghkno5irGaclh2RFnksiZNsQ2KKR6si
   M6mNra+ovRTzE5N7Tl14G3z+x94n26Pb0+XPheg15pUOfI3VuaO86gNPL
   GchSZqaBZmBSHxWNkGRuhqmeSc1TRHA+vChf5qcHWISY2pZnH+UP38ySn
   p1KWsroieVpq9WjYob93C+qxbeUW7rhFxmbyhA3H1BgAR6bGmFgJfCWuB
   6x0w2Ntv5jNm42wUVsyUCJXDT3iPtT4mpcbDXj5JjLaDX5Z5UdBa+bQ7f
   cwGT+Di3aXv9azgP45Y9NED5DIcBE0GkvyjbWgrHlgePfAY5gExAZOiF9
   w==;
X-CSE-ConnectionGUID: TQ9C7jg5T5yWp64DieN1kA==
X-CSE-MsgGUID: XlecTzB9S8CR84TUiDpdLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="20810282"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="20810282"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:12 -0700
X-CSE-ConnectionGUID: ddX+wz/jQZ6WOJZ31OzKTQ==
X-CSE-MsgGUID: TeiuBPilT4OqbcfhE8PxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="79298015"
Received: from jiaoxu-mobl.ccr.corp.intel.com (HELO [10.124.241.177]) ([10.124.241.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:09 -0700
Message-ID: <16e5d5df-3a4d-4bf3-adf6-8edb08df985c@linux.intel.com>
Date: Wed, 10 Jul 2024 16:36:06 +0800
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
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
 <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
 <20240709173643.GI14050@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240709173643.GI14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/10 1:36, Jason Gunthorpe wrote:
> On Mon, Jul 01, 2024 at 01:55:12PM +0800, Baolu Lu wrote:
>> On 2024/6/29 5:17, Jason Gunthorpe wrote:
>>> On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
>>>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>>>> +{
>>>> +	struct device *dev = idev->dev;
>>>> +	int ret;
>>>> +
>>>> +	/*
>>>> +	 * Once we turn on PCI/PRI support for VF, the response failure code
>>>> +	 * should not be forwarded to the hardware due to PRI being a shared
>>>> +	 * resource between PF and VFs. There is no coordination for this
>>>> +	 * shared capability. This waits for a vPRI reset to recover.
>>>> +	 */
>>>> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
>>>> +		return -EINVAL;
>>> I don't quite get this remark, isn't not supporting PRI on VFs kind of
>>> useless? What is the story here?
>> This remark is trying to explain why attaching an iopf-capable hwpt to a
>> VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
>> a response failure will disable the PRI on the function. But for PF/VF
>> case, the PRI is a shared resource, therefore a response failure on a VF
>> might cause iopf on other VFs to malfunction. So, we start from simple
>> by not allowing it.
> You are talking about IOMMU_PAGE_RESP_FAILURE ?
> 
> But this is bad already, something like SVA could trigger
> IOMMU_PAGE_RESP_FAILURE on a VF without iommufd today. Due to memory
> allocation failure in iommu_report_device_fault()
> 
> And then we pass in code from userspace and blindly cast it to
> enum iommu_page_response_code ?
> 
> Probably we should just only support IOMMU_PAGE_RESP_SUCCESS/INVALID
> from userspace and block FAILURE entirely. Probably the VMM should
> emulate FAILURE by disabling PRI on by changing to a non PRI domain.
> 
> And this subtle uABI leak needs a fix:
> 
> 		iopf_group_response(group, response.code);
> 
> response.code and enum iommu_page_response_code are different
> enums, and there is no range check. Need a static assert at least and
> a range check. Send a followup patch please

Yes, sure.

Thanks,
baolu
