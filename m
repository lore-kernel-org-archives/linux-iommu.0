Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC0343889
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297954; cv=none; b=luZoRJvlD4kkuFt6MGwc8VtvzmWLMxWLe9MY4zrJ2KYHR8wxHSRSDwCbiRqBOtqBOh0az/wOk4HVE7iXpZ8OOAEtnUAPUMgbw6p+tBrxrpgMX078F2f6GhepjxavnvYSxY4D/HG8PgPcB1KzRx5y4ImEVfpYBntbiSVB7wNdP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297954; c=relaxed/simple;
	bh=38yF4VkJngI1tQRsxKl3lTtZO5/FU4XKjAEF4W94y9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BySNNXH0gZTN6cP+eUz1qs1eMwVMMr8OABe3LzD03W5x04IMcaH4Z8qGP6dNshFDLUcKzmcLp6reW0vxWw7nwl5SeFC9e9TUbB1SR+8tz5zj6Qs0h9PW8PeHV0oTafmCJZAPBWaU2PQulrcCXQ/jtzYLVFj9ducM+ZRbF6GFrS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UB+jC8VE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UB+jC8VE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780297953; x=1811833953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=38yF4VkJngI1tQRsxKl3lTtZO5/FU4XKjAEF4W94y9s=;
  b=UB+jC8VETY203Eoni0T4mEn2O1mxhs2F6gCxCW+Qyramtyk4Svx4+Rkl
   b9kVxxKv84EsqgIdBQDPSoWkbJyYhqhy7REMAdiJWWggKuqyO5DPgHd9m
   oo5eZcRb1bv3pO95NRpfdynYTrkwsQCYIA+m+f+veYvrdxaPERmPSmBRY
   UVfU4UgeivZBNgA6nKIX8FoC06FnJW11g99MS0CNPM1/n0Eeq7wE5B5n+
   LxQlj9lQx2fn8SfhFmNyBFSIMmQMWDYFVrCGW6LNZY77GMTnlRPEI+4fK
   cvgh27xJ527pLB8rSJbj10V4w98rD2gNQI355MS3cajZ58lMqf9WpFAou
   g==;
X-CSE-ConnectionGUID: F7S7ltLGTNe4kPk8hlA/Dw==
X-CSE-MsgGUID: G3rZEjlATUaYmF/vCjTDPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92522671"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="92522671"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:12:32 -0700
X-CSE-ConnectionGUID: UfiM/PdAStqqmzgBwPZlAA==
X-CSE-MsgGUID: wa70ZCIUQweF+GtN1f1+OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="239313650"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:12:30 -0700
Message-ID: <b1991d9c-ae0e-49a3-bc28-623fa554d428@linux.intel.com>
Date: Mon, 1 Jun 2026 15:11:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix issues on probe error path
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20260531170254.60493-1-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260531170254.60493-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 01:02, Pranjal Shrivastava wrote:
> This series addresses two pre-existing issues in the Intel VT-d driver's
> probe error path. These issues were identified by Sashiko during the
> review of the ATS series [1].
> 
> The first patch fixes an RB-tree corruption that occurs when probing
> non-ATS devices. The second patch fixes a UAF by ensuring the per-device
> private data pointer is cleared before freeing memory on failure.
> 
> [1]https://sashiko.dev/#/patchset/20260525184347.4059549-1- 
> praan@google.com?part=4
> 
> v2
> - Updated the Fixes tag for Patch 2 based on feedback from Lu.
> 
> Thanks,
> Praan
> 
> Pranjal Shrivastava (2):
>    iommu/vt-d: Fix RB-tree corruption in probe error path
>    iommu/vt-d: Fix Use-After-Free in probe error path
> 
>   drivers/iommu/intel/iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Queued these two fix patches for linux-next.

I noticed that Sashiko reported two pre-existing issues here:

https://sashiko.dev/#/patchset/20260531170254.60493-1-praan%40google.com

I will follow up with fixes for them in separate patches.

Thanks,
baolu
