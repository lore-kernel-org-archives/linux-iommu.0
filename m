Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26433C518
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026071; cv=none; b=Lqa4aLadFYAP9F8O2t3XGCGhyjJ5UwUcwDrWCX6YJSV2+GmBOMHuqEIA0C4Hu+VT1KrMuTpKnxIVeYCQOOVhXYkVwPSaCVK4zQHYBy3aAWigwT6sgWqvxPUwg1S2J785erMN7uhQTi2UG5gCiR3HBmd8LfQO3qz+3Ahdq82rkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026071; c=relaxed/simple;
	bh=CbFKyfFPHPhZgNv/Eflo/dSNHYuCZu6tOve6mW/PAHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi4kI4zeielX6gSXEA6nwVX+awWkpEPaf12DLXhbW4L0gZRNkfPZvE5nz8Prk7EqetiLcdc2CFOc+/P7nVV6DvnCHyxe+8Vt0dl2ITCEmHa9Wkrehdj1vu82WfsCcyF4K4nYM3qG5wmNeRQ2FTfriElX8egulpBB12igCkgM6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrQxnYYd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrQxnYYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775026070; x=1806562070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CbFKyfFPHPhZgNv/Eflo/dSNHYuCZu6tOve6mW/PAHI=;
  b=YrQxnYYdd05dQ4219prBlvQEYdLLfp8r+zg9xOTTvdMXnKcJ7Xfi4Biy
   ApWIXdlEmuGbCJZ+RMAVbO/wHYoiWdyPeEVFzvnU3DJFGryg0iKXIu++a
   WO5acYXywgL21DippuM4KtbKIRussiGSXAo/zZ7isW8fi/H/SqvIDyC1u
   9iq4YCUSG0d2C4zdXSLyEWfhS6GC5fDzvyfekJs261idXudtSkCAOPAB9
   LCFmlqBQnNxQr/+wlBunq7wbLJalX/PryTXO7r5zwvbNFuHTYLznAIqdV
   u8iiFSPvKrJdTDM9p8F+2tm+rVLx8shcbK641jivYee+LPfGUYg3Yope/
   g==;
X-CSE-ConnectionGUID: b4W5yQevSQuv4uIxi4hweA==
X-CSE-MsgGUID: FUzkYQ3ASrCIngjlpx5MsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76068653"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76068653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 23:47:50 -0700
X-CSE-ConnectionGUID: PcllIZe5Qje1nnyS8NsDew==
X-CSE-MsgGUID: V1e3lvHwQyuQsbMKU2S1ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223711833"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 23:47:42 -0700
Message-ID: <619eae3d-db3a-400b-b733-f9ee8340ee17@linux.intel.com>
Date: Wed, 1 Apr 2026 14:46:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iommupt/vtd: Support dirty tracking on PASID
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, yi.l.liu@intel.com
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260330101108.12594-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 18:11, Zhenzhong Duan wrote:
> Hi,
> 
> When we add pasid support in QEMU for passthrough device, we found
> PASID attachment to a nested parent domain with dirty tracking failed.
> 
> It's because PASID-level dirty tracking is not there yet, by adding it,
> we can enable PASID attachment to such domain.
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v2:
> - a new patch1 to add a check in intel_nested_set_dev_pasid() (Kevin)
> - s/device_set_dirty_tracking/domain_set_dirty_tracking (Liuyi)
> - add R-b
> 
> Zhenzhong Duan (4):
>    iommu/vt-d: Block PASID attachment to nested domain with dirty
>      tracking
>    iommupt/vtd: Rename device_set_dirty_tracking() and pass dmar_domain
>      pointer
>    iommupt/vtd: Support dirty tracking on PASID
>    iommufd/selftest: Test dirty tracking on PASID

Queued for iommu next with "iommupt/vtd" changed to "iommu/vt-d" in the
titles.

Thanks,
baolu
