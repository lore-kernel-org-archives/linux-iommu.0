Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572553AD538
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543903; cv=none; b=LNiR6oIUiOkX+ZxiMMt5IMDxH0JVAON9fvfWP0+UUc9voYVnw92r3z6r/cewXuMbNiNOo7IctrF+KC+c297PlUCkz2KPYmuVAqb+vP/Ua1ENcKrHj25BQ/ZA9CABYRFCYAEClrWTJhBo5WQOYn6sGGdE1YXM2nYyByMQ7SUSgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543903; c=relaxed/simple;
	bh=m9sAhUXyy3CacNduEVQURk/rlD5yMXkjDXgtTZSqvi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4jCxaHWVX6zIpgshdqy/ZdbzGHZTxDNN28wKzxNfORrRoTS8VXUjJzFnn/Y7rasMSXtVt+x8yF+zV8yOXQDGHz3UMkQ6rsnFkNXj615X64IGBBlVSonJGgnAzE3Q+IWdAXMwnsgwFrEnx3HVkSrI0MZziCc34OLxnAXdJO6C3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU4d1WTC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU4d1WTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780543900; x=1812079900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m9sAhUXyy3CacNduEVQURk/rlD5yMXkjDXgtTZSqvi0=;
  b=PU4d1WTCv2Ax5HoUiCByMvKgK8V+QGwUsaOm3PFkaz56IPTADP4vR4jI
   3LVfrS7z98KTKFKbthlf4NiMUcgZksQSbHS1hu8JQVSFM0rKJLhS/AtG2
   v1k9u/GWvZHdGLrsBZMi8azYFGnSFUYSrQ5Wsty57jMY9QmuriJjVRGjO
   /AL31aq0kbiXY94LctBygHXo6+ZONyTk1oVM36764xoVBvm2hpZSF/ze/
   32z7FdUWD2Lo+hyu67mTcbgTWxlrrzd01qx+g2NQ8jqCbj7U2mYlkU2ln
   ERAlBOQT3j8eTIWNQUnTM+VPWDey9tDxWz1Vx4jv5oU0cCQKy4SZcO1ks
   w==;
