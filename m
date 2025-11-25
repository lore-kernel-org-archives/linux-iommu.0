Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95152DC76C
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065033; cv=none; b=ihgO3IOn/yN6BTxB+kHt2USansNv8bGTP+Q4dN9sXLbiXcpoKW8fxjBfWoH0RWB+10MRflxfgRakhlDMUXOADARNp79qtw5hX5ZirW5e2us+zfjh5uwvcU20SKQs6IMUkrkHsB38ecUFm1oc7iEdsuQs7oUyFZB5/ZJ/UHex4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065033; c=relaxed/simple;
	bh=Ynwt/PGQ1dl73sOWY1UrpUl+HJY5t5F/5BD+jLiu4iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnY+sAcsMUQDs43Bb4tsIGkoWPnY0peU0P0NM/DUeeu1jF3v2NL6AGNUKn6OZlIh9tFmCttIgpJhdRSilrIbZOqcCKZfIw9hPbq5mXsydmCWP+AXnOddbaDes75FU1X1HCARLJsnWLpsGI8VwpODApOzIoKnZO/N5s7ApzZoHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpuNsQSB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpuNsQSB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so42695e9.1
        for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 02:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764065030; x=1764669830; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVd5wHAvhsygYJktl9YNIl657UM2lLl+mprE++5Um5Q=;
        b=WpuNsQSB+aEgZj4EYJ///JgsKYd2Tdcnniz8J21Rv2B8IqhTsEMsajbmxaLHMz0qqN
         NlDn8YtawRvlLfzduzUTGws7GUyHsLSOa7qBl3xp66rLTq7PqJQJSr7vvJla+WYYHjp7
         Oh4CU9n3aa07nkTgDCKW8KBFGmU9LHPMsbQfPYUvTVMjU1WMo6ij2XhAvB4F30+vnSa5
         AqgEeaQcqoGoJ+cCHNddzRy6i3Jw3eTixiQ+Mr2UOuv3PaLI+uPpzPdA0Fcwr9JVDE7i
         KGQvmX5woqHlcXJe2VJHqYhZuQMrJUZ3LqpyOncCmz8xeGhKcBQMxRjLIYR4dyLBahQR
         1IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065030; x=1764669830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVd5wHAvhsygYJktl9YNIl657UM2lLl+mprE++5Um5Q=;
        b=A30s6n5Q7Leir4xIdAW/lha5y2ltKtij1cYwKS2KLH2kDqg26L9vkwIEIj6y7Jkhwk
         +/gsuxfxLI7Qv40p0dFI3T3YQf4zXtatXBkR8wRThkJk6B1LL0qfY0IPBcQRbSUp3ksq
         CbBsM3c9Ho8maGdMxGUhIWUHq1Vvhl02kIOoxWKpikZTO0Hrp9XY2tqovOICdVxFYY6O
         1Q7x5UDf0kvQaJKyc5VPIdcJcV5gXulvl+5dmOUy/iBIFD/Ev4wbRqeMhSFbBDkMz1SJ
         yWeRTPmR6OzXxQ/pu5WJHq6lf98LksaYnQxlKNrK4fCqJFFmMv7liiPhBHSt1zwIMRlh
         1rvg==
X-Forwarded-Encrypted: i=1; AJvYcCUKsOaM5LS/xafQYvhqSfYlPvKjEHtc71Mfx17E8EN8//DORplwFcyOcu11G2ImDrSPno8NWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/4ZIBBKDbq5EPyU7C8iifaG27U7mLOVV0qgYe9k+v1B8seGlk
	rgBw90vIe5i/KQsw4y8PksG4OVoGIznhaFlu+8+thQFkY1y7Q42V7fqQwrJicvVAA398p3FN0DK
	oO0Fy2g==
