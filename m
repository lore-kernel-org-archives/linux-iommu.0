Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB12DF709
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987938; cv=none; b=ofenbwOjMsudvLcEel0RBmUhH2opgxsLGZpNT0xX5YiPHmqQ37n2fJkh6fKa45FwvTd8rZmJz7TVOIfN3UM2i+a/OVVcz05culoqxayyM6fs+CUS2DQibhbs9JG6qMvf5wqUtQWX+Y+3aL9VzqkgtMef53/0qOgNXFR7SICm0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987938; c=relaxed/simple;
	bh=fmhzmUbf5MkrRNaJZmVA3g0/x3ROh18aYfmbA6C/VdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl95imtAxUw6Gtq4G96kziQCixNpAE8anu88IPGj+0jXFx2mH+EKdMmjKBoVM2VuN4XItOh228/drcG/BAlfw0nIoBgDXyO1dXbGekesa88XvBJTBQEQvxfPUaaUtahVzxPazpAt3e3/BCdQ8dSUVLYim1Hi9Kt38Zr0VAandmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pq27DUkE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pq27DUkE"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so98605e9.0
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 04:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763987935; x=1764592735; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+hKcjz4CEQtKu1cZ8SM9PbIexDlVU/R+LQLODvCo9Dg=;
        b=pq27DUkEqChu59wLE6OiAgrv/E2ZAbqFy9Gg10pl/BPPoA9IVEluuSnr1W3M8mxgnR
         gUokR6hFoGIhyhWE17YLspo6tCd0r5NNe9UG2WqNIYEunCaZg7a7HUOCFoLH0jFg/87f
         GzQqtsUSRYIEupudgQl7ukwcJsOw4gt4BfAEdoeNdXA6GaFWru3tmutWmckuWgYairps
         aJeOAeUueWztumhmhCnx6yHsJ6DowViIzAjn/12NkEAv3yaIrzdGtKwXiCQ01S1laWSm
         KMCVvjYbEoHq/FKhsTZ8Z9KAGY4oO/74aVxw0YDwXviTWqUKtjbunxPhsor9qc6X8KR5
         9fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763987935; x=1764592735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hKcjz4CEQtKu1cZ8SM9PbIexDlVU/R+LQLODvCo9Dg=;
        b=C6QzeQgmbDiETFlrdR9HEEomU48Wc0qjYL9Z13/Fz5L35FKmYtzW2/02yT07XkjvKg
         8lTSOEmX+bLWQCzgYmInEymp0gJTrYvq36lb2hQTRfMnih6UgHC7lDdHBv6z1nqb7lO0
         WBkxBC7XA0/ZflTPKh8BBXb4af0Vxwa7SyNO8cbaji9GY1BP9rd650wKnPGKroIq2hsy
         9aBIpvaSsAapdxJCqloQOpjWN8Z9G/Pf3qQ7tJMzSE5eVi5juJl51knTY2kDxacErBIz
         mtDI9ncReOJ8AHz4ebq3qx6ER06Lpkl/V/Y28Q1DmlovkfIp4K4Q4XS79lDdIkZGB9C1
         zOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4ikltrmruQWlJ9lsTDoBe1aXFNSYVjsOUPEhpYinyUhvBKIivEmNUjJpoKYBgbojkl537TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx341ymU14ecqXY3T4QZAue/Tcu1UhXBD2P59+FeJS57Out7BdB
	RQslegRC2xAA6X4jukfKsTEcaJ8p1MJj3UQFgD6XXlrdMEr7A87AyLZMQbUKPL8xoBi7pEAd8eR
	7nNfQMg==
