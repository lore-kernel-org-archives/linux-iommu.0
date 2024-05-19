Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A70BE40
	for <iommu@lists.linux.dev>; Sun, 19 May 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716111888; cv=none; b=GFQf9mucWCmS7LJut++gg7F63fQv+oaAm/IyHfJGYn1LW2fi29sTJDcqPj1DOLELWIItCPIDitBQErXJy78z61jFj1Ms/Rl54O//m52oc+KD2aTr9leSX2ilkU78F4Ke1eqjUElmQNcM7fwapEfilmgzkgAgkc6QCBIdrq06o9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716111888; c=relaxed/simple;
	bh=hueqTirpKC2bdBNHenpiB4RQo8DMF6ojHT+OfDi7HOY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iHCM2hOYSyo3wYRSpncqe4waIDvyZaa5FniafLOwZsRnTsJuoPjuoHtV8BC4lAHYb0bNhKIzhwwLrOUnM9BOTBSgYE6g18qqdcyf9ufzEo2if6oFJBDWbtNueEGshGgxoSainMxzrX4OyoVNHEUhD3MSsU0WK3Ne/flAV7htjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkMj/Mpv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkMj/Mpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716111886; x=1747647886;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hueqTirpKC2bdBNHenpiB4RQo8DMF6ojHT+OfDi7HOY=;
  b=dkMj/Mpv3EvBh77EDFrse1bw147DvGgdulTbimXExc8zsF0izrr2kmIH
   pkiww2wVcvkVqAJDScl4Zzrqplo5eoaXOSBeb8sxQAXvCIM0AwHewCi+M
   8hmIekLN9kLWC6hEKAUNEzocA6cRtDhYEVtsn+8J5pRFitW8x43ypbKzB
   d1r1coH2DtipyGqZ5SK7t9Qvf+/tsKV6Zxs45buIGRwDzG4MpJc7zI963
   dpdcwbeyiG0q4sYwzY8jntrbmwWSB7cdqmb+tSQsPst/4Oc+ND2hZ3Lt/
   6RMfFKk4eYbxHVCH6IGp2ITkT8Eo/twGIO5n9mtZZ3+gNpRA8uiCXVDyc
   g==;
X-CSE-ConnectionGUID: hcgexCYCS8Cq/wFvF4AboQ==
X-CSE-MsgGUID: v17+MYfURBGIVK2E3nHqrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="22825036"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="22825036"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 02:44:45 -0700
X-CSE-ConnectionGUID: sP83qbEYSjiks9ut8qkx5Q==
X-CSE-MsgGUID: 5tlAMuWdRWaeoJakhdi4cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="36817568"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 19 May 2024 02:44:43 -0700
Message-ID: <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
Date: Sun, 19 May 2024 17:42:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
To: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
 <20240517003728.251115-2-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240517003728.251115-2-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 8:37 AM, Tina Zhang wrote:
> Introduce a new parameter batch_desc to the QI based IOTLB/dev-IOTLB
> invalidation operations to support batching invalidation descriptors.
> This batch_desc is a pointer to the descriptor entry in a batch cmds
> buffer. If the batch_desc is NULL, it indicates that batch submission
> is not being used, and descriptors will be submitted individually.
> 
> Also fix an issue reported by checkpatch about "unsigned mask":
>          "Prefer 'unsigned int' to bare use of 'unsigned'"
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/cache.c | 33 +++++++++++-------
>   drivers/iommu/intel/dmar.c  | 67 ++++++++++++++++++++-----------------
>   drivers/iommu/intel/iommu.c | 27 +++++++++------
>   drivers/iommu/intel/iommu.h | 21 ++++++++----
>   drivers/iommu/intel/pasid.c | 20 ++++++-----
>   5 files changed, 100 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
> index e8418cdd8331..dcf5e0e6af17 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -278,7 +278,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
>   		case CACHE_TAG_NESTING_IOTLB:
>   			if (domain->use_first_level) {
>   				qi_flush_piotlb(iommu, tag->domain_id,
> -						tag->pasid, addr, pages, ih);
> +						tag->pasid, addr, pages, ih, NULL);
>   			} else {

I'd like to have all batched descriptors code inside this file to make
it easier for maintenance. Perhaps we can add the below infrastructure
in the dmar_domain structure together with the cache tag.

#define MAX_BATCHED_DESC_COUNT	8

struct batched_desc {
	struct qi_desc desc[MAX_BATCHED_DESC_COUNT];
	unsigned int index;
};

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index eaf015b4353b..dd458d6ad7ec 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -610,6 +610,7 @@ struct dmar_domain {

         spinlock_t cache_lock;          /* Protect the cache tag list */
         struct list_head cache_tags;    /* Cache tag list */
+       struct batched_desc *descs;      /* Batched qi descriptors */

         int             iommu_superpage;/* Level of superpages supported:
                                            0 == 4KiB (no superpages), 1 
== 2MiB,

The batched descriptor structure is allocated when the first cache tag
is assigned to this domain and freed when the last tag leaves.

Then, we have below helpers to replace the current qi_flush_xxx() calls.

static void batched_desc_iotlb_enqueue(...)
{
	... ...
}

and another one to push all queued commands to the hardware,

static void batched_desc_flush(...)
{
	... ...
}

>   				/*
>   				 * Fallback to domain selective flush if no
> @@ -287,11 +287,13 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
>   				if (!cap_pgsel_inv(iommu->cap) ||
>   				    mask > cap_max_amask_val(iommu->cap))
>   					iommu->flush.flush_iotlb(iommu, tag->domain_id,
> -								 0, 0, DMA_TLB_DSI_FLUSH);
> +								 0, 0, DMA_TLB_DSI_FLUSH,
> +								 NULL);
>   				else
>   					iommu->flush.flush_iotlb(iommu, tag->domain_id,
>   								 addr | ih, mask,
> -								 DMA_TLB_PSI_FLUSH);
> +								 DMA_TLB_PSI_FLUSH,
> +								 NULL);

Perhaps we could refactor the indirect call here.
	if (qi is supported by iommu)
		...
	else /* register based iotlb invalidation*/
		...

and only batched descriptor is only supported in the upper case.

Best regards,
baolu
