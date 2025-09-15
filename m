Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A12FC00A
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934653; cv=none; b=E0vdS2dVDy+whXUNIBP8icNHjQbk6kJ+fHgeer41xKtT1sz5KgmxPtTXYRBu5IcZEk3YBv5IPNlPh77elXrBs1AE3GM3aXc6kht7p4PFK1cBcJKfvwQdUAtzDSuri4aiwFnNaP+t9Vu8OJ2qfUYOU19viJz9nkF5DdIXYiFCxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934653; c=relaxed/simple;
	bh=UHoIfOvz+vIBIU0zeRizh5s/hNzNrzFEeDKSaEZGi+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWfnlt9eP+MluDx7jlHXbbaREiD+dI7qO5zzId4TXhR/5oBPlcWadY/zyJHECOKoaRFNJbFJ8Rtu7f1uffUsHZuGh3JTK54SPFZtRgSYiZ0VmsQtVInRmCPv9UhDG6bCYWsIsfEg+YCpTwF/kIgw3l1q/W2geSzlDBF/TAoaKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTEqITfg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTEqITfg"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24cca557085so344815ad.1
        for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757934651; x=1758539451; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGVw+dkj5nfYxmjH5LY4ZgVFCM7KXPpME6hBvdzBkGc=;
        b=kTEqITfghKf8X41dIukhQDfiJLng/zzCCUeudQH/DjrJIhkNyV3TbOjNJZsbRpg4un
         BDL/5i2S3uV+r5j588ghOeMUpoY8wHfG7lHSQJmakavonDvpsiT3Lxe0boNhCCme1MR+
         QCoOiw0l+wFKieYhaOdtTA1Soc4DdvpfNxlJE561rM6U0l7I5A4UTwa7Wqxxx/HXmMMv
         YxLy1cYvZ0PdoSaxBzALQkw41vp4xLSEhQjq3s1VdlIYxegsAaML8YVsOLpnVfKmmGbX
         QIPA5dLmDdzxmLSm9n8Ga8nBP99YiXatqo7jA4Pj/IG5V9kh9+i3emj947fpTSxHWHtN
         BkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934651; x=1758539451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGVw+dkj5nfYxmjH5LY4ZgVFCM7KXPpME6hBvdzBkGc=;
        b=Y+IL1fj7DB9sDs77s7ldD/ieSXt3IlEnVNJGoEVSwRkTYopIcheGa+dvCVu1GsODNn
         rKBY9jyeA7RLn2099YQJgLWvLu+M2jgpQFkny6mfBx0kMsZniaJVKAOJH4Lt+CV2C5OR
         xDurTly+wxSEzP/seIoM6PxfB5vUvUQyRvcWPAykewtGfK95SrZZjv9vmAjHn1ikz5JV
         9EfvVusqmuR6LEa2TDxQ//OBNzCq5U1+Lx0NvH8oWP300tRo3jUdceQmzgJj19Wx1o50
         JhUHxlhMvbbGaYkA6KKuybGLRZlNz3cSl/CaBWlxyiOxxIzjW86l9HCdWClVwGbk+Xb7
         pLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOWtQ+gHU/IoCeXMg5PEJVhOPz1Z8VDG5IpgQxDuXn6iwXYcTVIZok/XgiIic/wev40X8QbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxehgAZVTEdpu4gosqQi4g/oGibz5ej+o4KdCn3hVasC3Ondg9f
	2l71Q44g6ubbhSivPPoN4bfb9ctIhuoe6WFE4FE7121siBYbTN+98PS3eIcrNTL5nQ==
X-Gm-Gg: ASbGncsyjSK6fzDL85FNTli1O5C1b9nQVdCLJ2TzFp08vZRVwaURU6xB9VAeO3TBbqC
	TzqINSyfH2M13JC//fSrWrl6gEmM7E0hJdy+XGYwkhXg5TVl3kIfUkatpLf7La70m4obX8JPKUA
	oIK30a2nwhku6a+BxYWsHS5wRDODU1SV+EKtgTGdLPQMhy4Pe+plfIOD/wDA9njXOMfCYfsHAFZ
	fuw+2eZ5rsXMNqiX7y4h93S8cJXt+0FfHzVqYH0wo2NntSehZ4Wg8s59LB+HMZUv2hHMgBCebpO
	il5ZJaLFhe4U2J6+vRvlk5JlOc64t8erCRK6GACKMY6YpLaIlrA6SggHxpaaBJWwnk6PE4umipN
	MvNJ1NvioBoSfjImoJePO+pJtN69YUWa/4xcdZ84hBruEba36PnBvE09JZq9sb9y9AL+vzpCBtw
	==
