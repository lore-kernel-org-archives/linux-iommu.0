Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFD2ECD14
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064492; cv=none; b=UWNv4I5re3vSUmIqeCBB7jzZRdt+9tW7mZBabTPGAen7P/7uEc0yfXaQxacIPvL4/PAlgsKdml2n+Y3JCYLO4F2XIo+K9s/kR2xBPrlGusSG1M00RLc9QGP3ZCQZzF4zTaAQPHbQOkrXr8G1KNWSLI5/4rDtjsZUBdS84FhKHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064492; c=relaxed/simple;
	bh=XrRcP2ro/TCclrWLikByR96I9oovIxzaw/fFhhnprtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD+1MbNQTJxSbbObMYZTnoNPUryBuczZh2/lfhcckYgtst7occ8Tl+mkCh1Z6vf4tOmPJz+q8PYMlI2zw+fX1fQ1topGMbdaQlYRBSKYB5x7qk+wbcoLkJ6Ap3rPJbEpjBDVM2gr3/A02RT7ZHB7l61rtAHwYR+jEHO+yAu22p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvWzBaa8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvWzBaa8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a4fc916so42775e9.1
        for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764064489; x=1764669289; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vL2SF6DadjEfReQqy+MahpgoTUep+XQ3TbZINCjIIpU=;
        b=QvWzBaa82zx5eAC0p643eyngrD8yYXawv+FfNnLZt9hUUIkXw0gc8Zc2avXd5zJIWv
         DD45LFIh3QwBZe1CsGs9LlHb9zvY3oPSCdawgIkri/Q+ly4LJy+hmnALBUVrptbBtCxQ
         NeyaLg4uOqYoi//0yW1gE+6uaikUU9SSMueztkXSmpAqF7iVcaVgwkfc5zp0sC0vGiKN
         WggZtOeIk77ptkhpZtd9RLNO54rgd4DHqjvgkuJ9mNnJmGRS+JW1op1NB5OQzi91oLDu
         ufzl0bdPYUXS2uD92+CkjqQpWj7Gy4/3uE+NcPwG0bdlud+1lwtwZSNn21xfC1cj1bnM
         d7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764064489; x=1764669289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vL2SF6DadjEfReQqy+MahpgoTUep+XQ3TbZINCjIIpU=;
        b=uAQLLNmmIi51MGjmgYBJi3RZRJNtr8sDn/YbukoCcF5pgAxQcOnjf8+yB1htsHUW9C
         AQXa23wQb8bs0mXk2PO5DCSOjNQs3RJac/527UoWb6Kf6menzjPpYCteVDL7vLPdhMpA
         LFeAdElzyhj/kzqG7KtnB57vkoPqAdmq6B2oM4lc1aUm5PknyGDMJMBLnJwBfKRXzZVs
         PBrMAoWxxu5nrXwurNtJFnOosnMNyDBVBu7OW7WmoTn3jQYU6zgoux9fqsOML3pFOPjy
         zM7DYwdU4+Wygwc5z/1ziE5iZd5HKT+vYj0ClVFwgiBvhzn3eyIEhzs/3LehiNaO44Fd
         hxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYWsr4Fcihj2W48M8EvH9D86MrPxzYDj1j6m0JoX5C2Zw3BS8fvD4KerLX9OauusYivsrlnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmQYue0/XAUI862Im5vLOiCqjlEFu/bv1ckKRY3PwsWhy/TwRO
	wlo+KDQwrrcRRg6A0/k9DO1kwCvU/NtqnAiax7wBcuNeu8jx6+WTmNuK6lRlfofvAQ==
X-Gm-Gg: ASbGncsvdJcDkUVkMVMEZejjJkceYV/0hjz2PLWz1voG6dGzULq1AqihG3Ukc3Rr0nk
	JGWC++X6qKv9/J2VBiSKn6zygFdQtLQVTcJBnJHjHoATcTc2J8twvAwY1fWTbhz5PTSDOf9EB5i
	dKxjMk5cMmpKk/1XVN1QgTMkVcGKWU9DS+s5TIhwEWvz8mpdG030OewiEtMkQiR3PYd7EKJgT6m
	1asnB3PCELUKtQdEwYKrXTmDqgpkWoeH1uK82gzw75gI3g2dPtifywBH840ph7D1LmH1mEJ6QgU
	CZUVV3LDkYg5BLZe4rq0apjOu/d0Ux0QFyThCy9jlKpYlUgRjl6GbC9GPwcD4PuAROozpp1dyrF
	OQAR0IVk/Vv8skj3E+fDln9hYBX+CPNT/avTSLKJwqckdRJU+uTMHWfd0ZLJq5sRw5WRZhvLUNL
	AIbzsUX7CKIfkKLNa7pcArKRFU8m4z7I2MGETHvbHfgsY3Ydzh6Q==
