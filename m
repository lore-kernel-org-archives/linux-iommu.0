Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2042050
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431227; cv=none; b=LYNPP0gKKNT/ptrrF/BjpSRPr5DO1B1ol7IgOFwC5vOKryS2R2t+D+j+Pue6GweLsSdD7PGCAHYxHl1tqG/RdwEszKoYSHNrkWi2oiFw0kTFwP8Ey+taDBTzxAb5qZzJUvRi+HlZTIl+HfFDF/d+rnKsNf3zgZC4nMUvlRSoufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431227; c=relaxed/simple;
	bh=ly2APptl710o5IQSANw1FkJ1Hs/IX1HYYZP8hYKPPs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjnzxI/ul6iqZxK1+TIHf5zZCh+3VqUCKs4e6OsD8KOUOb1DIl0XcSJ1N5N8yxOGWXTbvTs5gMilcFCMLdcSI2v8MzUAqvdYUs+wjLCuwE712Pf8I7vJDsMiPdgMqAedD8fvgRybN0H19r/w8DaacRQOomxSGQIPS1te5iM3k0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apkdrTxD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apkdrTxD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763431226; x=1794967226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ly2APptl710o5IQSANw1FkJ1Hs/IX1HYYZP8hYKPPs0=;
  b=apkdrTxDKSB7H1eEflJ2ySfVtFs7yC4OSP/dVPYXQFpdaqprkTpR8Ir2
   VBGXdhKMuHnkL4oOevC8Uh/SwBMZdfMNp5SYbnRucra7Gfk51By+r+p1K
   IiRBu0MlsMBOkslR1gZDniHu0wnQ3k17X4RaeSLqXsKeDG/RrnVpvC2ZT
   vMijU848N7iWaSHhYBi5ifitW1vWOMRhBiLhxqCAsnTCHixcoWTOQl3yB
   /S3x39HJvwi43ruJ9V9Ll5Q2W9xvmRpjcugkxX/wvxOBepzNOMCWPmpHT
   5prgBQ9KG1o19fZ1fa4zfUHimYjGjxZqQGpTz5XuDKG98gkxIvrAkzfG8
   w==;
X-CSE-ConnectionGUID: wg9DuQjtQoeZeIhopqOxlA==
X-CSE-MsgGUID: lIgXiZyLRZqBr8Fx58pU8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="53016023"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="53016023"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 18:00:25 -0800
X-CSE-ConnectionGUID: TGcbY64tR8uEbrXeIHiHWQ==
X-CSE-MsgGUID: UUVCxeyyRMu1maARQ5T8Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="190639050"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 18:00:23 -0800
Message-ID: <f20ffea7-357e-4f1f-b451-d09cd7401ff5@linux.intel.com>
Date: Tue, 18 Nov 2025 09:56:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Remove unused code in dma_pte_free_pagetable
To: Aashish Sharma <aashish@aashishsharma.net>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Dmytro Maluka
 <dmaluka@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Aashish Sharma <shraash@google.com>
References: <20251014162408.2217563-1-aashish@aashishsharma.net>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251014162408.2217563-1-aashish@aashishsharma.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 00:24, Aashish Sharma wrote:
> 'dma_pte_free_pagetable' is only called by
> 'switch_to_super_page' and is not intended to free the
> whole page table (0..DOMAIN_MAX_PFN(domain->gaw)).
> 
> Hence remove the code that checks for this and frees the page
> table pointed by 'domain->pgd'.
> 
> Signed-off-by: Aashish Sharma (Google)<aashish@aashishsharma.net>
> ---
>   drivers/iommu/intel/iommu.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e236c7ec221f..3b3ad7b0c0ce 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -883,12 +883,6 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
>   	/* We don't need lock here; nobody else touches the iova range */
>   	dma_pte_free_level(domain, agaw_to_level(domain->agaw), retain_level,
>   			   domain->pgd, 0, start_pfn, last_pfn);
> -
> -	/* free pgd */
> -	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
> -		iommu_free_pages(domain->pgd);
> -		domain->pgd = NULL;
> -	}
>   }

Thank you for the patch. The dma_pte_free_pagetable() helper has been
removed in the iommu/next branch.

>   
>   /* When a page at a given level is being unlinked from its parent, we don't

Thanks,
baolu
