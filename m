Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C12E9ECE
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544569; cv=none; b=sb2QxbPsL1OKrpHWQmyvM1Z4Wldp0RCzclMJbCHxI/DmSQa+h6qy0R61PUv6LsILCzB9z8LwvlmYGe7oSCGzT8h8cPccHKnTkml9/Fieg1PSRQQ/ziGP/qXGVinGaUUN9f25lGFj/TSvGR5tXW0xeNVh3etLmta64Vo2AF9NSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544569; c=relaxed/simple;
	bh=HYhU1UvsaMo23P6j6sR6QJircnjXsWgiOTeLBE3hddE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EcPcmlosyZGpAcNPZbwIzVhTDElrkXq3hPKmHe+YzRHKVqLCIVjIB1CIf03T99p1Y5eW3rxtUc9Wt0cRjMgL2zHmMGvjLLIfKvlS62gUbA8Ih9/pESGfAXLlWURUcn2ygyJAjzfBoHTuphCZac9mvIY8yTF7OgKhjxUuh75aHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCkV7Z5/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCkV7Z5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763544567; x=1795080567;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HYhU1UvsaMo23P6j6sR6QJircnjXsWgiOTeLBE3hddE=;
  b=ZCkV7Z5/nQMHXJg5XtpXcJMySblPV0/wjglarLbLKUlD/96FOV6dmite
   TuUKbshatMhy0DHj+Yel7QGTpX/td8RRTggiNzmJGaQp4HQ8aSwPGAAiV
   fhiJa0YP0lHPWZLELNfjX2mre8n7UovvjaoyRX4XUwuPlPNPOdwi5xiBS
   x4l/OEHpIRAbZUX+gW/OmR2ChatY/4F/6QwkLnjh9w/ARfHSIs0+cap76
   rQ8+uFKs3bRuS+l+yjxKDTYplDwB/7pezLJut+IQYAeDU/5AKkFyDPHQc
   IH6IlhHOy0Q8ZOSg3UoyHRuPHF7jpRZMz9dS/3vPEY7QNw3h3CRxhPsFq
   w==;
X-CSE-ConnectionGUID: 9JbvYIkeRQWicdLxk3gubg==
X-CSE-MsgGUID: QQCmsv42Qky6K05J4+gzLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65520104"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65520104"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 01:29:27 -0800
X-CSE-ConnectionGUID: PLsjaoNyQVqLBN2WDdjcJQ==
X-CSE-MsgGUID: Qoc75SQWQNueevvM4f8ctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="196136897"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.246.21]) ([10.124.246.21])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 01:29:24 -0800
Message-ID: <8648735e-324d-4951-96a8-6276503fc8c9@linux.intel.com>
Date: Wed, 19 Nov 2025 17:29:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>, matthew.auld@intel.com,
 iommu@lists.linux.dev
Subject: Re: REGRESSION on linux-next (next-20251106)
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
References: <4f15cf3b-6fad-4cd8-87e5-6d86c0082673@intel.com>
 <20251118012944.GA60885@nvidia.com>
 <a79fe616-52c7-4fa5-906c-382b5ff2226c@intel.com>
 <20251118161341.GC90703@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251118161341.GC90703@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/2025 12:13 AM, Jason Gunthorpe wrote:
>> Also, the tests fail consistently and are not sporadic.
>  From these logs I see the below fragment, noting this:
> 
>   gem_exec_gttfil-1010    [004] .N...    50.126420: map: IOMMU: iova=0x00003fffffc00000 - 0x0000400000000000 paddr=0x00000001b9400000 size=4194304
>                                                                      ^^^^^^^^^^^^^^^^^^^
> Which is the high IOVA.. It has bit 45 set. I fed this mapping into
> the kunit and it does map successfully.
> 
> It is not high enough to get into anything special about sign extend,
> the driver sets:
> 
> 	if (cap_fl5lp_support(iommu->cap))
> 		cfg.common.hw_max_vasz_lg2 = 57;
> 	else
> 		cfg.common.hw_max_vasz_lg2 = 48;
> 
> Maybe this code is wrong? Baolu what did you get for this log:
> 
>   [   50.126166] i915 0000:00:02.0: Using 46-bit DMA addresses
> 
> In your force second stage test? Is it 46? Second stage uses different
> code to compute vasz_lg2 and is sensitive to magw:
> 
> 	if (mgaw >= 48 && (sagaw & BIT(3)))
> 		return min(57, mgaw);
> 	else if (mgaw >= 39 && (sagaw & BIT(2)))
> 		return min(48, mgaw);
> 	else if (mgaw >= 30 && (sagaw & BIT(1)))
> 		return min(39, mgaw);
> 
> Maybe this is the issue?

When first stage translation is used,

	cfg.common.hw_max_vasz_lg2 = 48

When second stage translation is used,

	cfg.common.hw_max_vasz_lg2 = 42

Interesting thing is if I hardcode

	cfg.common.hw_max_vasz_lg2 = 42

for the first stage translation, it works.

The only change that I have made to achieve this likes below:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2d2f64ce2bc6..a505bba8dcc7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2813,10 +2813,13 @@ intel_iommu_domain_alloc_first_stage(struct 
device *dev,
         if (IS_ERR(dmar_domain))
                 return ERR_CAST(dmar_domain);

+#if 0
         if (cap_fl5lp_support(iommu->cap))
                 cfg.common.hw_max_vasz_lg2 = 57;
         else
                 cfg.common.hw_max_vasz_lg2 = 48;
+#endif
+       cfg.common.hw_max_vasz_lg2 = 42;
         cfg.common.hw_max_oasz_lg2 = 52;
         cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
                               BIT(PT_FEAT_FLUSH_RANGE);

Thanks,
baolu
