Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009EF3CC7D8
	for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784385159; cv=none; b=k7v0MsU16C9/52FEHZJE259C8FNyu9v7klChgqqjnq1NMkPzUvZUY7eUaookO3foB24LwIpPSpMqoCNhF0HKjG5TPAJmWG4xROrU1AA2yorZM6ZxLYqIw6RFgc/zgA/TXIWkOz3MN72b5Xzl/Cb087WGR/Ey/+7j2GZQEYuPZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784385159; c=relaxed/simple;
	bh=qT89Wi3RAN9CgJ0A7GdoQ7adS5M+Uxt5TfxmdTXEZ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swspC4Y9mRBIcstQpjJt7nxupkqoj/azQrlGftjAiH5pZtddXMVrH+Y7sHetkeNik6WA8azzI388jG0A6dmYMJf95/786Ib8+3KWhVrGBI3gjnONixYjYwAuPwdCB2w1DJK11OEHAbsQiJY9ginQ82IUCAZhmm19zUCqisby0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o34ACwC+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o34ACwC+"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92c7a0a701aso678133185a.3
        for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784385154; x=1784989954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qT89Wi3RAN9CgJ0A7GdoQ7adS5M+Uxt5TfxmdTXEZ+Q=;
        b=o34ACwC+dFaglFEe0DafbBftm4FHED7rrj0va4J1n9poJlSbtZkrND+292H+1P45aK
         mLWJr5gEIkHSN8p6u1b29PolapO8hIckIkJnh+rhOEwZpm1/C4b1WP/MW6j1xghM9hJ3
         hyftvxEEUpNnHTOcPHjjOb8TyYMBEbknLCNDtJGF/xj/jd/2ksX/0T7NyKWeU6wB5d92
         HW3yEYWcxjFyd0eWeRqm0p3QdYku89rX1aLLvoTMhDN9pKcjIetSdh+HimO2yNBp3p6i
         zm9myWZzWMtSKhs8PPPuKUr9WE4FPkuIZj1tDlKjF1HkcDW2MBrwdPp8+Vt+bzob8zTw
         YB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784385154; x=1784989954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qT89Wi3RAN9CgJ0A7GdoQ7adS5M+Uxt5TfxmdTXEZ+Q=;
        b=X3SaLPfh1ZRKP/X2KHFh6WyYT6nFRc2irZGt7pG3qQ95P4zsvjcYPQ/VJThW0Rnrrl
         Rpmpo1wnNRvln94ZTlDtgAXJpWnxkQABPNDGA4XpC8Xi1oSJfQsYsurinTrMYnXTE3CA
         UIcUB+8Tc/66V8fm2UkSFt4hdU40ersuoeyCnAavXvNLUQiMTejDTQtgXqgIHpaMPH8u
         StF2yXuNcVStDs5rNzx4+n/6fjI5X7OQbW5d8LK95zzHS1hG6EK6w/Jxv90Fc+LlHuQv
         trDXJgc7s+RpyZ/1Del5sQ7xcROv3RvzpQFTbN/EL3buPYDCMBiXoTK2v/S7R2a6872i
         b82A==
X-Forwarded-Encrypted: i=1; AHgh+RpyGGZDXRaGhQ/vb7k73jRqjImL8D+m8KEPov1b9fAbjyiPGJXYA4hy7h6nhyMgmvZx0D5pzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu8sJRPBQ+/PV1TdUIiYGdKBWDAH+0dy7i/nNEhYplJ8IESrxG
	gMgF4vT1SatRdgYyn2XoG+GIppmDkfGrwKWdk9CiMH+KgYfRHk5eQf+aAd2MtNjWjw/9v6yc9A7
	cGqm4
X-Gm-Gg: AfdE7ckLXw1rol3nP4vk2u5FGSfZkz/lOhlpKVgq5LQZwHsoUN/vR7JhBMAB2h0ygfl
	2JUi9u/Pv7IEL12otVwET/rYQ9R7N/OfvmMgHqPAnciYl69+6rsIHSOQopogh2YV7RGea96vLZI
	KQgEbuK1Tgarc6aq8JKUwi83SZoMCNhLW6GDxTs0D91Lqd6HJimRGP6qJYY/nREn06EkZwjzc++
	u2JbUu4ISkI+2XKk8JWOOaYHaNtdum0hq6tgUSxVhQ9LeDxEFabaqFCB/OtHSBriReQCIl4EZkD
	SKjIReCh8Q2b7215mBmZw1IzA0zuVq5/ce5RT1ZrB/wLT/dtlOqHAoxcgZMuXdq+dpTFOLFPDLC
	fM0hckn7xFJ8iWqFK3RDrHCQOlD1pxAuclH13hAGaSjT+10Y7QoU7IjgaDP+Q
X-Received: by 2002:a05:620a:4706:b0:915:6a2b:6265 with SMTP id af79cd13be357-930b41e282amr722435385a.44.1784385154410;
        Sat, 18 Jul 2026 07:32:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542d1e5sm425204385a.23.2026.07.18.07.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 07:32:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wl65h-00000006T6V-0EUE;
	Sat, 18 Jul 2026 11:32:33 -0300
Date: Sat, 18 Jul 2026 11:32:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com
Subject: Re: [PATCH 5/6] iommu: Add Broadcom BCM2712 IOMMU driver
Message-ID: <20260718143233.GE701389@ziepe.ca>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-5-80e10cdde2ea@reactivated.net>
 <20260712221125.GD1835788@ziepe.ca>
 <57f5675c-8bcd-4022-978b-9f7933bb0032@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f5675c-8bcd-4022-978b-9f7933bb0032@reactivated.net>

On Sat, Jul 18, 2026 at 09:39:48AM +0100, Daniel Drake wrote:

> I don't think I can use that because this setup uses an IOVA aperture at
> base 0xA00000000, whereas generic_pt assumes it is managing a 0-indexed
> virtual address space. So the driver has to intercept every incoming IOVA
> and translate for the aperture, see how map_pages calls:

When you say aperture here you mean we place an IOPTE at VA 0 but the
dma_addr_t for that has to be adjusted to 0xA00000000 ?

I wonder if DT can do this with dma-ranges or something, we have many
other conditions where the dma_addr_t and the internal physical have
offsets..

> I was wondering about making iommupt understand apertures and
> translate accordingly, but I imagine you would want to keep that
> kind of thing out of the generic fast path?

We already have pt_full_va_prefix() which isn't strictly an offset but
it it probably matches what this HW does.

You can implement it in the broadcom format and return the prefix value.
So long as the vasz fits within those trailing 0s. That's basically
free and has no runtime cost on other formats.

Jason
