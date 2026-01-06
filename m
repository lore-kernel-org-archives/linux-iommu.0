Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5F34DCE4
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714623; cv=none; b=NcBL3Y2b6ZWT6qdVAyFstNqB0pUhEwyd8AMREdPnEjQnPtGZ2kcWwrBnSoUpQO/qOeUg+ynl26da6T9iXPrMT5uk7WF2mbWFaNOpPRhsOOMaf05LklYhktcAhOfm0FBjkdBBrcxqhYJ0EU/wUgDEaf739IENXty0PiKnmfGfQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714623; c=relaxed/simple;
	bh=b/zjggFl8/W6uEcltcHPtMmP86hS+JiDB4IS+bXA6Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep7WTMDsOfLEyQseEWnt8+WIxGExgP2Skzty7iG4KkgHXhrjM8mDRv28DviMdFnDViuZlDW5ZeJh7m22pnEfPULr7UhIKWOESvRdJz/bGVi8TR93mkqEn2cYl+knKWGtLrnrG9FBbgZ7nQUsX6TydQK3pB4SUSgLXZ4YWPrSyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JdHOAEz6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JdHOAEz6"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so1665488a12.1
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 07:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767714619; x=1768319419; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9fgEx0U4KKIU9NUKf/BCizk5aPErtLpqSrpq7gCm0U=;
        b=JdHOAEz67CJe7OKshK1wtT4CVgp1Kkkwesk79Uj6W0Bh1BwRnZLzZYftZkeVN4cOpm
         LMN092Uh0r6t2/FFgk3mV6PyEKWwq9xfm/P8k4Qvsicbw1oqUmafyN/+uDcUW2/8rCDC
         xYEF38Gjvp7frEI4CskhdYd+f164aiLEzviVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714619; x=1768319419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9fgEx0U4KKIU9NUKf/BCizk5aPErtLpqSrpq7gCm0U=;
        b=qFaML6XIr/g0GHpc7ZCSe4vDNcBEaJyiWaV9zW1hS5B+eTqmEOAqdgcW2KGXzlz9BP
         sHIQBUovo93O7g9zRKmyN0PGFw8pLRb6istIdMDmUSOEu7NMPyL0HJ7Cb32hI4bpMIF2
         mNP4buNgjM90Q5XQ32mSCW6GkZo8uc/4oQssNj/4dGZdbMD5+XzJCgkR5Fz/zLm96xMO
         yo1Q14hrc1CdzC+m8omy1WlcQb6i1eyU/WF1NI10PBdpqS9ogORCPizQED9o7VCBIVLo
         n4+t7HAl8Lt3Cclz6qjMg8qSY21DCxWpLBjpSf8pNVntPo+BRhuy6TTrT2CXCGDAPb1T
         Y8zw==
X-Forwarded-Encrypted: i=1; AJvYcCW+RwEb0bny6ZrQ35eJ+6CAa8aY7YbPqH9QBdIf90rSLXJwBCeRTn6Zoc9h9lwNt8cFye8irA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrRiV/ecDBz/8Ffwt5ATwg1HqkNAUd8W0QxzgHqpUUtWwg+g2w
	FprFN8ElEghM8ap9NpEKcuWF5jI4klvowruApVQWIrUV1Lxfu0UUKnBkjr4ErJQjfJHhWQKsjma
	Gguo=
X-Gm-Gg: AY/fxX7KOpv4l3cafT12GMpWbDD7lydKuvsQ4FGpKxnD2LdmxdXvJwVlOSpxdPRjGBH
	73kO8MXvzQk/XLoGs1GVFDNrNg/6tn/PvuBwGxhYunGSnnOs9QafFv427SNKAx6fYDLKW6dXO+L
	WWebZlHTibJsxa0KfCJWqoTllJ7Yt2ZOJERd0ps2bYvBu0fSfWR/HfodyaLQaGU61h6LjxvAgt4
	oVD08t0FyziHY9aXXDxx1uTWQce1iU0fhDebktWMch3Bi6KZ3BfjcRlyG8kdh8ciqkUQEowcy5E
	pDlECxoyd5XylG7MFvR7oS53KjzDzF00fc1a7iX0A3E/XWQ+a3oxMoXX8DoUDNuIFpGu0h8ucgq
	ub49ht29Jm8pGB7xkTKRHUypPHFq2A3s+0jF0IDDtmOCakxKQKQb2xoOu+asXCqNq8Q0SdHrIGQ
	GWjHxbteZVyXyFmR4miov1oU/xtEnIh4Y=
