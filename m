Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB41581E5
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627066; cv=none; b=n3N+iPsZfHmMJvwhBaVi8cZ6jjTwBEi+1/uCzcFo+Y2Su+zilRCHl1Wek9Pa0rI4BWBcFP+jT65dJuJSdo8nBi8ozAKcvMdIf72gfPG7TjWPFBUL0BG834uw2wM0V7txE9QExIp4TZz9iCkgdVnf5Mk7jSRMaoSaqt4VfqGkdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627066; c=relaxed/simple;
	bh=sIvX9knboiy572KwA/he8bco01FrgaVPOppe+DDLGlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5cKWPW4hpWLqXiiplTWm/YrOTczjMfSiuuIc9acnTKhCJ9c+vIwNuixNUF6kGAMmdi+j2i/dgFlshG0PsbHY4vlZrzEXmBRmo2JzbfMa7TqeY9coAVNOpvpviC6rHS0B/Yqe7oh1m4x+ry45mQ8EEZgscIYKK3sqfu/blevJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvBrZv/1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvBrZv/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740627065; x=1772163065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sIvX9knboiy572KwA/he8bco01FrgaVPOppe+DDLGlI=;
  b=NvBrZv/1/oSR9At0VW1vYuNhPdQttKMVO3CM4N6rIIoT1Ic+E1hKxpSf
   C9AR2kT1uP2nqZ1rIwT9sP7jCKc1xyZ68TLxLmjjjFOfpnxbPfwItUXOJ
   I5ZleThOkjkSilHuQvod8L5EToFc7G1RZFa+91vhqDNlaCiz1TQ1Nsq1l
   NwhYmUT/dFlZ9z6sjdLLGk/o7J01+x+65HjXXKUKD/oW861SE/3+B3k/Z
   d622At44kUpLgbgS6Ypdd6DiYR98wQ0fHb3m3uKzTSqv8qTvsm1OWMEsn
   2Va6Vd9MzzSq+4mLqwuDmI/7r/uVkNBk/2hemn4hUg77LhULu4JUCDufL
   Q==;
X-CSE-ConnectionGUID: yQ0lrNl0StyF/mZUJnlTHQ==
X-CSE-MsgGUID: vGzBcvd7RHaSEOYPua4ulw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52899533"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52899533"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:31:04 -0800
X-CSE-ConnectionGUID: J0gfdJg4TfmAsGN2gg0iDQ==
X-CSE-MsgGUID: LYUW3+xERKy6mAm0DgolZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117386951"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:31:01 -0800
Message-ID: <8839ae2b-014d-40bd-93ee-89a5791f95ce@linux.intel.com>
Date: Thu, 27 Feb 2025 11:27:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] iommufd: Support pasid attach/replace
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226114032.4591-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 19:40, Yi Liu wrote:
> This introduces three APIs for device drivers to manage pasid attach/
> replace/detach.
> 
>      int iommufd_device_pasid_attach(struct iommufd_device *idev,
> 				    ioasid_t pasid, u32 *pt_id);
>      int iommufd_device_pasid_replace(struct iommufd_device *idev,
> 				     ioasid_t pasid, u32 *pt_id);
>      void iommufd_device_pasid_detach(struct iommufd_device *idev,
> 				     ioasid_t pasid);
> 
> The pasid operations share underlying attach/replace/detach infrastructure
> with the device operations, but still have some different implications:
> 
>   - no reserved region per pasid otherwise SVA architecture is already
>     broken (CPU address space doesn't count device reserved regions);
> 
>   - accordingly no sw_msi trick;
> 
> Cache coherency enforcement is still applied to pasid operations since
> it is about memory accesses post page table walking (no matter the walk
> is per RID or per PASID).
> 
> Since the attach is per PASID, this introduces a pasid_hwpts xarray to
> track the per-pasid attach data.

I feel that this is somewhat redundant with the pasid xarray in
iommu_group. If iommu_replace_device_pasid_handle() were modified to
include the old domain that was assigned to the PASID, the following
patch would be unnecessary?

https://lore.kernel.org/linux-iommu/20250226011849.5102-4-yi.l.liu@intel.com/

> 
> AMD requires using PASID-compatible domains for PASIDs, hence the hwpts
> directing the PASID path requires to flagged with IOMMU_HWPT_ALLOC_PASID.
> 
> Signed-off-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Either way,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
