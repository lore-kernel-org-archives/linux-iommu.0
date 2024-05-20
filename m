Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C179DC
	for <iommu@lists.linux.dev>; Mon, 20 May 2024 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168937; cv=none; b=D9rUB+1mDPpvW2FJMeltca1cbl7XqUfaoHJPV52fOUMQ7nkVXPN6pRidbEwAOmvKKcc4+GafGTor3hiPVFAwdTkrr+Ta1b2FccY3Byw2pWuwrNNFLGe7EzYujw5/wkPyJK7qmq0T89V+oNXb2ui4YjMuzZ+5Ajg2fqizduYKDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168937; c=relaxed/simple;
	bh=VR6ZYeZcCM4yblOV/1NPtY2M0KZ0UgfEH1ScYqV1UsE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=exT+q+tXq6FvMNIfmMlW2Pn5RWfbNKH9JMPqnLf5+8YfyuKlC2b6xmZ/3WcMJ49z8i6hIEpIzrWTNE6JaOq3fsX6ec1ri0YxkLHkhZX5aNO9tHo679ylw7k5kOyGYJAUJdYmiMF3T1G9Z6Z/dT2DJMjM2hxGqs0ZNjGKyI5WmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MX/OBBvx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MX/OBBvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716168936; x=1747704936;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VR6ZYeZcCM4yblOV/1NPtY2M0KZ0UgfEH1ScYqV1UsE=;
  b=MX/OBBvxeYuL69ICc1ROdhAuO0s2bHRb7g4H+AMw/m0y1Oz8jeP0Jb+L
   VqsI9+Esy3/P77q0qaz2E0oO/58fudApG7Gbm1XYGL/15PyYMaJCAKLqA
   MQnXWDoKhD+ajZoXa27dyJ1Uhq3OSkccDvhXb34jTncKmF5syQlII78mM
   VrepNEPtadkq9vWOMXBrcMgoVjRyY8lCPbnfnK+n0RURAthXZ7NrlI+pF
   VkG8kEd1HdYRzdBokKkiGKBQwVehz62/13H+ScMul84fDYltdI3UXlbr3
   wlYNOa9pY+SqfpjpupeQBrozO8b9SS9NTLJmFJf6yNA+YCmVu8fOq/5eJ
   w==;
X-CSE-ConnectionGUID: g7SfVWEsSsaNLDbSkRM8RQ==
X-CSE-MsgGUID: vM4NTY/KSP+v0eIsAu3e/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12399688"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12399688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:35:36 -0700
X-CSE-ConnectionGUID: QUaP7uYHRRyDzJoDH8+C4A==
X-CSE-MsgGUID: yZT4bqSOQCGZ3TdBEi/f4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="69808925"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 19 May 2024 18:35:32 -0700
Message-ID: <e30d919c-2e28-4e01-8317-2a4d82049056@linux.intel.com>
Date: Mon, 20 May 2024 09:33:41 +0800
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
>> +
>> +		iopf_group_response(group, response.code);
> PCIe spec states that a response failure disables the PRI interface. For SR-IOV
> it'd be dangerous allowing user to trigger such code to VF to close the entire
> shared PRI interface.
> 
> Just another example lacking of coordination for shared capabilities between
> PF/VF. But exposing such gap to userspace makes it worse.

Yes. You are right.

> 
> I guess we don't want to make this work depending on that cleanup. The
> minimal correct thing is to disallow attaching VF to a fault-capable hwpt
> with a note here that once we turn on support for VF the response failure
> code should not be forwarded to the hardware. Instead it's an indication
> that the user cannot serve more requests and such situation waits for
> a vPRI reset to recover.

Is it the same thing to disallow PRI for VF in IOMMUFD?

Best regards,
baolu
