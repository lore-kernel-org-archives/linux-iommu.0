Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D93242B8
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272666; cv=none; b=IpPRZZKwhL2fHyF1786kPQNrWaOcSFXhvlUJ6ry0wRLgABc8IkQqDXfCY3gO/Dqwv8DupfpFH4sqcmVBPfiijThxi7t5Xc+4vd3G04OY6c/BwkpP0tz6S5yahxo9LGUIoddTk0GIEam3uu5aJ0Q6iOG3H6NddOFAVqd9mu3U87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272666; c=relaxed/simple;
	bh=DnJKPWvyb/ID4IFs2LonddjY1ZWhKJobKOH81ZpXg7I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rKaDMH9lKimW+wqkUI9XGWCsX+h3JTmnEZ07+WwTHBEe5fhSJylmUvAzje/DiMwhnaxpB3nSf9J5Yw0kV0gHpQ7MNWa6uOEH975WhKQWeXEPqU6jlREabFAAuKPQUtPLr3oggiimdNU60QKcj3Y6H/NHTMPJtrSzVhYOaFxMtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUK3cSmZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUK3cSmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781272664; x=1812808664;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DnJKPWvyb/ID4IFs2LonddjY1ZWhKJobKOH81ZpXg7I=;
  b=EUK3cSmZV8oT9AqMDMrtHaDewvZMJCADFsCWlxw6WrD5Su7ARaN9jBoH
   gz5wUtfs0c2GyFRClo21/hAXDExXX5P5QXPnT/CsVi9Ygwex2PcJohJ+1
   /hf6NGJ9Ho8bWDdGKrnEKpl6iIfwa3zJO47SuDu5nKoK/F6yF4Jy9bzJy
   g7Q6lk2+DCDEfjQ5M8x4MTJJAYzUOgfGZMxBO0KeEKojA8/F+1joynLvf
   j3horLLO9GtIz8yHYb5k7n25NIbBkvh6DrZapd6MLrNpFoivm855wtbh0
   Y16owP6vN4ZhbE2HYNaJUnveiCKUIiodjv2lmrLXab1faIJ56o/bgddL8
   g==;
X-CSE-ConnectionGUID: qHfmoTxFQyGbQPqI3nvA9Q==
X-CSE-MsgGUID: N9Cw56EHSFWv8Wzat4+2kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="86001671"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="86001671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 06:57:43 -0700
X-CSE-ConnectionGUID: RsV+fnrBSuOVlPboqOuwjQ==
X-CSE-MsgGUID: Kkc0j07gQAGNR0vDr3Kbtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="270494528"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 06:57:39 -0700
Message-ID: <cc8cd5bc-e093-4a95-a68b-ae3ca24944bb@linux.intel.com>
Date: Fri, 12 Jun 2026 21:57:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Chris Wright <chrisw@sous-sol.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 Asit Mallick <asit.k.mallick@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iommu/vt-d: Call dmar_can_force_on() for tboot optin
To: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-7-kevin.tian@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260604051540.592925-7-kevin.tian@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2026 1:15 PM, Kevin Tian wrote:
> So the policy of requesting ACS in detect_intel_iommu() is consistent
> with that in tboot_force_iommu().
> 
> Though tboot is the strongest override so far, add a panic() in case
> dmar_can_force_on() may return false due to future extensions.
> 
> No functional impact at this point.
> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index edf01261a41d..ed227de6d0ba 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2544,12 +2544,16 @@ static int __init probe_acpi_namespace_devices(void)
>   
>   static __init int tboot_force_iommu(void)
>   {
> -	if (!tboot_enabled())
> +	if (!tboot_enabled() || intel_iommu_tboot_noforce)

Hmm, it looks a bit strange here. The core design philosophy is that the
trusted boot environment takes priority over user options. However,
checking intel_iommu_tboot_noforce at the very top means a user
option (intel_iommu=tboot_noforce) is successfully overriding tboot.

Is this an exception? If so, it might be worth adding a brief comment
clarifying why `tboot_noforce` is allowed to bypass the priority?

>   		return 0;
>   
> -	if (no_iommu || dmar_disabled)
> +	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
> +		panic("tboot: Failed to force IOMMU on\n");
> +
> +	if (dmar_is_disabled())
>   		pr_warn("Forcing Intel-IOMMU to enabled\n");
>   
> +	dmar_state = DMAR_ENABLED_FORCE;
>   	dmar_disabled = 0;
>   	no_iommu = 0;
>   
> @@ -2566,8 +2570,7 @@ int __init intel_iommu_init(void)
>   	 * Intel IOMMU is required for a TXT/tboot launch or platform
>   	 * opt in, so enforce that.
>   	 */
> -	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
> -		    platform_optin_force_iommu();
> +	force_on = tboot_force_iommu() || platform_optin_force_iommu();
>   
>   	down_write(&dmar_global_lock);
>   	if (dmar_table_init()) {

Thanks,
baolu
