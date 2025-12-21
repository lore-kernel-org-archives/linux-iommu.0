Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7A242D7D
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766322706; cv=none; b=CkdcGbJwAMwHTxj3r1NoBYtahFftCOnehxtMoYZhoPLUiZksNEEz7JZp7bD7Lwl0MzBn+ux3xzADe+rzYgrMI0Jnz/h3S+sj5zrpHxXVouEeeGTPlI313bK/jKS4CUCMMvEvxmXa7YTG560YrRoadkaOSRd78tpx5huQL1Z3yXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766322706; c=relaxed/simple;
	bh=ZHz9jVzM6AAmfornbBnxB+DiZRmEnSTugONlVF973ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mykIeHSlCH7GK1ROAGRPW6BRDL2DrLRCMAOe3zM0x8CggFCdu9UX4DFcZe4FsI67zOvjoH4b1hHia8Sa/Z0H2baKxmMCBHZZW5Y9l4fi80Q0WwpBJm3PQLGNRcLNeiziHM/BNxqjGe96fnKTTMOACxcVeX9Uw8QGkW/AX2z8DFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=azzY1gWz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="azzY1gWz"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso437021666b.2
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766322702; x=1766927502; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b80CLgDxcDI7gWAXefrFbpijOSR8oO3X2+wFfLIFrjA=;
        b=azzY1gWz6cKxT4hjipXfxHm1tg2GZd5a3lE66lmULlfPhumXVQMLQgIpfwO7RCGLD4
         siEg4huUVxG7pDMFqrIU2NGzxj2/Nsg0w/nHZuPUPHsiIuDduxEIotQaIguzfPTtDd5N
         vZ3Grv3oyYZ/cY5bJRerpKwNP8UwGgJ1rCs8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766322702; x=1766927502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b80CLgDxcDI7gWAXefrFbpijOSR8oO3X2+wFfLIFrjA=;
        b=YUwX1iytVR9zARqy5bRLql9UWvaSg1h7vupcq4L9WAr0WnK/btoBpbYMr4PckvSmoe
         xZXeC5xQrOICxFT0P2b8RMm8ELuLRzhgo0allB+lTgMwbtx9dxrk9NEotpK9zHO+E0uz
         L9sgap8soClrZgNDnwqy6cGw6IkTn8ASBZ45YlVhWJ0RkPdqc/8BE6emM5qJfiJ/064X
         ZI28DN6sQAO1fc+57u9nKO2DdgZCp14r8p17jOAlKPKUhGsXkZNtAVqwZ8A/H8RogzU9
         uT0WqXRdWrvpk9KX4Op9svtNkBeXs6sPJmYdzf7imFDkS3DEmmoLVW4GQ1Pf03MKkrwo
         hyyA==
X-Forwarded-Encrypted: i=1; AJvYcCVjlBcWOskh4tQV7uE0UUmGLLlvRmAgVzttDqOx/ousHUG+vrHKzTq4N2LGvubp7nSq7CcjRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE4o6Iji0hNIGeJc8lm384kiHp67DWLKiVKLJRpLDDh0ehHalq
	7uR9Q+PUGMnhD/6ls22NZD6Xmx3I775h0GJtyvARwSN4gzAqMk91jt/ao9Zb/po+AQ==
X-Gm-Gg: AY/fxX6QQPueOUaiu5OaiAQHES1R8Ip6Pzf9UeO93NUx0qti+YT/A8xI55R+QxI+C3v
	nOgi2yYkxauGkGzCGXA3g0kl8Gvdy7hhZAR6BCWLMfp0UJW1rB1LMfkzFLF6A8PqtxgxxpqA3hh
	BzPSWTxiz6lpjTGAg1txIyPtBnh7Ovvs0+Hs47hPIy+7hfmk2p3DlvHoaOCpFZ9wvLc4c3+trvE
	GVVUu8KLS33CHoVGB26o7WQ76kgfAcRUrclgUOxx9GgVVz7+fHm8q36Oa/raa0mDnK6L6jKXQ9x
	kxt9DCSquJAOGlblgVHkvGP+Y04UM7kwGZAEuiE4JdCCD6wrPOjB53ZvvdfgMXbd+ObfprE1564
	aCXhl54ISdB6LF9sG4Ei4UHjxtUtRj9XEhWiZaO72tao1FXZ4q4Iw+BGTidiUHRrWpf+oYWHNiH
	d8Wh8/7X/tfpeZSZ6eeUJm68pawZMNGQM=
X-Google-Smtp-Source: AGHT+IG3QCwI2JDNTYLKWuzoZBqthGEMOUBk/pHwbGYUhUqhl61GdHKqx6jHANyZQwI7E5Vk3Jx3Tg==
X-Received: by 2002:a17:907:3da9:b0:b73:6d56:7332 with SMTP id a640c23a62f3a-b8036f0a329mr927560566b.13.1766322701640;
        Sun, 21 Dec 2025 05:11:41 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:4cc9:1698:dce5:4976])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b803d3cea32sm695782866b.34.2025.12.21.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:11:41 -0800 (PST)
Date: Sun, 21 Dec 2025 14:11:34 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Ensure memory ordering in context entry
 updates
Message-ID: <aUfyBmPQfosuCDab@mitya-t14-2025>
References: <20251221014302.17738-1-dmaluka@chromium.org>
 <20251221014302.17738-2-dmaluka@chromium.org>
 <e51dbe16-49a1-4925-8b2b-56beb66de520@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51dbe16-49a1-4925-8b2b-56beb66de520@linux.intel.com>

On Sun, Dec 21, 2025 at 05:04:27PM +0800, Baolu Lu wrote:
> On 12/21/25 09:43, Dmytro Maluka wrote:
> > +static inline void context_set_bits(u64 *ptr, u64 mask, u64 bits)
> > +{
> > +	u64 old;
> > +
> > +	old = READ_ONCE(*ptr);
> > +	WRITE_ONCE(*ptr, (old & ~mask) | bits);
> > +}
> 
> Add a line to ensures that the input "bits" cannot overflow the assigned
> "mask".
> 
> static inline void context_set_bits(u64 *ptr, u64 mask, u64 bits)
> {
> 	u64 val;
> 
> 	val = READ_ONCE(*ptr);
> 	val &= ~mask;
> 	val |= (bits & mask);
> 	WRITE_ONCE(*ptr, val);
> }

Makes sense. And then worth doing the same in pasid_set_bits() as well?

Actually we can use the same helper for both context and pasid entries
(rename it e.g. to entry_set_bits()).

> >   static inline void context_set_present(struct context_entry *context)
> >   {
> > -	context->lo |= 1;
> > +	context_set_bits(&context->lo, 1 << 0, 1);
> >   }
> 
> How about adding a smp_wmb() before setting the present bit? Maybe it's
> unnecessary for x86 architecture, but at least it's harmless and more
> readable. Or not?
> 
> static inline void context_set_present(struct context_entry *context)
> {
> 	smp_wmb();
> 	context_set_bits(&context->lo, 1ULL << 0, 1ULL);
> }

Maybe... And if so, then in pasid_set_present() as well?

Actually this would make a slight behavioral difference even on x86:
right now this patch only provides ordering of context entry updates
between each other, while smp_wmb() would add a full compiler barrier
here.

So this barrier may be redundant as long as we always use these
context_*() helpers (and thus always use WRITE_ONCE) for any updates of
context entries. On the other hand, it might make it more robust if we
still occasionally do that without WRITE_ONCE, for example in
context_entry_set_pasid_table() which I also changed to use WRITE_ONCE
in this patch.
