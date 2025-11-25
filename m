Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30A284894
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055387; cv=none; b=FTxVMXVPZmIOZwTVDQd7vHK8XU9zs//q17uNvb+d5xI7fc9AJ5OIukLJ2Frx06QmtDnap8xRJTNOzFqQS2JKV2OZrrlcA9hgjJnXTqzBJ+aBcMbxoBvaVNVLdbWDrXsK2IDqUMte3WhI6biGyJc5HQjkcHHgf4fhtMAb1lTdGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055387; c=relaxed/simple;
	bh=nkiQcmVMDAWDvgWH8TwLxZ5+OG/fvCcRuE7BgYF1oWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9cRRWwkwRQK6Gqh8zH3hnHEfrdxf+9svbHg2cpcTb4s5D27yacE9aH0xtIBMPES538pJEJo9fB4Jxwr7oCnhtP+R49zCdHulm6vAyP8zQ4/iGacYWoG9kdYo1mUthJP4W6wOkemu9scYhnsbVFrWh56JEJssolMMIPgcCbmEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgCNFRpk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgCNFRpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764055386; x=1795591386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nkiQcmVMDAWDvgWH8TwLxZ5+OG/fvCcRuE7BgYF1oWk=;
  b=fgCNFRpk76L5Bzrq8/dOo03rDi5RDrPhhV+8Pz9mmzLsQrAxOZVYO+wt
   4BFCsPCRHD6sTrMTFd0FBxPvYxpdn2YrbJQKdob26ZlVjL8vUH6SCPnM6
   yXL8qAxBqpjs6AX2CVi4BGxL2NmBnOvL8ADeeGj/EqJCEsreCKvybuCmo
   7FbqyyQJWyQc3BW2KpCqAxrcicetDCdQZ+tBQvWm6tS/NgAJw65zVGpIb
   woKnjdJxl4/2gR4yB8iQ3xXpOh6b68NeaEkWQTEUV2efz8zW0oQRcHlZb
   1Ofp8KeZeXD18UhFUvcUrI3eSZUa70sPnowVDmOXqbL725ojZvf0rSYku
   w==;
X-CSE-ConnectionGUID: P5ok4l6yRQybhFwWluWAAA==
X-CSE-MsgGUID: /AP8VgovQJCuVT1is0FSqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="69923070"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="69923070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:23:05 -0800
X-CSE-ConnectionGUID: vWVS/dgcRaeC6PW3k1QUiA==
X-CSE-MsgGUID: DSDRsP0gQ9STzZ9EvJfV8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="215906221"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:23:00 -0800
Message-ID: <5f85e519-5a05-4359-9904-06f16737e28b@linux.intel.com>
Date: Tue, 25 Nov 2025 15:17:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-2-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251124200811.2942432-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 04:08, Mostafa Saleh wrote:
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
>   .../admin-guide/kernel-parameters.txt         |  6 ++++
>   drivers/iommu/Kconfig                         | 19 +++++++++++
>   drivers/iommu/Makefile                        |  1 +
>   drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
>   include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
>   mm/page_ext.c                                 |  4 +++
>   6 files changed, 79 insertions(+)
>   create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>   create mode 100644 include/linux/iommu-debug-pagealloc.h
> 

[..]

> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> new file mode 100644
> index 000000000000..83e64d70bf6c
> --- /dev/null
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 - Google Inc
> + * Author: Mostafa Saleh <smostafa@google.com>
> + * IOMMU API debug page alloc sanitizer
> + */
> +
> +#ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> +#define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> +
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +
> +extern struct page_ext_operations page_iommu_debug_ops;

How about moving above to below mm/page_ext.c and remove iommu-debug-
pagealloc.h header file? ...

> +
> +#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> +
> +#endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index d7396a8970e5..297e4cd8ce90 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -11,6 +11,7 @@
>   #include <linux/page_table_check.h>
>   #include <linux/rcupdate.h>
>   #include <linux/pgalloc_tag.h>
> +#include <linux/iommu-debug-pagealloc.h>

... remove this include line and put the "extern" line here,

extern struct page_ext_operations page_iommu_debug_ops;

>   
>   /*
>    * struct page extension
> @@ -89,6 +90,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
>   #ifdef CONFIG_PAGE_TABLE_CHECK
>   	&page_table_check_ops,
>   #endif
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +	&page_iommu_debug_ops,
> +#endif
>   };
>   
>   unsigned long page_ext_size;

Or, put it directly in linux/iommu.h?

diff --git a/include/linux/iommu-debug-pagealloc.h 
b/include/linux/iommu-debug-pagealloc.h
index 87f593305465..b2b82cf032e6 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -14,8 +14,6 @@ struct iommu_domain;

  DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);

-extern struct page_ext_operations page_iommu_debug_ops;
-
  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
                        size_t size);
  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 801b2bd9e8d4..40133031985a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1185,6 +1185,10 @@ void iommu_detach_device_pasid(struct 
iommu_domain *domain,
                                struct device *dev, ioasid_t pasid);
  ioasid_t iommu_alloc_global_pasid(struct device *dev);
  void iommu_free_global_pasid(ioasid_t pasid);
+
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+extern struct page_ext_operations page_iommu_debug_ops;
+#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
  #else /* CONFIG_IOMMU_API */

  struct iommu_ops {};
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 297e4cd8ce90..345af8c9fcce 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -11,7 +11,7 @@
  #include <linux/page_table_check.h>
  #include <linux/rcupdate.h>
  #include <linux/pgalloc_tag.h>
-#include <linux/iommu-debug-pagealloc.h>
+#include <linux/iommu.h>

  /*
   * struct page extension

Thanks,
baolu
