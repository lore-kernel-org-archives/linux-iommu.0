Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53D21E097
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064871; cv=none; b=DnT5mZ/xKX7yudou3oUnExcyB683YQs9L/cL1oVHlgVCjtgQ8HllP4TFaby2zzCug1TjJQCBkLVJ+bXBNvVuA/YOPS+hwM0QXyzPaCvOzpJgBQN5ul55kqwXy6avWikmIWGZsixGSPDrYqj11iVpGgnSMbMAkieC78lPfSSYoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064871; c=relaxed/simple;
	bh=FflayG1R0mV1qS179pYu9XTzfQQl3+7kMxMmbTvLZPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaoZ92wWjDVkJKKfn6Y+O+WpH1Khgj8f6VnmAtXHT8ZyRa84n1W4At5fkly1SRmpo5+xwVk15kSqrLYqNDEZzu09+aoT4OeBmbuEBxTKUTcOMYEg5ikadacbZL2e26ZifEX5UzVBNUaH0WOXI9gnU+EVRdaxfvobcNxurmLe2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1nb/fQk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1nb/fQk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so42475e9.1
        for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 02:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764064867; x=1764669667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1XHwcWfbvKNkFkLxt3DIv5QKK97k3U/xNeeijWZm2Y=;
        b=S1nb/fQknbik6MzMChehrEvV+DsqDmqKv/ri/bTRcVaTQ1+t6aph/7nCbEcJB3V42H
         Kf5XTusEb4c2b040ALcr13jDM8mIuttALg367uuQPl+8M3yxJI7QKefi8nyYx/Y3SfYM
         Z3a5mdGF0o0TA0edlR4rm8v7BWyDSGS73xEAPXVLBvtkxkFbg8tuFF9AbdHyunwfNUl8
         kHYoM/tn9WbCImFkVX4mR836nWfZjrC7n40iEKzl4FKYDetCI4gQ8AB8ZOI3RtH11D6E
         Kw177p2ic0vMnoxjDALKHIaf05GNqhUh+EQErXsoGg4X1JvmUGl9Tlg9fp37eptI1Kn7
         z4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764064867; x=1764669667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1XHwcWfbvKNkFkLxt3DIv5QKK97k3U/xNeeijWZm2Y=;
        b=N29ilcqV5ow3rJ+mIb7qlmq/oMBBPneX9Ux65B9qitUK44rAHfzt/OfNMMF7Pk6Its
         38eQLRAWHi7FJslOoFrcn8fBvqAyViN1sISgQQowo2z6vWah6xRviP4Ar6uLtlqzsB0v
         hO8waqH9GFiUt5cbRqL5U3zvKbQecyQYlMSyQxwownCzF3EfvN+R9QZyhQj65ZETEPmw
         3OoNU+Vj8p0hzlKPKRwcnoyULl+cmDpvqS0KSskyuG2dp62VchXr0n9vRkZAbfWIA+Om
         Qxx8lvC7A+YyFo7v5p5zcPc0OvsaXe+ZYcqmwXN+68DI2CYPr1oAyPPI/0oFtruO0mes
         P5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm8G3A7BXgWoF+FdOatTnmEkH0F6/zWcqo9y67+LhQGg5CJENqHQOSuA+wf9zhK3UoW5kdEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxkg1kU8abeAqN64WY4jqZEczXO/Qq541Oa8yTgJlh7ZFLdIw2h
	kati+ccu2dneKQvwbC2uaN/xsfBKtFzoEv7UDwnvcJEsmEYUJthu0DMOS59T0tk2Og==
X-Gm-Gg: ASbGncviJVire5G4y70kadLSvN6PFS2dXDF4tyZ53hPufv0xDoUyXKE05jzD4SU28Lj
	jEQHoZe5oZ2bw5PwvtkvPzB2/mWKKfcX6p9xosyJFaITamEKxuixeuvD0lbEaG8fbUtU3dfGOkc
	MrnfwhdC1eyMUXO5/Lt15kIt8bayot6KOEcrNC75jm+6+qrOuW7W1zX4/GT1bZ10UpXKn9Q+UNp
	t+qAW5DC6d/gbQxFsH81+zLMCc0MgE3WGfOEvI7mduF8I+mGJlUbT0z/A/lXQKZWfbnh2fheBXo
	QmUE6HHrIgMAaQ4l0flcQpQV4AazpmdUDmnCsBxezIRuDOEBwgUcguWhPIfGR74fnfDtyBxyW09
	mSHjS7L+QbMLeLmmWzresUhPA6RwOPgG6sboUlgB3uy0guhR0EpVzmS6mQWE8Arr/N4rnS0S3j3
	ciTdKWJz5NuPkpJbDM1skRPZhFUDF330hxyiQNy8QMukAw4g+jX0vczDl2v7n2
