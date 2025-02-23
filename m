Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1C1632DD
	for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740317337; cv=none; b=n/ciWNz261ngT+8oJ4Gqkknolj8x8Wkh9sVUrn97BaGti2NWU5ofJrRLYZKzBwOx1+vZalKwKuP7I0LhWtCoCcqY8m1rPkMD9l+hoMQdKnc9nDgFURFHvai67SgwROAuEigiS2aBjR9pp0NX0/xBdkYBqiDZqCVTt4SfnD2UIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740317337; c=relaxed/simple;
	bh=cf+ujsWDPpezjKm+2ZmEyxsYqYVQj2OS7Bz0mD6l3Yw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jC2vg4Xg3RxQ2G+hCDR7g1ZU3lGb9i7X35jM2iAdDI4yN1YfABFMWSTnFLsrxf2mvk2LH2Tz3O6ox/jsytQl3PcZ3KLcxGoHpstnWFm2WlKHT7FLT2lFHoBfn/koDBcBl1J8vdPP5nnXHuFmAWPKz5fVktwuB8/PJncAwNUtYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acFEVjEX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acFEVjEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740317336; x=1771853336;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cf+ujsWDPpezjKm+2ZmEyxsYqYVQj2OS7Bz0mD6l3Yw=;
  b=acFEVjEXcdZN1dTq6L76r2hiMplcU8bXSvurRJ7jny7N4mqkzVsXwdMl
   8rBS5d7HBEtihHSJmNp60xikWUeSHAQFesoZEUK3qgdImM/IWhghWxYpj
   RQx4+/LPYoEGQVdweLdp4uKT5JiW39yN8wPeDHw1GErztQtnHw+nSq/Dn
   Js1tDV04LkqSlReyDgWJYODcoRbBYTdJDnRm5zLc4Yyf4pj9BB2KfG6wa
   PBdoqEPTor157qrt9gi0oyJv+js93gBbBNTvumH5wZbUud4/LhORADzNW
   2LkeUXEpEyquhrNfmzQFUxlKeXRjRQrUdT2zcxM+lCv33sbvvCDDefdoC
   A==;
X-CSE-ConnectionGUID: U6K9KdmyTca7a7a8pAPuSw==
X-CSE-MsgGUID: hoM8Z1lCTwmXb4DA7JXCSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="51294186"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51294186"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:28:55 -0800
X-CSE-ConnectionGUID: QTdmSC/lSaiYcO+jTvGeqg==
X-CSE-MsgGUID: m2JRFll3TqmEYEPM3CBT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120737871"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:28:52 -0800
Message-ID: <d37ab69b-cc70-439e-ace6-2fc4368149f6@linux.intel.com>
Date: Sun, 23 Feb 2025 21:28:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, iommu@lists.linux.dev,
 robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250221143335.49874-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/21 22:33, Yi Liu wrote:
> The current implementation stores entry to the group->pasid_array before
> the underlying iommu driver has successfully set the new domain. This can
> lead to issues where PRIs are received on the new domain before the attach
> operation is completed.
> 
> This patch swaps the order of operations to ensure that the domain is set
> in the underlying iommu driver before updating the group->pasid_array.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++------------
>   1 file changed, 32 insertions(+), 12 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
