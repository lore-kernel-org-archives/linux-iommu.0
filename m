Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307297;
	b=mfNxzZQrYEJcxSl7AwVKuayjJuja+b0MWbSZUO7XanVNaA1vHA/hvKxPMh4vqKbaCjb0
	 I/I5QhEKDVjj0RjmGrmZFdSR2ZTBiPtWyMVyhl3Dg9B4UPH1OGd66KaP/uvWnnA/qEtiR
	 bbRR9UQv6j8WvGZyHDDkVN7qcHS6mjo3WcaaZZQiE8AyFxORqGn+Bk40MZlFGduycxSj/
	 KyglOQkHOeSwkdi+TkKEM6epVHCRtqKrUR9t4ySpz/J+w3cnOC1oDs97JtnfWIBZ6n9Yw
	 y7NZ5wMZ2Co2jrq8r85RWqJCZSezpWnIbHVdldd5n10RPZqxlKI34O47+GQwSnzIlMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=R9ybw6cxS0shDJ4UVVgiEKCnqeSU4VPhRG8DzGKzjow=;
	b=nhpscz+BQXOMVtQRGtdIhAd414QhTWXDTK+WVfh0+rYMEliIusahRdJZF203MOxIu7TC
	 VoPGAUa8CCKXPIvgS+1K2yHCdryWXzJjnHZtAE1Gx45hFwbayVn+SDKciTK3uwrf0gO/p
	 SeW6ID4qj6u73xJA0/mZLyTXV90JUznjPZtw8V7kyITjucBVtk4PrJrFc05PwdICC7wjr
	 7H6gNe6M3YnVra0dzxj/n49wijuIkLvSr0y85sH0NFrrWTUzmN8NDAdI9ceucXbefzk1D
	 5LhohfbK3ykCxuFfwbXZj/a/ABI+aFr2+g/j3dyp/RG2gJI+FAXb4l3ewDmgqCwZQxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UTUVv5rm;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961E606A32E
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 10:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6961E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UTUVv5rm
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso37665e9.0
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 02:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794307296; x=1794912096; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R9ybw6cxS0shDJ4UVVgiEKCnqeSU4VPhRG8DzGKzjow=;
        b=UTUVv5rmYt27Td+Kz1VAIJ3ADB8he8b/1Z2O5ynUmU4caxM+RiMT3OanRLpTLTtjrD
         tVTuFP1c6cnJZWUkOB7e7Dih3pK9zjDOLG4HIwB4Wj34rqxRPuV5JJPvv9/bl2FIkFRc
         E3P7XkrxHfH3nRF5nXGlW28N3FlG+BSpc3gg/KYx5YJUTYGTf5OujuCutuJ2zre1qg0V
         cG78PYnhtpKiYHWo2rlbrUuLtkAvW1peOBv2QVnq5vL+NAnqhS5GAtKOtjf+p/zeMKJ7
         A9uCda0GQrfXjQx/GFSGAgteTqOMvwVxOmKiixzQEB9rI1HVkQyw1JYhKk7nDuoodBV7
         YQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307296; x=1794912096;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9ybw6cxS0shDJ4UVVgiEKCnqeSU4VPhRG8DzGKzjow=;
        b=VCouY4bLSgZYOk2z1pbN7utQqarRxOooQ/63eENK7zbW82qCoHNj/1r+8XlRCEmoKe
         MdkcBjn/6iVu/olh6xPLCsPmBPv2dvR59HN4tLulIbiB3OevTniNOW99qaYFh2/aI37f
         ucmrxiQcMrfp0f+x8MSA5WiXQ9i7SwbfTpUZsElomTlEUyxJRbMpI3mtOxkbBUBoOwiw
         hokzIEQZ+220Rw2lm2xXSOqLOJmbxRlHTc6L2KTR/YcQlk7OpKc5/G4mmn++PnFdIBdJ
         +6wb/V1yiKwtUfAY4kBxfbSEfgzHwANlaN2pSz1zMiq+eG6c8ZprAIIRc7bzzac1TUGW
         7ptQ==
X-Forwarded-Encrypted: i=1; AL+hErG96fsj/szlq5Uozx9itnFP1FmiES6waCcKCf5KRRI4kwq3iAdlDqOW1l6SwvsNHnv2nONurg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8yFqPh6wwVINfTJuUfhvoUmP51KX1RegJ77hAKGJfbgbfn8FO8
	T7CLaYsXQnbt0WKBDkY7X9fqeAQz8GVCQB4slM8Zzc+9CTLL/fysyIsSHwMxvJSqYw==
