Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B9225403
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122699; cv=none; b=MuV8ofHm9jUgyzW0CikH6oz3pk+e+s4hqZWA0Y/OYxIUvFVlnj0rrg9rpTySk/VeczrxnDiFHcPJtWm1omp0T6KDB2Hr/QWyvciUqRGauiD90FUgZcJaQ0rd0IV4Vo6FL9TW1wge+hfOLc6yeSbQvLJTYD9vvY6+HKSmmivdQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122699; c=relaxed/simple;
	bh=iXISzev/0LC4OZ3gbHLmUdmiQ+zAVSODpccbTdBCK1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TC8ZbO6ReVMA/87jcIsFPAGbH+aev0FvDK/FTBckaYKwhoxHIc6N6P/zd8KbMxPOZoshMkmfeTy0kyF3QrXacBWbZppqxQsLsTsw1Mpkb+85RrOemblOOzvlxMWBgMr7Rb9iXkTLXOZl7q0KPigQCmTXhkBmnMsq+ZD8Okg2NVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKBhxPho; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKBhxPho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778122698; x=1809658698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iXISzev/0LC4OZ3gbHLmUdmiQ+zAVSODpccbTdBCK1U=;
  b=OKBhxPhozlVV/s7R/4KcdWK5MkgLAtfxP0dxCU0m7Eb+vlIMtusV5s1m
   7pu76PEccAi6+ZTzqGl0VwlldVaFlOIP+DZKcD/Y61O8zgOZzYOzBZ4F+
   /uHqOLA8j1uu8wSVYPIbVqRxJk0F/QkdMVhN3macvbbCiQbEFDRzFdwJs
   JYuwhP+VPLn46N/13m4wrPPinWrai4qDTIbjiGlCsuKSJeDbJVCZwo+BX
   4jZrUcd2T+3I/mYerZgJSSvkznn0+mkg51/sZ8NZxa4X56nzkdY79PZ9Y
   y4VxiA0SoV8HsFEaW7DNQucvg3neEHmgfdwHJjkRwX+0MWZE9g5nN1jC1
   g==;
