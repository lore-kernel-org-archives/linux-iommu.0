Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442601B0406
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127246; cv=none; b=CIZZ/qLEAI2X8qVw52Nj8vZzRDxW5PZIdJ+9CN8bA/nOXFIEABhOR7Kg3qVz5SjQPcUiy7knWVxcG+gqsfPukeBwpQ7tn6uDYwRNHa+HXsB9M+xOjvC92EDAIN0UaWilv0BB8UPXpv8q4xz5NZnjkuWqC7ZDHmxDK4TPH+6B9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127246; c=relaxed/simple;
	bh=6c1PzwN4NRYtcuftWBGGwWofWdbrcsG9TaB1kFxsjk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JxBmltS2jm8XV6H78y4DCjMwDolOdZ2Brv94gP5CnYs61vd56Aq1KFQA909J8Pq7STyxUf1nQ5k2/JwLe4S64V1HDEPD3lJ/j1VbjdkYjR4cLZXF8Buu0pT/zqxpOoqbHYkWEY2s8pMsILcyTGIhNdf8RBWPnUA+0XCOjmjGM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeFQlmVp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeFQlmVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740127245; x=1771663245;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6c1PzwN4NRYtcuftWBGGwWofWdbrcsG9TaB1kFxsjk8=;
  b=PeFQlmVpt8603c17hjJBHQ6/PAidXxZmhQCXIE9UFOw4NfbMFwVqMVH/
   CssyqozI9Slq67nvJ/rPXDzMiJTaSkAqjNLZ8JO+QjWyU+ndj21WiiPSd
   23DG1luqq6XGOdVUCXFF03PQbma9Dm2JmC6Y9ROBgs3O8/VfKlE5Mkw5j
   b9J2Ft3EbKsIzCD8rPYNpknmY18bYiBSEEGLe37wGGxrVqVGNddl4JJq7
   OdY7wsnGYHgJXEp8UIYrDJ5c+Pfomsq6lmsT9LXnaIOQtbYPTPq1eK2O1
   abPSNClGWpHaCPz3kLWnldzoKaDqRGKEobdUu36sYZye9v1LViCsswsil
   g==;
X-CSE-ConnectionGUID: nTgWGV5iTom37qCKNhJ5Ew==
X-CSE-MsgGUID: WQV4n4wKSsO6AlNwFGnD6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40166559"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40166559"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:40:44 -0800
X-CSE-ConnectionGUID: tatSNnKISYKsAhQoAB6QQw==
X-CSE-MsgGUID: /hamaI1eRC2aNuKA/a7Fhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="119930193"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.124.242.192]) ([10.124.242.192])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:40:42 -0800
Message-ID: <ba2a6295-7983-4701-8c42-797efe22ecb7@linux.intel.com>
Date: Fri, 21 Feb 2025 16:40:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250220101511.37602-1-cuiyunhui@bytedance.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <20250220101511.37602-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/2/20 18:15, Yunhui Cui 写道:
> When entering intel_iommu_shutdown, system interrupts are disabled,

System interrupts were disabled ? you mean all interrupts were disabled
when entering intel_iommu_shutdown(), perhaps it is not true, at least
for upstream latest code.

> and the reboot process might be scheduled out by down_write(). If the
> scheduled process does not yield (e.g., while(1)), the system will hang.

No NMI lockup watchdog jumping out here ?

Thanks,
Ethan

>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
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
>   
>   	/* Disable PMRs explicitly here. */
>   	for_each_iommu(iommu, drhd)

-- 
"firm, enduring, strong, and long-lived"

