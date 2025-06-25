Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016FD1C84CB
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827287; cv=none; b=YVvxcE1wAsuz/zOMT43Ay4l3UV0jgrRHLWwvzYioRti1SUVCerUmTJ+K2RW02SS659G1fnRFNUNFEZHI1cHWLOkefzpIEvN/HH7tpv7EkC8H5TtzcjTwgglQFybHSZ/E6d2BIcQ2NtY8GHN3WDcuDJkdqT5VaPfq0ueOiquWVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827287; c=relaxed/simple;
	bh=dd9Qun5alIb832kjxzLiwo2DDL06Ewvd0ileT0Lq4iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vh/1Yj6r2padO1OK5cKlPmwVK4ArrPeigijydGPIh36veguwOiVd2j/uoKkU/L1f98RF+5kI7KKAVPS260OWPtvDATYqzn4FsmOfrfLGpaA5EN17c1Wnwv/Ddq66XcMMK8WH4Ko6zjzqmgFFrFzoIkfYRNP55FiRMtCWkD3y2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ud7P7CH+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ud7P7CH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750827286; x=1782363286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dd9Qun5alIb832kjxzLiwo2DDL06Ewvd0ileT0Lq4iI=;
  b=Ud7P7CH+5RJvCLtOb8kAL0cer1q8g8F6NCHi///zAW5x5Chv21ahl/wY
   cc1Eab93dKfgG4sW2r+1o0JMgGEa29nVR19V0ze6bLK2ed38TRzGiIGSH
   ztlztAP7j8Np6KEwiIguTE7ruE58YebD65QyY7tbrvjtXwFS6XJVo9xhZ
   509WsGGBkAYbupW8Y+w+LYFpOi72H9LajUyLseWojCm3s8LlmGQ5mEMOk
   w5wXGt0orCBF0aOaOL0m/8dCz5gEdi0yulSg5mVR1aKNYldO/cHDwmBVg
   VX8OhQJZCTn9BAARTg3eF5jHqNHOlBwl1LBJ19lhOg60dUYjvw/OZqtVb
   A==;
X-CSE-ConnectionGUID: 7RcoV6CZTK6OGiGJ2Cp9Rg==
X-CSE-MsgGUID: yPYvm8PFTUSYYd5EEK1L7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64142055"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="64142055"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 21:54:45 -0700
X-CSE-ConnectionGUID: c+mawL3RRL+swpu2DZhapQ==
X-CSE-MsgGUID: kPfirjqcSd2q+AfUierqVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="175750369"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 21:54:43 -0700
Message-ID: <c2191a58-5330-406c-b6b0-951a9d370bed@linux.intel.com>
Date: Wed, 25 Jun 2025 12:53:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable ATS before cache tag assignment
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250620060802.3036137-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276371ACFE0B5CEAAA021C88C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276371ACFE0B5CEAAA021C88C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 16:33, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, June 20, 2025 2:08 PM
>>
>> Commit <4f1492efb495> ("iommu/vt-d: Revert ATS timing change to fix boot
>> failure") placed the enabling of ATS in the probe_finalize callback. This
>> occurs after the default domain attachment, which is when the ATS cache
>> tag is assigned. Consequently, the device TLB cache tag is missed when the
>> domain is attached, leading to the device TLB not being invalidated in the
>> iommu_unmap paths.
>>
>> Fix it by moving the ATS enabling to the default domain attachment path,
>> ensuring ATS is enabled before the cache tag assignment.
> 
> this means ATS will never be enabled for drivers with driver_managed_dma
> set to '1', as they don't expect their devices attached to the default domain
> automatically.

You are right.

> 
> does it make more sense sticking to current way (enabling ATS in
> probe_finalize) and assigning cache tag for device tlb at that point?
> 

Yes. I will post v2 with this approach.

Thanks,
baolu