X-Google-Smtp-Source: AGHT+IHEabe/7pXhdzmn7h02Or0O3qxqSNjpbYe1IcSPnLYCWEVv/evZDk1iZk2r+Q06y19BisRFJg==
X-Received: by 2002:a05:600d:1c:b0:477:86fd:fb48 with SMTP id 5b1f17b1804b1-479068edd0emr316815e9.9.1764064488818;
        Tue, 25 Nov 2025 01:54:48 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a6bsm33143282f8f.28.2025.11.25.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 01:54:47 -0800 (PST)
Date: Tue, 25 Nov 2025 09:54:44 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com
Subject: Re: [PATCH v3 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <aSV85G0F4bQNYwHE@google.com>
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-2-smostafa@google.com>
 <5f85e519-5a05-4359-9904-06f16737e28b@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f85e519-5a05-4359-9904-06f16737e28b@linux.intel.com>

On Tue, Nov 25, 2025 at 03:17:47PM +0800, Baolu Lu wrote:
> On 11/25/25 04:08, Mostafa Saleh wrote:
> > Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> > page_ext.
> > 
> > This config will be used by the IOMMU API to track pages mapped in
> > the IOMMU to catch drivers trying to free kernel memory that they
> > still map in their domains, causing all types of memory corruption.
> > 
> > This behaviour is disabled by default and can be enabled using
> > kernel cmdline iommu.debug_pagealloc.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |  6 ++++
> >   drivers/iommu/Kconfig                         | 19 +++++++++++
> >   drivers/iommu/Makefile                        |  1 +
> >   drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
> >   include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
> >   mm/page_ext.c                                 |  4 +++
> >   6 files changed, 79 insertions(+)
> >   create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> >   create mode 100644 include/linux/iommu-debug-pagealloc.h
> > 
> 
> [..]
> 
> > diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> > new file mode 100644
> > index 000000000000..83e64d70bf6c
> > --- /dev/null
> > +++ b/include/linux/iommu-debug-pagealloc.h
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 - Google Inc
> > + * Author: Mostafa Saleh <smostafa@google.com>
> > + * IOMMU API debug page alloc sanitizer
> > + */
> > +
> > +#ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> > +#define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> > +
> > +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> > +
> > +extern struct page_ext_operations page_iommu_debug_ops;
> 
> How about moving above to below mm/page_ext.c and remove iommu-debug-
> pagealloc.h header file? ...
> 
> > +
> > +#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> > +
> > +#endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index d7396a8970e5..297e4cd8ce90 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/page_table_check.h>
> >   #include <linux/rcupdate.h>
> >   #include <linux/pgalloc_tag.h>
> > +#include <linux/iommu-debug-pagealloc.h>
> 
> ... remove this include line and put the "extern" line here,
> 
> extern struct page_ext_operations page_iommu_debug_ops;

This file is needed for other functions added later, which is then
included by iommu.c mm.h

Also, the pattern in page_ext looks that users have their own headers:
include/linux/page_owner.h:extern struct page_ext_operations page_owner_ops;
include/linux/page_table_check.h:extern struct page_ext_operations page_table_check_ops;
include/linux/pgalloc_tag.h:extern struct page_ext_operations page_alloc_tagging_ops;

> 
> >   /*
> >    * struct page extension
> > @@ -89,6 +90,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
> >   #ifdef CONFIG_PAGE_TABLE_CHECK
> >   	&page_table_check_ops,
> >   #endif
> > +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> > +	&page_iommu_debug_ops,
> > +#endif
> >   };
> >   unsigned long page_ext_size;
> 
> Or, put it directly in linux/iommu.h?
> 

I tried that, but in the last patch we need to include that in linux/mm.h
which didn't compile and required including other files which seemed
unnecessary and that it would be better to isolate this feature.

Thanks,
Mostafa

> diff --git a/include/linux/iommu-debug-pagealloc.h
> b/include/linux/iommu-debug-pagealloc.h
> index 87f593305465..b2b82cf032e6 100644
> --- a/include/linux/iommu-debug-pagealloc.h
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -14,8 +14,6 @@ struct iommu_domain;
> 
>  DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
> 
> -extern struct page_ext_operations page_iommu_debug_ops;
> -
>  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
>                        size_t size);
>  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 801b2bd9e8d4..40133031985a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1185,6 +1185,10 @@ void iommu_detach_device_pasid(struct iommu_domain
> *domain,
>                                struct device *dev, ioasid_t pasid);
>  ioasid_t iommu_alloc_global_pasid(struct device *dev);
>  void iommu_free_global_pasid(ioasid_t pasid);
> +
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +extern struct page_ext_operations page_iommu_debug_ops;
> +#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
>  #else /* CONFIG_IOMMU_API */
> 
>  struct iommu_ops {};
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 297e4cd8ce90..345af8c9fcce 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -11,7 +11,7 @@
>  #include <linux/page_table_check.h>
>  #include <linux/rcupdate.h>
>  #include <linux/pgalloc_tag.h>
> -#include <linux/iommu-debug-pagealloc.h>
> +#include <linux/iommu.h>
> 
>  /*
>   * struct page extension
> 
> Thanks,
> baolu
