Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F11957FC
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816627; cv=none; b=dlp3/Ul4B9X3+mg6I11hhvDpeXlCAdyP0EidJg1qqTXk1vgIEPWnhIyx9FnCZnxqAwnAJcl/u8I0491j/jZbPD/jqMXrNz5i+IkV5SKOzyAXrBmy/k4FUF4gYvoI6XsDPraWUyBc8LIApCOgYeCEyTBehZ0GIwKyxnRFkUzSxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816627; c=relaxed/simple;
	bh=32U2wOAlMtIyO75Asy250dWcqCGf5UC5QID2tausaWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O55nhPtR7MGAJIatY2ULSvV7N3Yel+cINl2ZhsbZPw3ysmyiSsde+e1cE72o5d+aizy5odHqisTFiYFVMpSIEpaX1DZufCKg6NibbgfsRG7nsPX8/KsFHh/G+/z8GIg63ugBiN+9NA90z0rd3Pmn/b5lUhyVfQEXgIEBS3BKdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmeD0fSK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmeD0fSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750816626; x=1782352626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=32U2wOAlMtIyO75Asy250dWcqCGf5UC5QID2tausaWQ=;
  b=GmeD0fSKGvklJBWqxXmUIGeH+EOgYEOnV7BAriYbf9+2B4h4N3FK8Ftg
   U5SnHWb54styrusHn8WMJgfDwiF04Dk7zkIZs2uoPUbNieUMFln7Lgc3s
   HuYSw/eABq0XN51Bm6zRnPw97eaas1L/WCU5KzApocatGz25cYuzruPA/
   jGNF/pS7dLucTKZE85+GCcyTRaygCEr7gOR+WNrLEnicB3zyXBS685SOs
   EJ833dczLivRCDX+BSnxe3Y7C8dTtmze4G7sq+CoR0TowNK4DRm17L8sv
   XTaU2NBlOePcR5SeG3XXGEVAtV2yPW5nhROp7Sp8LdfzJWHOXjhlGNtPz
   w==;
X-CSE-ConnectionGUID: ziCWxLoXSJ2zuu31TuHV3Q==
X-CSE-MsgGUID: tMRR/iB8TX+483SswSQ0aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56748953"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="56748953"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 18:57:05 -0700
X-CSE-ConnectionGUID: WxY9OlOoQcCBuk7WUwHnzw==
X-CSE-MsgGUID: wSio0s/UQe2fUPImjc7KTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="156364357"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 18:57:02 -0700
Message-ID: <e8977169-e1f6-4ba4-931b-9bebffc1469f@linux.intel.com>
Date: Wed, 25 Jun 2025 09:55:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
To: "Tian, Kevin" <kevin.tian@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
 "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>, "Xu, Yilun"
 <yilun.xu@intel.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <a2fddab4-bc85-46f6-9008-57a26e099698@linux.intel.com>
 <BN9PR11MB52763649BE32A38A60866D518C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763649BE32A38A60866D518C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 16:12, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 24, 2025 11:32 AM
>>
>> On 6/23/25 17:49, Xu Yilun wrote:
>>> Destroy iommufd_vdevice(vdev) on iommufd_idevice(idev) destroy so that
>>> vdev can't outlive idev.
>>>
>>> iommufd_device(idev) represents the physical device bound to iommufd,
>>> while the iommufd_vdevice(vdev) represents the virtual instance of the
>>> physical device in the VM. The lifecycle of the vdev should not be
>>> longer than idev. This doesn't cause real problem on existing use cases
>>> cause vdev doesn't impact the physical device, only provides
>>> virtualization information. But to extend vdev for Confidential
>>> Computing(CC), there are needs to do secure configuration for the vdev,
>>> e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
>>> destroy, or the external driver(VFIO) functionality may be impact.
>>>
>>> Building the association between idev & vdev requires the two objects
>>> pointing each other, but not referencing each other.
>>
>> Does this mean each idevice can have at most a single vdevice? Is it
>> possible that different PASIDs of a physical device are assigned to
>> userspace for different purposes, such that there is a need for multiple
>> vdevices per idevice?
>>
> 
> PASID is a resource of physical device. If it's reported to a VM then
> it becomes the resource of virtual device. 1:1 association makes
> sense here.

Okay, make sense.