X-Gm-Gg: ASbGncsu/GJ2CoF49dB7aOg72sU06l2ORgGqYd5C17tV6AXmPbMXxu75Hhw1t1ob4Tk
	AUBTM+6XvgsSEcDKHUhzJE/OuSBjoH7Fnipdaw8LnNOhDo6v4bfSIWIgeYTNDS9Mms6f/NNPYMp
	kI98J9j6arcswB1NVRamD1/WwJ+Xupy2HD9HlOwWSExW1UvGEGq2BP3cCZpzPYCEXPfr3fC00dv
	76aeEHCDTR/+JbEt/IdE2hlF5nwdbtxkTCm5BEnERCSRqd9mv9FVvbNN0vIGRigIZrn+T5ERiMi
	IaHcYbupBsYMuaZXmF+nhI6dweg4NfWC0QsDZ70l2fuIybsta0IOT91sAdqU5CKTtETEDz1b32F
	kEYHZtRhrNiPWd4njWzCH4pboQ3G5XjvAT1VP/JM0QVut2SSvIUB90JJqxRci0Ys0e98vTi6ZY4
	2kYMR2KGU/UYR4dDeyO/S1pXyDsz3L1qn419XbsRBKIqW5Q7IJHA==
X-Google-Smtp-Source: AGHT+IEZgUg1bUbdAI5VMl92UmNgBFeGgbcBg9hYsUoLQBWM96FEzs3PepDjVAB17q+bUwBOhS6TRA==
X-Received: by 2002:a05:600c:8a8:b0:477:86fd:fb48 with SMTP id 5b1f17b1804b1-477c5e9b0e9mr810065e9.9.1763987935133;
        Mon, 24 Nov 2025 04:38:55 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fddsm29238614f8f.14.2025.11.24.04.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:38:54 -0800 (PST)
Date: Mon, 24 Nov 2025 12:38:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 4/4] drivers/iommu-debug-pagealloc: Check
 mapped/unmapped kernel memory
Message-ID: <aSRR2h68l9LRn3iZ@google.com>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-5-smostafa@google.com>
 <aRW6LWh_1lTce7kU@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRW6LWh_1lTce7kU@willie-the-truck>

On Thu, Nov 13, 2025 at 10:59:57AM +0000, Will Deacon wrote:
> On Thu, Nov 06, 2025 at 04:39:53PM +0000, Mostafa Saleh wrote:
> > Now, as the page_ext holds count of IOMMU mappings, we can use it to
> > assert that any page allocated/freed is indeed not in the IOMMU.
> > 
> > The sanitizer doesn’t protect against mapping/unmapping during this
> > period. However, that’s less harmful as the page is not used by the
> > kernel.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> > ---
> >  drivers/iommu/iommu-debug-pagealloc.c | 19 +++++++++++++++++++
> >  include/linux/iommu-debug-pagealloc.h | 12 ++++++++++++
> >  include/linux/mm.h                    |  5 +++++
> >  3 files changed, 36 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> > index 0e14104b971c..5b26c84d3a0e 100644
> > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -71,6 +71,25 @@ static size_t iommu_debug_page_size(struct iommu_domain *domain)
> >  	return 1UL << __ffs(domain->pgsize_bitmap);
> >  }
> >  
> > +static unsigned int iommu_debug_page_count(unsigned long phys)
> 
> 'phys_addr_t phys' ?
> 
> But having said that, wouldn't you be better off taking the
> 'struct page *' here rather than converting it to a physical address
> only for get_iommu_page_ext() to convert it straight back again?

Will do, we will need the physical address anyway for the error message.

> 
> > +{
> > +	unsigned int ref;
> > +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> > +	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
> > +
> > +	ref = atomic_read(&d->ref);
> > +	page_ext_put(page_ext);
> > +	return ref;
> > +}
> > +
> > +void __iommu_debug_check_unmapped(const struct page *page, int numpages)
> > +{
> > +	while (numpages--) {
> > +		WARN_ON(iommu_debug_page_count(page_to_phys(page)));
> 
> Since you only care about the count being non-zero, perhaps tweak
> iommu_debug_page_count() to be something like:
> 
> 	bool iommu_debug_page_referenced(struct page *);
> 

Will do.

Thanks,
Mostafa


> Will
