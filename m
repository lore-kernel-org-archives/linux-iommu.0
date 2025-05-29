Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129E16EB7C
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748497690; cv=none; b=gk3CJyENRVGDY8VLn6whT4D9468H/kVao7EZ/iTUrfsrkHLZnuytBdn9wLTNiijdGgZgywbMN9P12Lpn4J0SnWSAFBeq7KZYfWo/lwDt6IHSEQs2DKlw2RyFiTJISUl4CpFbdfkGEHvXU69HkqAZLvqIAa9jI8vJTwwQkI89IWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748497690; c=relaxed/simple;
	bh=b3fqpqq9xOal3GHk5sCQHg4YeZtAbsFC0JfjC8/qt0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I/Ph1CGoqDNokn2pEP4fQ2Jf5AZhFuD4MzmExpCfq/tFQ3KzSTK7l1WDsmJ+j583eVy5dv4st/DVy1oY4K7PrqY3yOf0jM4+Cy/mm8DLFKqCp0tjrFpsXqfKUI2pB5cO9tV+oD+3My2el7u/y+KWVLm1x4HOdp4b27g1MJEByRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOd9v27Y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOd9v27Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748497689; x=1780033689;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=b3fqpqq9xOal3GHk5sCQHg4YeZtAbsFC0JfjC8/qt0Q=;
  b=fOd9v27YpmVuw6axhdbzy1wNsTiElYRRMx0NLC+WtNaQvFq+Acbn7qxo
   R4cJ5Z5RLeZpzbz6VGI1Y3OY+toprUm+r8lq/7x3LljKNh24tfbRaH9w6
   g3QXkJPU3mJpDmsJAsYXP4IQLMq5jTUJY0tyNRPjf0tTdQypJMKjjLlMO
   VDipHDFUo6bal1UMcnpmxu1VfqlrY7WaW208N4HuLK8PDh+1gO09uVjEk
   GBLZ4cyHcbVN67EaDa/xZGessV+p3oBrdjftqnIPoa7+USKiFpYx70xYZ
   Yhxzr7g9dW+CjrjIlz9BEvb6zm+f/1O8m6jph1dsKW1YvA4HU8r/E9khO
   g==;
X-CSE-ConnectionGUID: 15NBFeNeTBGGjq5ayT5Akw==
X-CSE-MsgGUID: Y6CHgOZ4Rn2oBRsvdHCkaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50544725"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="50544725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:48:08 -0700
X-CSE-ConnectionGUID: TzcTpfEJQHqTsY/iq2IYCA==
X-CSE-MsgGUID: uDsb0xsWQBODW/jOq8l+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="180660749"
Received: from yisun1-mobl.ccr.corp.intel.com (HELO [10.238.129.118]) ([10.238.129.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:48:06 -0700
Message-ID: <01e5d0a9-715a-48d4-a2a4-2a0b5d99149b@linux.intel.com>
Date: Thu, 29 May 2025 13:48:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
To: Wei Wang <wei.w.wang@intel.com>, baolu.lu@linux.intel.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, dwmw2@infradead.org,
 jroedel@suse.de, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250523081056.223082-1-wei.w.wang@intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <20250523081056.223082-1-wei.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/5/23 16:10, Wei Wang 写道:
> This original implementation included redundant logic to determine whether
> first-stage translation should be used by default. Simplify it and
> preserve the original behavior:
> - Returns false in legacy mode (no scalable mode support).
> - Defaults to first-level translation when both FLTS and SLTS are
>    supported.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb0b993bebb4..228da47ab7cd 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1366,15 +1366,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>    */
>   static bool first_level_by_default(struct intel_iommu *iommu)
>   {
> -	/* Only SL is available in legacy mode */
> -	if (!sm_supported(iommu))
> -		return false;
> -
> -	/* Only level (either FL or SL) is available, just use it */
> -	if (ecap_flts(iommu->ecap) ^ ecap_slts(iommu->ecap))
> -		return ecap_flts(iommu->ecap);
> -
> -	return true;

The function works like a digital circurt has 3 single bit inputs  sm, 
flts, slts and one bit output ret.

so the true value table of the orignal function looks like

    sm   flts   slts    ret
a   0     x     x      false
b   1     1     0      true
c   1     0     1      false
d   1     1     1      true
e   1     0     0      true

> +	return sm_supported(iommu) && ecap_flts(iommu->ecap);

And the true value table of this new one looks like

    sm  flts slts    ret

f   1     1     x      true
g   1     0     x      false

h   0     1     x      false
i    0     0     x      false

h, i covers a
g,   doesn't cover e, c
f,   covers b, d

So if we take them as two circurt blocks (chip), their functions aren't 
equal to each other.

If we don't make any assumption,  I wouldn't replace the old chip with 
new one

But, maybe all the new chip and old one all works well under specific 
context that I

didn't think deeper. :)



Thanks,

Ethan

>   }
>   
>   int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)

-- 
"firm, enduring, strong, and long-lived"

