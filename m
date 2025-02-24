Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81F7E0ED
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740359162; cv=none; b=F6/0qz6VhoB6KZTA42hoJuBMm8BRIf1YdRvKtvmOtpbruxsksdwamYQcvwSDNYQwac9nkbJmHZ43KoIY5Nf52zFPpEGslSDg5/gOCqPhFz079BsZZiql8AsB1+vmGjTna8+7iEtEqGb16H/RNYmrjlu7czvg2thPP9MjFsV8iCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740359162; c=relaxed/simple;
	bh=oD3Vv1xLKSqblwXCvn7mLey5f49zi8MvqKFaIX/dRQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MxKy6wyUl2BehSmyjuxJO6Dpojd6mSMEXs6MUfgCg3PH3jAX2k3luzPApXM4K+DcouNjcjguI6VrZDc3KRC1XS2KpnWv9VlCGY4ICX3P34e7fqEyVPYqjq03xNv9bnYcCmfxw51U6Lfcg9IpgyHwhyMo3Mr69lkx3bvZXdaZL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcWh1/27; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcWh1/27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740359160; x=1771895160;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oD3Vv1xLKSqblwXCvn7mLey5f49zi8MvqKFaIX/dRQg=;
  b=WcWh1/275rvOMQc33x+B+DGR4moJjBa5zOrnX22lLtBGCCGJzMsjDiJC
   q5E9EMBK+o01BQz+epM11X42sJaeBLoZyJPTmNdW/K7DlvPHsXquB5f68
   Ot9e7esetZH14MxI7eZPZEqSQ98SrP/+a0vkOJImAIm/xKl5yjMyTDbT9
   tmE5GqvTWSRMs3dQJVnt5efKJwDcptbBYxFabn758ioO9VVv1u0lxjxbT
   zCrwWMJJwHfU7yKtw55aiDAHaOuSsRcJmdrAv8hpnv4vl+nGVxWNxYOZv
   Rv64HmyA5Ag49dotSD1h5Vzlk+ly3NlBFpJHFc6Ug9ZHwp/oWnELxLOXi
   g==;
X-CSE-ConnectionGUID: vowzhlPRTaiyz2g5Ohiltg==
X-CSE-MsgGUID: Tpnu8EyAQpKG6vMLDx/4Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="44882017"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44882017"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 17:06:00 -0800
X-CSE-ConnectionGUID: Epy8D3qSQWC3bRgDSjLA2Q==
X-CSE-MsgGUID: b+C6eWWSRRKUQWmH0oINsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115887458"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 17:05:59 -0800
Message-ID: <622aa790-6560-4be9-bfb4-736809a249bc@linux.intel.com>
Date: Mon, 24 Feb 2025 09:02:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250220101511.37602-1-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250220101511.37602-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 18:15, Yunhui Cui wrote:
> When entering intel_iommu_shutdown, system interrupts are disabled,
> and the reboot process might be scheduled out by down_write(). If the
> scheduled process does not yield (e.g., while(1)), the system will hang.
> 
> Signed-off-by: Yunhui Cui<cuiyunhui@bytedance.com>
> ---
>   drivers/iommu/intel/iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cc46098f875b..76a1d83b46bf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
>   	if (no_iommu || dmar_disabled)
>   		return;
>   
> -	down_write(&dmar_global_lock);
> +	if (!down_write_trylock(&dmar_global_lock))
> +		return;

If system interrupts are disabled here, locking is unnecessary. Hotplug
operations depend on interrupt events, so it's better to remove the
lock. The shutdown helper then appears like this:

void intel_iommu_shutdown(void)
{
         struct dmar_drhd_unit *drhd;
         struct intel_iommu *iommu = NULL;

         if (no_iommu || dmar_disabled)
                 return;

         /*
          * System interrupts are disabled when it reaches here. Locking
          * is unnecessary when iterating the IOMMU list.
          */
         list_for_each_entry(drhd, &dmar_drhd_units, list) {
                 if (drhd->ignored)
                         continue;

                 iommu = drhd->iommu;
                 /* Disable PMRs explicitly here. */
                 iommu_disable_protect_mem_regions(iommu);
                 iommu_disable_translation(iommu);
         }
}

Does it work for you?

Thanks,
baolu
