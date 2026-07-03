Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637A6FBF
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042093; cv=none; b=EWoeyZFuPW+hrLyFCkaMNG754RYE2IiF/d0u3TtwoizMDMSCLpdRKejcx840Q7X8yC5RC3vzFjscHphD5NNkkuRAixoEZK5uZw8tmeInGkZDdqKGNZuGHEgI+CRNE2lxmWCAOOuMnMHI2FJPHz+RWwaHfLGQmn95QfNa4YtaTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042093; c=relaxed/simple;
	bh=RtgZm7OYnpGKhWmXgmo5LBLpOdkf67Q1hCQx9VOe0B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqaGwfIMkxfn70IjxonpnY7k7yDdpJPeOHr/CCPawSxgvjVWdY7yLor6zX90WgDUzioy3m9rEZAypO5m6lgKAuMesShfPqYB2l4YUkWL8mVZUpNa6oKvJgeSFWdz/Y7UD4stUxG4mKJxWgImsCfOEjHHBWlw/FL4XNPcGbW2gPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hu/PDX18; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hu/PDX18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783042092; x=1814578092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RtgZm7OYnpGKhWmXgmo5LBLpOdkf67Q1hCQx9VOe0B8=;
  b=hu/PDX183vU8BIKUt0V6H2wgs3Nb7oWqRiFDrV6bvmel2bfsBjzv4A4F
   DVPmrC20iXeL4dkBq5rwGDwDMNOAiju1QIcbyVmOwg0xE3Px3F3fbYIN2
   hqWqgGZBfp9SKIk6iWbCmlsoOm4vauEOoM19AEVSmPGzE2Pc4TTbYdRGe
   ped6Ap05+/5wh8yf2YSVjAUS9uPghnT11w9U/AmtR1MydRLwM3rtYEzq+
   FYH6Ja79oQla7TWihNz280YIkDmrm87lNwcmr0t1/62ervzJmX2jtG9G4
   yvQYGiUXUlmDMQDBlkPvKBbqcYNlbxevP3WLbrvpN1Gb36O6+sULVOifG
   Q==;
X-CSE-ConnectionGUID: GUM6LAfQS4a7I8nL8p/h1g==
X-CSE-MsgGUID: /bANjfa/T4K3nwQ7ggUGlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95299751"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="95299751"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 18:28:04 -0700
X-CSE-ConnectionGUID: Q0X92sAzT2SLdXslaphUDg==
X-CSE-MsgGUID: h1z9Am2zR6S61A3OAEOW2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="250335582"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 18:28:02 -0700
Message-ID: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com>
Date: Fri, 3 Jul 2026 09:26:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: respect user override for intel_iommu=on on
 Lenovo ThinkPad P50s
To: Oliver Lin <oliver@liuxiaozhen.dev>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 robin.murphy@arm.com, will@kernel.org
References: <8d131b2c-978e-4aac-88aa-21b39237344a@liuxiaozhen.dev>
 <20260702103137.508709-1-oliver@liuxiaozhen.dev>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260702103137.508709-1-oliver@liuxiaozhen.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/26 18:31, Oliver Lin wrote:
> From: oliver<oliver@liuxiaozhen.dev>
> 
> The current DMI quirk disables VT-d on ThinkPad P50s unconditionally,
> even when intel_iommu=on is explicitly requested via kernel command line.

The current driver doesn't have the DMI quirk, so this patch cannot be
applied to the tree as-is.

> This breaks kernel parameter precedence and user intent.
> 
> Make the quirk conditional so that it does not override explicit user
> enabling of Intel IOMMU.
> 
> Signed-off-by: Oliver<oliver@liuxiaozhen.dev>
> ---
>   drivers/iommu/intel/iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Thanks,
baolu
