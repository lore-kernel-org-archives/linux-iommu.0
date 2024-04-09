Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506D13329C
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667536; cv=none; b=p0jneG/eodF7xDi8V/QfA0aq/05w3aXoZvHjgRIVCJDMQFkYAG4RbuBJJu28Z3rUiz0mI9+LLBcg1BYK0V0TaUYWTV7QUfVKk58Vvb3QXvclAyH76pV6yWxhET2U9ApLuAk9VI0xyhjoOzhET4fWhNF0kkWp9FEnKaYonrb1Yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667536; c=relaxed/simple;
	bh=I0krt7w7sD25rjlSCZbI3lOT+9qyYPxjoGm8i8ESdyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JPzkoPU3NIsLonudTd0hRDBQkQElhzybG33O2T8WnxWThpPh791usTzHCKsEo/BsIKiA3higQn+dOW1Sj/GMhnw+IWDmRA8YJ0nAZMeAIgfHb3hpCJ44aUqxiHunABnxeHy1SG4uCQCUHUny0OpLFIzaA8fhs436lmZjZacL4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrmhit8O; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrmhit8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712667534; x=1744203534;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=I0krt7w7sD25rjlSCZbI3lOT+9qyYPxjoGm8i8ESdyQ=;
  b=hrmhit8ONhkVIrSJHt7vMmCR94ZwfiGVSL9SFqoKE6JOVQm7Nk1tyZRJ
   lAbSdVQZW0HnjHiRv8jPHy9s0AiQCBrU+zCmFHDjO1lw8+yllCX5grMCe
   D2uRq8yPxKwiQKMxGDQjqdbYzpykQ2pXfYS7QZvqs1Dxu2NhSZp5btOOs
   V+/bw7HZOEShd2jOD8oRrHo3f1Fq+KhTSgZosrTAAhYOUXXEsjKQ9GHNu
   I2evuXZK6S6lXH9U+/4TqorYavCLbYiJoMV3LB8e9oz6TX0KeDpi5Oz4o
   vqQH3LR0nWrrJRDGnLFZSrnoN5g6TJAvc+dfJnhkHTsmLiAxAk9rzW9+L
   w==;
X-CSE-ConnectionGUID: AqxeHJZeRAumd41J+ZKvJQ==
X-CSE-MsgGUID: KfOEgXJVRpyE63Fa9MlO5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11773181"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11773181"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:58:54 -0700
X-CSE-ConnectionGUID: FmaBK7cgSUemDlJkVvYhKA==
X-CSE-MsgGUID: Zfitb4pVTsifTd0P8pluAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20332129"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:58:53 -0700
Received: from [10.213.177.168] (kliang2-mobl1.ccr.corp.intel.com [10.213.177.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4279C20B573A;
	Tue,  9 Apr 2024 05:58:50 -0700 (PDT)
Message-ID: <5e29fc2d-0f75-4929-af74-224c5f891c2f@linux.intel.com>
Date: Tue, 9 Apr 2024 08:58:48 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix wrong use of pasid config
To: Xuchun Shang <xuchun.shang@linux.alibaba.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
References: <20240401060753.3321318-1-xuchun.shang@linux.alibaba.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240401060753.3321318-1-xuchun.shang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-01 2:07 a.m., Xuchun Shang wrote:
> The commit "iommu/vt-d: Add IOMMU perfmon support" introduce IOMMU
> PMU feature, but use the wrong config when set pasid filter.
> 
> Fixes: 7232ab8b89e9 ("iommu/vt-d: Add IOMMU perfmon support")
> Signed-off-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  drivers/iommu/intel/perfmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
> index cf43e798eca4..44083d01852d 100644
> --- a/drivers/iommu/intel/perfmon.c
> +++ b/drivers/iommu/intel/perfmon.c
> @@ -438,7 +438,7 @@ static int iommu_pmu_assign_event(struct iommu_pmu *iommu_pmu,
>  	iommu_pmu_set_filter(domain, event->attr.config1,
>  			     IOMMU_PMU_FILTER_DOMAIN, idx,
>  			     event->attr.config1);
> -	iommu_pmu_set_filter(pasid, event->attr.config1,
> +	iommu_pmu_set_filter(pasid, event->attr.config2,
>  			     IOMMU_PMU_FILTER_PASID, idx,
>  			     event->attr.config1);
>  	iommu_pmu_set_filter(ats, event->attr.config2,
