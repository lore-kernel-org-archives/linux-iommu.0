Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24E27733
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577988; cv=none; b=ipHvvAbEyrLo+HENN12rMsYgFv1K3ETHVbCljfNsBeXA5Gtra8QQjPygyTlX/V6B9bxDpyfZeCKxUoEpi7U7etTlLxkDPD/+rn/FY6P0fuYRi5/WtMAj2K3DUtRlNh+kB8qikJ9OJcS1aoGkVyi63IMPM9NjtrstUA+GqLrOU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577988; c=relaxed/simple;
	bh=iP72sjx0dw/MwgE+xmP0d2ItZCoMMkXEZyU0W+SEO5o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JVEY4/VuNkE0NfclFibt/Jyrw/+g0rPj9pNMrZc5Yd3VdITyYgDhyDrkLKG/JS3AlUsP0Cdcn6nUE4xo/fPoB/RbTXRUbsLbeOSxnA/ss7yIX7tRYr6enqrI4VV9fpiyv41rkPs683soHH5g2+6Ml5CpGGf1DcW8FNgy3q9Cxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5H7dNBw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5H7dNBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719577986; x=1751113986;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iP72sjx0dw/MwgE+xmP0d2ItZCoMMkXEZyU0W+SEO5o=;
  b=j5H7dNBwT5k8Ju9xJo+tNe0mGaMxEhVwVktQi/ioU9Far072qobBVysA
   lhZnE1PX8swjsCmE/hfsw3Le12ft338q7SQQ2I9rpx0igsSiPgfDm0SOA
   OM5Pjddeu/l4kkKuHE7Ez+2ql6Fmqh91hCI8bnJIqPud5l+m3Gof7r0Z7
   E1QoDwMmQZEh2+w82GhiuyETWo3lRLPXIxLQiG0XXScF3Gsli3QLaWKXX
   NdsLhiukgMrAlVlaV+HLmfirKpH10aIr0ycqJd28rDuWLANxPJ57o/hto
   Y/pkYXNbZCdMM8hJGmJqpb4nALIm7aOPwp7+Prei5QQtxT2VZZbEfPZnc
   Q==;
X-CSE-ConnectionGUID: yQrzJ07TT6m9Obwb0sigUA==
X-CSE-MsgGUID: zQNVm34jRWihdrGsOksEQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12299777"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="12299777"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:33:05 -0700
X-CSE-ConnectionGUID: 8ZksAHdgQ3upAMxwF8GTzw==
X-CSE-MsgGUID: rZ8Cq3WYRyyuvf5sMQtcqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44563171"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:33:03 -0700
Message-ID: <fbede9a0-cfbc-4782-99c1-803f611c28b1@linux.intel.com>
Date: Fri, 28 Jun 2024 20:33:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, yj.chiang@mediatek.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iommu: Remove iommu_sva_unbind_gpasid
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240628113011.3535-1-mark-pk.tsai@mediatek.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240628113011.3535-1-mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/28 19:30, Mark-PK Tsai wrote:
> This is a left over of commit 0c9f17877891
> ("iommu: Remove guest pasid related interfaces and definitions")
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>   include/linux/iommu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 17b3f36ad843..225403cfe614 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -785,8 +785,6 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);
>   extern void iommu_detach_device(struct iommu_domain *domain,
>   				struct device *dev);
> -extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -				   struct device *dev, ioasid_t pasid);

Not sure why this still remains there. But it seems not alone.

$ git grep iommu_sva_unbind_gpasid
Documentation/userspace-api/iommu.rst:  int 
iommu_sva_unbind_gpasid(struct iommu_domain *domain,
include/linux/iommu.h:extern int iommu_sva_unbind_gpasid(struct 
iommu_domain *domain,

I believe the document should also be removed.

>   extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>   extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>   extern int iommu_map(struct iommu_domain *domain, unsigned long iova,

Best regards,
baolu
