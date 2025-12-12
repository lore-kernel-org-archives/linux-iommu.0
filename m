Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F89199FB0
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507088; cv=none; b=jbfiE0Mo4KKJapcqwJrFV7vx6wM0mb0/TtrZsz4HktbezsnX3ycXc6nkMe4E/pnrGmsxsBGnGwwzxZp2YOXX3vLs2h3yBjoiaBNZrkekAYHVXLBNzTWSNyi59JBJk7ON9fugaWUvmNsGsVZ4qO3Le0WFRMLB/QSqZwMu0vCnanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507088; c=relaxed/simple;
	bh=CxbZ+ZkeHIHwwVZs0wsMaxR2EAT5NzFU17ILwd374tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2k8dm1LfkwdCA+UDsD26ApnfxbXkoZYoGzgBOu+dMg6KspNfU6yX+82Bk8OkTA9I28xQnewgfmlbjISPLdJBaVHFrhHgLjnUBJdvSTY295uF/BLWaWkMZ1I1dTdcDGlLQFo/Arvegrhc4aAEFvxiPvjFw1QGJqn0lN+OsCBVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzS6rJTL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzS6rJTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765507088; x=1797043088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CxbZ+ZkeHIHwwVZs0wsMaxR2EAT5NzFU17ILwd374tg=;
  b=gzS6rJTLTp4wPME8c0t56m4qmC4dHXUMjXkN6AFp7M8A3Nn/ntm1CLMd
   4YmnnUUs469/Ite74tfDvfFjgwzVW+WlZ9j6wzAf1q4raWOOzyaD/Jo3U
   P9FDWwpo1PCvGrMBTa5wUQETFx7737gLPFQZh9hEKOgYZJyG3Wr80jQzj
   BQKxtbyiCI9wbqt2SF385WOXPwj60gf6I35HB+DRc/Xnce4yOkWTyFVKq
   Ryd6wDkcEqzgtXM+aQGmiwF8Zd/A0iQPvrUy/Tnucp4QDD/5wk0s9n2Oi
   a1W1E9Spjz0BDVv3e/St/bXiiguY/p49Gq2b73Iy4fVRJQTJCii2qwDDI
   g==;
X-CSE-ConnectionGUID: qJ5g4O5sSWKJQGeKbh4MmA==
X-CSE-MsgGUID: S3yHxFtcSiGvg4Oj091rmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67428886"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67428886"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:38:07 -0800
X-CSE-ConnectionGUID: cCt1EI17SoulFJ516oP8+A==
X-CSE-MsgGUID: paT5FfTpRjCzRzo8IAFUCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197436429"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:38:01 -0800
Message-ID: <20e015d7-cb54-4a2a-bf62-a828e10e3126@linux.intel.com>
Date: Fri, 12 Dec 2025 10:33:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com, rdunlap@infradead.org
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-3-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251211125928.3258905-3-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/25 20:59, Mostafa Saleh wrote:
> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> - iommu_debug_init: Enable the debug mode if configured by the user.
> - iommu_debug_map: Track iommu pages mapped, using physical address.
> - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
>    IOVA and size.
> - iommu_debug_unmap_end: Track the end of unmap operation, passing the
>    actual unmapped size versus the tracked one at unmap_begin.
> 
> We have to do the unmap_begin/end as once pages are unmapped we lose
> the information of the physical address.
> This is racy, but the API is racy by construction as it uses refcounts
> and doesn't attempt to lock/synchronize with the IOMMU API as that will
> be costly, meaning that possibility of false negative exists.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/iommu-debug-pagealloc.c | 28 +++++++++++++
>   drivers/iommu/iommu-priv.h            | 58 +++++++++++++++++++++++++++
>   drivers/iommu/iommu.c                 | 11 ++++-
>   include/linux/iommu-debug-pagealloc.h |  1 +
>   4 files changed, 96 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index 4022e9af7f27..1d343421da98 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -5,11 +5,15 @@
>    * IOMMU API debug page alloc sanitizer
>    */
>   #include <linux/atomic.h>
> +#include <linux/iommu.h>
>   #include <linux/iommu-debug-pagealloc.h>
>   #include <linux/kernel.h>
>   #include <linux/page_ext.h>
>   
> +#include "iommu-priv.h"
> +
>   static bool needed;
> +DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
>   
>   struct iommu_debug_metadata {
>   	atomic_t ref;
> @@ -25,6 +29,30 @@ struct page_ext_operations page_iommu_debug_ops = {
>   	.need = need_iommu_debug,
>   };
>   
> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> +{
> +}
> +
> +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> +			       unsigned long iova, size_t size)
> +{
> +}
> +
> +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> +			     unsigned long iova, size_t size,
> +			     size_t unmapped)
> +{
> +}
> +
> +void iommu_debug_init(void)
> +{
> +	if (!needed)
> +		return;
> +
> +	pr_info("iommu: Debugging page allocations, expect overhead or disable iommu.debug_pagealloc");
> +	static_branch_enable(&iommu_debug_initialized);
> +}
> +
>   static int __init iommu_debug_pagealloc(char *str)
>   {
>   	return kstrtobool(str, &needed);
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index c95394cd03a7..aaffad5854fc 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -5,6 +5,7 @@
>   #define __LINUX_IOMMU_PRIV_H
>   
>   #include <linux/iommu.h>
> +#include <linux/iommu-debug-pagealloc.h>
>   #include <linux/msi.h>
>   
>   static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
> @@ -65,4 +66,61 @@ static inline int iommufd_sw_msi(struct iommu_domain *domain,
>   int iommu_replace_device_pasid(struct iommu_domain *domain,
>   			       struct device *dev, ioasid_t pasid,
>   			       struct iommu_attach_handle *handle);
> +
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +
> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
> +		       size_t size);
> +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> +			       unsigned long iova, size_t size);
> +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> +			     unsigned long iova, size_t size, size_t unmapped);
> +
> +static inline void iommu_debug_map(struct iommu_domain *domain,
> +				   phys_addr_t phys, size_t size)
> +{
> +	if (static_branch_unlikely(&iommu_debug_initialized))
> +		__iommu_debug_map(domain, phys, size);
> +}
> +
> +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> +					   unsigned long iova, size_t size)
> +{
> +	if (static_branch_unlikely(&iommu_debug_initialized))
> +		__iommu_debug_unmap_begin(domain, iova, size);
> +}
> +
> +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> +					 unsigned long iova, size_t size,
> +					 size_t unmapped)
> +{
> +	if (static_branch_unlikely(&iommu_debug_initialized))
> +		__iommu_debug_unmap_end(domain, iova, size, unmapped);
> +}

