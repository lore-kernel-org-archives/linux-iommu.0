Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F03F54AA
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822907; cv=none; b=KaEjGH6jEf9JUkFSIInWh08fOW9wLKJ48efo92tNB67jUR7A26c/SZIwELyo0N+ChjOmHon6lKp3sO8I8rkI70a8b0CLnGqVruxlaiWMMJyTtEFlqMKNulfJMU+YS7DNRaQPYGZ+T6OckdDzWxeBHw8s+JfrYyeD3QqMFWnE8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822907; c=relaxed/simple;
	bh=b34nJTqW7yXQpfl7UI3VNDqLABkSlRzAYQTTT0X/WNI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=a1Gb2EhEEWG+zjUuKYWhaACZMwZVJC+dQHhF7Tyk92jp/vhUJw6i5XzYyTohE56EaAr8OLsxLQazDxI2LnnyXBMvoE7L/9HzProaot1dNf2b1pYYEVJdUm2eB5HGu8w5I0NEFmAJZw0JiMWQ/3/fok0lrzESBK0aBTt7D6JsTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0nzhGM0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0nzhGM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785822905; x=1817358905;
  h=message-id:date:mime-version:cc:subject:from:to:
   references:in-reply-to:content-transfer-encoding;
  bh=b34nJTqW7yXQpfl7UI3VNDqLABkSlRzAYQTTT0X/WNI=;
  b=n0nzhGM0P7VJ0lkbZS6tYuo79wiPwVU7dCST6PA/3Lx/WB3obn2grrbJ
   7Oc4PmNyFDmQEHJXuIvARsH1g6s2LzEpmC823Rcsnng1myuZCvzTaYqvB
   728nDGl/IDEXNxukfN2KCP1sb8dsGAEL8SXJzNVRrL+v0kJW04eM4H7cg
   uB6MvXMIq9oo7JoFB3Mtz/JjalLWk+zRHZAhC91v/tx6eICVITJxjvhYw
   UIn9vFzwt/WAHm6MN5w1d/+dAyL4mueawcmy3RQ/thBR7yv5Gbq+3IDTd
   g4cbjSWaUvlJWu9+Y8RmcbjSKWMe36kJDqIYIokjV+NOPBb8ujw1Bri9H
   A==;
X-CSE-ConnectionGUID: +cturkcgQImaHGHCy0acbA==
X-CSE-MsgGUID: ACbHnpC5T8ih1ABAS7LBcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="73903234"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="73903234"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 22:55:03 -0700
X-CSE-ConnectionGUID: duOAl4GQSSqlIZPh80F1mg==
X-CSE-MsgGUID: vF5kDt2bRmydDK3PlRqh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="257529312"
Received: from unknown (HELO [10.238.0.222]) ([10.238.0.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 22:55:01 -0700
Message-ID: <688fcc40-d1d6-4452-9b98-1dda3c15a7d8@linux.intel.com>
Date: Tue, 4 Aug 2026 13:54:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: ZhaoJinming <zhaojinming@uniontech.com>, Kevin Tian
 <kevin.tian@intel.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 Li RongQing <lirongqing@baidu.com>, Desnes Nunes <desnesn@redhat.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/20] iommu/vt-d: Fix shift overflow in
 qi_desc_dev_iotlb_pasid()
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
 <20260804023714.3080506-17-baolu.lu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260804023714.3080506-17-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/2026 10:37 AM, Lu Baolu wrote:
> Callers request a full Device-TLB flush by passing MAX_AGAW_PFN_WIDTH
> (64 - VTD_PAGE_SHIFT == 52) as @size_order.  Two shifts in
> qi_desc_dev_iotlb_pasid() are not prepared for a value that large:
> 
>    unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
>    ...
>    if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
> 
> The first evaluates to 1UL << 63.  On 32-bit builds this is undefined
> behaviour; in practice x86 masks the shift count to 5 bits, so the
> expression yields 1UL << 31 and ~mask becomes 0x7fffffff.  That value is
> zero-extended when it is applied to the 64-bit descriptor, so
> 
>    desc->qw1 &= ~mask;
> 
> clears qw1[63:32] as well as bit 31.  The ADDR field, which had just been
> filled with ones to request the widest possible range, collapses to
> 0x7ffff000.  As the S bit remains set, hardware decodes the least
> significant zero bit of ADDR and invalidates only 2GiB instead of the
> entire address space.  Device-TLB entries above that boundary survive the
> unmap, leaving an ATS-capable device able to keep accessing memory that
> has already been freed.
> 
> The second shift, VTD_PAGE_SIZE << size_order, is 1UL << 64 and is
> therefore undefined on 64-bit builds too.  On x86_64 the shift count
> masks to zero, IS_ALIGNED(addr, 1) is trivially true and the sanity check
> silently degrades into a no-op.
> 
> Compute both quantities in 64-bit and clamp @size_order to the largest
> range the ADDR field can encode.  Capping at 63 - VTD_PAGE_SHIFT keeps
> the intended "flush everything" behaviour: qw1[62:12] is set, bit 62 is
> cleared as the size indicator and the S bit is set.  The non-PASID
> variant qi_desc_dev_iotlb() already uses 1ULL and is unaffected.
> 
> Fixes: f701c9f36bcb7 ("iommu/vt-d: Factor out invalidation descriptor composition")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260623060122.3796325-1-guanghuifeng%40linux.alibaba.com
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.h | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index c00f44db0020..8a59c7c9d0a6 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1105,12 +1105,20 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
>   					   unsigned int size_order,
>   					   struct qi_desc *desc)
>   {
> -	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
> -
>   	desc->qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
>   		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
>   		QI_DEV_IOTLB_PFSID(pfsid);
>   
> +	/*
> +	 * The invalidation range is encoded in the ADDR field, which only
> +	 * covers bits 63:12.  Clamp @size_order so that callers asking for a
> +	 * full flush (e.g. with MAX_AGAW_PFN_WIDTH) do not overflow the
> +	 * shifts below.  The clamped value still spans the whole range that
> +	 * the descriptor is able to express.
> +	 */
> +	if (size_order > 63 - VTD_PAGE_SHIFT)
> +		size_order = 63 - VTD_PAGE_SHIFT;
> +

Sashiko reported a critical issue with this change. I will drop this
patch from the series and spend more time investigating and reworking
the fix.

https://sashiko.dev/#/patchset/20260804023714.3080506-1-baolu.lu%40linux.intel.com

>   	/*
>   	 * If S bit is 0, we only flush a single page. If S bit is set,
>   	 * The least significant zero bit indicates the invalidation address
> @@ -1120,7 +1128,7 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
>   	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
>   	 * ECAP.
>   	 */
> -	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
> +	if (!IS_ALIGNED(addr, BIT_ULL(VTD_PAGE_SHIFT + size_order)))
>   		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
>   				    addr, size_order);
>   
> @@ -1136,7 +1144,7 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
>   		desc->qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
>   					VTD_PAGE_SHIFT);
>   		/* Clear size_order bit to indicate size */
> -		desc->qw1 &= ~mask;
> +		desc->qw1 &= ~BIT_ULL(VTD_PAGE_SHIFT + size_order - 1);
>   		/* Set the S bit to indicate flushing more than 1 page */
>   		desc->qw1 |= QI_DEV_EIOTLB_SIZE;
>   	}

Thanks,
baolu