X-Google-Smtp-Source: AGHT+IH5ExdhH3cvp5++TTlavtYEe3AsTAcecnjP7jkcJzbJvxKDWz24P+rCoFWq2g2fHKYoI2gZmQ==
X-Received: by 2002:a17:907:3c8e:b0:b79:f965:1ce1 with SMTP id a640c23a62f3a-b8426bedeb1mr362072666b.42.1767714619387;
        Tue, 06 Jan 2026 07:50:19 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:43e9:5120:2208:3239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a22ff58sm255887066b.6.2026.01.06.07.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:50:17 -0800 (PST)
Date: Tue, 6 Jan 2026 16:50:11 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Message-ID: <aV0vM9ad-4QhCNaA@mitya-t14-2025>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
 <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
 <aV0TalseaDGW-1Jp@mitya-t14-2025>
 <20260106142301.GS125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106142301.GS125261@ziepe.ca>

On Tue, Jan 06, 2026 at 10:23:01AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 06, 2026 at 02:51:38PM +0100, Dmytro Maluka wrote:
> > Regarding flushing caches right after that - what for? (BTW the Intel
> > driver doesn't do that either.) If we don't do that and as a result the
> > HW is using an old entry cached before we cleared the present bit, it
> > is not affected by our later modifications anyway.
> 
> You don't know what state the HW fetcher is in. This kind of race is possible:
> 
>      CPU                 FETCHER
>                         read present = 1
>     present = 0
>     mangle qword 1
>                         read qword 1
>                         < fail - HW sees a corrupted entry >
> 
> The flush is not just a flush but a barrier to synchronize with the HW
> that it is done all fetches that may have been dependent on seeing
> present = 1.
> 
> So missing a flush after clearing present is possibly a bug today - I
> don't remember what guarenteed the atomic size is for Intel IOMMU
> though, if the atomic size is the whole entry it is OK since there is
> only one fetcher read. Though AMD is 128 bits and ARM is 64 bits.

Indeed, may be a bug... In the VT-d spec I don't immediately see a
guarantee that context and PASID entries are fetched atomically. (And
for PASID entries, which are 512 bits, that seems particularly
unlikely.)

> > I was talking about compiler guarantees, not HW guarantees. I mean: when
> > setting some other bit in the entry before the barrier, if we do that
> > without WRITE_ONCE, with a mere "foo |= bar", are we certain the
> > compiler will not implement that as, for example, setting the value to
> > 0xffffffffffffffff and then clearing other bits (for whatever crazy
> > reason)? That would be still a legal thing for the compiler to do, in
> > terms of its single-thread guarantees?
> 
> The HW doesn't read the values the CPU is writing, so it doesn't
> matter if the compiler does something strange. That is the whole
> justification for why it is possible to code it like this at all.
> 
> The dma_mb() is also a compiler barrier and ensures all that
> uncertainty is resolved. Once it completes a DMA from the HW will see
> the program defined values only.

The HW (the IOMMU) may read context / PASID / page table entries from
memory at any time, whenever a device makes a DMA request so the IOMMU
needs to translate it? We don't know if it happens before or after the
barrier?

So we'd better make sure that if it happens before the barrier (i.e.
when the device is not supposed to do DMA), the compiler (and thus
the CPU) doesn't set the present bit, so it stays non-present, so
the IOMMU will block this unexpected/malicious DMA?
