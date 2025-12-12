Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E219CCF5
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507814; cv=none; b=OYTg1ROM5akC4lpK9zzzxjpwFW1Sio143sac/OujLJf7tC3jEHbKB/q7zqYQSLFXlKTGfFQgU1UnLMLisoL4aShWoQjh4lMgZadhTagC7PFi5f/oImQF+Ntk5r2GMle7jD47hPqt3XT//PC4+zeOGdChxACuDrXHxs5rSN8KU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507814; c=relaxed/simple;
	bh=g0azLKHQPuviLzNQ7aFttbhCLkEnPceuCV02p/FafUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTkp/wbyxBfatEO6CegHR+nmsAAzj9rkDrBn4pJKptX6zJlEHVAxalDNRUZ4ZIN611wDfzctWbfRJeWIId9IyKSnOWuPdTFxOSWN9kgdxXozbXfydJzLlFYUAx9iVndzKfWHW1n5b29+hXwW+rrY/hP8uIdKyKVGJT5GW1jnyfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDhwq/ZE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDhwq/ZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765507813; x=1797043813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g0azLKHQPuviLzNQ7aFttbhCLkEnPceuCV02p/FafUQ=;
  b=cDhwq/ZEhQFvloziKdSwZE9KtXsN+IwbvL4y05zpTW+NRMuK+Gio6gSI
   Z1b2VvRrwfipkHaAC9vHfY67xp+HW6Tr7+fXaYs7A4S8Dk/rgey2Kgfoy
   pSDkIPhf25gP0HSjFBdALJZlYkQbrowpUwNUE5c6k1RBAIye6xIu3C+XT
   OJlN0hpBE0vd05iZmSwzHdQtJygOgycDFLJQm0QRw1anDtVqDiUPEKSbC
   bEDR7L7Ct+nnVp2uuyflOC5Y4UBy2cRqqO40GbCidmD4rrgG0RxTyrUXR
   I4Z9icDjaPiAJTgR4yW6AHgE4AjImvfvTVZmeanl4Q7t4fBLIKUukY1Ub
   A==;
X-CSE-ConnectionGUID: tgMdtFGwSTiaxx5e8d1HCw==
X-CSE-MsgGUID: Rs2uH+5dQjG5InGEFqN1IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67383776"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67383776"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:50:12 -0800
X-CSE-ConnectionGUID: BT9+dIZKSmaXQuTxaIAXYg==
X-CSE-MsgGUID: eM42Sz1IT66EE2en6ly2vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="201380653"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:50:06 -0800
Message-ID: <dd62c21c-6ac5-4e30-b173-d1fa5dcf019f@linux.intel.com>
Date: Fri, 12 Dec 2025 10:45:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com, rdunlap@infradead.org
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-4-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251211125928.3258905-4-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/25 20:59, Mostafa Saleh wrote:
> Using the new calls, use an atomic refcount to track how many times
> a page is mapped in any of the IOMMUs.
> 
> For unmap we need to use iova_to_phys() to get the physical address
> of the pages.
> 
> We use the smallest supported page size as the granularity of tracking
> per domain.
> This is important as it is possible to map pages and unmap them with
> larger sizes (as in map_sg()) cases.
> 
> Signed-off-by: Mostafa Saleh<smostafa@google.com>
> ---
>   drivers/iommu/iommu-debug-pagealloc.c | 91 +++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index 1d343421da98..4639cf9518e6 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -29,19 +29,110 @@ struct page_ext_operations page_iommu_debug_ops = {
>   	.need = need_iommu_debug,
>   };
>   
> +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> +{
> +	struct page *page = phys_to_page(phys);
> +	struct page_ext *page_ext = page_ext_get(page);
> +
> +	return page_ext;
> +}
> +
> +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
> +{
> +	return page_ext_data(page_ext, &page_iommu_debug_ops);
> +}
> +
> +static void iommu_debug_inc_page(phys_addr_t phys)
> +{
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> +
> +	WARN_ON(atomic_inc_return_relaxed(&d->ref) <= 0);
> +	page_ext_put(page_ext);
> +}
> +
> +static void iommu_debug_dec_page(phys_addr_t phys)
> +{
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> +
> +	WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
> +	page_ext_put(page_ext);
> +}
> +
> +/*
> + * IOMMU page size doesn't have tomatch the CPU page size. So, we use

s/have tomatch/have to match/

> + * the smallest IOMMU page size to refcount the pages in the vmemmap.
> + * That is important as both map and unmap has to use the same page size
> + * to update the refcount to avoid double counting the same page.
> + * And as we can't know from iommu_unmap() what was the original page size
> + * used for map, we just use the minimum supported one for both.
> + */
> +static size_t iommu_debug_page_size(struct iommu_domain *domain)
> +{
> +	return 1UL << __ffs(domain->pgsize_bitmap);
> +}

The changes look good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
