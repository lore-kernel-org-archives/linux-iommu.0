Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D9175A9D
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541151; cv=none; b=f4yXxMMK3poe8od9tpVMnT5kFaO9/l//tcfp5skJQvS7oNVBEdJRnwtWi9RjnCfq5zVg2xCXv5WQkCJEIDMNpzPtJeSgTy8JBLVnTx3LzblUXO6ALkdQ9i2X/CZ+2IF5t9yVziNBzqHE5Pj95PudklbvrN93qw+DtuoBBV75qJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541151; c=relaxed/simple;
	bh=zwaEOC72aj4r75+dKErQgCh/I2UYQPGFQIzWi9Bh55Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZptAujP1C0T9u09hA6xE2AP8Yl1ykSDJxu1WGJFRpX9Om02OXOEW9HBgpgrD1JzuDySszQiG95fIdWnZG7ieclJQwgytAeCc5NWsnVImPWcB7f5GgxkU8ZT0prLlW1uQlXjgzlzg5J9KXwkcNiiyJI+Mq7+Y7emh7xs2Eu9J3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q59NykEs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q59NykEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780541150; x=1812077150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zwaEOC72aj4r75+dKErQgCh/I2UYQPGFQIzWi9Bh55Y=;
  b=Q59NykEs2yiaUSVoE6zHmVyHmAlYiQWZoyUWIqOpCXQczH1Db19kIbI6
   tM8jOtLfB1Z9DpVrxE3DdrLKSFgdW8A/mDBgNVvhGWFCCiFnMsdGIIZYY
   pt3wPm/OnNvvH0UIBPc4ogwzBek0ap8FokWdymTKQuWom9BGHF3a47Ljm
   PftZ9Zb4nTQajqZ7x+Af+IBJDejklY/fr7Wf3rsgKDysAco2AwCK4DKEK
   2fBrzXrKtU4bcYwbRXPr1TOxrl7+jbKjzTXiAyIKiZII8wZE2qTCo8K1k
   tdISjGMnMewAfbmcWWSl8e8BJXtLX34GFZhh1/M2IzeYwvRZ1VH2wNeb8
   A==;
X-CSE-ConnectionGUID: eUUDjYtXQ1SHl4P18KrOfg==
X-CSE-MsgGUID: BP/vPkXUQVqHojaIB8rd9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81394977"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81394977"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:45:49 -0700
X-CSE-ConnectionGUID: S4I3acvjTca0y7rBk61R5g==
X-CSE-MsgGUID: OCypOtVWTQWlA8M8EeXAjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244260671"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:45:43 -0700
Message-ID: <633995b3-f534-49ef-9bb5-2ebebfc2d443@linux.intel.com>
Date: Thu, 4 Jun 2026 10:44:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/32] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/26 23:17, Guanghui Feng wrote:
> Add iova_to_phys_length callback to struct iommu_domain_ops alongside
> the existing iova_to_phys. The new callback returns both the physical
> address and the PTE mapping page size in a single page table walk.
> 
> Add iommu_iova_to_phys_length() core function that:
> - Checks ops->iova_to_phys_length first (preferred path)
> - Falls back to ops->iova_to_phys for unmigrated drivers
> 
> This enables callers like VFIO to efficiently traverse IOVA space
> by actual mapping granularity instead of fixed PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang<shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo<wei.guo.simon@linux.alibaba.com>
> ---
>   drivers/iommu/iommu.c | 50 ++++++++++++++++++++++++++++++++++++++-----
>   include/linux/iommu.h |  9 ++++++++
>   2 files changed, 54 insertions(+), 5 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
