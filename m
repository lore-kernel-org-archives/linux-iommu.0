Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D92CCB4
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579557; cv=none; b=e1Joe2KfBZN8jN0+M2OWwtW7M21ms/cpWhGTQRcGK/K4sVYJahH8kPRmu+t+eV/ZTVFpaxQCLtxjCm1ZJQwEdrq6IWXDrTmkDBLFLJyiOF6sPi2+vlHr7EuITkcD5y+GIEArUCIxHW2rGZ2YKozzAWRfaZI8wgsfExYICxamUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579557; c=relaxed/simple;
	bh=vdQbFqvslElgsLobOX+dTA+Q3NTnmAZa4Z743GULUy8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AyTA7eEYgXTpHUqDE6mUdQTWBypmxQKx81AE4GzBjsEvMsVopSm+jhQAEIUWwc6EKcR69aylTjl5+vm8oNDfX6genNbbTn8qKKzYOnWYVS6i5NVCQCFxgVDzs0zZb3gK0IqQwj0oJ0ODzH1NmLmdFegtuDs3bMbYszt+tMaOH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EC+2AQKY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EC+2AQKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720579554; x=1752115554;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vdQbFqvslElgsLobOX+dTA+Q3NTnmAZa4Z743GULUy8=;
  b=EC+2AQKY2svPZpXToxJoyXt32b70WzyJG51Myzv6co0NlGGa9jCKrTZh
   582xu8Runk1fDrmHpCmbC+WTXla3ULZUvAZ8jVwg/J0r5+81w7sSBEWUr
   ImbYQSP8GAlmG0GWHB7eTNnkL+cY/zXVwgngWx3sEoSkT2nHWA7F1sNg0
   EDEU7OifJ/xRuZipODeLZFtCPRyPb+x4JU71gzpIESeaqRU6iU6Egc8Rs
   ljHY6MFKuEqZnqRfwzWtdiIRf70ReoTgtP1B1L+x4wu5EczgtcfbPhovB
   YXBy4cBRdKjpAaVh0uyd6r1eH27+56bPH4Dr1zqDn0/r8iKhxH6vUITyd
   A==;
X-CSE-ConnectionGUID: SpX5aWXbRpqNdCZFQBzOnA==
X-CSE-MsgGUID: ShAbm8/zQcWJaxKqJAFeEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35306060"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="35306060"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 19:45:54 -0700
X-CSE-ConnectionGUID: p6CmHOf4Rd6Ju5boocmZxQ==
X-CSE-MsgGUID: yFKuLdBgTeS/XspVIaDPDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="53243612"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 09 Jul 2024 19:45:51 -0700
Message-ID: <b3401333-76d3-415a-b2e4-b148c44b13f3@linux.intel.com>
Date: Wed, 10 Jul 2024 10:43:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sudheer Dantuluri <dantuluris@google.com>, Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
To: Jon Pan-Doh <pandoh@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240709234913.2749386-1-pandoh@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240709234913.2749386-1-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 7:49 AM, Jon Pan-Doh wrote:
> Intel IOMMU operates on inclusive bounds (both generally aas well as
> iommu_domain_identity_map()). Meanwhile, for_each_mem_pfn_range() uses
> exclusive bounds for end_pfn. This creates an off-by-one error when
> switching between the two.
> 
> Fixes: 5dfe8660a3d7 ("bootmem: Replace work_with_active_regions() with for_each_mem_pfn_range()")
> Signed-off-by: Jon Pan-Doh<pandoh@google.com>
> Tested-by: Sudheer Dantuluri<dantuluris@google.com>

Do you mind telling me on which platform did you test this fix? My
understanding is that modern VT-d hardware supports hardware pass
through mode, hence this piece of code won't be executed anymore.

> Suggested-by: Gary Zibrat<gzibrat@google.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index fd11a080380c..f55ec1fd7942 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2071,7 +2071,7 @@ static int __init si_domain_init(int hw)
>   		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>   			ret = iommu_domain_identity_map(si_domain,
>   					mm_to_dma_pfn_start(start_pfn),
> -					mm_to_dma_pfn_end(end_pfn));
> +					mm_to_dma_pfn_end(end_pfn-1));
>   			if (ret)
>   				return ret;
>   		}

Thanks,
baolu
