Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCD273FD
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244685; cv=none; b=XeRnEpe6ZVPy7glaKDw8C74WxcKqENJHYSnXt8ZZLK8yqytd2IvQS0pH8xMbYA8tR+nw3hGFeFA+M01j+Zxr3mYXXJ4fIpS8hnRh9xqcjsV6gUfdT0Xg1kG9onFWQ6FiaOkzpwmuZoENlZUwc00kj4h99P91vFEJpcKHQEYaY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244685; c=relaxed/simple;
	bh=ZuAo2ecop6gc7mqzQ6fpPAqXDU8HXYGy/NGQivWqyfE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ls0dwX75No4Si+RyWnSZ1sQrUUeHTUToEtyPHIshz3yYe18030hTBBqjdtlO0y015hmGXTVjOWSnGFAX5WkX+xLWz92UOSktvvL+YPjn9FguMvBHr26QMQTlqRJAHkTxLpit7JyAqi3dMVxbie4PyzI7USS+hZ3Aavuyos3wKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hi7CnpxQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hi7CnpxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244684; x=1756780684;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZuAo2ecop6gc7mqzQ6fpPAqXDU8HXYGy/NGQivWqyfE=;
  b=Hi7CnpxQug9eT5XAgSSdQvjFzd4rNX20OKYflZSAeSqqnw0UGV2qM2+q
   i9hqLTep+8bnyVQ7Dsx821nQK+8zkyFp61jRtQWFDGEMtj0ysI63sMKXj
   XLdRDHbXvMOBOKhzDMDBCZedS6fnohP5Tu3EQHeTxmprOgHbX5ABMB4Y5
   39t7RxY+8DrCcDiX3nfQZPsQGYTnbsDHute3AupRRvcDIFp28s34kSc5t
   ebAA0cTz1fSf7pB0uvFQBaRJSIdqPCZCb99BbhKU6tvT5XVi57HbcBr+S
   c1f/pWTdzH+X93i99ee3VOgFIGB+7P60kdyOFQSP/Ap29/SODIlsVAdu8
   A==;
X-CSE-ConnectionGUID: AR4SofE4QuiaZiCqUnqO1w==
X-CSE-MsgGUID: TtfGse1YRhOdXKYPedK7gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="27572840"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="27572840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:38:04 -0700
X-CSE-ConnectionGUID: 4r16Da/8RNSJRPL2iE8G8w==
X-CSE-MsgGUID: L9CtQ+afQvipDyErkYAYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69271303"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2024 19:38:01 -0700
Message-ID: <59fe0bf4-76e2-43cb-84e7-e044c2407c4c@linux.intel.com>
Date: Mon, 2 Sep 2024 10:34:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] iommu/vt-d: Convert to use static identity domain
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 1:54 PM, Lu Baolu wrote:
> Intel's IOMMU driver used a special domain called 1:1 mapping domain to
> support the domain of type IOMMU_DOMAIN_IDENTITY, which enables device
> drivers to directly utilize physical addresses for DMA access despite
> the presence of IOMMU units.
> 
> The implementation of the 1:1 mapping domain is influenced by hardware
> differences. While modern Intel VT-d implementations support hardware
> passthrough translation mode, earlier versions lacked this feature,
> which requires a more complex implementation approach.
> 
> The 1:1 mapping domain for earlier hardware was implemented by associating
> a DMA domain with an IOVA (IO Virtual Address) equivalent to the
> physical address. While, for most hardware supporting passthrough mode,
> simply setting the hardware's passthrough mode is sufficient. These two
> modes were merged together in si_domain, which is a special DMA domain
> sharing the domain ops of an ordinary DMA domain.
> 
> As the iommu core has evolved, it has introduced global static identity
> domain with "never fail" attach semantics. This means that the domain is
> always available and cannot fail to attach. The iommu driver now assigns
> this domain directly at iommu_ops->identity_domain instead of allocating
> it through the domain allocation interface.
> 
> This converts the Intel IOMMU driver to embrace the global static
> identity domain. For early legacy hardwares that don't support
> passthrough translation mode, ask the iommu core to use a DMA type of
> default domain. For modern hardwares that support passthrough
> translation mode, implement a static global identity domain.
> 
> The whole series is also available at
> 
> https://github.com/LuBaolu/intel-iommu/commits/vtd-static-identity-domain-v4
> 
> Change log:
> v4:
>   - Add a new patch to remove has_iotlb_device flag as suggested by
>     Jason.
>     https://lore.kernel.org/linux-iommu/20240807121712.GD8473@ziepe.ca/
> 
> v3:https://lore.kernel.org/linux-iommu/20240806023941.93454-1-baolu.lu@linux.intel.com/
>   - Kevin worried that some graphic devices might still require identity
>     domain. Forcing DMA domain for those drivers might break the existing
>     functionality.
>     https://lore.kernel.org/linux-iommu/BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com/
> 
>     After confirmed with the graphic community, we decouple "igfx_off"
>     kernel command from graphic identity mapping with the following commits:
>     ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic identity mapping")
>     4b8d18c0c986 ("iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA").
> 
> v2:https://lore.kernel.org/linux-iommu/20231205012203.244584-1-baolu.lu@linux.intel.com/
>   - Re-orgnize the patches by removing 1:1 mappings before implementing
>     global static domain.
> 
> v1:https://lore.kernel.org/linux-iommu/20231120112944.142741-1-baolu.lu@linux.intel.com/  
> 
> Lu Baolu (7):
>    iommu/vt-d: Require DMA domain if hardware not support passthrough
>    iommu/vt-d: Remove identity mappings from si_domain
>    iommu/vt-d: Always reserve a domain ID for identity setup
>    iommu/vt-d: Remove has_iotlb_device flag
>    iommu/vt-d: Factor out helpers from domain_context_mapping_one()
>    iommu/vt-d: Add support for static identity domain
>    iommu/vt-d: Cleanup si_domain
> 
>   drivers/iommu/intel/iommu.h  |   2 -
>   drivers/iommu/intel/iommu.c  | 468 +++++++++++++++--------------------
>   drivers/iommu/intel/nested.c |   2 -
>   3 files changed, 201 insertions(+), 271 deletions(-)

Queued for v6.12-rc1.

Thanks,
baolu
