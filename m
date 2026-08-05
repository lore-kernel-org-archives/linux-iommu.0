Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABEE477E53
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943585; cv=none; b=XNJhBZiYYfRAJhGzx4YJ7rhHkFz89V/qxlgYV/Vd/6XcHvXVAcDhljm/ve/3pk9eUms7FbHOUNsWHr/YujXWSBPcxeSUEjeW3/NVMiwZkaTxe+Hby4Ja515s6zLfVJgZQUMAmTlmP0nv/e4zH5nYYhBejLOWowvSbyX0/YTtamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943585; c=relaxed/simple;
	bh=k2dfPXeOzAHpRioWn2Z8dsyVF7DcClGaHxC6ZjFMKf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx1eP7hEfxDtx/1xAQ4dXebwPxv7/wvBXfBibwQwnH87KA0ecGsQajX8p798C3RfUW8rzUo2sWdIvQ39sfOu0oUtY8VGZMwyCjwTWHli7opf1AuJdK/QGAfD9dGYh1gQQDOoWNTvImfC5S2Q9MiqKZ9v0sHudaSEaC4oNZY7vr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQJKtFo5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQJKtFo5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so10544a12.1
        for <iommu@lists.linux.dev>; Wed, 05 Aug 2026 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785943572; x=1786548372; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNRmrl2B/brOKHnxIA/lHQtuwZlyNTPIK3U8kLKpdDc=;
        b=rQJKtFo5KkAcR8QutQ/+pnH7sUNsKnCB0rBKoIgfR7ndQlVK4l6g7YxbJR5uhG++wY
         ZJZ3VdFL1hbpbnspNa+5s7iIh9887zQXaEWObefCQmVFPPopzYaVYm7gnBnX/KASOTqk
         lscifaJnHYyRdWVikqyyH5acOkP/y92beNJdaAwukygu1GptTnhgruXLmtRzxeK2V8Z0
         DPpdoqz09sQPqhEt1hvyMjBnUVscdoZrUjmXiZgsHkqwqwBexi7+ImZ4235qDDxQpKQz
         wq9zUKTZ8yN2ieZHE6ICnpScjPIIbduRohl7bc7ZiSVHie1FCokIOaZJMZr/Jajj2SZX
         yFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943572; x=1786548372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNRmrl2B/brOKHnxIA/lHQtuwZlyNTPIK3U8kLKpdDc=;
        b=Ky+oN0YafSMNu1Tq1G40Y8uYhl0gpdQ4sDRzeHcfMRgRF4xMxAaRwYamG68xNH0SOp
         VZAp4gYAXwZAwz0UBDwM9KuaYcBXI9gPGNKoE/pMPeiIHdkEYSVqXjQLywRVijP1jTBD
         0F8nBCIzDOBavWwtLsGZfYI7CiuTzPB59pU14orQtv+ME1qdzXRfxsdweCBOY61sBNos
         neC5KUdgKfIB6QZ3i6/5Tmp5peIybMKWT4Q+he2TMy3i5rIJoJg0VuJdhfrvk3AyZ+lo
         AN+uvIaZJ6HcLk7xnF7z+DeOGBcdjZLvxYe9J+7L0eBvFWWC8cSTbY5NDD5JlWbjlZKm
         5fBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsMpOcNkiLbaJAbVV4Uo/JNAA/7r8cM1VCE3LtG+sAJEyPdFBk/4M0qYuZLugJ/FwkaeT4sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YywCcPFvO8icu7kpqwOwV/GxCxh7F4qeKJo2MFrtVs7FeE8X3Gy
	Qb3Z6Lq/Tdcv42A1WR8xxHBp+OpBncLDWYOmagTJyAf1d4lJ5oA397s3LYbJXGLif0pVM8d3lla
	vexM2Tg==
