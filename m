Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94762236E5
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765508174; cv=none; b=J+ersYEFC1mn3Q763VRJw/h7hWZ3dlloPB1J2PED8zd8YKcUcl+Uj0aVxgbn3FaKAGiLRGCV5iFck/WPr5RWIBy2yoV+xJQbRo4QDNhMSM3BXeAMTvi1VuVtW9eMZFuZUADHIM6C0DhUao5gygkV2fSW0UGNrq5Mqn98i0i/PZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765508174; c=relaxed/simple;
	bh=kT137sNmfNB8Sc6qW8Hhi0yb56d3CUsss1jHlI43eOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYd0RAvrYVKJ0Yqr2DsNmNiWfxuTxeAaGQRaCtchEIoVZF1pFg3p0TbNzA4J8jIeraLNkEZFIO4kyjcQoThYKBwld2FKeZEKesV0QsrpQkFc9/b5yG7N7eKJrCsjDFltDcKpW66bglGv6xDvyI0QHM7mia9wFwmIf28UixSqG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyVPO1em; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyVPO1em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765508172; x=1797044172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kT137sNmfNB8Sc6qW8Hhi0yb56d3CUsss1jHlI43eOw=;
  b=DyVPO1emGi4fmrjxeq7sjQlvmNvSLk/RbZkaq2ObOdnuQuxt9dGWv1GN
   NdcUV23XNVx2iD0tQ5wnAWdpEvbdZ/cYlNmXHDcW1tMpjvZSJY3m7kVP1
   m+mDXoYY4+cgfkIcuhIuT5VsA1FP5YSGh2+Ihfm8Z1B2OBbriOAon7pvI
   bj66D8BfwptEJffaKW8aI/V1mjvsMPJYhE7BtTzuUTH+X3vnuVFn8YEXA
   3FTv8gkGXB7lbUzU9KB86U2MIusFTodFBaSM6lugemlkQMbwsW/7N20/2
   GjIW21R4p0UVUekMVcG/Ygi3qVtWHplqumwcWX8bf3ldyFdzpunTHigBw
   Q==;
X-CSE-ConnectionGUID: qF3f/UyrT+e8Bxg0k8PdKQ==
X-CSE-MsgGUID: d/Doqg+sQUSXoreXGUmLDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67546824"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67546824"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:56:11 -0800
X-CSE-ConnectionGUID: gI04P57fSR2SYtMNoD/a5w==
X-CSE-MsgGUID: ut7bpy5cR82ss1Mh0YQ5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="196048871"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:56:06 -0800
Message-ID: <aa14d149-dfde-44e9-8fb3-72cb9b0e6920@linux.intel.com>
Date: Fri, 12 Dec 2025 10:51:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] iommu: debug-pagealloc: Check mapped/unmapped
 kernel memory
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com, rdunlap@infradead.org
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-5-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251211125928.3258905-5-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/25 20:59, Mostafa Saleh wrote:
> Now, as the page_ext holds count of IOMMU mappings, we can use it to
> assert that any page allocated/freed is indeed not in the IOMMU.
> 
> The sanitizer doesn’t protect against mapping/unmapping during this
> period. However, that’s less harmful as the page is not used by the
> kernel.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/iommu-debug-pagealloc.c | 23 +++++++++++++++++++++++
>   include/linux/iommu-debug-pagealloc.h | 14 ++++++++++++++
>   include/linux/mm.h                    |  5 +++++
>   3 files changed, 42 insertions(+)

[...]

> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> index a439d6815ca1..46c3c1f70150 100644
> --- a/include/linux/iommu-debug-pagealloc.h
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -13,6 +13,20 @@ DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
>   
>   extern struct page_ext_operations page_iommu_debug_ops;
>   
> +void __iommu_debug_check_unmapped(const struct page *page, int numpages);
> +
> +static inline void iommu_debug_check_unmapped(const struct page *page, int numpages)
> +{
> +	if (static_branch_unlikely(&iommu_debug_initialized))
> +		__iommu_debug_check_unmapped(page, numpages);
> +}

Same here, possible to make iommu_debug_initialized static?

> +#else
> +static inline void iommu_debug_check_unmapped(const struct page *page,
> +					      int numpages)
> +{
> +}
> +
>   #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
>   
>   #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7a1819c20643..3763b71a7d3e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -36,6 +36,7 @@
>   #include <linux/rcuwait.h>
>   #include <linux/bitmap.h>
>   #include <linux/bitops.h>
> +#include <linux/iommu-debug-pagealloc.h>
>   
>   struct mempolicy;
>   struct anon_vma;
> @@ -4133,12 +4134,16 @@ extern void __kernel_map_pages(struct page *page, int numpages, int enable);
>   #ifdef CONFIG_DEBUG_PAGEALLOC
>   static inline void debug_pagealloc_map_pages(struct page *page, int numpages)
>   {
> +	iommu_debug_check_unmapped(page, numpages);
> +
>   	if (debug_pagealloc_enabled_static())
>   		__kernel_map_pages(page, numpages, 1);
>   }
>   
>   static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages)
>   {
> +	iommu_debug_check_unmapped(page, numpages);
> +
>   	if (debug_pagealloc_enabled_static())
>   		__kernel_map_pages(page, numpages, 0);
>   }

Other changes look good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
