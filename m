Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9EF286881
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056368; cv=none; b=W6FnZmEKq4gQT71KE75XM7ESVH9VRUys2vfY1HvRaRsvecdJ60YYZZjKfygFQ5xy4JxvYYCFsJdjm1plbmY1GscB1xGXpsZqNhcwi4tIzE+aNJJYtmIMXXiH+Pgkd11CM0c5YLG1VQn22XNIuu+WzExH0kroyhlS4OhNf0MxsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056368; c=relaxed/simple;
	bh=xTFbS/Nr2mwt++HLPItIulcioAWqO4kkoCiqlajkTgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFCBO9kAKUQoJp87fKKtFIG1osGWhq51fatOTuuvRkjKtvEtcckXWMlv++vKGwDqJqm40+An2lmTX4Miw+T+stLB6qT4BtqgoDEGk1Em3a79OSbv9JEpBUGosHU6JhmyG7CzbZEDkd7Jz3bkZPt10wg8ui/ta/sDnMp02AUmlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Azq8ZniK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Azq8ZniK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764056367; x=1795592367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xTFbS/Nr2mwt++HLPItIulcioAWqO4kkoCiqlajkTgo=;
  b=Azq8ZniKkSySOFSjJGtsSt77Bh2jOIoCtnRb7sjwcsVmwADejglv47dx
   lGPYMW7C4hO9jNTYYGHrB/OHR1/2NK4XbaKLwzQM/JgQSwbVg5aqarf+e
   8eanbCTNL5vezxTPiQTi96/sLPnGN0BhPF74o7crJ64TV6I1WZZth3jBi
   Twq6nt5L/KytC+HXUAtIZ3eCITWAiVoHDkp67Qh/oLBs+hKmYoUKzuxPh
   pWXpKpuQoPeROEDYuyqAK71h0J3Y0eczPWsepleJsE6BVnkpSRQrXx/Dn
   Kkrv3+FE9lBSW2g5jvb5j/3Gft/NFGG8zDTindkx5svnJywAzN2hLY3b4
   Q==;
X-CSE-ConnectionGUID: qGkkotXlSxG9gulVxlqw5A==
X-CSE-MsgGUID: Wi3NtK0aSOKNvdjT29r/fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77436418"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="77436418"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:39:26 -0800
X-CSE-ConnectionGUID: dCqAkL8QT9+gDGbFn17ZCQ==
X-CSE-MsgGUID: Lo04VFdkTxeDsMlYPzCL4w==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:39:21 -0800
Message-ID: <07434771-3233-4c88-b505-ee02da72c905@linux.intel.com>
Date: Tue, 25 Nov 2025 15:35:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-3-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251124200811.2942432-3-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 04:08, Mostafa Saleh wrote:
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
>   drivers/iommu/iommu-debug-pagealloc.c | 26 +++++++++++++
>   drivers/iommu/iommu.c                 | 12 +++++-
>   include/linux/iommu-debug-pagealloc.h | 56 +++++++++++++++++++++++++++
>   3 files changed, 92 insertions(+), 2 deletions(-)
> 

Remove "drivers/" from the commit title.

$ git log --oneline drivers/iommu/iommu.c

[...]
> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> index 83e64d70bf6c..454303ec09c2 100644
> --- a/include/linux/iommu-debug-pagealloc.h
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -8,10 +8,66 @@
>   #ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
>   #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
>   
> +struct iommu_domain;
> +
>   #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
>   
> +DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
> +
>   extern struct page_ext_operations page_iommu_debug_ops;
>   
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

I suppose that all these should go to drivers/iommu/iommu-priv.h, as
they are for use in other files inside the IOMMU subsystem.

> +
>   #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
>   
>   #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */

Thanks,
baolu