X-Gm-Gg: AR+sD12J+HLGFx3QHZNFvcWfUKJGZNqaVj1oxg0ohKVI9iymeVW7iNfO8/4YY1o1Rza
	up4yZz5p+sEEuZr4c/FjVGzcZrqz395Kka+QJy/VdJMUgLZOZCCnTfiwrC2Ewf/UCYdx6l2oauH
	b0Q2yzeI9W4fYIlpGeWzSrkNt991c2IlIb/SmWYcZYjh0Ld8rzz65LqRwOSSDgohZiHZG+Z/rbP
	UAuWi8xt1kOQ23HQKvEO234KhrdDxGzY1adgu/gvngS1oES7WPuFMWukgi6mR6ZHSqXDBgz3x5b
	kQ15m8DpYHNlQP3RkEUoakXIZ6UUgAzAOhcdO3rHyj/LTd0wqJj8sXnExXnioYj82RaXYhYqTLw
	1QpyfND71vc+8fQGACLnorkJwVuMTKc0Z109PR3hbL3BLcHR8xEEu3z+XRlQumSQk7Ff/16B2WV
	ShpPmxcyuSYmnpwH8ojILgD8PV7sNSql407OHKqR60Iusga2FkeB8naVBPVckDlI+JWL2tOQD+M
	suR0Khz7eGj+F9geWSQJbtVzA85pg==
X-Received: by 2002:a05:6402:44c8:b0:697:7f69:48e3 with SMTP id 4fb4d7f45d1cf-6a14fc7db15mr77076a12.10.1785943571545;
        Wed, 05 Aug 2026 08:26:11 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a17c55aa21sm1309954a12.21.2026.08.05.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:26:10 -0700 (PDT)
Date: Wed, 5 Aug 2026 15:26:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, keirf@google.com
Subject: Re: [PATCH v7 02/24] KVM: arm64: Donate MMIO to the hypervisor
Message-ID: <anNWDt4fNFNkbSdO@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-3-smostafa@google.com>
 <anMwxy9gEEt_Wu6M@google.com>
 <anM9sk_gXTt5F1Ie@google.com>
 <anNPPrjGd2Z2dSwc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anNPPrjGd2Z2dSwc@google.com>

On Wed, Aug 05, 2026 at 02:57:02PM +0000, Sebastian Ene wrote:
> > > > +			      KVM_HOST_INVALID_PTE_TYPE_DONATION,
> > > > +			      FIELD_PREP(KVM_HOST_DONATION_PTE_OWNER_MASK, PKVM_ID_HYP));
> > > > +unlock:
> > > > +	host_unlock_component();
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +int __pkvm_hyp_donate_host_mmio(phys_addr_t addr, size_t size)
> > > 
> > > This function seems to only update the host stage-2 annotation but it
> > > doesn't destroy the hyp mapping.
> > 
> > Yes, as mentioned above there is no way to destroy it, and this was
> > not desgined for frequent use. Typicaly, __pkvm_host_donate_hyp_mmio()
> > is called at boot per area/device. And __pkvm_hyp_donate_host_mmio()
> > is only used for failures.
> > 
> 
> Yes, I saw that you only allow the call during the init pKVM calls, however it seems a bit fragile.

Why is it fragile? Nothing is wrong with leaking private mapping it's
not real memory and it's massive, and given that this shouldn't happen
and will cause KVM to fail on the system, it is not that bad. (as
mentioned all other callers do the same)

> 
> > > 
> > > I was looking to make use of this patch in an upcoming posting for the
> > > v2 ITS hardening but in my case I don't need the private VA range
> > > creation.
> > 
> > I believe if you need to map MMIO, private range is the right way to
> > do it as the linear map was mainly designed around system memory.
> 
> Is there a reason behind not having MMIO as part of the linear
> map in the hypervisor ? I would like to avoid holding the hva around and
> just do a simple addition to resolve the hyp_va.

When the linear is created it only considers the system memory layout
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kvm/va_layout.c#n82

Which means that on some systems an MMIO address can be larger than the
linear map.
There is another comment about tha also in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kvm/hyp/nvhe/mm.c#n420

Thanks,
Mostafa

> 
> > 
> > Thanks,
> > Mostafa
> >
> 
> Thanks,
> Sebastian