X-Gm-Gg: AYBFou0p3JSx9Kpd4F94zpEba5W1YkHC+NWIWhxOnG4KtWqthuXWzjGgJGJ8QQDQzjI
	D8tcvydwvPD2JPm0WnKhRJF+a8FceykW+oy5phss9oSoDRWBfCVXstVzBj5BTfhRYpr7wZ8FxwZ
	HiAlZPrH4UKOX7VjKpCF429urElKlDBmCrJs1zU2HumhelQxVA3O5XewrYcjlUeY0s+h+j6smXt
	vE3t7oY4Y8dC/MGFcQnY0vbINgsyiKI/M5+6xRZ5ackMB/GF1trQGpjtd+I/xgLYxiAG2Kecw8D
	T1HAkaRAL7iSzCegnDbioCNlKWdZy5oeVAK3NucAlIWW9ujs+LJZSmWJ9gier0d+HZPyer7Ckt4
	FmbFnVSLdecsfR3dmmk3WYt0yipudT8kPqAFn23JSP5tV3+Df+hB6c0VfHjZnbTQ31ySS4gn5Fg
	xWOkN8xqYWxKhRAFT3EM+Xbps1OM/nww+vq8d7R5wfYHjDPuGwMFBBje4UW4HKnJ8t00+5Yhm0w
	uKdpej21DJ4Q6k7kTY+fc51M7U77G1rrW97BSBmIFKhilJEJf4qGPe0ByhMqUmwTl74SSNvmXXa
	pHg+mFC7ly8y9ZD5i30r5zjUv4l4O2m8HjkLYwiYnRUyPRqDJ7KU2UgUlOKmtrqLncIh5Xw=
X-Received: by 2002:a05:600d:640f:20b0:4a1:e368:cbf7 with SMTP id 5b1f17b1804b1-4ba022dacbemr640635e9.0.1794307295364;
        Tue, 10 Nov 2026 02:41:35 -0800 (PST)
Received: from google.com (160.193.189.35.bc.googleusercontent.com. [35.189.193.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe63e6sm87694655e9.7.2026.11.10.02.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:41:34 -0800 (PST)
Date: Tue, 10 Nov 2026 10:41:27 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 11/25] iommu/arm-smmu-v3-kvm: Add the kernel driver
Message-ID: <avL016l_xASN5paR@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-12-smostafa@google.com>
 <auzvygiGRTWgJXzF@nvidia.com>
 <avGk0ilyJh3obmKx@google.com>
 <avJidXM9yQOX4VBJ@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avJidXM9yQOX4VBJ@nvidia.com>

On Mon, Nov 09, 2026 at 04:16:53PM -0800, Nicolin Chen wrote:
> On Mon, Nov 09, 2026 at 10:47:46AM +0000, Mostafa Saleh wrote:
> > On Thu, Nov 05, 2026 at 01:06:18PM -0800, Nicolin Chen wrote:
> > > On Thu, Oct 15, 2026 at 08:08:42PM +0000, Mostafa Saleh wrote:
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> > > > +/*
> > > > + * Two devices are involved: the aux device bound to this driver, and the
> > > > + * physical platform device bound to the pKVM init driver, which only uses it
> > > > + * for discovery. This driver keeps using the platform device, as it carries
> > > > + * the fwnode the IOMMU core and consumers link to, the DMA configuration and
> > > > + * the IRQs.
> > > 
> > > It would be nicer to have a diagram or so to show the co-relationship
> > > among different devices and drivers.
> > > 
> > > I assume the regular arm-smmu-v3 driver is a part of the picture too,
> > > when the pkvm driver binding fails?
> > > 
> > 
> > I can add some ASCII diagram.
> > If pKVM driver fails, no aux devices are created and the main driver
> > probes the platform SMMUv3 devices as usual.
> 
> I didn't check closely, but would it be safe to do so?
> 
> Is pkvm aware of the missing SMMU device and handling it properly?
> 
> When pkvm is enabled and the SMMU device is supposed to be a pkvm
> device, should it not fall back to the main driver?

If pKVM fails to init for any reason (unsupported layout or non-coherent
HW) the SMMU will be bound to the main driver so the system remains
functional.

However, pKVM will not be safe in that case regarding DMA isolation
as the status quo.
In Android, in that case, pKVM clears the FW (called pvmfw) that loads
the protected VM and authenticate it so any protected VM knows the
system is not trusted. This part is not upstream yet. [1]

However, there is not much that pKVM can do and I think it is better to
keep the system functional in that case than causing a panic or failing
KVM init for example.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/virt/kvm/arm/pkvm.rst#n106
Thanks,
Mostafa

> 
> Nicolin
