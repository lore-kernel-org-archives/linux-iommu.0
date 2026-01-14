Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F3396D18
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388303; cv=none; b=IcmELOy7znI+/9AV1kcMu+L/w33Ks7O9Bo7Oo2G7gZ4IPTEou9JSeJZWzMBn0gPXtD7RJtdyn5BDN62V3Z8rzbV9y1W+Z/ICMji1U/KBsqp3U2P1sxS4UZs+HRbIwwz7GbAqHoDJM1lavBxdanlbwip5yQkBMMTEsJsRRuAQmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388303; c=relaxed/simple;
	bh=8bq4shRo5Z7fiHCZj5v37UpZhSnxoVxIhPa8MTMywoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ02LNkZ7bb8Vgyk5KRURiFANHIojRxBG9EHj960IAFt1KyjrE6kuPFaeGpMqSv9juCDD3ET0zU6usDdm3FV9kIHWLxYuS/JuXkdFewfWJzfR7zkEfbuG27I+2FVHokc7zVYarvntxIQLP6eXYWHztEV9abMHkv3+B6EFD/Cwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Weq83wWf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Weq83wWf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso12346073a12.2
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 02:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768388140; x=1768992940; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOZuGnQOlS2i5sQN7GC1dbMnjG2feQiajX3m9PVzMaM=;
        b=Weq83wWfuPS0S7bEHtE5sDTdV53/jLHIEjd62XtmIXpxPcrBUvZgHER65xFpEs8x5a
         NP8JWjfBnLrGZkTwhv+YWiEK8ag6Smur6wP2yUltWb7L3LBAALLyUiYQh+dl2NqI7oFN
         l/QOAGLRZD0NnqZU7blQBrqTpIc5T2fV9kkco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768388140; x=1768992940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOZuGnQOlS2i5sQN7GC1dbMnjG2feQiajX3m9PVzMaM=;
        b=ACoLbl3YtWit6U6huyVMLgXUCt5B0aPbKlMaWvJlyOAyMjdDrXlKS2PN14P6w6gT+K
         y0XBFf1F3aLE0/G6VywTQRmE6u2aP04ppLKOcZY4nveWqE0IJdGEpQTfWGbblo0McmP5
         sWxc0xpdQl/M/8EwY6roNLUQ55TxoEcM9+OTEDOOzbwrcX5gcycnD4zTpN+PPGbmLDbU
         HNR7Io1MxoQ3c3bJphWn7fkv6LSABnIshiE0pYiMjchp/YKudOASwJLG9Ap5b5P9FqOU
         g/P1K7Xtbyebj1KW14/HpOMPvqp4sBubUSodSLuQUVqQQsJQs5DsBUwcr599WD8RgfGx
         6TYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEwJyA3rifr2zUq66w2MLBdn4si3WTLYo61mBk9KbYT7F8yADhuRljFhUobT5msN6OT6UYxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaSQtkwcYXtO5s+ZUDU3oINB8wrLzLKR9p6ALC+FzNZoBxl7yx
	y5xdvAx8MIHM0rXb6MpsC9cBKtNwsnHCg/fXoATeTGv7AjmC3rpw293P4kJueN0ahw==
X-Gm-Gg: AY/fxX5x1gP52xr4sJNC00Rehc0d6bO8YGtuKIdC+8DLUlpGA6gIrDZJQ8pCctj2OYf
	9QGmoy2PIAg79OtPaiLfxyd24GLe07Ltac/Qwyu7uMllNESs/JRHnUI/dCr5QBSo4QiM5yyMHGf
	LX7nihVFxE9Oz5azqUK7w/ys5sP1XOCwyQ1Op3fyoLhupUhQhnm74J1MDufALoDCQn2JO+PmI0a
	c4EGomD9u5bcpcys4uVTaYnhNdakulXDTmfATar4sYbV9dZpxhDdXHA0DbJlHhW0trD6Wk0WrW+
	5jUCyEMTN45gNCTdmyxYHXz6Saf0GmkNgInUMVoOKLunZ7IC1S/Qa+vU6eX/6P9Rn2G+cP964Kg
	s21AcVVIUL5ZzGNs3ZLULpJvlX9z99JtCAQNnqDRT5mwAo11rvIZWPs+6rQGgZ3krfsFLaE87bx
	7vpQ+ZWU6YYmKQD6oj8P9U
X-Received: by 2002:a17:907:f495:b0:b87:39d:2bb4 with SMTP id a640c23a62f3a-b8761452319mr191212566b.59.1768388140053;
        Wed, 14 Jan 2026 02:55:40 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:8f9d:1786:e151:a9f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm1281735566b.31.2026.01.14.02.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:55:39 -0800 (PST)
Date: Wed, 14 Jan 2026 11:55:36 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Message-ID: <aWd2KCSU6XTNmQ4R@mitya-t14-2025>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <aWacsq9gDrAgPxli@google.com>
 <1e967054-d2bd-4c3d-99eb-315a40bac9de@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e967054-d2bd-4c3d-99eb-315a40bac9de@linux.intel.com>

On Wed, Jan 14, 2026 at 01:14:36PM +0800, Baolu Lu wrote:
> On 1/14/26 03:27, Dmytro Maluka wrote:
> > On Tue, Jan 13, 2026 at 11:00:46AM +0800, Lu Baolu wrote:
> > > +static __always_inline void intel_iommu_atomic128_set(u128 *ptr, u128 val)
> > > +{
> > > +	/*
> > > +	 * Use the cmpxchg16b instruction for 128-bit atomicity. As updates
> > > +	 * are serialized by a spinlock, we use the local (unlocked) variant
> > > +	 * to avoid unnecessary bus locking overhead.
> > > +	 */
> > > +	arch_cmpxchg128_local(ptr, *ptr, val);
> > Any reason why not cmpxchg128_local()? (except following the AMD driver)
> 
> Yes. This follows the AMD IOMMU driver. Both drivers use spin lock to
> synchronize the update of table entries. They only need the atomicity of
> the 128-bit instruction itself. So arch_cmpxchg128_local() works.

Yeah, but my question was merely: why use the raw arch_*() version, not
cmpxchg128_local() which is the same but also includes optional
kasan/kcsan instrumentation:

#define cmpxchg128_local(ptr, ...) \
({ \
	typeof(ptr) __ai_ptr = (ptr); \
	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
	raw_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
})

IOW, why bypass this instrumentation?
