Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9A338597
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707509; cv=none; b=VhBYp842gFhyK2FtJV8O7hgyGnh4Ml+CegIDxua4cBmM8n8DRwKyEYiT3Dj842Dm5Q6tfZHF24vBbvjBRq5R4CYXt/6TMmGnSr1fUY0PmHahoeLXPdZlNlv58bhVWraWxWzmc6odNanFV7whe7Jxj/MTP8or26IiLoATIwWH1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707509; c=relaxed/simple;
	bh=zXr+iLednLcYqiiAca5A60eK1ZlY/WKsuhkOhEKs29I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exC/4U2qHCzxuFb9SLPKHya6TUyeX2i2vzP/fvoH188PjaKDWdUctqhKciuWMoTPUPqX2W/39MkEMqwqhd6/HBkdaJHoXWFD9GIZSMmHCIgfcXGQR+Wf5rFLGykhe2i58kicwOuJQg1mAT31FBiDLNYbRXbJVL9P9UPlffeLOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jONgW15I; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jONgW15I"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so1401664a12.2
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 05:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767707506; x=1768312306; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otgUQYuu5A+quca13KcoFdag1ptfaGsgiKQ3LYEpZIg=;
        b=jONgW15Irh9eeRBKZztORZFlsWpVIZL6/PAobxNyoXhuypXqiUrAZ64RI7NTpsM6Ig
         wg/t9S8ZrOmWQQWHb1dtz1M1nu/JDqjzyhAk0oCQLg7BYgSaxy42Y/9c+zd86biFZDZN
         p/8GznF5acrACJbx9FCdkZsdM3dUqrHP9jsFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767707506; x=1768312306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otgUQYuu5A+quca13KcoFdag1ptfaGsgiKQ3LYEpZIg=;
        b=DS1nAZU9e3hrGG1v0LwIr3/6Zeg2mIZyfsrBmUo13U7XN6IKhPgdjn3cZ6qoGL/nqv
         oQRG7vyKtUslYgSD6S8MFNJioAb7+O7JYhv0foz0WYZIE7pMFhPhvzMeALxi4Fd3Ry8d
         kwW0i1hAEZAhfU4dkzAnSDXZqEqJksQl4TNR7P7dY94ADFrI86t3+PFKtWXIAYedFn8Q
         46Nk8GaBHIPR/DNuVpQy8oNckuQW1j/q3B6Hds5RYUPYNBWyhjblpoClO6jYFFzOWiJN
         2/2CVrrmVUWoQWyQmrSYZD5XiCc/d2auY6HC7M6jatNtDQr/2SOv4Ijt6EhhE1MPNGd7
         aD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpZfSVbGvip/dxO+KQTJlBC/4TNV1MYzFdBX+/3cfcoVYb0pJ58AlUru3/zbLLNpmzqOFAFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDfwyY5rm/7RGyxUNADUHWHc2RC8zpIIU0vjMaGZ1KHo5l0Cv5
	XvWTkIFSpF8B8fu+kVowY855wmxFHLUDjNrBcWDDEgncpbRTx4o/5qtWbP/lgL7Oyw==
X-Gm-Gg: AY/fxX7L9ihD83uYj3XPb4QQKYoFIDde3KnPX51+bu25LshwSMqe4vbPPByviEeq3xj
	g3QtncCOz5f1mkUKZ79mMTbKCsl4rSKD6WTAyxOzI8ufkx3uLyfQYjzl/eQKkKA61DrOA77Xy+C
	rvkx1xbZZ/sVJIHQl9/tODdDDRt7Hj4ve8wFHrNgSJDuJVQmuoRmpY4Uq06aMVUBMzjMhHkowCQ
	P5ctgLKY2RdRTKvgnoIJ+fVG25JEqu4d4UzEwrS4YLgBgMpV0jxX15CnU1R7RzIzUnoyqS/lf/s
	dHaIAjJzHvqCULdJNTFgBW9jcDiG1G1O8RU7SBZtqI26ULvp6YxYa81I/uqqVpaFB2TGAek4Btx
	suGovGrpUUbRI4Vwfr6yUYDUbXbTl6VxaHxVw5rHFvXuCf18sWTyQrJpYDd9lZiZ6OjCXm9LiEA
	2VLkBo5E6bUV24QCJAMQ+z
X-Google-Smtp-Source: AGHT+IHfs1NCiviorp5D5CPudHEDsr5xSrD8Y7TY4SpO2cO9ruMxLsgqkuvg/n976wFzlqh2m+mVBA==
X-Received: by 2002:a17:906:ee81:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b8426adfea1mr342452066b.28.1767707506097;
        Tue, 06 Jan 2026 05:51:46 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:43e9:5120:2208:3239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51543fsm232466266b.55.2026.01.06.05.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:51:45 -0800 (PST)
Date: Tue, 6 Jan 2026 14:51:38 +0100
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
Message-ID: <aV0TalseaDGW-1Jp@mitya-t14-2025>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
 <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106001418.GK125261@ziepe.ca>

On Mon, Jan 05, 2026 at 08:14:18PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 05, 2026 at 09:05:36PM +0100, Dmytro Maluka wrote:
> > > and WRITE_ONCE is pointless if the HW is promising not to
> > > read it due to non-present.
> > 
> > As long as we use a barrier. And IIUC vice versa, if we use WRITE_ONCE
> > for any updates, a barrier is not necessary (on x86). And WRITE_ONCE for
> > any updates (for PASID entries) is what was already done before this
> > series.
> 
> That is an x86 ism and it shouldn't be needlessly leaked into drivers.
> As this is not performance it should have the portable flow:

Agree. And as a matter of fact, patch 4 in this series already does that
- it adds a barrier before setting present bit, despite it being
"redundant on x86".

It adds smp_wmb() as suggested by Baolu but I can change it to dma_wmb()
which indeed seems more suitable. (FWIW on x86 there is no difference
between smp_wmb() and dma_wmb(), both are just barrier().)

>    WRITE_ONCE(non-present)
>    dma_wmb()
>    <cmd to flush caches>

Regarding a barrier after clearing present bit - good point, I should
probably add that to my patch 4 as well.

Regarding flushing caches right after that - what for? (BTW the Intel
driver doesn't do that either.) If we don't do that and as a result the
HW is using an old entry cached before we cleared the present bit, it
is not affected by our later modifications anyway.

Of course we flush caches at the end, after setting the present bit, but
that's a different story.

> > Although, perhaps even with a barrier, WRITE_ONCE is still desirable to
> > prevent the compiler from doing strange but legal things that involve
> > transiently setting and then clearing the present bit behind our back?
> > (Not that I'm aware of any compilers doing that, but I'm no compiler
> > expert.)
> 
> You do have to write once the present bit, but not the others. The
> dma_wmb() will make sure the HW cannot observe other states when it
> observes present.

I was talking about compiler guarantees, not HW guarantees. I mean: when
setting some other bit in the entry before the barrier, if we do that
without WRITE_ONCE, with a mere "foo |= bar", are we certain the
compiler will not implement that as, for example, setting the value to
0xffffffffffffffff and then clearing other bits (for whatever crazy
reason)? That would be still a legal thing for the compiler to do, in
terms of its single-thread guarantees?

So it still seems a good idea to use WRITE_ONCE (or anything not weaker
than WRITE_ONCE) for any updates of memory structures used by hardware,
to prevent such things? (And using WRITE_ONCE for that doesn't really
cost us anything anyway.)
