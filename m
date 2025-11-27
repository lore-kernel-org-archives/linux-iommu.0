Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AB30DEBD
	for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764275984; cv=none; b=ebYWrK0eu4ifgyILjGG6i72ZXBlMm+Z46weXJ08V5qv2O/Kk1jpC7JRd08YUK9/IaW1AByk6G2gYMskXtI2QmbC35S1enJWtizMy0+mhKwSEWvLCQgrebJOICkMZO9hs/yma6kbKXqJj/tLi2LPtmSSgGhxz7isdUI/Svipk6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764275984; c=relaxed/simple;
	bh=tvodW7JRvcfiQ+2b1TbMwMXmlYGjYL2Yk/oD6Ttl48o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmNTgAOlro+PyJQRCnMWyfuXYLJgfw7SNQaHMKSNSsLEGRjyuW3UB0RWetfqUMiVAlMDAs/a1sEDgEOfET9vNzsWnsKtkcx50Q/sWg5bkmoHBBLKq40KUmKHtVs3hW2s8TbAFFU4CE6AoN7VCddD3/i5mpFU3v1HcAXaGZe8dn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=MfFtoa23; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="MfFtoa23"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1287283b3a.3
        for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1764275982; x=1764880782; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f4zeb8l9u5i+aR98BJaZX6AUgu69rdxc6FAslyPRtU=;
        b=MfFtoa23bXpQ8/ElRuVBETmyOzxsL57eHMLsAgmt8KGfAFpGB68IgVpUraRQsDDx2K
         7pVwB998RXCcOdbIeRoxf0s/bbQbHwW1ay/BxYSsCoMSwDZ8yOJXulV9Jjf9FW65lBv3
         v7HkzCZN2SRGpQKXgMWfibsbGy0Gwv2LKuIYegs7MmSM8Utel/S5OcMQwdHYMf9KuaPz
         ugfHpgyPgDYMdNXysV5ARBiRewB9nUF+99DN5q4lg6KhCQWCu2FEhuZc5u9aJ0Agxy8E
         xv4bI0NiKurlQ7cIpdi7vP3AIZRWWuoDjh5azLP3d1MXY12amH1+CGKlm15U1F05IHGN
         +bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764275982; x=1764880782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f4zeb8l9u5i+aR98BJaZX6AUgu69rdxc6FAslyPRtU=;
        b=ufn2VJ2zbGG39JSnDWmMUeb21Tu1xyNjRjKqJoMblchVHE+TfQE2OE3KiT0+J8e23u
         6uqOI6lVgfZHd/etdnkL7ULrCk8u/0tGqarx9TibG4P+WIiD4XaP3TECnZFFotYV3Mfs
         5gDs8bckxXF8eSHy/8nUhNuZSMW2bOhYDqGJWQJNplPIl8FTKVoNMpBzGMpnOq4Cej4I
         7OdDsAh0oFhsXp70J8auVw6OS3rNyUP0JoW7VZ8FrisxNZOvjhm82gHC+YxRYBNsR9vt
         looKf25T6X0i5tjROndxrlRKOlD+YfreKMuFgEsyUwWQOpnJLK3Yrq0J0Kt6pX995nz5
         g/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXOenvo8nYpdt1VgcH78AXMngAYirqmokXwX9WH8toExLahBtAkxynabRGf67XdZ8g+LR2u+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZMZVld8ImUV6A5OB7rFfYqkYy6ndkoUmOzzi5+d/ftsrJLDNX
	vLyjC1/7wL7fsiMSMWjZLlcLsS6umxxiUJoIpK4SUUkuA0O6pX1YGz3exigsIbgzqgE=
X-Gm-Gg: ASbGnctRzh1PdUc27wzdM8tn2UnimpQNrdhsHHNJkytHM0jHGb3mU+dy3G1CyXT8Hco
	Ym+Qf+jlBJYDwYypYW8TSHl8wCpah2qwOlSX2VzczPCxyOfZLLW38bFEkZjhO4wWMCOR+ygcX28
	eVDzGb0cyBHppI/DbkpFaIun2EdZZ3zq9vBZI5OrraY6OTcUOWYZzAvRF+aatFhP/2NZcophALf
	luOquPiMMvCbM0iftUkGiRQ5QzfFf6Gio0vRo5KtXKrBMsaCpdDHdUJTcixRfiLo0xAlH/+MW8y
	6+CdgLYiZvTwkFcL3F66bZPauAszLpNvwcpx6MQ6yweX5cDOUEj0aMaG7iOc44tF2SeREqJ7dkU
	q4s9hKr4QclcEtOB0im3P0VMpLo4W2reQxMYTQIXrQRM27ZFf2wTeiaW2jyleBna2psEIz2P91m
	8qMSikDhAgOKQO
X-Google-Smtp-Source: AGHT+IGQb0w4AY9IxnlagBk5k4aSVNLwiqHrKrAOKZAF+LOvj3KhlnhsUyJNm2KfzNYdC67lMSerlA==
X-Received: by 2002:a05:6a00:23d5:b0:7ad:9e8a:1f72 with SMTP id d2e1a72fcca58-7c58c7a7601mr28835992b3a.14.1764275982249;
        Thu, 27 Nov 2025 12:39:42 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a48b2sm2766991b3a.28.2025.11.27.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:39:41 -0800 (PST)
Date: Thu, 27 Nov 2025 12:39:39 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH next] iommu/vt-d: Use shallowest supported table depth in
 sagaw
Message-ID: <aSi3C5ws5mS-6NFx@mozart.vkv.me>
References: <8f257d2651eb8a4358fcbd47b0145002e5f1d638.1764237717.git.calvin@wbinvd.org>
 <20251127183210.GC738503@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127183210.GC738503@ziepe.ca>

On Thursday 11/27 at 14:32 -0400, Jason Gunthorpe wrote:
> On Thu, Nov 27, 2025 at 09:06:35AM -0800, Calvin Owens wrote:
> > The failing condition in paging_domain_compatible_second_stage() is:
> > 
> >     /* Page table level is supported. */
> >     if (!(cap_sagaw(iommu->cap) & BIT(pt_info.aw)))
> >         return -EINVAL;
> > 
> > This happens because, for many domains on this machine, MGAW=39 but
> > SAGAW=0x04: that claims a 39-bit maximum address width, but also claims
> > to only support 48-bit/4-level paging, which seems odd.
> 
> This logic was intended to deal with this:
> 
> static int compute_vasz_lg2_ss(struct intel_iommu *iommu)
> {
> 	unsigned int sagaw = cap_sagaw(iommu->cap);
> 	unsigned int mgaw = cap_mgaw(iommu->cap);
> 
> 	/*
> 	 * Find the largest table size that both the mgaw and sagaw support.
> 	 * This sets both the number of table levels and the valid range of
> 	 * IOVA.
> 	 */
> 	if (mgaw >= 48 && (sagaw & BIT(3)))
> 		return min(57, mgaw);
> 	else if (mgaw >= 39 && (sagaw & BIT(2)))
> 		return min(48, mgaw);
> 	else if (mgaw >= 30 && (sagaw & BIT(1)))
> 		return min(39, mgaw);
> 
> Though it is not right..
> 
> I didn't consider that this would come up, the only way to solve it is
> to pass in more information so the tree can be higher than the vasz
> requires..
> 
> Can you try these two commits?
> 
> https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd/

That works on the Skylake machine. If you want it:

Tested-by: Calvin Owens <calvin@wbinvd.org>

Thanks,
Calvin

> Thanks,
> Jason