I am wondering whether it would be better if we move iommu_debug_map()
to iommu-debug-pagealloc.c,

void iommu_debug_map(struct iommu_domain *domain,
		     phys_addr_t phys, size_t size)
{
	if (static_branch_likely(&iommu_debug_initialized))
		__iommu_debug_map(domain, phys, size);
}

(Does it make sense to use static_branch_likely() here? Normally, people
  who enable CONFIG_IOMMU_DEBUG_PAGEALLOC would want to use this
  debugging feature. Or not?)

So that ...

> +
> +void iommu_debug_init(void);
> +
> +#else
> +static inline void iommu_debug_map(struct iommu_domain *domain,
> +				   phys_addr_t phys, size_t size)
> +{
> +}
> +
> +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> +					   unsigned long iova, size_t size)
> +{
> +}
> +
> +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> +					 unsigned long iova, size_t size,
> +					 size_t unmapped)
> +{
> +}
> +
> +static inline void iommu_debug_init(void)
> +{
> +}
> +
> +#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> +
>   #endif /* __LINUX_IOMMU_PRIV_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2ca990dfbb88..01b062575519 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -232,6 +232,8 @@ static int __init iommu_subsys_init(void)
>   	if (!nb)
>   		return -ENOMEM;
>   
> +	iommu_debug_init();
> +
>   	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>   		nb[i].notifier_call = iommu_bus_notifier;
>   		bus_register_notifier(iommu_buses[i], &nb[i]);
> @@ -2562,10 +2564,12 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>   	}
>   
>   	/* unroll mapping in case something went wrong */
> -	if (ret)
> +	if (ret) {
>   		iommu_unmap(domain, orig_iova, orig_size - size);
> -	else
> +	} else {
>   		trace_map(orig_iova, orig_paddr, orig_size);
> +		iommu_debug_map(domain, orig_paddr, orig_size);
> +	}
>   
>   	return ret;
>   }
> @@ -2627,6 +2631,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   
>   	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
>   
> +	iommu_debug_unmap_begin(domain, iova, size);
> +
>   	/*
>   	 * Keep iterating until we either unmap 'size' bytes (or more)
>   	 * or we hit an area that isn't mapped.
> @@ -2647,6 +2653,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	}
>   
>   	trace_unmap(orig_iova, size, unmapped);
> +	iommu_debug_unmap_end(domain, orig_iova, size, unmapped);
>   	return unmapped;
>   }
>   
> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> index 83e64d70bf6c..a439d6815ca1 100644
> --- a/include/linux/iommu-debug-pagealloc.h
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -9,6 +9,7 @@
>   #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
>   
>   #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);

... we could make this static?

>   
>   extern struct page_ext_operations page_iommu_debug_ops;
>   

Thanks,
baolu