X-Google-Smtp-Source: AGHT+IG+KnTaq24FjuTie0tLAx5tjS9go61y7PiJSmroIbPi5FQrw77ok8WdDc8ABTUNJc0zJlZa4g==
X-Received: by 2002:a05:600c:1f90:b0:477:95a8:2565 with SMTP id 5b1f17b1804b1-47905265293mr341685e9.16.1764064867219;
        Tue, 25 Nov 2025 02:01:07 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cc231dc6esm24521687f8f.7.2025.11.25.02.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:01:06 -0800 (PST)
Date: Tue, 25 Nov 2025 10:01:02 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com
Subject: Re: [PATCH v3 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aSV-Xi5uMJcMtk1b@google.com>
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-3-smostafa@google.com>
 <07434771-3233-4c88-b505-ee02da72c905@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07434771-3233-4c88-b505-ee02da72c905@linux.intel.com>

On Tue, Nov 25, 2025 at 03:35:08PM +0800, Baolu Lu wrote:
> On 11/25/25 04:08, Mostafa Saleh wrote:
> > Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> > - iommu_debug_init: Enable the debug mode if configured by the user.
> > - iommu_debug_map: Track iommu pages mapped, using physical address.
> > - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
> >    IOVA and size.
> > - iommu_debug_unmap_end: Track the end of unmap operation, passing the
> >    actual unmapped size versus the tracked one at unmap_begin.
> > 
> > We have to do the unmap_begin/end as once pages are unmapped we lose
> > the information of the physical address.
> > This is racy, but the API is racy by construction as it uses refcounts
> > and doesn't attempt to lock/synchronize with the IOMMU API as that will
> > be costly, meaning that possibility of false negative exists.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/iommu-debug-pagealloc.c | 26 +++++++++++++
> >   drivers/iommu/iommu.c                 | 12 +++++-
> >   include/linux/iommu-debug-pagealloc.h | 56 +++++++++++++++++++++++++++
> >   3 files changed, 92 insertions(+), 2 deletions(-)
> > 
> 
> Remove "drivers/" from the commit title.
> 
> $ git log --oneline drivers/iommu/iommu.c

My bad, I will fix it.

> 
> [...]
> > diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> > index 83e64d70bf6c..454303ec09c2 100644
> > --- a/include/linux/iommu-debug-pagealloc.h
> > +++ b/include/linux/iommu-debug-pagealloc.h
> > @@ -8,10 +8,66 @@
> >   #ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> >   #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> > +struct iommu_domain;
> > +
> >   #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> > +DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
> > +
> >   extern struct page_ext_operations page_iommu_debug_ops;
> > +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
> > +		       size_t size);
> > +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> > +			       unsigned long iova, size_t size);
> > +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> > +			     unsigned long iova, size_t size, size_t unmapped);
> > +
> > +static inline void iommu_debug_map(struct iommu_domain *domain,
> > +				   phys_addr_t phys, size_t size)
> > +{
> > +	if (static_branch_unlikely(&iommu_debug_initialized))
> > +		__iommu_debug_map(domain, phys, size);
> > +}
> > +
> > +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> > +					   unsigned long iova, size_t size)
> > +{
> > +	if (static_branch_unlikely(&iommu_debug_initialized))
> > +		__iommu_debug_unmap_begin(domain, iova, size);
> > +}
> > +
> > +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> > +					 unsigned long iova, size_t size,
> > +					 size_t unmapped)
> > +{
> > +	if (static_branch_unlikely(&iommu_debug_initialized))
> > +		__iommu_debug_unmap_end(domain, iova, size, unmapped);
> > +}
> > +
> > +void iommu_debug_init(void);
> > +
> > +#else
> > +static inline void iommu_debug_map(struct iommu_domain *domain,
> > +				   phys_addr_t phys, size_t size)
> > +{
> > +}
> > +
> > +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> > +					   unsigned long iova, size_t size)
> > +{
> > +}
> > +
> > +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> > +					 unsigned long iova, size_t size,
> > +					 size_t unmapped)
> > +{
> > +}
> > +
> > +static inline void iommu_debug_init(void)
> > +{
> > +}
> 
> I suppose that all these should go to drivers/iommu/iommu-priv.h, as
> they are for use in other files inside the IOMMU subsystem.

It seemed better to have all the feature functions/declarations in one
isolated file, as it is included outside of the iommu susbsystem also.
I have no strong opinion, I can keep them in drivers/iommu/iommu-priv.h
if you think it's better. But then we will have to include also
"iommu-debug-pagealloc.h" for the static key to avoid including extra
files to linux/mm.h.

Thanks,
Mostafa

> 
> > +
> >   #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> >   #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> 
> Thanks,
> baolu
