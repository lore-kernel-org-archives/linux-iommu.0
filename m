Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30736492D
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903779; cv=none; b=kQSa/Fi6e46tQORmQa+xjbZotw1LVTmqFJMBP+Hq9lP3lVDEGkJAYAzWUKIHnon2MQI5ONOCuwG4hbBi0uClaKtr7uE/gtd3oTIYIDpvyg6NrO3l9oH20WnatUy0TEKVyj5W3aUAps9Z6jH2aanmPSsbb4LeQ5m9PJcnnPMJwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903779; c=relaxed/simple;
	bh=gMc5L1zVMPzZjdbtYpciPwNi0OH0QJ460eWm+Y0412k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptrEhWmAGsc6djQqgTfWX4wLSmkCuRkysNpc9TSXZAGU8var7SnaYC72skUtcqt1+Mt5Sh70rGiKLSCnpHTrZXnBeZD9OHMxlws2BnsuVgcbRnzNmHm6uT0MAyRBHQ7AmvObjX8h/pADm6TSFIQ0veJM0NQ3MK0Qtp/79frBWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paOhk0Hb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paOhk0Hb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so8405e9.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774903776; x=1775508576; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kWki7QjLmHNc9w65OSD9JTgREHsE1qeACKoEkwZBvg=;
        b=paOhk0HbJw3yindigfXzMZt8oEDekPvVTbX/yV/B4Ay6tLZzht7YIX30OhSWycYmvK
         H15sg7goIdhj3OQsEnRLZ+Vwn0mP8w3Y+wjeEmNPTFbtSTwlxGufIQW3GJPjFLMr0krx
         A0nHc/knocZ1XFf9jm9/5/CRhAUL8sNhgWajZPLFzgpssDMsm8842B36UCZ/4uxtle9Q
         AzA/lEZCvORdG3BZzr/sGVxpwE2kOetqphiyJOmg3PZvWZQEuo0tJ3Oe9YiOf7y061ub
         ZVPlvRwH1eVB9iN2HSmQBKjRP3u3BQ9Iw5vsxGwzElL3Ny0eCLVRwdLtj4HbKR6dhcfP
         51xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903776; x=1775508576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kWki7QjLmHNc9w65OSD9JTgREHsE1qeACKoEkwZBvg=;
        b=eU1Xw/7iFdywyeG1M+YfDP+BU/5EA23ZOAmxJsqlkuE4esN38w/0e5ERB5Xo4uhnWQ
         QSeFZ7XPbzD2SiimKUTDXOtTiIxdC0s+aeQCpt9HFbxJkZFsjSiR6YgtzqmKlaZnILiq
         GchL2IDvxHYTIp05XwMCL6qZca3HCztNT8ACS/a3LYNWajh+aVllGzhK5nRoLjJcsODZ
         pTzhEGVcgHHHDTHbDDZ4kuEItbeEAgVGzcHUjO0nWTfKD45IHFjfjVnWZMoRFQJB9LaM
         3deaMaCIXf6d9baCCSonzCYKSy9tiW04kkuFE2EAMLEUF/WZjTXBQ7AbZstCebYpltTR
         Iozg==
X-Gm-Message-State: AOJu0Yxnfq1g9OauTOtGeWCJb7MdNSWnQnilInjllOGdSYi2IPYtY1pN
	qWHq3gRKymEeRpzMnLJOWPydOqwrCb7dDq4nIuyGXD1moPknXwOd7Kfzh7W8ke7dZV2nR82khZO
	DcBvKyQ==
X-Gm-Gg: ATEYQzzdwx9Iw+ivTVxDcn7uoaV1saFAizyXtCvoIp+EWcCNRmzaQafm/bwvvnqvA0s
	UzlHwBFGMvFrtgrl1XYWeGKEoWUrIhN+khl4eEcfA8tYJuejfJyFX9O/WdIs4b1fyxYl3YwylOi
	SIGEY2ebhSTzs0W1MPcc+K9OpRrp2Fco/NtufsbTAZzaHqccWEqJO46IFMmHOeLxSNsRr4JX0Hk
	+wEfROwBd/2/k137DHmG/8q/5VnkSxgcULaqRLgnNwgJZLs6jSH+LGVtp7qKK9Suej3n/ZCGwFW
	JkQim0KO4x2/RaO5Zh33Rkhwnu5uQShcn4nKawWs/FDWz/CE3sFHnX6Hi67300Ir0e4W4spoTn1
	wVD5rJ9Ix/Ik1xvD4uCcQDSjU7FZK5UndkpXE9XLj6PlPWXKvJdb8ibukQ/KNlTggM46qdr11Uv
	pQH9d5e+F9GmhSJBqJL9Tk9XK3w8qCz/gPV53PLofPHbDMrAML5T1dai7W
X-Received: by 2002:a05:600c:548a:b0:485:32b7:5b87 with SMTP id 5b1f17b1804b1-48878dc0812mr286445e9.14.1774903775534;
        Mon, 30 Mar 2026 13:49:35 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873068858bsm194669315e9.9.2026.03.30.13.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:49:34 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:49:31 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 3/5] dma-mapping: Decrypt memory on remap
Message-ID: <acrh26HVqbQ8B6Eu@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-4-smostafa@google.com>
 <20260330151900.GC809900@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330151900.GC809900@ziepe.ca>

On Mon, Mar 30, 2026 at 12:19:00PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 02:50:41PM +0000, Mostafa Saleh wrote:
> 
> > @@ -265,6 +266,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >  		set_uncached = false;
> >  	}
> >  
> > +	if (dma_set_decrypted(dev, page_address(page), size))
> > +		goto out_leak_pages;
> > +
> >  	if (remap) {
> >  		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
> >
> >                if (force_dma_unencrypted(dev))
> >                        prot = pgprot_decrypted(prot);
> 
> It seems confusing, why do we unconditionally call something called
> dma_set_decrypted() and then conditionally call pgprot_decrypted()?

dma_set_decrypted() will call force_dma_unencrypted() so that check
is consistent.

> 
> So, I think the same remark, lets not sprinkle these tests all over
> the place and risk them becoming inconsistent. It should be much more
> direct, like:

I agree we shouldn’t be sprinkling all these random calls all over the code,
that’s why I was trying to consolidate the logic in the next patch.

> 
>     page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO,
> 				    allow_highmem, &flags);
> 
>     if (!dev_can_dma_from_encrypted(dev) && !(flags & FLAG_DECRYPTED)) {
>        dma_set_decrypted(dev, page_address(page));
>        flags = FLAG_DECRYPTED;
>     }
> 
>     if (flags & FLAG_DECRYPTED)
>        prot = pgprot_decrypted(prot);
> 
> And so on.
> 
> The one place we should see a force_dma_unencrypted() is directly
> before setting the flag.

I will look more into this, but my main worry would be
phys_to_dma_direct() and it's callers as I am not sure if is possible to
preserve the alloction origin in all contexts.

Thanks,
Mostafa



> 
> Jason
