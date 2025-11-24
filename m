Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DC2FD69D
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982615; cv=none; b=pOMqKkIYOFdEd/tYXofz9ynL0cihtWHdv8ECw761iwM4S7u2aSfwleYOxtWP7z0SByqRly/c9elCKvdj1t+RrBg8NYKgmISFah0WHeeZCxlO2H8+ISmKQx1ICaBH88CkNmyUGyBZKQlAc+BN8M0dS+X6HabMPUWLjYSOrcQhYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982615; c=relaxed/simple;
	bh=2YSPr10FWTObKo0gxuxrZAvv+qKp1p0Qc5IDcyun6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upEBzVkAEm0cUjz90mImWMWgOeJoCcVgsoMThvElQgvdMiQ26Fai4hPG0BuSRDTTR0XYsIsXDgwWif8o78Cg6ucCv17ISm9blR/vuNEM3hG+mdMA/oKUERjeJPNhgh24Cs3sYO3/OFkRGEpBqyzyGJ3tuHmviz7+gjMp7jZPbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZofvSPB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZofvSPB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso91095e9.0
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763982611; x=1764587411; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P8AjfdImdi3z82U5X17wqTjR004YKNEvjVP2eHyRFGI=;
        b=AZofvSPBmfup6jgfutD307AAZmqg3aAiPjBn5YNjoWKLD2q1SDaeXvx07MDQ5fl4Pn
         AQRv1/HKytgx+rfDgV8qyD4/aaCdXTAWfJthXjJ8jh/K88YtxkLfsunz3YgDzpWBObuJ
         NXyHvzdrO4AYFCQHqSltBR9Xw2xEkvS164bZpV0AP1UVhN+MYUZ0IXev/TP3UDbuzX/l
         ezk6Vxr3LeIWcQ+7MvF/l21c4DHHHUH3rM1IagQFRR8L0oYJ7C+5J9F1Y/asGkb2RTWs
         /nZr8CwiX6Vndq2sWIPmvnM4LIDX7lLNbh7w7PhxegTMd1o+swk7RxfZDRHujbfaJh7b
         XPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763982611; x=1764587411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8AjfdImdi3z82U5X17wqTjR004YKNEvjVP2eHyRFGI=;
        b=qiw0RWZ4JRd4gSw1PdEGJBccxnFq/UmTRFsATPvnrlmwyei9VjfKI9LJtR70QP66Sc
         5pjF7gW5Vz7RE5aHbcEhks6MaTTLHcGn6SRUFpSOdl7m9Z48DHTImR7dXkp9Jgiz2xkY
         qta2YhgC03ybVVJ9wFmOMjaCkSaJm2af5y+l5N3Vk/qc5fcaaoRkCVICKQ2x3NdjKQIB
         FcHpRWwX0lRHiebkgicOn7JRZpa9CqvuYe69kjaDndBSX1RrRw4G9e2VyOXlPqbTvg6G
         XzItWUU9FJ7qvWpNZdOe2aY0pE2SFmtDjdo+prwg/Wz5V5KHSVS5FItLSmI5f6i0fJga
         3wmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrIjg1RcNPZY3cVurq0NLKeZ5gycNueHW4J85S/tT2oUu2a6XL/CLKwcLyOQYGawS5dHM8vg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCr407QdVI7zaBA0P8c0CSLXvnEcBus74VAX1STXh+8185+AoO
	zbw69WPp8+XgM1Ul/2cniTlFyRdkIZDOlQtMwuFUgOOjEQ1a0p873KvSqidh8jn+Ig==
X-Gm-Gg: ASbGncvAn/ZgbeejZDjn+koqCzEbZMLSKTq/+hTxfNSZMpEOlFZhPqH2+qKsR1sJ5/m
	8LkrX07OrvhQc9CZIVmMBlwHWQt0vsQVpy434zYNPulISQlKo9VOUBAaisqBOUBnvjli9JzifdU
	7EHAwLdoPajhHokETLTi/9XyxMbHp8e1JoJEO/XqjbjXeTj3n8ShbIf3f1x2jMtbjpFjhkh7B3N
	0Az197BvbDuQLTrO5WblITXOvXDVRLmZxmc29RpKF9FNduQqaZSxJ7JHLQp6PoL+8PyDI+O/CaP
	zOkk9pDqwJwlVjPZCe0TYL+uhZy35/ZtbR19KaSWZ27Ko24/QpqgOvKFoU2Hz2VG2GP8HOG8xGm
	+W6zkZ/e2cZWDuI/sGgVJ85Ta6iCrIw8Q4l0Q2RET6gxpJbZBeLKdVMHAUbdWWzlWO+EaD5DGjv
	e3PfLKHs75LvikOX5Ka7ceNF/BfjCGgs6SdOuytl+8HBBULuuAJw==
