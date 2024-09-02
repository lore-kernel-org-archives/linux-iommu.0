Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D624A08
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244894; cv=none; b=GIQ2MlBbTuG4SM9gNXLwGJyJaaN/UJPcxpnCZpuqoQJS2SSVAIE043mJPi1Qr0JLaaWo8P/iV2WDHMVdkcnH2C26OUjEVW1AXK0MPoY0dJN1zrkh17INqCHSJqqJeh6VvWLPRm5Sj6U0JcXIygLMvMEor3ZHiOGCTp/s8lL6Kog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244894; c=relaxed/simple;
	bh=fPmbLSUA16Yr1yhBmQ/34GpFWwoHllKNmL+2+w1CtS4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kLOe3aBk370EXEw41btIDSuf7qBKixB7Ooya74Sw+HS4Wg1C90ko3HHatJMfgzTEzp0HxQ06kl7UeHkRtKSP7m4kHn3fALO3PVXW4kqtgF4V+RcFw4YXVR6d/VwUeZCtVUrmT2z4Y9UZwnDuJpd6TxuUq3F5B1ZsBRPBV2XU0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuKlRO1h; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuKlRO1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244893; x=1756780893;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fPmbLSUA16Yr1yhBmQ/34GpFWwoHllKNmL+2+w1CtS4=;
  b=ZuKlRO1hrueG46SBq9kqGeR87uNIgQfAYy1RONadO834w9u9VvqqdQHr
   KGTTuoot6nVVeSllEhs1uHchRW9hZQRmiPSNhIpruRLfhdf+A0yAcpjGP
   Th4Z4ZOM5xhxJ+eL0dBRRO9LJ4C7BwnJsAkNZ6CLNC2wzdL6261io4hzD
   oG/IS6vgO52eQJexzhdMKDFIN46jOWZktGE1VDDXUoiNXP3iwfu2gtZD6
   HhkaIg/pZATXY6TGaLaYZC542Olz1ki0jXmn4FGeG1cFfUm/4T3fXQe+S
   V6DodBtb4esdeXPPdgOybzRNci0W7rfZuvsOcuWYieyjvSrHet4Sb+m2l
   w==;
X-CSE-ConnectionGUID: ZNpjRVMpSsu89QfoKqUd8g==
X-CSE-MsgGUID: rhpt3hJ2S1GUJw+kv62DVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41292028"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="41292028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:41:32 -0700
X-CSE-ConnectionGUID: zwbRTF3nTuSsKtEKIkegnA==
X-CSE-MsgGUID: VxX0hpXaSS+gSZ6xa9Yj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64826977"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2024 19:41:31 -0700
Message-ID: <8e9d96af-0a1d-493b-9ad6-154330902216@linux.intel.com>
Date: Mon, 2 Sep 2024 10:37:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move PCI PASID enablement to probe
 path
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 1:18 PM, Lu Baolu wrote:
> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> attached to the device and disabled when the device transitions to block
> translation mode. This approach is inappropriate as PCI PASID is a device
> feature independent of the type of the attached domain.
> 
> Enable PCI PASID during the IOMMU device probe and disables it during the
> release path.
> 
> Suggested-by: Yi Liu<yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)

Queued for v6.12-rc1.

Thanks,
baolu
