Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782892652A2
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 01:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431064; cv=none; b=HItubAjm4aajhtE5KBN+OtZOND4A5vm/DvB+KN6/lBoyJX1iXWuBBPEtBxKmp5uinqbrh2Jjk9HeFbDvIkmVRoxpLvKW+Y+QISsStLsqKM2hbJq265UAuR4Q5JF6dkOiiQ0fN0FI6vSwmFNe8SCstNhAd90AWXzK3dsXx+IBEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431064; c=relaxed/simple;
	bh=DpFVic7YWH0BlyrxXOW+sZkVF+M4c4M+n6n4Zsdt30A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQvLzfVk+VFfKgHC3f1hoXxh5d3GzJEumt8+5A11cT3uHceBuap6LU+BDPGs5ENDcYzT7hSOQNLNVI1KVXHLQMkDzXfCkFiTEpbiaAyYs15XbyXtxaC3ni36t0J3+9Py4fe4pCFK/wnKnz5KDdWHWSEdXr4CaRtYEb4a5a4eZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Is/2LWfL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Is/2LWfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763431062; x=1794967062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DpFVic7YWH0BlyrxXOW+sZkVF+M4c4M+n6n4Zsdt30A=;
  b=Is/2LWfLGYco7bYFMpzyzmuOuD/W/SJbeFamS8QLq+NiK3Fo5gvQ5VgX
   5YHWy1aMAQfnbYLoQduWxx2HUdBaRTv/1ShHmXRL3/m8TL5/26S2XOhy5
   aU/CCf35SfZ4YvAzbaYH+DrSO0uElav0xX8Rvdz1EM6Gs7/L58UNVzWNR
   vnJi2nJVCfVbRjdXY9Fbz4Lp7K88Um9G9uP/Y1TLIYdB1oqvDW3mL3FMi
   YBHZOx1HeD9CSHLd3kCY/dXgMG1lIgO9Dxj7NlUIHEuaz2cXJJlzGEXwc
   XvnlsT9niLIwzRMwOkD05R2x33ESdpQSLxU3uTqlOmrW4hHdyevhytZ41
   g==;
X-CSE-ConnectionGUID: rDdkHiJ0TWy/FYJOIPOBwA==
X-CSE-MsgGUID: ETptY0EsTC+JlQ28VEvDwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69063075"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="69063075"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 17:57:41 -0800
X-CSE-ConnectionGUID: jIA0VwtlQ3KMU8Dpvzdhrg==
X-CSE-MsgGUID: N/78ki0ASgW9u23TTCj00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="190288095"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 17:57:39 -0800
Message-ID: <36cd3953-80fe-4605-ad2d-881440f92f3c@linux.intel.com>
Date: Tue, 18 Nov 2025 09:53:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb
To: Aashish Sharma <aashish@aashishsharma.net>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Dmytro Maluka
 <dmaluka@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Tina Zhang <tina.zhang@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Aashish Sharma <shraash@google.com>
References: <20251009010903.1323979-1-aashish@aashishsharma.net>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251009010903.1323979-1-aashish@aashishsharma.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 09:09, Aashish Sharma wrote:
> Invalidation hint (ih) in the function 'qi_desc_iotlb' is
> initialized to zero and never used. It is embedded in the 0th bit
> of the 'addr' parameter. Get the correct 'ih' value from there.
> 
> Fixes: f701c9f36bcb ("iommu/vt-d: Factor out invalidation descriptor composition")
> Signed-off-by: Aashish Sharma<aashish@aashishsharma.net>
> ---
>   drivers/iommu/intel/iommu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued for v6.19-rc1. Thanks!
