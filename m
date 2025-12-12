Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C02D63E5
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765565279; cv=none; b=I4oqxZn4i7b8IUrLj8FfXqYhqCRGg7QRYs4UpqW66rvLNSLIwlSPuNaNp1076+H64Eyvhh4lWD6qhQhRAcVsh+1NnhIwB11TwE37+8IMyQ9KsP3tPe0xJ6boXlmNDIn6Wqg9+P52xhqtfyTfaaISzHgpxwTH9t16AtLu/s/rY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765565279; c=relaxed/simple;
	bh=aYlLP5oK9ujcask7x6uq3Z6XkCkRSggu11eLJH2sWLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpkOneJ4P5nutcQQfkpaveaIDSYYwk3KTq8Tep/WLNwLJKwTjgUeJq40Mx7yQoO9zEQvUoU4RRh+4IKxK6EK8NB4hgXg8GxWYJcuTi6Xa173RKESOo518/7/VbeRUCdm3LkoHs0YfqG6m4K/Xzlqcq2hTtqYKlbwn+Bi2abrzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2Nmcr64; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2Nmcr64"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so182085e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765565274; x=1766170074; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kyaZ/i78MwYb3FB370zdecXw44g8nQdErJMSZHrGqA8=;
        b=J2Nmcr647GurauSRJi4/Lzqh8NKx5SUlI2tW3rRFnpT31Vw0ZXejiH3rpEQb2vuXB6
         srrxaCtSuCzQH8EXJou0Y33ke0mrTB5Tp+sa7jICHxCWV0fzDaG2DQuQaCitqDvU2HwH
         DXEUPLWNV/xeq8afRGLr1linnb5dzemp/LE4QaPmeLN7VNYFMERakjKzloMtVZf+zPez
         8kljZqsiAijNWHcRFzqlAwVpUTII8Udv/z6nmpKEaYrzhyi4i5nvXfu5Wyh9wjTcVVhl
         AZ/p3PfJ0/cafIq8bvK36CByeKWwjQHaY5+/FWT2H8Wkdb3Xw9FJOnhagetXSWSfS2+a
         0Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765565274; x=1766170074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyaZ/i78MwYb3FB370zdecXw44g8nQdErJMSZHrGqA8=;
        b=Ap4UqFaPbnquZE9PqT34ReZU2wiTLifavmX1tPj9wWVa+u7YVOYWNuhN3OInp91Vn6
         0NndtTWHWOQZK3vsbO+elLsELhQ0y899pM3xn4PGYDmo8bxw2zaMwCmFle/qXhGnltYF
         GN2lMrpGQrY9c1Z9EGkDTica3Eu/3zqmkDC42n1yMszalE+vy8It037NKfTrnSiUuUHc
         gN7CBzPiF7i8+mJkCOcixOp8TmXp2ZcZWlBjzQ0KoawLK6ox1R6NZAywEg1FHX2nLfB1
         Nz5jP/WAq2zbHEzDlSA08ryXA+RCwJB3UoBgDqZW49fTSVntWs9TMut0LXYzKLpdXZxs
         DhNg==
X-Forwarded-Encrypted: i=1; AJvYcCWz704Li5v2eBkdEYo/HknIdLpmxf7nONMkEOmRG68FwmKG1SMRA8xtVmcP0VIsJmAou7OXGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxFNNDT0Gxq0HwX37expgJuwHGhsWfNRc8WMYFZcQHC113oGxj
	0kThX4SDwyxGSqNnTIIdO6a79JXfCT4B0/CS8xIqGLtPo4PsllGudq1TssuauZ8fUA==
X-Gm-Gg: AY/fxX4QM6QPbgWWS+NqaH+Xtqm1Dy7/TyUy2sjQfZ9FubqOJhp0S/Hhq+wnfpvbfY2
	aswkyxctOmojst+rCeyWkKpK6jLHRyUe2DuZc71Yni18jeK4qSfjFvbPxzZ8O+rrKan60T4PX+D
	L+3o7vQT1lu7MjT/dvxPpF/sCWyqrzSRiszlZFa9nRzqO3VaoEHo/ZYJNIZKva626CqRJVwelRe
	AHfWzEjfjnNGrmBFCOn7xpAlolPtiNumo/qh4cnemxUoMgYBmu3bOrsjaJlXk1PjZLjf9I6zewh
	22v0ozwrI1ddRryb6zfF84ZkmMBuKOROSr+MJdHO70S+hVhQhH6yimX305hp+julCwLEaV75FfE
	gDwk6tLx2rGgOAz68uS9WuQ84K4H4MZJf0MedtstMngtd0VjMI2psUADBpISNXaFNHetqFiYz3y
	XROGgAtctttg6GvvW7PKA1Is/YZyDoVYpytNmjM93oR5B92LZ4eA==
