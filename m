Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600592D97B9
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117223; cv=none; b=T15H3VKfOOPRSpNyfVE8wSvaL+ZnGHEWzjIohfYCv7Unc6Rduhdas2kiO9Udd4Esuj+vqj7VzX/8qkJA8nlRCO2biN4uZgIFnS4T3lVNhszbJOGwVA8+JUBj8zdKEYGLnzYS+ASoAEHQJ2ok/3qYFery65ZBaF82uXxhSREmjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117223; c=relaxed/simple;
	bh=pCDClR0Vuhs3d0r8J/fBUtaKxj7HpHhAUrlTf2E7sl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/VfpZvxhNuWTTw/cG6VneXqgbt1+uJ2iFad3rVk9FFs+zoiSemGc5khYwbwF2sd7Q7XDWEh+OInX/yuuejlcr+PXXjr6BSPSY8s5NuWa0OtxHKiptc/izCNR8kTMybBzwVKZcfXafZuisXgbz0wfzU5pvvbwS49kil60tWyWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDxZ2d+s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDxZ2d+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785117220; x=1816653220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pCDClR0Vuhs3d0r8J/fBUtaKxj7HpHhAUrlTf2E7sl0=;
  b=SDxZ2d+sTQrqsYnbFt+wUq4z7vATh4B4ye/xOWaamUO3CWkhzepgduj3
   +lhtOAWZx83WhubqP2Kc5sNMEnrBLm8W4/Y5u42byCzxmPCagON2C+RZf
   DgWswGvGadHkTk1C1pQOV+vZWM2cv6pM1srPljobWb+YBmEASHOhg5Il7
   SCWdsGcSLunp+/hR1TY0EphWO85wi5TFnackO5Wcu6/Q7IBG6LSAqxUbn
   hqU1iFaPRVCYGdOQqPFwpkeCS3ikn4i21oF12qVheE7Go5uISD1kyoMpS
   f4kCclx6RegxIQEWWaL704DFG0549ytwVxFWH9cHy7XCEjGJlqjNriM0m
   g==;
X-CSE-ConnectionGUID: Qm+KaWwhTzur6NhM+IgZdg==
X-CSE-MsgGUID: I1xXqmi2TZmkDOQoW67Y8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85870790"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="85870790"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:53:39 -0700
X-CSE-ConnectionGUID: logOMXViTvGxYGHoLX3GcA==
X-CSE-MsgGUID: 0utGwJAvQq2+rh9/ngbdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="264275735"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:53:37 -0700
Message-ID: <367f963a-d337-4d49-9d5b-a558fcba813a@linux.intel.com>
Date: Mon, 27 Jul 2026 09:51:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix copied_tables bitmap leak on error in
 copy_translation_tables
To: ZhaoJinming <zhaojinming@uniontech.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260721132635.1436908-1-zhaojinming@uniontech.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260721132635.1436908-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 21:26, ZhaoJinming wrote:
> The iommu->copied_tables bitmap was introduced by the IOMMU live
> update series to track which context entries have been copied from
> the previous kernel.  The allocation via bitmap_zalloc() was added
> inside copy_translation_tables(), but the error paths were not
> updated to free it:
> 
>    1. When old_rt_phys is 0 (invalid root table address)
>    2. When memremap(old_rt_phys) fails
>    3. When kcalloc for ctxt_tbls fails (goto out_unmap, which only
>       unmaps old_rt without releasing the bitmap)
> 
> The bitmap is only cleaned up by free_dmar_iommu(), which is
> called from the free_iommu error label in init_dmars().  However,
> when copy_translation_tables() fails, init_dmars() does not jump
> to free_iommu -- it logs the error, falls through, and continues
> with the next IOMMU.  As a result, copied_tables is leaked.
> 
> Fix this by converting the two early returns to goto a new
> err_free_bitmap label, and by making out_unmap fall through to
> it so that the bitmap is always freed on any error path.  The
> success path is changed to return 0 directly instead of falling
> through to out_unmap, since copied_tables must remain allocated
> for subsequent use.
> 
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>   drivers/iommu/intel/iommu.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 849d06dfe1ae..25f49d29da8a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1554,12 +1554,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   		return -ENOMEM;
>   
>   	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
> -	if (!old_rt_phys)
> -		return -EINVAL;
> +	if (!old_rt_phys) {
> +		ret = -EINVAL;
> +		goto err_free_bitmap;
> +	}
>   
>   	old_rt = memremap(old_rt_phys, PAGE_SIZE, MEMREMAP_WB);
> -	if (!old_rt)
> -		return -ENOMEM;
> +	if (!old_rt) {
> +		ret = -ENOMEM;
> +		goto err_free_bitmap;
> +	}
>   
>   	/* This is too big for the stack - allocate it from slab */
>   	ctxt_table_entries = ext ? 512 : 256;
> @@ -1603,11 +1607,13 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   
>   	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
>   
> -	ret = 0;
> +	return 0;

Returning directly here bypasses memunmap().

Sashiko reported this as well:

"
Does this code leak the old_rt memory mapping on the success path?
old_rt is mapped earlier in this function:
copy_translation_tables() {
     ...
     old_rt = memremap(old_rt_phys, PAGE_SIZE, MEMREMAP_WB);
     ...
}

By returning directly here instead of setting ret = 0 and falling
through, it looks like we bypass the memunmap(old_rt) call under the
out_unmap label, leaving the mapping active.
"

https://sashiko.dev/#/patchset/20260721132635.1436908-1-zhaojinming%40uniontech.com

Do you mind fixing this with a v2?

>   
>   out_unmap:
>   	memunmap(old_rt);
> -
> +err_free_bitmap:
> +	bitmap_free(iommu->copied_tables);
> +	iommu->copied_tables = NULL;
>   	return ret;
>   }
>   

Thanks,
baolu