X-Google-Smtp-Source: AGHT+IGldm5kVklLwWI+W0luGJJTP/Fy8rtLyArOHHmGPz2Td1ttKApb5Hb7I95Cb8Bwiryv5S6sUQ==
X-Received: by 2002:a17:903:1b08:b0:24b:1b9d:58f1 with SMTP id d9443c01a7336-260a27af356mr6498255ad.17.1757934650882;
        Mon, 15 Sep 2025 04:10:50 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26175efc667sm64942635ad.112.2025.09.15.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:10:50 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:10:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 03/28] KVM: arm64: pkvm: Add pkvm_time_get()
Message-ID: <aMf0M72p8AEEoTny@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-4-smostafa@google.com>
 <aMA2ugNakqrA1Pg0@willie-the-truck>
 <86frcvd3hb.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86frcvd3hb.wl-maz@kernel.org>

On Tue, Sep 09, 2025 at 04:56:16PM +0100, Marc Zyngier wrote:
> On Tue, 09 Sep 2025 15:16:26 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Tue, Aug 19, 2025 at 09:51:31PM +0000, Mostafa Saleh wrote:
> > > Add a function to return time in us.
> > > 
> > > This can be used from IOMMU drivers while waiting for conditions as
> > > for SMMUv3 TLB invalidation waiting for sync.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  2 ++
> > >  arch/arm64/kvm/hyp/nvhe/setup.c        |  4 ++++
> > >  arch/arm64/kvm/hyp/nvhe/timer-sr.c     | 33 ++++++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+)
> 
> [...]
> 
> > > +#define SEC_TO_US 1000000
> > > +
> > > +int pkvm_timer_init(void)
> > > +{
> > > +	timer_freq = read_sysreg(cntfrq_el0);
> > > +	/*
> > > +	 * TODO: The highest privileged level is supposed to initialize this
> > > +	 * register. But on some systems (which?), this information is only
> > > +	 * contained in the device-tree, so we'll need to find it out some other
> > > +	 * way.
> > > +	 */
> > > +	if (!timer_freq || timer_freq < SEC_TO_US)
> > > +		return -ENODEV;
> > > +	return 0;
> > > +}
> > 
> > Right, I think the frequency should be provided by the host once the arch
> > timer driver has probed successfully. Relying on CNTFRQ isn't viable imo.
> 

Are platforms are using DT to change this value?
Because I think TF-A mandates [1] this value to be set, from the docs:

BL31 programs the CNTFRQ_EL0 register with the clock frequency of the
system counter, which is provided by the platform. 

Even the TF-A porting guide [2] mandates it to be set.

> We can always patch the value in, à la kimage_voffset. But it really
> begs the question: who is their right mind doesn't set CNTFRQ_EL0 to
> something sensible? Why should we care about supporting such
> contraption?
> 
> I'd be happy to simply disable KVM when CNTFRQ_EL0 is misprogrammed,
> or that the device tree provides a clock frequency. Because there is
> no good way to support a guest in that case.
> 

And even if someone choses not to use TF-A, IIUC, doesn't the aarch64
linux boot protocol[3] mandate CNTFRQ must be programmed with the timer
frequency? As per the doc:

Before jumping into the kernel, the following conditions must be met:

[...]

- Architected timers
  CNTFRQ must be programmed with the timer frequency and CNTVOFF must
  be programmed with a consistent value on all CPUs.

Thanks,
Praan

[1] https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html
[2] https://trustedfirmware-a.readthedocs.io/en/latest/porting-guide.html#function-plat-get-syscnt-freq2-mandatory
[3] https://www.kernel.org/doc/Documentation/arm64/booting.txt
