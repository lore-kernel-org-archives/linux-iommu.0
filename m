Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5901270031
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628161; cv=none; b=dVrlmYlw2ftYV/56LKij38tyZ3BuaOORPd23ZJacB7z6s/4dc7s78Y/6Qpntm3Jc9WguE26fKHMPB95wNCBHjqU3e0jOjts3Iy9wNsyxYHe31al92RY42sB2qHtvhisUylMNtODh9tDZ9Vtio+RKFw/9xMzwtcJLlI0M2G8A/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628161; c=relaxed/simple;
	bh=j/P4RhfiAsmQrLDYUd2fouHU/qTrqu79tHMStWc5Es8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJv3KdeL43eyp5cFWluAFn2LE57QAw+UtxfvykdY8Nla9ys0gcEGBA1V6J5oAtnPMHmGrE8CANlagQJqQzUal5Ezs/JOXTC5ueam5E9prBtlkULu659DvuhyyLHovL6H7K9NiTkgTHKv4fkUfGuf4CaD21x7gmVGVuBdJ5NmA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1lKjZRV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1lKjZRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740628160; x=1772164160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j/P4RhfiAsmQrLDYUd2fouHU/qTrqu79tHMStWc5Es8=;
  b=G1lKjZRVDiS0FpyBqM0NJE2+CiE+b9jh3s3HpCFSZ06M8G3qVFYxAXUP
   QXbKTi9UJBoxKfho03SkBlhIxJONDTQxqEw2kvCNZusDo724Mqv9cwAqF
   wXu0AXYBJC+LEdjBDADofgEG0ihm3BVUJ7I8OjIFa0ssGSoxSKIMden2K
   n/GvzvOV/iZlDbdxUEr0v47Dbf5xnOTmCVwiruUMbfyICccJiiJSLUHf7
   y2TTC7zGG2LBDtLb17Maov4XbaahKx//KZuj1mlKsCwN+VgvB5baDyAJc
   Nk8LC4Xl9hGQBggzEssKNIGFuZhQv0rvg7g1A8sT3Tl1xp5bjXhVJiaLh
   A==;
X-CSE-ConnectionGUID: z5lQezjOQBGAg0harGFslQ==
X-CSE-MsgGUID: eDe30wO2RR+MRpuBjZCeGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40743685"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40743685"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:49:19 -0800
X-CSE-ConnectionGUID: DMJyz6shTAyIEnTVHzP+zQ==
X-CSE-MsgGUID: qXw8KO4LSLucJ/W9KBPb8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117818471"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:49:17 -0800
Message-ID: <6d580104-eaa9-4315-8140-a88a2a05d38b@linux.intel.com>
Date: Thu, 27 Feb 2025 11:46:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/12] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-9-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226114032.4591-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 19:40, Yi Liu wrote:
> Intel iommu driver just treats it as a nop since Intel VT-d does not have
> special requirement on domains attached to either the PASID or RID of a
> PASID-capable device.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
