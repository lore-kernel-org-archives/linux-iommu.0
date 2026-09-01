Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894203264D9
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252301; cv=none; b=TH20d12arNneQ1FqJ/hWIWQHkg5R15cI3RQTzFn34C1GWGdNAMFHWWqKQioLJ1e6uR1Wj/7lI8kYjGzbAO1QbVGZX/XcSSqCatTBwCO6Pv+jajg+a7YxvIBhhhkK27rlmYsDx4vLTOEHGl0/0Vryt1mG5GJO3a0RfYOgodwfuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252301; c=relaxed/simple;
	bh=NtxBgGd0WqDwOaBUwC/6y9K57MOJXS3nxDsFOYpS97o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb9eGdYn5fnWaDZo9MScLKhRt8Tsml40iw9jIZSy0p83iiyNXcJXcrnTYIBVBfflc0qahnUMR6wY1SJuWSFdCmZ1St11l2ZHPYBQaIMepWowypBfeYPkWkRFuPemZ49vSDz9Aec2+NW1QJ1GtgWfkEuJQQBjTzFg5Pi6S281uX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJecCCxI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJecCCxI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49ccf12bed0so25615e9.1
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788252294; x=1788857094; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BuTBrOfvCm76tZTU5xJSnq9MvRdv20v7nkLipK7J2Nk=;
        b=XJecCCxIg+w0gqrO4RyjnjSGJ5X0K4seEOlkU9CGNAfExy34/9Lk3NQeJ95+2PpL71
         OTsvpjRq143u8qsH4+bwhGVVOHteR0xTvbsimNxnxqNylark4yBIdkWVNnizfjDuV6vR
         Eqz16gzk+b+QwMw30wYhiWaLgncWHMo7aumaH5z0zGH57YzGkQZK5C8tSkXNVUy5Sm3Y
         EfEDrlYZzynBPRGHDoru5yUOFw+1/JCJUuDfvbM6+iNYVsbRAV1N4DFqIylHALIOifI0
         mnJ0+L4c3o7jExSuR8O47Xibp8mbdTjTU1KnPAAv2ip0hYwAbAanotI6ZwghZKqE9jkt
         g/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252294; x=1788857094;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BuTBrOfvCm76tZTU5xJSnq9MvRdv20v7nkLipK7J2Nk=;
        b=P+Sb33mcTzFTB+MYhlROzaZrY1M7GTEChG+UHnyAginJbVNiyI0S93du3C8fYhzcZv
         C90u1Fa+Da7a4bzjBxdHKEiNTxHEvINk1tT5Wo8Gwo0znEE37EjozM4ySEqyA0lv8LYQ
         mIYOb/C9DOY/X9RNiw5jbAzOamM5X7cV5DEnns1+A04qv1miNp4izwrjnI3BmeTmImBK
         TGO63kv9y2qqBgiZ7BsacnRhbnXY8A9TdhVMnkTu4y12haoNCd/vSnRnWIFYj9CnEZA9
         gZk7P99X0AwfK9YvR95K0a3l2PQFi5kX2Iyw3XaQZ2CimCKoH8mFMFDW4bnihmiN1i8P
         9AZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpG/C7picCGu9eEcfzqf5dscSaT3N1eWQObwd2zkezb39G85jn9zKZ043XD+adLUaabqukwwg==@lists.linux.dev
X-Gm-Message-State: AFuF++lAfN3KLo/m0Gkat8B8Pe4bw93Ihpr7iBGOyiQEaHawxBpA/iuT
	M/AW1637Xn07AUyb+Ya7OZR0DleevXAnRrmsNWOZMgzUlKMTwsPZvnY/TJJ3K4Sxsg==
X-Gm-Gg: AR+sD10mMpE1EjL5EzHc/SvtPLCNEF/tKcxSbcXvUbUmzf9kqEZz7Su2dCyEccl2chn
	DmxNfywM7hKci9uxaelaM9M6OCnDEFJ1zTziqIxZ2d1RJTAZn/3JEg0i0oHE5REuxxIRIGg1Q/Z
	Z7CcorJ/x5mgdRWQ+zE+Tl0c96gIZ24DvljvHTUfx0S9TRz3E0b0GeoLhQ1irXlx80fYzos603L
	217gtvKWmTOO32uR8ApgGs7Jqikf4PJJTLHNP/IQTRGhZC75n1k00FyZLY/I/Y2UCW9FR3avIFg
	ri8ZGrY8ltCR1rpr4KaBwNuJwFDdSW8E+kskWQ70NCFvYbvSeuVDcIuzGIrgF/J9FMD3tJE76hK
	/WVoG2BVi8YPWx6MYFz/gNLqXLT18rMEgyUFSpvkstYvgnm8ieQuUygX19U4m9+IwYoBrWLiMJl
	YY3NHQFOiIBnQ6lv71q6tD35hkvG5okLyD4v10hY9un10NHM/JnvEr2M4zzYPvZ2OvF/f5/Md1/
	ITI2y/jt+nNQXR0v0ZWIiIkwrUtWQ==
X-Received: by 2002:a05:600c:e557:10b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-49cde7b12ecmr305735e9.7.1788252293875;
        Tue, 01 Sep 2026 01:44:53 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d78a0bsm3463359f8f.28.2026.09.01.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:44:52 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:44:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	praan@google.com
Subject: Re: [PATCH 2/7] iommu/arm-smmu-v3: Prevent rbtree corruption from
 duplicate streams
Message-ID: <apaQgcURYAuzBpAy@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-3-smostafa@google.com>
 <apGudts94pqFL20G@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGudts94pqFL20G@nvidia.com>

On Fri, Aug 28, 2026 at 08:51:18AM -0700, Nicolin Chen wrote:
> On Fri, Aug 28, 2026 at 12:53:37PM +0000, Mostafa Saleh wrote:
> > In handling PCI devices with duplicate IDs, arm_smmu_insert_master()
> > will continue the loop skipping the duplicate sids insertion in the
> > rbtree.
> > However, in the error path of arm_smmu_insert_master() and in
> > arm_smmu_remove_master(), the code loops over all fwspec->num_ids and
> > calls rb_erase() unconditionally.
> > 
> > For the duplicate streams, the node is zero allocated including the
> > parent pointer "__rb_parent_color". That means rb_erase() will think
> > that this node is root and it will corrupt the tree which includes
> > other masters not being removed.
> > 
> > Fix this by initializing those nodes with RB_CLEAR_NODE() and check
> > if they are empty before erasing.
> > 
> > Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")
> > Reported-by: Sashiko <>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> 
> I submitted a similar patch a while ago :)
> https://lore.kernel.org/linux-iommu/9136477b9c737a50cecc38f2ee6704a01510169a.1783044582.git.nicolinc@nvidia.com/

Oh, I missed that, I haven't looked at this series. I beleive this
bug exists in the current tree so it is better to send separately.

Anyway, I ok dropping this patch if you want to re-send yours.

Thanks,
Mostafa

> 
> And I think the fix tag, as mine posted, should be:
> Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
> 
> Before that commit, a duplicated SID gets -EINVAL and errors out.
> 
> Thanks
> Nicolin