X-Google-Smtp-Source: AGHT+IEVZG3wHfe72Ly1OF3yuy/6xrNrPiEA8hzzhu0i82Q2n2GZB/t5f/ePhNdeE0eyqp1ZEcC0Bg==
X-Received: by 2002:a05:600d:106:b0:477:73f4:26b with SMTP id 5b1f17b1804b1-47a948c78e9mr17525e9.3.1765565274191;
        Fri, 12 Dec 2025 10:47:54 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm43341825e9.3.2025.12.12.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:47:53 -0800 (PST)
Date: Fri, 12 Dec 2025 18:47:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v4 4/4] iommu: debug-pagealloc: Check mapped/unmapped
 kernel memory
Message-ID: <aTxjVhQxJAX9TdLm@google.com>
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-5-smostafa@google.com>
 <aa14d149-dfde-44e9-8fb3-72cb9b0e6920@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa14d149-dfde-44e9-8fb3-72cb9b0e6920@linux.intel.com>

On Fri, Dec 12, 2025 at 10:51:24AM +0800, Baolu Lu wrote:
> On 12/11/25 20:59, Mostafa Saleh wrote:
> > Now, as the page_ext holds count of IOMMU mappings, we can use it to
> > assert that any page allocated/freed is indeed not in the IOMMU.
> > 
> > The sanitizer doesn’t protect against mapping/unmapping during this
> > period. However, that’s less harmful as the page is not used by the
> > kernel.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/iommu-debug-pagealloc.c | 23 +++++++++++++++++++++++
> >   include/linux/iommu-debug-pagealloc.h | 14 ++++++++++++++
> >   include/linux/mm.h                    |  5 +++++
> >   3 files changed, 42 insertions(+)
> 
> [...]
> 
> > diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> > index a439d6815ca1..46c3c1f70150 100644
> > --- a/include/linux/iommu-debug-pagealloc.h
> > +++ b/include/linux/iommu-debug-pagealloc.h
> > @@ -13,6 +13,20 @@ DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
> >   extern struct page_ext_operations page_iommu_debug_ops;
> > +void __iommu_debug_check_unmapped(const struct page *page, int numpages);
> > +
> > +static inline void iommu_debug_check_unmapped(const struct page *page, int numpages)
> > +{
> > +	if (static_branch_unlikely(&iommu_debug_initialized))
> > +		__iommu_debug_check_unmapped(page, numpages);
> > +}
> 
> Same here, possible to make iommu_debug_initialized static?

This also is similar to the iommu ones to reduce overhead, the main
feature have the same pattern with "_debug_pagealloc_enabled" static
key.

Thanks,
Mostafa

> 
> > +#else
> > +static inline void iommu_debug_check_unmapped(const struct page *page,
> > +					      int numpages)
> > +{
> > +}
> > +
> >   #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> >   #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7a1819c20643..3763b71a7d3e 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -36,6 +36,7 @@
> >   #include <linux/rcuwait.h>
> >   #include <linux/bitmap.h>
> >   #include <linux/bitops.h>
> > +#include <linux/iommu-debug-pagealloc.h>
> >   struct mempolicy;
> >   struct anon_vma;
> > @@ -4133,12 +4134,16 @@ extern void __kernel_map_pages(struct page *page, int numpages, int enable);
> >   #ifdef CONFIG_DEBUG_PAGEALLOC
> >   static inline void debug_pagealloc_map_pages(struct page *page, int numpages)
> >   {
> > +	iommu_debug_check_unmapped(page, numpages);
> > +
> >   	if (debug_pagealloc_enabled_static())
> >   		__kernel_map_pages(page, numpages, 1);
> >   }
> >   static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages)
> >   {
> > +	iommu_debug_check_unmapped(page, numpages);
> > +
> >   	if (debug_pagealloc_enabled_static())
> >   		__kernel_map_pages(page, numpages, 0);
> >   }
> 
> Other changes look good to me,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
