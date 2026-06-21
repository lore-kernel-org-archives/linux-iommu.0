Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3B23ABB9
	for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782006822; cv=none; b=ErtgR8eX2N2e+ElLunxdW/n7hfabliIr/psQhJNKuYeOaLQUWPORWipqHq/1GBbxbimnSUKbt125IQ7qMiwPDdEe3yh88nWD59zW24z7uRnW/IxS1eVqNpp3pkWhtNhOSA5o45PsVCdwUjee2c9QlGgzCO975yPvDCUK9asRXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782006822; c=relaxed/simple;
	bh=0IdytbMR6TeppsD+FYqGVCZHan6NncQo+OpSjxk8I4A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ts+EbZ7tRKFmZH/9k4cSqjYBn+Kd/aOlUfHnuiL3idk01ElszCNGvqyujNG8FJIaSn5spgpXVGCl7/RpwIXSuqFMO3uqKvO3ZbVohhR7VirhfXg4r07DstdBi6S1u9YbusT/NBC7+vQlw+Z/tuMArsBh8UaDT7bAW0dzrK3DLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCeZ9Nl6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCeZ9Nl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782006822; x=1813542822;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0IdytbMR6TeppsD+FYqGVCZHan6NncQo+OpSjxk8I4A=;
  b=KCeZ9Nl63NSMIYMIHKYXCM7Ls9BtFdqqI1vupU0C8fRPCuijwEgBUDFC
   CLn0X0Jg69MtSeuDntKnSjZ9ODri8VA47F1s3Rkn2PPN9bsH+G+VAz4U2
   5uwhMOahKyJi0oJk/6mquLdKBJ6riGqqBND+W5FAXtagZ34BR0cyoohU3
   VZ41LJWL1hDdItuyyZXtkh9ptRZivFtyBUmUjXzOlQaaEYOpet6BJcClF
   5Z0OBKUrnb/7/kdIZmvgx1w5kIKipfM4eXmiZuo0RkPhwTJndGpXAPb3Z
   vJuIlvL/9+7E3fd9+4cSfMSGqucs78ZUGVeMXZTOKcfcoZ/LbCJcIeqQc
   w==;
X-CSE-ConnectionGUID: wja0HhvTS5OZxLilG06B9A==
X-CSE-MsgGUID: ldgKBTwARrOFIMGHigWT3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11823"; a="82556315"
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="82556315"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 18:53:41 -0700
X-CSE-ConnectionGUID: 6u0UB0TbQyq5DxD3eFw+QA==
X-CSE-MsgGUID: FxUDobN6RDifAvLqSfvaDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="250831584"
Received: from unknown (HELO [10.238.9.114]) ([10.238.9.114])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 18:53:37 -0700
Message-ID: <25bfc4b7-ec84-41f9-a68c-5dda7839320d@linux.intel.com>
Date: Sun, 21 Jun 2026 09:53:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Chris Wright <chrisw@sous-sol.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 "Mallick, Asit K" <asit.k.mallick@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] iommu/vt-d: Call dmar_can_force_on() for tboot optin
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-7-kevin.tian@intel.com>
 <cc8cd5bc-e093-4a95-a68b-ae3ca24944bb@linux.intel.com>
 <DM6PR11MB3690B5C7395AB982C0AEBA588CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DM6PR11MB3690B5C7395AB982C0AEBA588CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2026 3:19 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, June 12, 2026 9:58 PM
>>
>> On 6/4/2026 1:15 PM, Kevin Tian wrote:
>>>
>>>    static __init int tboot_force_iommu(void)
>>>    {
>>> -	if (!tboot_enabled())
>>> +	if (!tboot_enabled() || intel_iommu_tboot_noforce)
>>
>> Hmm, it looks a bit strange here. The core design philosophy is that the
>> trusted boot environment takes priority over user options. However,
> 
> user options here refer to "iommu=off" or "intel_iommu=off" which
> opts to enable/disable iommu.
> 
>> checking intel_iommu_tboot_noforce at the very top means a user
>> option (intel_iommu=tboot_noforce) is successfully overriding tboot.
> 
> but tboot_noforce is to specify the forceon policy on tboot. No conflict.
> 
>>
>> Is this an exception? If so, it might be worth adding a brief comment
>> clarifying why `tboot_noforce` is allowed to bypass the priority?
> 
> so this is irrelevant to the enable/disable priority part.

Okay, that explains.

The "intel_iommu=tboot_noforce" option is used to disable tboot
entirely, which is not part of the enable/disable override. I suppose
tboot_noforce is only designed for debugging purposes, so it should not
be used in a production environment.

Thanks,
baolu
