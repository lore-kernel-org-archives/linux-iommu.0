Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501E3624BC
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922411; cv=none; b=kk+4ifp9miQRWVlQXZ/xTyrpdqlHybii1nppfxsXpxNT+barsJ4cwecEu6OewPav5QnZVkv+yZiwX6tLkyM5RcMrYRTWXxt/TooR8Ow+4+drLpB3z9nTKlkhMSc7AV2WVB14oBDdAYTGhaOUyricc5md9fjULMIu1yWJQxcVv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922411; c=relaxed/simple;
	bh=psSl44kQAmpduvXJgayiRWg2HnIuLxnednHA5OIgwc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNOpyPiIiihQmw91zKCB0b6dWVLW1Ms1tu4upkPzCbGmGdTIArfKDGzgxrN7eizk9HlmhNaPWyLwb5mzlaAkFxcMThxA+fRycPUoYGws9iklPtDZrlY3KP7/YGAYr36bHyw5/U888hFveW92k5Scer3Z7XoHJSd5s8UaKEZGz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDhtFa7M; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDhtFa7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783922408; x=1815458408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=psSl44kQAmpduvXJgayiRWg2HnIuLxnednHA5OIgwc4=;
  b=kDhtFa7MYi6iYYMeP2dc9Mx5lTQvQf2AVTQrCP32DWnTslTBRTPD4B4E
   38mNRFQBz6l30vlRl+JHp95Sv8YaEjQA6q3sj844YgMo83Av5yWBOP6Ra
   NdivoOwDvcZthOfD4x/L0NvsFq+knjRbi15mErGhAgQqjLdFfS9MkmW2j
   p0lXQoA0qlSg6SBzEtIkIi8KrOtxAvV+vrKTRJnSQhBXBfRV0keDzoeDJ
   o1vp7S2X7unWMPBahYd6CSyOkvg2h/nrz4tyybHzZ0Xr80/w4iYgcG71G
   mTPUP04Ad9C3LfYopIkiEFgOWYovBRbnJg6l5V7ITk3IxsBlB76Wb7RJn
   Q==;
X-CSE-ConnectionGUID: 7KCWQkEOS0KHZ8iNnXhB3Q==
X-CSE-MsgGUID: LSkOQLyTS7+eVs5iakRnyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84542241"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84542241"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:00:08 -0700
X-CSE-ConnectionGUID: 7YCWJH7ERM2Hvzz7QNTwpg==
X-CSE-MsgGUID: VTmitOknRAWzZ+CF1zlFAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279862934"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:00:05 -0700
Message-ID: <06cfeb74-0cf5-49b0-bc94-5703524203fd@linux.intel.com>
Date: Mon, 13 Jul 2026 13:58:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommufd: Iterate the cache invalidation array in
 the core
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <c19b7508428e9f14d6997ff9f5a41d9d5ba6cde5.1783539724.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c19b7508428e9f14d6997ff9f5a41d9d5ba6cde5.1783539724.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 03:44, Nicolin Chen wrote:
> The cache invalidation ops, cache_invalidate_user() for a nested HWPT and
> the cache_invalidate() for a vIOMMU, are each handed the full user request
> array and report how many of the array entries they handled by setting the
> array->entry_num. Every driver therefore implements its own loop over the
> array, and a driver wanting to process that array in fixed-size chunks
> (e.g. to issue commands out of a fixed-size on-stack buffer) has to carry
> the loop and its sub-array bookkeeping all on its own.
> 
> Move the iteration into the iommufd core instead. Invoke the op with a
> sub-array that starts at the first not-yet-handled entry, let it handle a
> prefix of that sub-array and report the count via array->entry_num, then
> advance the base pointer and re-invoke the op until the entire array has
> been consumed or until the op returns an error along the way.
> 
> A driver that handles the entire window in one single call, as all of the
> current drivers happen to do, finishes the loop in just one pass, so this
> does not change any of the existing behavior. It instead lets each of the
> drivers convert to bounded chunk processing on its own, done by each of the
> subsequent changes.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Assisted-by:Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h                |  6 ++++--
>   include/linux/iommufd.h              |  2 ++
>   drivers/iommu/iommufd/hw_pagetable.c | 25 +++++++++++++++----------
>   3 files changed, 21 insertions(+), 12 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
