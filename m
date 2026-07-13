Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3CC26F29C
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963720; cv=none; b=kAXXZlNURUL9k8CO7cpP/l8wKPuWAd3Z5bf7CFSXI5LXdMZpaYCoeIYD5PvnI/DhffffJ1d+eMbvkBwim6Mq8MdF8SbcFgz0Hx5SKQVWgdbfGB8l6JQKOvOGL+jNHgKoTBBk6fyVwfT/bU1Dzx4L3VeVxAYcL2Fs4weX2vvV+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963720; c=relaxed/simple;
	bh=gT9s9oRpIiwyq5GIG9RUX0KOjdNXvmY7rnr7/TrhcE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/Vv/kwumsp9vfuT5Vw0hCZdjqKoOpVhN1F1tIrVL+DudWLqUc1Dbl3XuHxZc+ySeHbLPE6zr1s/piiZ/lMhdzZa3FExOu0sGD1SfAHQFh220QqRKIBu1aJ9njmoX52iWk0wEfZ9nBa+BtexDKeOOHukxCUYtCXXKS8SaajFT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FTmod8Ex; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FTmod8Ex"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c15bf5000so19916761cf.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783963718; x=1784568518; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JDQW3Iu7NBoAVzUsdpY0L5+hRHDfdkqTfxv3iduKA6M=;
        b=FTmod8Exaj++hZBcGl2Di8dDWWFCE/vhGWvhnrC7iKZrL7bBJvTO+gTKSuUVHGiFYu
         O0Tsr3fB7s0eV/YgM/g2l2UF8v4dUQDx5Wvl5RMkQsH+Uvt5kNCzIyFtdAkZgI5lnWHM
         ZpnaDjWMCxhEmGlY0JeFNehEt0/MQ97dBpackxNqwaOT+Y7zM8vq/D7OM8/GjvKCyokz
         +jeqdYMvhPX9OZ7E2eR8kfPzw2ID8RcNG1Rkcdl4EOcWLuKPGL6nhrs31Hy1xFAkC6yU
         JYa+wK9kRcKt8CR49Utf2rBvMFnmb1yRp3pGjQz+r0wrjlaDzaW644L12wXqpQC4tPzn
         stnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963718; x=1784568518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDQW3Iu7NBoAVzUsdpY0L5+hRHDfdkqTfxv3iduKA6M=;
        b=HqJlmxjNVtGebGRioQfLfhRs2aJryRok+MNUmLCgUjE/n55KEvJ/A34KJt6D6mwZ0R
         Cbuk0PZx4ZP9a4YfqrdI6LHZ6ByMrEUeulsnFCoS7V1OWNYDUJNF1oVbwv/CQrcN/NVM
         oiLMapTkwtJmldArQ1faE7/643a9MK0LZd0QK2LmMj5nu/06SpCl3MVP8wmCMY1M6soZ
         1Pojdr0gf44OWGyRBvtYwn+bWqQOii3oiKwH0rVmkPLjwiMcInYQP06/dPsqVB6rJwQQ
         tjz+qfsQBhfvmOQJei94vqTjydCwOJlfL8sRAwPfEi3qy5t8CbmhsCUZPOiOUYci9g93
         8fxg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0jUR1OVZa3WFo1R44bQsojiSr63FDKeMoY4HaQzq8rrQnUsfH7iIc6TYzJ1Ba/rgmMjxcUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7T3jaad/heXHckjDMH8O6HBuAolzTRIKtZq01iURIxebUFSNa
	hRLDeXthYkcuEgxgbKLwGQNqpKZAzBE+asHau5Eai7n17M3oZR85oTmyUjqlct/BZ+U=
X-Gm-Gg: AfdE7cmwWZu6u8B3fq/SPCo+8uCc+kVcOdDA0ECrEfDz6PH0aQt5rv1tfns+ePcluc3
	CWpZmwonqp058nzeyKEX5zFW+ERwZJ5BuHx+iaP56FCHUa3RlFLA/FwJlgFVKmdKelO1cYdIOFa
	xhIfu5/LXwww/aoV2GJlfd8AvQSBHer6H9fAAl9P+urFGu+Mi5yOgV513V+iN8AX45qomMvlme0
	jisAv22JKPo4iKn1cjuZqHpJ/XcjovW+hqBQjPIJhwltebAQ/idH+lF5dCg+ECIipF/0Q6gVqRH
	/CmPkvNHhR0VfpAFNchvA4ROnnn7CHIB51Zh5FsG0bDQJwH1Q/U1Rcq/3nOGZyohYmtpWvEbvMC
	XVU2hCwo760yfmyP1/lHGJJ7bz3Yuh08cPCejAsLG7sq5kTErAKnkBZE6C/7O
X-Received: by 2002:ac8:5ac1:0:b0:51c:478:32a1 with SMTP id d75a77b69052e-51cbf06d972mr109410031cf.18.1783963717964;
        Mon, 13 Jul 2026 10:28:37 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b4fsm89742801cf.31.2026.07.13.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:28:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKSK-0000000Dmea-3sFm;
	Mon, 13 Jul 2026 14:28:36 -0300
Date: Mon, 13 Jul 2026 14:28:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: Reject DMABUF pages from the access pin path
Message-ID: <20260713172836.GG3133966@ziepe.ca>
References: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
 <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>

On Thu, Jul 09, 2026 at 01:08:00PM +0800, Peiyang He wrote:
> DMABUF pages are not supported for iommufd access pinning.
> iommufd_access_pin_pages() returns struct page pointers for
> in-kernel CPU access, but DMABUF-backed iopt_pages do not carry
> a userspace address that can be passed to the GUP path.
> 
> iopt_pages_rw_access() already rejects IOPT_ADDRESS_DMABUF before doing
> CPU access. Apply the same rejection to iopt_area_add_access() before it
> takes pages->mutex and calls iopt_pages_fill_xarray().
> Otherwise a DMABUF-backed iopt_pages can reach the hole-fill path, where
> pfn_reader_user_pin() interprets the union as uptr and
> calls pin_user_pages_fast()/pin_user_pages_remote().
> 
> This fix also avoids the lockdep warning reported from that path, where
> pages_dmabuf_mutex_key is held while gup_fast_fallback() may acquire
> mmap_lock.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn/
> Fixes: 71db84a092c3 ("iommufd: Add DMABUF to iopt_pages")
> Cc: stable@vger.kernel.org
> Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/iommufd/pages.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied thanks

Jason