X-CSE-ConnectionGUID: YnItPX/rQVOqtsnqHUY9oA==
X-CSE-MsgGUID: 69Zr0pr9Q0Wr0RacweuGgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79082961"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79082961"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 19:58:17 -0700
X-CSE-ConnectionGUID: oftxAlgJRXKbzWPd9mP2ug==
X-CSE-MsgGUID: xfkid6ZrTjq8L7ZBayG4Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="266707987"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 19:58:11 -0700
Message-ID: <39a010b4-7099-434a-b8de-5d03a75f2a9f@linux.intel.com>
Date: Thu, 7 May 2026 10:55:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 YiFei Zhu <zhuyifei@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260427175633.1978233-7-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 01:56, Samiullah Khawaja wrote:
> Implement the iommu domain ops for presevation, unpresevation and
> restoration of iommu domains for liveupdate. Use the existing page
> walker to preserve the ioptdesc of the top_table and the lower tables.
> 
> Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
> the next kernel. On restore the domain has only the preserved features
> enabled and all the other features are zeroed. This is ok since the
> restored domain is made immutable and can only be freed. A kunit test is
> added to verify that the IOMMU domain free can be done with trimmed
> features.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/generic_pt/iommu_pt.h       | 131 ++++++++++++++++++++++
>   drivers/iommu/generic_pt/kunit_iommu_pt.h |  28 +++++
>   include/linux/generic_pt/iommu.h          |  19 +++-
>   3 files changed, 177 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index 19b6daf88f2a..7bca827e3a55 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -961,6 +961,133 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
>   	return ret;
>   }
>   
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +/**
> + * unpreserve() - Unpreserve page tables and other state of a domain.
> + * @domain: Domain to unpreserve
> + */
> +void DOMAIN_NS(unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +	};
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	iommu_unpreserve_pages(&collect.free_list);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unpreserve), "GENERIC_PT_IOMMU");
> +
> +/**
> + * preserve() - Preserve page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, 0 on success.
> + */
> +int DOMAIN_NS(preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +	};
> +	int ret;
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	ret = iommu_preserve_pages(&collect.free_list);
> +	if (ret)
> +		return ret;
> +
> +	ser->top_table_phys = virt_to_phys(range.top_table);
> +	ser->top_level = range.top_level;
> +
> +	/*
> +	 * VASZ and SIGN_EXTEND will be needed in next kernel for collector page
> +	 * table walk to restore and free pages.
> +	 */
> +	ser->vasz = common->max_vasz_lg2;
> +	ser->sign_extend = pt_feature(common, PT_FEAT_SIGN_EXTEND);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(preserve), "GENERIC_PT_IOMMU");
> +
> +static int __restore_tables(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	int ret;
> +
> +	for_each_pt_level_entry(&pts) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			iommu_restore_page(virt_to_phys(pts.table_lower));
> +
> +			/*
> +			 * pt_descend can only fail if pts.table_lower is not
> +			 * init. So the if statement below is dead code.
> +			 */
> +			ret = pt_descend(&pts, arg, __restore_tables);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pt_iommu_ops NS(ops_immutable);
> +
> +/**
> + * restore() - Restore page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, 0 on success.
> + */
> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range;
> +
> +	common->max_vasz_lg2 = ser->vasz;
> +
> +	/* Make this domain immutable.*/
> +	iommu_table->ops = &NS(ops_immutable);
> +
> +	/*
> +	 * It is safe to override this here since this domain is immutable and
> +	 * can only be freed.
> +	 */
> +	common->features = 0;
> +	if (ser->sign_extend)
> +		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
> +
> +	range = pt_all_range(common);
> +	iommu_restore_page(ser->top_table_phys);
> +
> +	/* Free new table */
> +	iommu_free_pages(range.top_table);
> +
> +	/* Set the restored top table */
> +	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
> +
> +	/* Restore all pages*/
> +	range = pt_all_range(common);
> +	return pt_walk_range(&range, __restore_tables, NULL);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
> +#endif
> +
>   struct pt_unmap_args {
>   	struct iommu_pages_list free_list;
>   	pt_vaddr_t unmapped;
> @@ -1138,6 +1265,10 @@ static const struct pt_iommu_ops NS(ops) = {
>   	.deinit = NS(deinit),
>   };
>   
> +static const struct pt_iommu_ops NS(ops_immutable) = {
> +	.deinit = NS(deinit),
> +};
> +
>   static int pt_init_common(struct pt_common *common)
>   {
>   	struct pt_range top_range = pt_top_range(common);
> diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
> index e8a63c8ea850..af1918d693ed 100644
> --- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
> +++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
> @@ -426,6 +426,33 @@ static void test_mixed(struct kunit *test)
>   	check_iova(test, start, oa, len);
>   }
>   
> +static void test_restore_free(struct kunit *test)
> +{
> +	struct kunit_iommu_priv *priv = test->priv;
> +	struct pt_range top_range = pt_top_range(priv->common);
> +	u64 start = 0x3fe400ULL << 12;
> +	u64 end = 0x4c0600ULL << 12;
> +	pt_vaddr_t len = end - start;
> +
> +	if (top_range.last_va <= start || sizeof(unsigned long) == 4)
> +		kunit_skip(test, "range is too small");
> +	if ((priv->safe_pgsize_bitmap & GENMASK(30, 21)) != (BIT(30) | BIT(21)))
> +		kunit_skip(test, "incompatible psize");
> +
> +	/* Map a large mixed range to populate multiple levels of page tables */
> +	do_map(test, start, start, len);
> +
> +	/*
> +	 * Simulate a restored state by clearing all features except
> +	 * SIGN_EXTEND. This verifies that the generic page table free walker
> +	 * can correctly tear down a populated domain when other features are
> +	 * zeroed.
> +	 */
> +	priv->common->features &= BIT(PT_FEAT_SIGN_EXTEND);
> +
> +	/* The domain will be freed when the test exits. */
> +}
> +
>   static struct kunit_case iommu_test_cases[] = {
>   	KUNIT_CASE_FMT(test_increase_level),
>   	KUNIT_CASE_FMT(test_map_simple),
> @@ -434,6 +461,7 @@ static struct kunit_case iommu_test_cases[] = {
>   	KUNIT_CASE_FMT(test_random_map),
>   	KUNIT_CASE_FMT(test_pgsize_boundary),
>   	KUNIT_CASE_FMT(test_mixed),
> +	KUNIT_CASE_FMT(test_restore_free),
>   	{},
>   };
>   
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> index dd0edd02a48a..649b3b9eb1a0 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -13,6 +13,7 @@ struct iommu_iotlb_gather;
>   struct pt_iommu_ops;
>   struct pt_iommu_driver_ops;
>   struct iommu_dirty_bitmap;
> +struct iommu_domain_ser;
>   
>   /**
>    * DOC: IOMMU Radix Page Table
> @@ -251,6 +252,12 @@ struct pt_iommu_cfg {
>   #define IOMMU_PROTOTYPES(fmt)                                                  \
>   	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
>   						  dma_addr_t iova);            \
> +	int pt_iommu_##fmt##_preserve(struct iommu_domain *domain,             \
> +				      struct iommu_domain_ser *ser);           \
> +	void pt_iommu_##fmt##_unpreserve(struct iommu_domain *domain,          \
> +					 struct iommu_domain_ser *ser);        \
> +	int pt_iommu_##fmt##_restore(struct iommu_domain *domain,              \
> +				     struct iommu_domain_ser *ser);            \
>   	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
>   		struct iommu_domain *domain, unsigned long iova, size_t size,  \
>   		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
> @@ -266,12 +273,22 @@ struct pt_iommu_cfg {
>   	};                              \
>   	IOMMU_PROTOTYPES(fmt)
>   
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
> +	, .preserve = &pt_iommu_##fmt##_preserve,	\
> +	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
> +	.restore = &pt_iommu_##fmt##_restore

Nit: would it look better if we put it like this?

#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
	, .preserve = &pt_iommu_##fmt##_preserve	\
	, .unpreserve = &pt_iommu_##fmt##_unpreserve	\
	, .restore = &pt_iommu_##fmt##_restore

> +#else
> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
> +#endif

Thanks,
baolu
