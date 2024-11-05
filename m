Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E94A0A
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775131; cv=none; b=hpm2l8P6IsfUFd61VdZXxSOwAa+/AZgdXx7xVWVLGsTw2Q/EA4qr4mNhk7pRLKFyyRLd67R2xP4byCzFTHM1LdfCSKRT+JA5/+UAUbE2MPVF1awwjKJdXzCrDLSurYvBbv9WXhXR5ouGP0gDtT/Vlub6DVy5JdUD3hCzDGD8J8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775131; c=relaxed/simple;
	bh=/fne5fCFChojEHGlVra1bCqeCuKKR9purCKtH81mryg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAsraQiPyQFqsw2HfWmnLSvQv8nIPuXLl/aGeJLpUOCY9Rcnij7F2qqbEFn2zdE9/rBSVk08NemoB6cPKdUFyzu29eVwKRJILKy6yKSMt4aGfRNJpLNVL9mJobPXJwExre5VDtcY/XL+9TkPniSCEKQ60MKL2gwJJy4bTC6JDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9jYpZkU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9jYpZkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730775130; x=1762311130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/fne5fCFChojEHGlVra1bCqeCuKKR9purCKtH81mryg=;
  b=L9jYpZkU/ObaOblIJOBtI2TqogxO7VYbcupTnAWGIfssnqIX+E1kfBiC
   IMWjvXSG35xDZP1q9n7suSbDmXepvHh5fYV8bQqAiFw3V6RvHB9fghx+a
   p0xmNQyR8/Tl7iFhXjC5c18hydcklBYMmU4d4m+2Lr+7RLxXWgVyUyCdp
   lSdMGlm9/Gl2kb66jeusOID2ROkxjrP/7e8EhEzx5dDvrx5oD4veyIIRo
   2lO2NoIUvv7oG/vAhkMCTecnNKu03eolElxborSenis1ICqJWQcG8ReKA
   MO7boK3fr/5tu+Q0tYOHDFzw+XM2qZuPNMnKZ1mwJMW9E0qyo/NnLTI7u
   Q==;
X-CSE-ConnectionGUID: a/t+/PadQYCnMTXeDO4DgQ==
X-CSE-MsgGUID: ZiVfwsBVSceYijB1Zrkdzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30452389"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30452389"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 18:52:10 -0800
X-CSE-ConnectionGUID: M6k3pBrOR0SsCckXJ4RWvQ==
X-CSE-MsgGUID: X+wSg261T76MbUkolaWTMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="114644999"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 18:50:04 -0800
Message-ID: <63b941ed-4f46-47e8-9fdb-211b6413137d@linux.intel.com>
Date: Tue, 5 Nov 2024 10:49:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] iommu/vt-d: Prepare intel_iommu_set_dev_pasid()
 handle replacement
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
References: <20241104131842.13303-1-yi.l.liu@intel.com>
 <20241104131842.13303-6-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241104131842.13303-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 21:18, Yi Liu wrote:
> To handle domain replacement, the intel_iommu_set_dev_pasid() needs to
> keep the old configuration and the prepare for the new setup. This requires
> a bit refactoring to prepare for it.

Above description is a bit hard to understand, are you saying

... the intel_iommu_set_dev_pasid() needs to roll back to the old
configuration in the failure path, therefore refactor it to prepare for
the subsequent patches ...

?

> 
> domain_add_dev_pasid() and domain_remove_dev_pasid() are added to add/remove
> the dev_pasid_info which represents the association of the pasid/device and
> domain. Till now, it's still not ready for replacement yet.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 90 +++++++++++++++++++++++++------------
>   1 file changed, 61 insertions(+), 29 deletions(-)

The change itself looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