X-CSE-ConnectionGUID: Sfsy9O5STYaZ7bQ32lqr/g==
X-CSE-MsgGUID: l56aKil+Q6iMmW1rGnuxwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="84988559"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="84988559"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:31:39 -0700
X-CSE-ConnectionGUID: tDtIkBjHQp+ahDL4TIlYWw==
X-CSE-MsgGUID: RrMw6T74SU6zOV024GZFrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="243589464"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:31:34 -0700
Message-ID: <c179b999-8c7f-4338-8aad-b61fd09f1329@linux.intel.com>
Date: Thu, 4 Jun 2026 11:30:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/32] iommu/generic_pt: implement iova_to_phys_length
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/26 23:17, Guanghui Feng wrote:
> Extend the Generic Page Table framework to implement iova_to_phys_length.
> Use pt_entry_oa_lg2sz() to determine PTE block size. Update
> IOMMU_PT_DOMAIN_OPS macro to set .iova_to_phys_length.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
> ---
>   drivers/iommu/generic_pt/iommu_pt.h | 84 +++++++++++++++++++++--------
>   include/linux/generic_pt/iommu.h    | 13 ++---
>   2 files changed, 69 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index dc91fb4e2f61..e362e819ef9c 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -145,13 +145,21 @@ static inline unsigned int compute_best_pgsize(struct pt_state *pts,
>   				      pts->range->va, pts->range->last_va, oa);
>   }
>   
> -static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> -					     unsigned int level,
> -					     struct pt_table_p *table,
> -					     pt_level_fn_t descend_fn)
> +struct iova_to_phys_length_data {
> +	pt_oaddr_t phys;
> +	size_t length;
> +};
> +
> +static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
> +					       void *arg, unsigned int level,
> +					       struct pt_table_p *table,
> +					       pt_level_fn_t descend_fn)
>   {
>   	struct pt_state pts = pt_init(range, level, table);
> -	pt_oaddr_t *res = arg;
> +	struct iova_to_phys_length_data *data = arg;
> +	unsigned int entry_lg2sz;
> +	size_t entry_sz;
> +	pt_oaddr_t expected_oa;
>   
>   	switch (pt_load_single_entry(&pts)) {
>   	case PT_ENTRY_EMPTY:
> @@ -159,45 +167,77 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>   	case PT_ENTRY_TABLE:
>   		return pt_descend(&pts, arg, descend_fn);
>   	case PT_ENTRY_OA:
> -		*res = pt_entry_oa_exact(&pts);
> -		return 0;
> +		break;
>   	}
> -	return -ENOENT;
> +
> +	data->phys = pt_entry_oa_exact(&pts);
> +	entry_lg2sz = pt_entry_oa_lg2sz(&pts);
> +	entry_sz = log2_to_int(entry_lg2sz);
> +
> +	/* Start with the full mapping size of the first entry */
> +	data->length = entry_sz;

data->length doesn't account for iova offset. Is this by design? We
should document this clearly somewhere.

Sashiko reported the same issue too.

[Severity: High]
Does this calculation overstate the mapped length for unaligned IOVAs?
If the IOVA is not aligned to the PTE block size, pt_entry_oa_exact()
includes the intra-page offset in data->phys. However, data->length
is unconditionally initialized to the full entry_sz rather than
entry_sz - offset. Callers relying on mapped_length might operate
on out-of-bounds memory because data->phys + data->length extends
beyond the valid mapped physical memory by the unaligned offset amount.

> +
> +	/* Accumulate subsequent physically contiguous entries */
> +	expected_oa = pt_entry_oa(&pts) + entry_sz;
> +	pts.end_index = log2_to_int(pt_num_items_lg2(&pts));
> +	pt_next_entry(&pts);
> +
> +	while (pts.index < pts.end_index) {
> +		pt_load_entry(&pts);
> +		if (pts.type != PT_ENTRY_OA)
> +			break;
> +		if (pt_entry_oa_lg2sz(&pts) != entry_lg2sz)
> +			break;
> +		if (pt_entry_oa(&pts) != expected_oa)
> +			break;
> +		data->length += entry_sz;
> +		expected_oa += entry_sz;
> +		pt_next_entry(&pts);
> +	}
> +
> +	return 0;
>   }
> -PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
> +PT_MAKE_LEVELS(__iova_to_phys_length, __do_iova_to_phys_length);
>   
>   /**
> - * iova_to_phys() - Return the output address for the given IOVA
> + * iova_to_phys_length() - Translate IOVA returning phys and contiguous length
>    * @domain: Table to query
>    * @iova: IO virtual address to query
> + * @mapped_length: Output for the total contiguous mapped length in bytes
>    *
> - * Determine the output address from the given IOVA. @iova may have any
> - * alignment, the returned physical will be adjusted with any sub page offset.
> + * Walk the IOMMU page table to translate @iova to a physical address while
> + * also returning the total contiguous physically mapped length through
> + * @mapped_length. The function accumulates consecutive page table entries that
> + * are physically contiguous, so callers can determine the full contiguous
> + * mapping extent with a single call.
>    *
>    * Context: The caller must hold a read range lock that includes @iova.
>    *
> - * Return: 0 if there is no translation for the given iova.
> + * Return: The physical address, or PHYS_ADDR_MAX if there is no translation.
>    */
> -phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
> -				    dma_addr_t iova)
> +phys_addr_t DOMAIN_NS(iova_to_phys_length)(struct iommu_domain *domain,
> +					    dma_addr_t iova,
> +					    size_t *mapped_length)
>   {
>   	struct pt_iommu *iommu_table =
>   		container_of(domain, struct pt_iommu, domain);
>   	struct pt_range range;
> -	pt_oaddr_t res;
> +	struct iova_to_phys_length_data data;
>   	int ret;
>   
>   	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
>   	if (ret)
> -		return ret;
> +		return PHYS_ADDR_MAX;
>   
> -	ret = pt_walk_range(&range, __iova_to_phys, &res);
> -	/* PHYS_ADDR_MAX would be a better error code */
> +	ret = pt_walk_range(&range, __iova_to_phys_length, &data);
>   	if (ret)
> -		return 0;
> -	return res;
> +		return PHYS_ADDR_MAX;
> +
> +	if (mapped_length)
> +		*mapped_length = data.length;
> +	return data.phys;
>   }
> -EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys_length), "GENERIC_PT_IOMMU");
>   
>   struct pt_iommu_dirty_args {
>   	struct iommu_dirty_bitmap *dirty;
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> index dd0edd02a48a..859b853e9dc7 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -249,8 +249,9 @@ struct pt_iommu_cfg {
>   
>   /* Generate the exported function signatures from iommu_pt.h */
>   #define IOMMU_PROTOTYPES(fmt)                                                  \
> -	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
> -						  dma_addr_t iova);            \
> +	phys_addr_t pt_iommu_##fmt##_iova_to_phys_length(			\
> +		struct iommu_domain *domain, dma_addr_t iova,			\
> +		size_t *mapped_length);						\
>   	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
>   		struct iommu_domain *domain, unsigned long iova, size_t size,  \
>   		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
> @@ -267,11 +268,11 @@ struct pt_iommu_cfg {
>   	IOMMU_PROTOTYPES(fmt)
>   
>   /*
> - * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
> - * iommu_pt
> + * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for
> + * the iommu_pt
>    */
> -#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
> -	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys
> +#define IOMMU_PT_DOMAIN_OPS(fmt)					\
> +	.iova_to_phys_length = &pt_iommu_##fmt##_iova_to_phys_length
>   #define IOMMU_PT_DIRTY_OPS(fmt) \
>   	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
>   

Thanks,
baolu
