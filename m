Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47426ACC
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106090; cv=none; b=WrPXI+sX14M6C4iKlny9sSpMq33rhOhnQQ0CJi7aorrr6teIetV2p2AvDD+9RO2azZZ+BxRU0hdkyUAAxZt+F/yKmTR4MbQNPblhkc8PUykhl+RLKBrxIz+qhOkrjJRFM3w3zn7cwmEaT5WXJLGKz42y2Qq3Q+15xCzUa1dUfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106090; c=relaxed/simple;
	bh=B69Fwo2+QzZx7dEcmRg5efB3EDdp/0eOzcDVsXpU7gY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QTSffypPkD8fH60mXA6pf9oaEqQBWnEo92pmhxvZQ4sEynSAL8zi45gkIE5B1bM7ytP9YKUDof4E2XDHpagQDd25kriGTnwpe99eeLe52NQanUL49fdIWNvWoc9173XnFeAlTSDSiEo4MeK2t5gMBsRfRCPG8UuSeib49klQLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TT0Kz0Wb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TT0Kz0Wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726106089; x=1757642089;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B69Fwo2+QzZx7dEcmRg5efB3EDdp/0eOzcDVsXpU7gY=;
  b=TT0Kz0Wb90EJ1ZYOe/ePeGknJ3urEHmugVjGezV2riauf+cIU10UxgRi
   yWPjp5u7ynUoWc9J/tES0jwLgupAzdulLO/WUHvTA+TkCN+2ORCFz+RSF
   Tuojc4ldPGtWC+S6FYIo54GM21iKyabMqwtvdg+8NbEfxYVGG9DVbCQZG
   PUMH7nw4ctNPdHtAbMaSREWFfTdlyUwTQzEJEg1929+WIkOAu967mPKe2
   l9/KHvlODfdwzQi7zYMv/LTQAtEb2Agu8TcSxuTNCkYoXRs3LV2FxWstq
   yN9fMfh/gVm6jd/D6B4+d/5AuHz6g81ABDJ7cM5ba2yCkh7sv59B2wyol
   g==;
X-CSE-ConnectionGUID: Ap8JtKU0SlOPWC/Jq+0f+w==
X-CSE-MsgGUID: P599eh3FRPGPAZPbtcxfEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28715424"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28715424"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 18:54:48 -0700
X-CSE-ConnectionGUID: V2kW2m8HT/ymiGu0AhX6Dw==
X-CSE-MsgGUID: Fia8KVdOTnaNe3FwJwZu5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="68055719"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2024 18:54:45 -0700
Message-ID: <7727e184-e089-421a-acc7-6bffc42177eb@linux.intel.com>
Date: Thu, 12 Sep 2024 09:50:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-2-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240911101911.6269-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 6:19 PM, Vasant Hegde wrote:
> From: Jason Gunthorpe<jgg@ziepe.ca>
> 
> Following patch will introduce iommu_paging_domain_alloc_flags() API.
> Hence move domain init code to separate function so that it can be
> resued.
> 
> Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
> its required in DMA API mode only.
> 
> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
> [Split the patch and added description - Vasant]
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c | 46 +++++++++++++++++++++++--------------------
>   1 file changed, 25 insertions(+), 21 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