X-Google-Smtp-Source: AGHT+IGGRir/b7AxctEA/ruMRlHV3TbVGbHQsIMl63FPt6s5B9UD2TFfctY7Vuq6Em4LmFT2VkcNLg==
X-Received: by 2002:a05:600c:654c:b0:477:95a8:2562 with SMTP id 5b1f17b1804b1-477c5ea96c0mr823985e9.13.1763982610531;
        Mon, 24 Nov 2025 03:10:10 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e574sm27670466f8f.3.2025.11.24.03.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:10:09 -0800 (PST)
Date: Mon, 24 Nov 2025 11:10:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <aSQ9DsR0nAAvc4Pd@google.com>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-2-smostafa@google.com>
 <aRWtX3n2I7El4Ykv@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRWtX3n2I7El4Ykv@willie-the-truck>

On Thu, Nov 13, 2025 at 10:05:19AM +0000, Will Deacon wrote:
> Hi Mostafa,
> 
> On Thu, Nov 06, 2025 at 04:39:50PM +0000, Mostafa Saleh wrote:
> > Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> > page_ext.
> > This config will be used by the IOMMU API to track pages mapped in
> > the IOMMU to catch drivers trying to free kernel memory that they
> > still map in their domains, causing all types of memory corruption.
> > This behaviour is disabled by default and can be enabled using
> > kernel cmdline iommu.debug_pagealloc.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  6 ++++
> >  drivers/iommu/Kconfig                         | 15 +++++++++
> >  drivers/iommu/Makefile                        |  1 +
> >  drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
> >  include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
> >  mm/page_ext.c                                 |  4 +++
> >  6 files changed, 75 insertions(+)
> >  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> >  create mode 100644 include/linux/iommu-debug-pagealloc.h
> 
> This looks like a pretty handy feature to me, but I have some nits below.

Thanks for taking the time to review the patches!

> 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 6c42061ca20e..9a1c4ac8ba96 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2557,6 +2557,12 @@
> >  			1 - Bypass the IOMMU for DMA.
> >  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> >  
> > +	iommu.debug_pagealloc=
> > +			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
> > +			parameter enables the feature at boot time. By default, it
> > +			is disabled and the system will work mostly the same as a
> > +			kernel built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
> 
> Can you be more specific about "mostly the same"?

The only difference is that the static key to gate the calls, I was not sure if
saying “exactly the same” is correct, but I think it’s better avoid “mostly” as
it might be confusing and as the data in the cover letter shows no overhead,
I will re-write the whole help anyway.

> 
> > +
> >  	io7=		[HW] IO7 for Marvel-based Alpha systems
> >  			See comment before marvel_specify_io7 in
> >  			arch/alpha/kernel/core_marvel.c.
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 70d29b14d851..6b5e9a2d936a 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -383,4 +383,19 @@ config SPRD_IOMMU
> >  
> >  	  Say Y here if you want to use the multimedia devices listed above.
> >  
> > +config IOMMU_DEBUG_PAGEALLOC
> > +	bool "Debug page memory allocations against IOMMU"
> 
> Perhaps "IOMMU mappings" would make this a little clearer?

Will do.

> 
> > +	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> > +	help
> > +	  This config checks that a page is freed(unmapped) or mapped by the
> > +	  kernel is not mapped in any IOMMU domain.
> 
> I can't really parse this sentence :/

I will re-write it.

> 
> > It can help with debugging
> > +	  use-after-free or out-of-bound maps from drivers doing DMA through
> > +	  the IOMMU API.
> > +	  This santaizer can have false-negative cases where some problems
> > +	  won't be detected.
> 
> Maybe just say "The sanitizer is best-effort and can fail to detect problems
> in the case that ...".

Makes sense, will do.

> 
> > +	  Expect overhead when enabling this and enabling the kernel command
> > +	  line iommu.debug_pagealloc.
> 
> I'd reword this to say something like "Due to the overhead of the sanitiser,
> iommu.debug_pagealloc must also be passed on the kernel command-line to
> enable this feature".

Will do.

> 
> > +
> > +	  If unsure, say N here.
> > +
> >  endif # IOMMU_SUPPORT
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 355294fa9033..8f5130b6a671 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
> >  obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
> >  obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
> >  obj-$(CONFIG_APPLE_DART) += apple-dart.o
> > +obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) += iommu-debug-pagealloc.o
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> > new file mode 100644
> > index 000000000000..385c8bfae02b
> > --- /dev/null
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 - Google Inc
> > + * Author: Mostafa Saleh <smostafa@google.com>
> > + * IOMMU API debug page alloc sanitizer
> > + */
> > +#include <linux/atomic.h>
> > +#include <linux/iommu-debug-pagealloc.h>
> > +#include <linux/kernel.h>
> > +#include <linux/page_ext.h>
> > +
> > +static bool needed;
> > +
> > +struct iommu_debug_metadate {
> > +	atomic_t ref;
> > +};
> 
> s/metadate/metadata/

Ah, that's embarrassing, I will fix it.

Thanks,
Mostafa

> 
> Will
