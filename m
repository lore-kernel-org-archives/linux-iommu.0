Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43620E31C
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729224305; cv=none; b=Nhh4li/urCKuyUpiw8QxYrBxPAy1mjiBQhrrhLe7ImIUpfKWKPrNH1v+uJYMkG+5ulTdGoMxPwKwTVKTqQ0W7q+WXWqjMNjLue3Sg7fKYC6b6Eu7Ti4+4e3Jr5ufxG1kD9IcSjK0hbdH6iAU1xdVlflgqN8F8l1ITlQmZoe++mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729224305; c=relaxed/simple;
	bh=RhO9HgF2c4ywndxIJOQRONYb70dEOOOvx6A3K/zv4Ik=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ObSF3f7WB5uP2Ym4BxSBC9LD1nyXFfv0QzR94nPpf8avK3FusW16ihR9h4kRu8cjglClBNGJxaQ9C6pao83D0ubPO8/vSLgmAOwVhdx+P+IIDnG3AR8KjAJakJo3nRNip+cRnDquaM3RUOLI/AxTBRDL1dxjtPZjlzvwvLp4icw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8kAt/sG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8kAt/sG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729224304; x=1760760304;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RhO9HgF2c4ywndxIJOQRONYb70dEOOOvx6A3K/zv4Ik=;
  b=m8kAt/sGmFELTBlr9VUmacgYeXmbiEakjiSoK5RD9/rG8vltgc3pPpAa
   ptuzveUrOLOWwapu0OhrsW9CfIkdftZp6Vy7h5b9GxTaJW31A0iwj1Cya
   amju06Q062TaEo85mneeifB1/I+0p62HH6Ef3te+McsX62dAbrlxaJosQ
   /MrDMSYgEanieuYzWg7wLCxZWarKtMeRPX2h2ZuURGNdQXySFGmSSh1+k
   Av5twMqQCAgcbix5hMiqd9oQJhXezyxyOoZlmrYUzTnpqO5H8lHMboZwZ
   ufL9d4f9lGoOzBNGj8bAuByumBC+ZyV8YvcKj4b7EMPDkqmmHKTCMD8dN
   Q==;
X-CSE-ConnectionGUID: QxfGgkz7RySk8ZIQhrI6gA==
X-CSE-MsgGUID: 6IFnasK4QOCPExHesAaKEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32541419"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="32541419"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 21:05:03 -0700
X-CSE-ConnectionGUID: iUvrY8QnQ3uu6G6DOwuUKg==
X-CSE-MsgGUID: 7MfdidbQRyaDzCcna61b4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="102051337"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 21:05:00 -0700
Message-ID: <51b7c19e-fdbb-4e2c-8d52-44a336aeec10@linux.intel.com>
Date: Fri, 18 Oct 2024 12:04:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 12/12] iommu: Create __iommu_alloc_identity_domain()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-13-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241017140137.6028-13-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/17 22:01, Vasant Hegde wrote:
> From: Jason Gunthorpe<jgg@nvidia.com>
> 
> Consolidate all the code to create an IDENTITY domain into one
> function. This the legacy __iommu_domain_alloc() path from all core code
> paths, and preps it for final removal.
> 
> BLOCKED/IDENTITY/PAGING are now always allocated via a type specific
> function.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c | 43 ++++++++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 15 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
