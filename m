Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505113698E
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491428; cv=none; b=N1q2HZKlbUw/0rO9m5OJIH6GiPDpjx8qfJ0QYOF91MdkX4+Y1vgl+lmuWjAqrsR2PgJEHvBtEl2XApB4enGUa+nbrVCY8F/vOm20J5gca6s+qaZvUtnh/vHOUCnoEOa3AChiNodms64pKR/FoCYnb28NEP8ROy5vUBu+WfmEMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491428; c=relaxed/simple;
	bh=Z1VqGfy2LTCxobp0qobiMrtFZHWxMeW4quBbM+rwbFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJ/L9r52uTIsV9ZJVcDOQtNoIO7QuUlK16D21nM64OLUcJcEfa3TzHoxA5J5VlfaemmPfrkXJ9SBNqAS1ojdb6V9UwfGO10amVDvsH6UR1qwtirhyYEkczdAUVXJ49mpIUW6627ax17JKvLbXzHMDyiftXNWpseoYhv4kn8rTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EO5M+WJp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EO5M+WJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734491427; x=1766027427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z1VqGfy2LTCxobp0qobiMrtFZHWxMeW4quBbM+rwbFM=;
  b=EO5M+WJpS5E5HgovgC7g0/U9YKlfo0R1rXz0vTBZ/x9dfN1zsoMvSS1D
   r4cStdtPFCBIHiGSOsukvImuJjAjv9bX/+9SORsO6zFhLQpID+sKWptIG
   lSm05aMi5Xtxn3pPelF2HHXac3+QEA+TvNRS4cqrLilm+yaX3fgfhpvwd
   XQpA/OPItPx2g79gg62A3iG2RRrxAvVzh8jsWHeckluRf3SXToNgui8Kx
   wU7iDP4gCYQ7vMIjg7VgMhKHp7x9IixcgNPKUY7FksjxcUQMVyv2Rqbg2
   jwpIj/F0ynU4xtwJzIB6GUPcyKK67e5tVN6HUeyKerTr9a8O9GDG1TebK
   g==;
X-CSE-ConnectionGUID: vbe5S4K/S2u2eJzgbfXDbA==
X-CSE-MsgGUID: eSF3q2wwTfuOH7NylyiaBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="35103671"
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35103671"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 19:10:26 -0800
X-CSE-ConnectionGUID: ZINxrdXeQQKRqnkmKQPbSQ==
X-CSE-MsgGUID: F2CaTt1SShq4K0zr1bLooA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="98308501"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 19:10:23 -0800
Message-ID: <897738ba-5c1f-4d42-bf10-402d59e3f430@linux.intel.com>
Date: Wed, 18 Dec 2024 11:08:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20241216033809.170366-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241216033809.170366-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 11:38, Zhenzhong Duan wrote:
> Cache tag invalidation requests for a domain are accumulated until a
> different iommu unit is found when traversing the cache_tags linked list.
> But cache tags of same iommu unit can be distributed in the linked list,
> this make batched flush less efficient. E.g., one device backed by iommu0
> is attached to a domain in between two devices attaching backed by iommu1.
> 
> Group cache tags together for same iommu unit in cache_tag_assign() to
> maximize the performance of batched flush.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/cache.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
> index e5b89f728ad3..726052a841e0 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -48,6 +48,8 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
>   	struct intel_iommu *iommu = info->iommu;
>   	struct cache_tag *tag, *temp;
>   	unsigned long flags;
> +	struct cache_tag *temp2 = list_entry(&domain->cache_tags,
> +					     struct cache_tag, node);

Is this valid for a list head?

>   
>   	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
>   	if (!tag)
> @@ -73,8 +75,15 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
>   			trace_cache_tag_assign(temp);
>   			return 0;
>   		}
> +		if (temp->iommu == iommu)
> +			temp2 = temp;
>   	}
> -	list_add_tail(&tag->node, &domain->cache_tags);
> +	/*
> +	 * Link cache tags of same iommu unit together, so consponding
> +	 * flush ops can be batched for iommu unit.
> +	 */
> +	list_add(&tag->node, &temp2->node);
> +
>   	spin_unlock_irqrestore(&domain->cache_lock, flags);
>   	trace_cache_tag_assign(tag);
>   

