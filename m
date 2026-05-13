Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C44DBD89
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693921; cv=none; b=ZaeINJDHBAzMkJrtveaJVY54bca/uW2ehv9gxi+1jzb2G4ULdoZDFoLYG981Ufv1ohHQhif1ZP2RK3ZfJRYnho45lC10I7AN67MUepBY7a48y8oMPQ3wEo9mRTnG2M793AzDtnEGsiN1QqiNDndRs099XVCQsxno+t4Xnk2iqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693921; c=relaxed/simple;
	bh=N6K4B1CTT6yPfuEBOvcCzB3o4HYWvogfL8BuiuQ+vKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdInGMktHlcKunrtEV6P+r3u7GlrraWGS2Uz4k1oE76UHVrzr3350FcqGDju7vgSRZ2x2+N4C9dDaQtgn+06zBAgiIysbStQJdpwqJhWv+xJLyhv2VewSbXmdg0xxwu6BpACcjIxq7oZgf9s7n+dXwluAt6/Vs2apnou8dvQeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igCS962N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igCS962N"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so895ad.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778693919; x=1779298719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZHV2Kb6uwd0Z6ZEGhEeHOrazGmeyX5uyJYUBguLyzA=;
        b=igCS962Nd6E8ebM8ApIO8A+Ej6azPrwkECjsNgylvOI9HRIJr5virvTrAZlRlrg48s
         yNGZgncxBcgyw4LppkW03JeQ2Df274Dcf15KSwMC4B555rEp0qFy7fZHUAOIkhRE/3eX
         VVvaFpbV73hoL7c6jFIL/5EZX3n4szYANQKwc9aagIHgQzVNQ41aD4QDazFdK5vgxpqu
         FNeTvPGdKaZRV5zD+YlzoRJnrzyd5YM8Z0LtJPc1qTe6e6jQ/w9Mn610mKAtXJ2yROO2
         9RxfvY3VI+RAY2Uv3/N1txfK948sHa+P2NUoEPZRiwhj/aSaY7iVD74Z2m51E18dHCtx
         oUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693919; x=1779298719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZHV2Kb6uwd0Z6ZEGhEeHOrazGmeyX5uyJYUBguLyzA=;
        b=jYBgsZNlzYkJsGlSqEpYbRDQdRsRzFoXtG2EqFpRPfZyxD60niAauPDHiPYxqMA1kM
         N3d6yR89yS86hZG1nNWKTQFGy3p9ZZzTZL8rNjcd+q0ADhgb/VsFtM11K7y2fnFGqtVy
         KrbinYF/L33yRJncYujhFvSYEyesQxOmP4ZWDotcBQRE3DBYHjyHPlexAqo6M+7kMGR0
         73zmQHorzT17haoNpKtr9IZ5TKy2C3eW83sZoBZtWt6NhWEjb9ZHX5onnLmjqVI6DCTM
         A8+OVMGePguw8oBftQ9frLq45r7LbpV8hxbsiPfrppTEbTJFZQVEQFPZ9GJmtx2qPkWY
         iDTA==
X-Forwarded-Encrypted: i=1; AFNElJ/XSyzR6xtkHWL2rgKQdSmJ4DJwl4ab9jOmQ0AAO8xtPnXjWiD/SyMOvdZFPVOJ+ddxuqJxqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxhi3uqABa9fGI1mPFH6xu2ktoMht7gyUuLLRW/a9oLeOMUsIfQ
	MgfFtKlhqdATvHuAlsepqoL3/fY0GML2WJenEhQl/rQvwKv7KvUz4owU2m3vLLQ02g==
X-Gm-Gg: Acq92OFbpquENWfHYXsoJ/lalp16ZxlFTMibGKLmOeYS+FRi/21A81LqyOHyT+khR35
	1gdVUK9kh0yp+0eK7EL49AZ7fddo5HoQtLkS/Ilvko7dYOAHyEvHTt4aVjF7hBbsMyj+M48mlug
	3Wyw+iC9nsDacVRJhtHxWb/nx+dUeiLnu5Iyf4mWhdWBgn+cj+JrkLodnVQYAV91/yStyASyMEF
	U6I6rjj6PkM5ptcdu0+9no1ZLgz4nc4JsMVHZ9hkfkHdVT5Ucv6iCGQlcn3mCVfttljVwesHLM6
	tc210C9zBFEo72k2IH3lqVwjIdjX2rBcxNTbudT4it24wWZQnggE6finiWzkGpV70Nbed+XgJ62
	qw9pz5kMQ/oXZb+/JeViQntZAlqzFyHCwTkok5cGikEDY3+82HUh2h9LX7GaqL2l9vDSbeQblFS
	caaew8+hNbaZSEZQ3vqUqNGcXm2/kRS3QmQiQrN9/Ex2qWOVMJmcTy8hb26gMEIY1LaEcoujpSa
	VR3XGk=
X-Received: by 2002:a17:902:c401:b0:2bc:a58c:fd7a with SMTP id d9443c01a7336-2bd55e48463mr183585ad.16.1778693918255;
        Wed, 13 May 2026 10:38:38 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e6199csm223692405ad.55.2026.05.13.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:38:37 -0700 (PDT)
Date: Wed, 13 May 2026 17:38:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <agS3FzgDlMADXU1e@google.com>
References: <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
 <af3ryl7G58D2GeWr@google.com>
 <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
 <af7oyeleKFXpcIKu@nvidia.com>
 <agHYDxuYyqzmAfy5@google.com>
 <agRjt9XpN66ktdk9@willie-the-truck>
 <agSKZPJmFMLc0gno@google.com>
 <20260513143213.GA787748@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513143213.GA787748@nvidia.com>

On Wed, May 13, 2026 at 11:32:13AM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2026 at 02:27:48PM +0000, Pranjal Shrivastava wrote:
> 
> > Now, if we're work on an SVA page, with only SMMU supporting HTTU. A DMA
> > writes to the page and the process (CPU) calls fsync(). IIUC, it performs
> > a lookup in the Page Cache specifically for folios tagged as DIRTY.
> > Since, vmscan didn't run yet, this could potentally drop the writes..
> 
> How does it work differently in the MM when the CPU has BBM support?

Hmm... I looked at fsync and I see that it eventually calls 
folio_mkclean() (via writeback [1]), which performs an rmap_walk() [2]
to harvest dirty bits from PTEs into the respective struct folios.
Similarly, the vm_scan path does the same thing via try_to_unmap [3].

Since the MM subsystem actively scans the tables during writeback, it
doesn't matter if the dirty bits were flipped asynchronously by HW (w/o
kernel traps).

I guess that settles it, we don't need to gate this behind cpu_has_hw_af()
and we need not care about the CONFIG_ARM64_HW_AFDBM either.

Reviewed by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/mm/page-writeback.c#L2905
[2] https://elixir.bootlin.com/linux/v7.1-rc3/source/mm/rmap.c#L1103
[3] https://elixir.bootlin.com/linux/v7.1-rc3/source/mm/rmap.c#L2164
