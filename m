Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01826FDA5
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170329; cv=none; b=WqhFupCtFkACPNYuDZptSmS3lKT69D+7YUnuTfGUk/aEBH43kcGyo8j2YNGjbOEInEr6PpY30K0Q6dbSUdEHPx5pZR2nYAGyHTn5/yie1iNdlrg+D8+/8wP41znxfaxIjzhmJP9xmtKNBtGDhprwddtKPTOZ3d53Fex1076empY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170329; c=relaxed/simple;
	bh=19A0BvKwdFkVmHRkHRoUDIQMJZk61HiWjl6v7LFzehk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3ChdaaEEz5bP9BdcvY5jGor/cA4gEupXeOHh/YzRCMSmC4GNUbdThizco/KRULdX2x7d5dpV+V3xEKQm3s5cFwm91gpa7kZm65xxpH2uZwigUjxVSsWEvBHAh3KDUlOY6/uxq/v16fuqzaCMddpxpgfnizzWav2bGdRlv023qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eo2yvznA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eo2yvznA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758170327; x=1789706327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=19A0BvKwdFkVmHRkHRoUDIQMJZk61HiWjl6v7LFzehk=;
  b=Eo2yvznAGwifVi97UTEQNTuLJ8wERNm+VslZgX/jKGX3nLz+ZWMbJGhu
   KAKcB7czO8+Wx6q22ziNTJbAjk9+Mp6LiRIcaPqsdSf2l45gHbKSSZgpJ
   Q6hLR5Zwv+z8xG4YNMC7+VyCVAzuVi8mxIoJEYQYHAojuJlzhzpY8ofpc
   9/7gNfkp9e6Clca7Qs9p/HlhFox/Jeu9eCS0M+socg+bdmKGAIT72BAu5
   yKEGqUJVW3lRT3jhILVIhOjkYv7Twu0dRMTUWM3Y2WMp7cCYhgnwrHAcy
   ucTi0TMREmBZl4vdVwR/Dph7upbQgZr5aH8zbSFPuYDzKr1oEFGqEkcMW
   Q==;
X-CSE-ConnectionGUID: kBTBUeEHRYCFw5h+KgIvLA==
X-CSE-MsgGUID: FctmNFvgRX6PaQjPAhfs+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77926692"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="77926692"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:38:46 -0700
X-CSE-ConnectionGUID: S6AmySZGSwyeM4AyhT6QMw==
X-CSE-MsgGUID: huLf3JqOTFelvrAkfCtHIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175826986"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:38:43 -0700
Message-ID: <66aa72f4-6630-4270-830b-0252f650529e@linux.intel.com>
Date: Thu, 18 Sep 2025 12:35:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: PRS isn't usable if PDS isn't supported
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250915062946.120196-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250915062946.120196-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 14:29, Lu Baolu wrote:
> The specification, Section 7.10, "Software Steps to Drain Page Requests &
> Responses," requires software to submit an Invalidation Wait Descriptor
> (inv_wait_dsc) with the Page-request Drain (PD=1) flag set, along with
> the Invalidation Wait Completion Status Write flag (SW=1). It then waits
> for the Invalidation Wait Descriptor's completion.
> 
> However, the PD field in the Invalidation Wait Descriptor is optional, as
> stated in Section 6.5.2.9, "Invalidation Wait Descriptor":
> 
> "Page-request Drain (PD): Remapping hardware implementations reporting
>   Page-request draining as not supported (PDS = 0 in ECAP_REG) treat this
>   field as reserved."
> 
> This implies that if the IOMMU doesn't support the PDS capability, software
> can't drain page requests and group responses as expected.
> 
> Do not enable PCI/PRI if the IOMMU doesn't support PDS.
> 
> Reported-by: Joel Granados<joel.granados@kernel.org>
> Closes:https://lore.kernel.org/r/20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org
> Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued for v6.18.
