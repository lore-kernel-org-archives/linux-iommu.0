Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DB3C3F5C
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232209; cv=none; b=r56AlqlJ4kgv68ReV6OxioOw3Ul2DjDhLTjW14u4GBwoKo0TNUcjU54G0niAnZjVcMrQKBp0bdE1IjZdBANEEumlUwpufmJJMUbkv2xQ8mgrlls70W4aSDD9p5f+gpT+IIVeKF1aXCdTuMNPrdamTnFDV1Z57dhYPLVhZjcArBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232209; c=relaxed/simple;
	bh=xG6aahRndMxJ7+wby1MyMe0xQb6nv/hja+g9gLR2Z1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK5edaCePHl4+6Gx49TX/hc6foD5qBS+2ZCGO4lmA9s+AOJvKziVarCGPqhnauSznlXrP0gff3xIzQ2ro5ayOVD9glLnvrnuwF956584ifRFceRY78lpbB6lVvcm4yoGPz5lzIQRaoaWvYJ7cMPBosnpJMtc5iA6dRP7PYaHKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UW7b6HDj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UW7b6HDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232208; x=1821768208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xG6aahRndMxJ7+wby1MyMe0xQb6nv/hja+g9gLR2Z1c=;
  b=UW7b6HDjVqnp8vKZ8W4ATe0sC+kSqSDJ7J1BoC/s8Th5FYWpq/BdOiv3
   dniLzl1xjo0eBZI0GzdUX4mYQmdryprEVWPKByfnP6oiNz+MxdkIZUW4s
   O004Th0gl8vWdlQRKAJX4TiqO/zfqBZiEZ+jgx1P0YHpzvpKTUNKtjP0B
   /mdf10H+i+u1EFAnSBWPhNx11Vud5ULxUhgV1abEvsNbIusHP+45DtS0O
   Qf0oaBs7hxXqR6P03IIHG/EWOKAzG8daNgDwCDUkL2NLDNz9FIw2MEEKE
   QAnWdUflOSQ6bo2BoV4jPDW1DY5kDpRD9r1lNLvRQsymBpjSmAUv3NSmY
   Q==;
X-CSE-ConnectionGUID: xp7OyBWDSier5+MZ5teTJQ==
X-CSE-MsgGUID: cCEs5telSiSO95dwmJ0zeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101166041"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101166041"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:43:27 -0700
X-CSE-ConnectionGUID: pY9orfd9R6qBMDUXknKN9g==
X-CSE-MsgGUID: Chksm04BRyetykOJyAmKwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="5179508"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:43:24 -0700
Message-ID: <360a128c-19b4-454e-b7a0-c96e3d47484f@linux.intel.com>
Date: Thu, 24 Sep 2026 14:43:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix page table level calculation in
 compute_vasz_lg2_ss()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com,
 Joerg Roedel <joerg.roedel@amd.com>
References: <20260825080002.117412-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260825080002.117412-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 16:00, Zhenzhong Duan wrote:
> compute_vasz_lg2_ss() finds the optimal Second-Stage page table level by
> intersecting the maximum guest address width (mgaw) with the hardware's
> SAGAW capability register.
> 
> The VT-d spec maps the SAGAW bit field positions as:
>    - Bit 1: 39-bit AGAW (3-level page table, top_level = 2)
>    - Bit 2: 48-bit AGAW (4-level page table, top_level = 3)
>    - Bit 3: 57-bit AGAW (5-level page table, top_level = 4)
> 
> The fallback paths use bit shifts that are one position too large,
> causing ffs() to select a deeper page table level than the mgaw window
> requires:
> 
>    - mgaw > 39: "3 + ffs(sagaw >> 3)" evaluates to top_level = 4 (5-level)
>      instead of top_level = 3 (4-level) when hardware supports both
>      48-bit (Bit 2) and 57-bit (Bit 3) AGAW.
>    - mgaw > 30: "2 + ffs(sagaw >> 2)" evaluates to top_level = 3 (4-level)
>      instead of top_level = 2 (3-level) when hardware supports both
>      39-bit (Bit 1) and 48-bit (Bit 2) AGAW.
> 
> In both cases the selected level is still one that the hardware advertises
> in its SAGAW capability, so IOVA translation remains functionally correct.
> However, an unnecessarily deep page table may be selected, adding an extra
> level of page walk overhead and reducing TLB and cache efficiency without
> providing any increase in addressable IOVA space beyond what the mgaw
> window already caps.
> 
> Fix by decreasing the shift offset by one in each fallback case, ensuring
> ffs() targets the correct SAGAW bit position and selects the smallest
> page table level that fully covers the mgaw range:
> 
>    - mgaw > 39: "2 + ffs(sagaw >> 2)" correctly yields top_level = 3
>    - mgaw > 30: "1 + ffs(sagaw >> 1)" correctly yields top_level = 2
> 
> Fixes: d856f9d27885 ("iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires")
> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued for iommu/next. Thanks!
