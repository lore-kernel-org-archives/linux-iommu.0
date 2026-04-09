Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228C36402C
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704849; cv=none; b=gTpDQV5FEYXEPXRGhuKzkJTNaWJpAv2ROoA3pNgQ7OZQJYLsXT1tWLR8UDbc9gO1gVjXCFg7cHRZDkTcWGec8Crvm56TvYjheDpgPSRqWZzuLvpv1W8W61L7Cp8MG7WJKwbnvPzh+zbXFXOkDyRAb1tC23FXYhY+0gTZaqXr5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704849; c=relaxed/simple;
	bh=Ivsyot8mqUOYIdy2/sTMMWw3NQ/o7YBNzjGMtdIhThU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWoANi35ClYxcpS6wo5PWhJ5qV22XrsGY8/bciaeiWRLTSbaWPBmTG/sJifMFrZuEcRbyERbgPPlAM0UjW67j33VYp92dls4Htlx4a3VmEBl9AIelJ/+TmZPvbimqwpLTlrLO0BtXBjmUxC30pIUN0xL/cqz8bMACPfkHMxVrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k21enlUW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k21enlUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775704848; x=1807240848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ivsyot8mqUOYIdy2/sTMMWw3NQ/o7YBNzjGMtdIhThU=;
  b=k21enlUWNe7B39cMPt1aAWdA479CCmevQYd/6ldzdWMNBLj08TFGR6Av
   uL/DZqbTYHaWilWl7A89Y7nB1YdwVI2+1w1DVMjXbNx8VYbBlxwCC4QYr
   W42gFjlUfHNT8jGiKkZw20UA/1YSLqaqCrPRQ12vHY+Drj+iDCcKFePMq
   OkSkuJWe4uyAoRX6wtTEaF3334m0MQ88LiRx4luAfoZat5AULUTttFXCD
   iuC7CNp8ZPZxB2skkHR9MBjtOCkhbeEg8FDhef8LY3JWSJyFzlScjZfgE
   +IrBSh3ppZ8w78Uo7kF2ofw0k/NiLWItw1biPh7yE8ixZ413G5loGiuCB
   g==;
X-CSE-ConnectionGUID: 81IxMwa6SuyZ4WwYL8UICQ==
X-CSE-MsgGUID: Znc7UuHzRHSBkYR3JWAEeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76823371"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76823371"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:20:47 -0700
X-CSE-ConnectionGUID: xK9djlm/Rj29Fb1x8Wa+Uw==
X-CSE-MsgGUID: TW4WcSENTAu0uHA/gHXxaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="228885053"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:20:46 -0700
Message-ID: <6ce82bd0-5f19-4dfa-97ca-d0d69b098229@linux.intel.com>
Date: Thu, 9 Apr 2026 11:19:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY
To: Alex Williamson <alex.williamson@nvidia.com>, jgg@nvidia.com,
 joro@8bytes.org
Cc: kevin.tian@intel.com, robin.murphy@arm.com, will@kernel.org,
 iommu@lists.linux.dev
References: <20260408184443.3077333-1-alex.williamson@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260408184443.3077333-1-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/26 02:44, Alex Williamson wrote:
> In removing IOMMU_CAP_DEFERRED_FLUSH, the below referenced commit
> was over-eager in removing the return, resulting in the test for
> IOMMU_CAP_CACHE_COHERENCY falling through to an irrelevant option.
> 
> Restore dropped return.
> 
> Fixes: 1c18a1212c77 ("iommu/dma: Always allow DMA-FQ when iommupt provides the iommu_domain")
> Signed-off-by: Alex Williamson<alex.williamson@nvidia.com>
> ---
>   drivers/iommu/intel/iommu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
