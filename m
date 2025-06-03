Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3C13D8B1
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748918433; cv=none; b=nYpbrcRqozPpj2M+EVrL8a6adjYCkjYHafrf66aYWPBY8dlnaWFZ4pCLXpIxGOhU8nScPN7UCQ686HdnAqftJjTEhC660UWIH+zeWMBKau0012aK+271JCg5JTF7rcOLAo0nvuaNdM9tnH7DM3gEcDmVhunh7azM4f/gHbT1xVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748918433; c=relaxed/simple;
	bh=z79HJX12PybKRm03vtiVeVVDeotWtfjwn701t6R8GZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m7TNLnDLqaiC69KaEQ7WBzN+WfCZeRR8263tg0t2K/yYhLojyYFMtg8lujOrTBHya3CchGwUk1eUs+MiADrRdg11pwwgj9xJxIK6ToZPh2fxh1nSOnaDmRS75Jf7oAMfXCn/wCpRpZQLMVGPWHUOvMwyTYgq1mBx6HdOuhMLrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeApfnW3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeApfnW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748918430; x=1780454430;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=z79HJX12PybKRm03vtiVeVVDeotWtfjwn701t6R8GZU=;
  b=YeApfnW3jBk8AXat04PrnuaTVkXB/ccORKZjjaf8To/de51mTntlWuUE
   MNuPB96TFumCP61f8+hKjCXzWAbgEiKj0oQ2/C1NoIna1K2ibPfW5h4c1
   3rlYknwrBd6JrfZCVkmNWQnTj/nScE+yZkrHEQJZDhQTyBM6hmoqPyQ78
   XrGogRknZ4PkElOxcdpYXPimeIljCYSQIWG0kveySYfjtxzRKpnczAJu1
   JGK1OfSzy+/Oa/jJuYE1ryD8rf3FGx8eWL6RNYziF46PIB6byvahNeAJ0
   eUAYKveIldHisX9PtnF3ZwzDUOac3oGOeuKQFyzQl/SulvcZouTAsOQ88
   Q==;
X-CSE-ConnectionGUID: kpw3HFHKQDe2xKClMhPi3w==
X-CSE-MsgGUID: hiMviabaRNiXL/Cn/rvK9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62297144"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="62297144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 19:40:29 -0700
X-CSE-ConnectionGUID: 7ZX6FMdwR5uzqPvWGK3BWg==
X-CSE-MsgGUID: F8yA2VMbSaa8f8MVamXl1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="149872896"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 19:40:27 -0700
Message-ID: <f1f55968-28e0-4c5d-876b-1c5499b3c01a@linux.intel.com>
Date: Tue, 3 Jun 2025 10:39:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/vt-d: Remove dead code in
 intel_iommu_domain_alloc_paging_flags()
To: Wei Wang <wei.w.wang@intel.com>, kevin.tian@intel.com,
 yi.l.liu@intel.com, dwmw2@infradead.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250530091325.694456-1-wei.w.wang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250530091325.694456-1-wei.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 17:13, Wei Wang wrote:
> When dirty_tracking is enabled, first_stage is set to false to use the
> second stage translation table. dmar_domain->use_first_level, which is
> assigned from first_page, is guaranteed to be false when the execution
> reaches the location of the code to be removed by this patch. So the
> handling for dmar_domain->use_first_level being true there will never
> be executed.
> 
> Signed-off-by: Wei Wang<wei.w.wang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb0b993bebb4..1145567c60f9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3418,13 +3418,8 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>   		spin_lock_init(&dmar_domain->s1_lock);
>   	}
>   
> -	if (dirty_tracking) {
> -		if (dmar_domain->use_first_level) {

This *explicit* check enforces that dirty tracking cannot be supported
for a domain that relies on first-stage translation due to the lack of
enabling/disabling dirty tracking support.

While this might appear redundant, this prevents potential issues
if related code is modified without awareness of this dependency.

> -			iommu_domain_free(domain);
> -			return ERR_PTR(-EOPNOTSUPP);
> -		}

Thanks,
baolu