X-Gm-Gg: ASbGncs+L0v/TOuaPRXH8PukV8H/p6n113FWNa1/HFaO+YddYy5pZlcocDflWo9oaud
	Ll3xac0Mb13GqDwLx5ZcZxssDPPVcc4iTJQVuIPQY+98sb0uGdHG0usxko+H1Ih0IFyFAczXFoY
	GIYHzV9FfUT4zwgmEyVNe5MNXY0ycay0SyNvKSVlTcJQQsN00xEgmoRzjx8npg2ua+o2JQtrsXL
	auCZ1A3vpq5w2JzVcJDYmRNz5+Puy/Es4kauSv6gJifZMdoNaLXkpYx6E9IPWDvXb3yKaj/kUA+
	R2T20xquh6GFn7u1u+ajvinsAsjyvk0j6MNHCLsRifrnDe0h/pVFRZHOe5vMRLTPv+ArShDMBC4
	RBdbs0rre/jnAzB/qWj1RKBebUP7p4Hrbz7m/pLZiAY5QD543+gZ+YwkrI0S4cS6Yr0uCnxF0o9
	PH9AcnOly1RgIX82xTqejB7GHj+mKd/CH2CvNDxOM/83854wZB4A==
X-Google-Smtp-Source: AGHT+IHGtSW4ZFPm5Ld3MnDEYsj1B4+fTprfbo1S10kQvVjHYAXxPLPTfSswDS2c4HSt3WgH56Nz+A==
X-Received: by 2002:a05:600c:8901:b0:477:772e:9b76 with SMTP id 5b1f17b1804b1-479068ef80fmr299385e9.7.1764065030179;
        Tue, 25 Nov 2025 02:03:50 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e574sm33316474f8f.3.2025.11.25.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:03:49 -0800 (PST)
Date: Tue, 25 Nov 2025 10:03:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com
Subject: Re: [PATCH v3 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
Message-ID: <aSV_Ap1RynBULiZM@google.com>
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-4-smostafa@google.com>
 <ae535698-33fc-42a1-8a5a-ed8dd192f697@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae535698-33fc-42a1-8a5a-ed8dd192f697@linux.intel.com>

On Tue, Nov 25, 2025 at 03:54:56PM +0800, Baolu Lu wrote:
> On 11/25/25 04:08, Mostafa Saleh wrote:
> >   void __iommu_debug_unmap_end(struct iommu_domain *domain,
> >   			     unsigned long iova, size_t size,
> >   			     size_t unmapped)
> >   {
> > +	if (unmapped == size)
> > +		return;
> > +
> > +	/*
> > +	 * If unmap failed, re-increment the refcount, but if it unmapped
> > +	 * larger size, decrement the extra part.
> > +	 */
> > +	if (unmapped < size)
> > +		__iommu_debug_update_iova(domain, iova + unmapped,
> > +					  size - unmapped, true);
> > +	else
> > +		__iommu_debug_update_iova(domain, iova + size,
> > +					  unmapped - size, false);
> 
> In any case, could the 'else' branch become a real operation?
> 
> In the __iommu_unmap():
> 
>         /*
>          * Keep iterating until we either unmap 'size' bytes (or more)
>          * or we hit an area that isn't mapped.
>          */
>         while (unmapped < size) {
>                 size_t pgsize, count;
> 
>                 pgsize = iommu_pgsize(domain, iova, iova, size - unmapped,
> &count);
>                 unmapped_page = ops->unmap_pages(domain, iova, pgsize,
> count, iotlb_gather);
>                 if (!unmapped_page)
>                         break;
> 
>                 pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
>                          iova, unmapped_page);
> 
>                 iova += unmapped_page;
>                 unmapped += unmapped_page;
>         }
> 
> The comments say that it is possible to unmap more bytes than 'size',
> but isn't it a bug if this helper unmaps more than the caller desired?

I was wondering also why the core API allows that, I couldn't find
useful information from "git blame". But I vaguely remember that some
IOMMUs can't split blocks so they unmap the whole block when a smaller
size is requested.

Thanks,
Mostafa

> 
> Thanks,
> baolu
