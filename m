Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1EB1C3C18
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057556; cv=none; b=VR3Wxvax/Urk9k2b9b/cGBA1yw78YSPemQ+ksOhJm7bgNgsi5cnwj5Fv/oNCyt5SS2/oCuzkUWqhIPNQjip1w64vm3MDzEYFAuhAAnKROenCEgI9dkq2XMMb6Bo1c+QAnQIqXVCu1lWKV4JjAWpNW6N3qG4BzoCrgrDvl0igm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057556; c=relaxed/simple;
	bh=RGjxKJ2ZxAiE5osguDNbbjhtWqjDFmM8MSebv4rSgVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adqy2aRj8JIxb3uzwDdQAkA57SBFtSKfySBxSzvSNxSat1kM3e+EAzSVNNgZEciTyQDJe+bSgR5/KMDrLsI1mxROVC1YxeC4cNUQBEaPES6sN3FqzycPN2qEdZYkZHbm75+pHdXEZsET00W5kW6WLUXoNix4vGP1dVb3VfNG0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVNAmY2p; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVNAmY2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764057555; x=1795593555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RGjxKJ2ZxAiE5osguDNbbjhtWqjDFmM8MSebv4rSgVQ=;
  b=MVNAmY2pdnXs7tw2/nRNQyHwLOR8gEHlELc11vVcpcuTA2Qsc1X/gnpJ
   iXF5QTvV7W/JK7bTzFvkXzyxrtViqW4iZLQqm7NKQWjuSYYnmo+EkvZj3
   HIqidCsposTntPLVjKZpFk9SY5+/4lJQn46aXfrO/4gKVCL14fkZRSS0+
   tj/KOhEFgMe4dJCIOfUy5p5yghvR1Iam+UBX5o8+9rBy+3XHrn9Xf28au
   U9fBV1ilyXQzh9x+Hm8akU4i0dhjnor+q8bpFH9fRuQnQ91VJWU3f+TQL
   CTmKy3ssdGbQm9kF/Sroo7TpZul04wdmemw6mAPh4vUQ0NRUCvlPVK0kn
   w==;
X-CSE-ConnectionGUID: cNApB3kZTgK0u3Sf3CB4+Q==
X-CSE-MsgGUID: Ksy2dk19QpSz5QqjxXhfuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="69925585"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="69925585"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:59:14 -0800
X-CSE-ConnectionGUID: ZspEYjjeS9izC1yNOLqMnQ==
X-CSE-MsgGUID: aM4gg/PKSemlzoUv5gQjjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="192647450"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:59:09 -0800
Message-ID: <ae535698-33fc-42a1-8a5a-ed8dd192f697@linux.intel.com>
Date: Tue, 25 Nov 2025 15:54:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-4-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251124200811.2942432-4-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 04:08, Mostafa Saleh wrote:
>   void __iommu_debug_unmap_end(struct iommu_domain *domain,
>   			     unsigned long iova, size_t size,
>   			     size_t unmapped)
>   {
> +	if (unmapped == size)
> +		return;
> +
> +	/*
> +	 * If unmap failed, re-increment the refcount, but if it unmapped
> +	 * larger size, decrement the extra part.
> +	 */
> +	if (unmapped < size)
> +		__iommu_debug_update_iova(domain, iova + unmapped,
> +					  size - unmapped, true);
> +	else
> +		__iommu_debug_update_iova(domain, iova + size,
> +					  unmapped - size, false);

In any case, could the 'else' branch become a real operation?

In the __iommu_unmap():

         /*
          * Keep iterating until we either unmap 'size' bytes (or more)
          * or we hit an area that isn't mapped.
          */
         while (unmapped < size) {
                 size_t pgsize, count;

                 pgsize = iommu_pgsize(domain, iova, iova, size - 
unmapped, &count);
                 unmapped_page = ops->unmap_pages(domain, iova, pgsize, 
count, iotlb_gather);
                 if (!unmapped_page)
                         break;

                 pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
                          iova, unmapped_page);

                 iova += unmapped_page;
                 unmapped += unmapped_page;
         }

The comments say that it is possible to unmap more bytes than 'size',
but isn't it a bug if this helper unmaps more than the caller desired?

Thanks,
baolu
