Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F5126BF1
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506119; cv=none; b=qtQNu2D8r4dtiybML83C+5s4Z/EL5sWw7VdCGNuQx+gFpPooja2SdQQqI1REYpopsV7CbmxZt660g81JLAS9z4uSSuhaeSJbE2rAjHWTmJQHacGwEnSNWByX4rBzcQDfWM1C65aPeH5OVtdL7znwxBgyUGFouWNJZFZ8E3Eb19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506119; c=relaxed/simple;
	bh=mTt8SDC8aH6PXy9ej/JNq1avguUMeGlT1TNm2631vCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEv0KVo/vmWbKACWkkaQ7CpsDTin1mHvoERkraChC6XZeZDnjNGdV+YnvaePVXZtMtZEu1CzylsaY66eJWe6mmxuYwqzbZs4IWUQRexHjGec9h619TZhX8R9H8pTctq2IEO36Dh27oPIuDx5swa7OV+LH7Gna2CXOZtbx0A8TWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTlmUF6U; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTlmUF6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765506118; x=1797042118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mTt8SDC8aH6PXy9ej/JNq1avguUMeGlT1TNm2631vCc=;
  b=CTlmUF6UWN2+e0yXJVgIiFjRLBos3XaVcCkSUlnfNVf5FQIDkLUYWnzd
   oOa/XEXnhVKXF4gUm1Z52NORIS9oF4tJtGCDudHet3UQjrq5lEcRhdjiA
   pozjFIKMXe1GVbIXA18+iFbY1/wlrmOxpjcVSFW/r6MySiBm4Cc5MIbMA
   2S8hfLJ8y8XaRld1a928gbC+lpOdk/fG+i8APxufxH92hHsVzyI1SyE71
   q+tA+75hztsiG188LEkpyBE73HvO032XIlVlsNy2KAEKzbZWy1uizDish
   MbrGsMnZk84PnMApA+nNZrC7QTVK/cJZQjgSYHg5fgU7wtWjI/lP7zjXE
   A==;
X-CSE-ConnectionGUID: f3z7LFYWQEKRMm1QT4ZcOg==
X-CSE-MsgGUID: VgvcIwEESHKgMDi+oR/wDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85105366"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="85105366"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:21:57 -0800
X-CSE-ConnectionGUID: /SHB2B8qRjKtPwD499eH0g==
X-CSE-MsgGUID: 5HgWqXezR6ex+SBURVIEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="202038476"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 18:21:53 -0800
Message-ID: <341bbfd9-e6bb-4d1e-b9c0-9077dc3eaba3@linux.intel.com>
Date: Fri, 12 Dec 2025 10:17:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com, rdunlap@infradead.org
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-2-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251211125928.3258905-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/25 20:59, Mostafa Saleh wrote:
> Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> page_ext.
> 
> This config will be used by the IOMMU API to track pages mapped in
> the IOMMU to catch drivers trying to free kernel memory that they
> still map in their domains, causing all types of memory corruption.
> 
> This behaviour is disabled by default and can be enabled using
> kernel cmdline iommu.debug_pagealloc.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  9 ++++++
>   drivers/iommu/Kconfig                         | 19 +++++++++++
>   drivers/iommu/Makefile                        |  1 +
>   drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
>   include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
>   mm/page_ext.c                                 |  4 +++
>   6 files changed, 82 insertions(+)
>   create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>   create mode 100644 include/linux/iommu-debug-pagealloc.h

Do you need to update the MAINTAINERS file, since a new file (iommu-
debug-pagealloc.h) is being added?

> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a8d0afde7f85..d484d9d8d0a4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2675,6 +2675,15 @@ Kernel parameters
>   			1 - Bypass the IOMMU for DMA.
>   			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>   
> +	iommu.debug_pagealloc=
> +			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
> +			parameter enables the feature at boot time. By default, it
> +			is disabled and the system behaves the same way as a kernel
> +			built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
> +			Format: { "0" | "1" }
> +			0 - Sanitizer disabled.
> +			1 - Sanitizer enabled, expect runtime overhead.

"iommu.debug_pagealloc=0" has the same meaning as "unset". Would
"iommu=debug_pagealloc" look more appropriate?

> +
>   	io7=		[HW] IO7 for Marvel-based Alpha systems
>   			See comment before marvel_specify_io7 in
>   			arch/alpha/kernel/core_marvel.c.

[ ... ]

Other changes look good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
