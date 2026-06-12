Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971A3D3D03
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270207; cv=none; b=aQDWn0V2BUY9Npl4KRRFZL/CC32SWRcOzj1oylw9C/TeZpUKJQT67ncl6RNXUO7fAJmBztstlN5bJI9CXcUmyT+5barfFXgCq00qyxQCPFnlAPh8Jv+j9KPX5T/TL5X/UyLQGFfO7G13ABUMO6vfMo49LfdeWu3kHGR+CslIbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270207; c=relaxed/simple;
	bh=+emU+da1/I9FlSN2/d5Li8V1EGT6RkbzKGs5pKZJdgY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ks+FT2LGUrKlGesg2U0eDua1QW5/SfXUUp5PkB/9PNSq4/0WVmQx8R3tMJBI4/IrIgNR66clABXtbhRq1rdohmJmMOiPP2tRV26RLIXGuZG3GYanYjzVD+4+Oighl1OYqT5E4ryqgqvLLFZZdh82SXGJCoHGESCkINx6H5PgTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZ3z0nl2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZ3z0nl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781270206; x=1812806206;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+emU+da1/I9FlSN2/d5Li8V1EGT6RkbzKGs5pKZJdgY=;
  b=LZ3z0nl2jrouZJsK4tygrT02gOsg0wWr2ZzRfJ9vBcBal6vzC0LEbXVZ
   E6VPPSCdDNYP7153HSrjKVZIL+04ahv7Hf+r/WBjgCTioT1C8JCwKj+gM
   GcU3Vqa6iVNCMXUULPiuTe5TuI3hJ0hx3ksqjxImmloOecqcAutc6C9G/
   8T1a83AmgU4jo2hwzX6kE4Ahjw7+/EyM/zkHhb7b8QAp5RjkjX1iaUU9m
   PuEgHhCq7VF05C5mS4u8K1+L5m0p/8XuGnBjWFL6bEZ2paIvEbekw1u6R
   Xqda9oSBlnMDDNA77otAuQIH8f0rCSYJKMDGwLtymjrelMrm7ceGXK5EA
   Q==;
X-CSE-ConnectionGUID: Bv2vdzXnSviOSGtqXiugbQ==
X-CSE-MsgGUID: WrffYEwxQvSpSkFGiL0sgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84667738"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="84667738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 06:16:45 -0700
X-CSE-ConnectionGUID: Vl7A8WVUQU2oPikLAxuQww==
X-CSE-MsgGUID: MQFv22YZQDKutH/T3KaGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246883010"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 06:16:43 -0700
Message-ID: <6832298a-0d2d-4d45-92c6-b1e081b73cf1@linux.intel.com>
Date: Fri, 12 Jun 2026 21:16:39 +0800
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
Subject: Re: [PATCH 5/9] iommu/vt-d: Use dmar_can_force_on() for platform
 optin
To: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-6-kevin.tian@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260604051540.592925-6-kevin.tian@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2026 1:15 PM, Kevin Tian wrote:
> So the policy of requesting ACS in detect_intel_iommu() is consistent
> with that in platform_optin_force_iommu().
> 
> While at it, remove no_platform_optin which is unnecessary now.
> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 0fc131a34963..edf01261a41d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -58,7 +58,6 @@ static int rwbf_quirk;
>    */
>   static int force_on = 0;
>   int intel_iommu_tboot_noforce;
> -static int no_platform_optin;
>   
>   #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
>   
> @@ -248,7 +247,6 @@ static int __init intel_iommu_setup(char *str)
>   		} else if (!strncmp(str, "off", 3)) {
>   			dmar_state = DMAR_DISABLED_USER;
>   			dmar_disabled = 1;
> -			no_platform_optin = 1;
>   			pr_info("IOMMU disabled\n");
>   		} else if (!strncmp(str, "igfx_off", 8)) {
>   			disable_igfx_iommu = 1;
> @@ -2486,20 +2484,22 @@ static bool has_external_pci(void)
>   
>   static int __init platform_optin_force_iommu(void)
>   {
> -	if (no_iommu || !dmar_platform_optin() || no_platform_optin ||
> -	    !has_external_pci())
> +	if (!dmar_platform_optin() || !dmar_can_force_on(DMAR_FORCEON_PLATFORM))
>   		return 0;
>   
> -	if (dmar_disabled)
> -		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
> +	if (!has_external_pci())
> +		return 0;

Moving has_external_pci() down here seems to be an optimization. :-)

Scanning the PCI fabric for external-facing ports can be costly, and now
we could skip it entirely if platform force-on is unnecessary.

>   
>   	/*
>   	 * If Intel-IOMMU is disabled by default, we will apply identity
>   	 * map for all devices except those marked as being untrusted.
>   	 */
> -	if (dmar_disabled)
> +	if (dmar_is_disabled()) {
> +		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
>   		iommu_set_default_passthrough(false);
> +	}
>   
> +	dmar_state = DMAR_ENABLED_FORCE;

I was initially wondering if we needed a lock to protect dmar_state
here, but since this runs during early boot in a single-threaded
environment (indicated by the __init prefix), concurrent access isn't a
concern.

However, changing dmar_state here does mean that any logic calling
dmar_is_enabled() before this point will see a "disabled" state, while
subsequent calls will see an "enabled" state.

While I don't see a real problem right now, this state volatility is
something we should document. Could we add a brief comment here to
clarify this intentional state upgrade?


>   	dmar_disabled = 0;
>   
>   	return 1;

The rest looks good to me.

Thanks,
baolu
