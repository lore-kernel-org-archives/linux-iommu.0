Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AF25C835
	for <iommu@lists.linux.dev>; Mon,  9 Jun 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479647; cv=none; b=Z67UAkyfRb1UOMsuGr7mHZGTju9zSmxxfpmpMj80YzgRdjh2q1SQ6bBrToZqK5jenZTlo6ELRiBK6+ur5q1UL7A6x137dOR9j4HAQmvh665Y0UuO9UPcAwSpSD/g6uRY239rTi/bBx/FDKJ/ayNlBq3w22q8L8yiLdj+uCykOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479647; c=relaxed/simple;
	bh=RncucRipf1cYTuMs00M4ActoK6bvKzfNJNtvT9JpgjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DkyMZTiIyzox37V7GkaXBz8rRK7CwPWW0ntxHkocDXFlvz2iNUTAM5dz1FlUTHy0KzvyFc0u8cIoeKqg0v92kO9S+VwTICCecYwBXnqch7rkEdw/527jVtJJ5SBzaAiv99TvFsbhjcrr8owPIEpiO/icZb9Jqx70ERCQb1oWR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qbh/Dd89; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qbh/Dd89"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234aceaf591so29514555ad.1
        for <iommu@lists.linux.dev>; Mon, 09 Jun 2025 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749479645; x=1750084445; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=skrVgnKxd0KDctgtNsrczTFq3oqZuzABurM/ZDk3Ink=;
        b=Qbh/Dd89vsL0ipYQytEFMH2krrz7rd6SxaIOt3k/xuu/b6OehwehvvETCrDaQA/efz
         EYuoGSZq6+gfuFaE+Bk2iP+GNLp4AB1GFC/BqQfYnVt4GpCHOmG+b6IGgWNyirWO7BCA
         WqabVWVqqTyYdTl8mU0awyzchEk+dBY84lUMhs2ViwWjDEO7GA+pB51e/Gal1T2ia7Dc
         NJ7ytG+nfWZnF2dzvXoBoXB2+V5XQyWw9y2GLuaXWJ3fKz+PR0nhmEbYsEXE8tsLqOIS
         ik/6XZVgMttw68N7ErQn+OG2LTwEDdNFNkwgjkoRs6UO3Wq8gyeqXsDXZvmwlceVmlIe
         mdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479645; x=1750084445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skrVgnKxd0KDctgtNsrczTFq3oqZuzABurM/ZDk3Ink=;
        b=wyg7LQMOuU+Qlz/Uf0ZcdZKg2NJDFkh/tX53nILJWE8YARmLGU4uAzxsQu5CmASj9b
         5HTA+S1wvKmJ0ag2CiGsTvRrtTTry4bb7VjY69wOi2v6wIps4mRSX0EpLNumlpNw232L
         LFKl6wEFp4lmyJbnAaxfow2B5DiXRdEb8B2U5xuzEFNXFUOkmvmLxzbosHkJnJ6+yXGE
         TZ5cniVKFZQnjMy/4SlQwYmwP5fcu7LdjXCBc8Pk4oHXvlRP0FLwxGwlyR0UIicdBtyS
         T7JVp7G2LW65fE44s5KHho2u2ZtUVh1MaMLSrstjWGNS1yx3eCDPvnLBEMxNqGPmKODk
         kCrw==
X-Forwarded-Encrypted: i=1; AJvYcCWLoH4TWS6F/6wUFGXFBb4SzcYwkRLfWZTZWLFADSx0atSEtgktyLbSxe/RBoJsdFgQkHM7TA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVtBAkZzE71Qvgd2xYQd5czqazqAXG0OW3//8ToOcDeuK5wOgX
	QRJPJB1TbSBhmACACpPauGXHAlt/ijTOvFWk1WQV6okA46Z646L4a03eER8ZRZXk51TXE+oppiF
	M3p3SzQ==
X-Google-Smtp-Source: AGHT+IG0JGW+2ERvh9VAKD2SYT7EuVC5l/3/Q6a8vdYy73LZU6rmVVJeO2/2xeSR1j2Z/GlfjJU6yRXE7Fs=
X-Received: from pjbsg3.prod.google.com ([2002:a17:90b:5203:b0:30e:6bb2:6855])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c950:b0:234:b430:cea7
 with SMTP id d9443c01a7336-23601cff140mr191326735ad.22.1749479645053; Mon, 09
 Jun 2025 07:34:05 -0700 (PDT)
Date: Mon, 9 Jun 2025 07:34:03 -0700
In-Reply-To: <20250609122050.28499-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com> <20250609122050.28499-1-sarunkod@amd.com>
Message-ID: <aEbw2zBUQwJZ3D98@google.com>
Subject: Re: [PATCH v2 00/59] KVM: iommu: Overhaul device posted IRQs support
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: baolu.lu@linux.intel.com, dmatlack@google.com, dwmw2@infradead.org, 
	francescolavra.fl@gmail.com, iommu@lists.linux.dev, joao.m.martins@oracle.com, 
	joro@8bytes.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mlevitsk@redhat.com, pbonzini@redhat.com, vasant.hegde@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 09, 2025, Sairaj Kodilkar wrote:
> Hi Sean,
> 
> Sorry for the delay in testing. All sanity tests are OK. I reran the performance 
> test on the V2 and noticed that V2 has significantly more GALOG entries than V1
> for all three cases. I also noticed that the Guest Nvme interrupt rate has
> dropped for the 192 VCPUS.

Hmm, I don't see any obvious bugs or differences (based on a code diffed between
v1 and v2).  I'll poke at the GALogIntr behavior just to double check, but my
guess is that the differences are due to exernal factors, e.g. guest behavior,
timing, scheduling, etc.

IOPS are all nearly identical, so I'm not terribly concerned.
 
> I haven't figured out what is causing this.

Might just be slight differences in guest behavior?  E.g. did you change the guest
kernel?  

> I will continue my investigation further.
> 
>                           VCPUS = 32, Jobs per NVME = 8
> ==============================================================================================
>                                          V2                         V1          Percent change
> ----------------------------------------------------------------------------------------------
> Guest Nvme interrupts               124,260,796                 124,559,110             -0.20%
> IOPS (in kilo)                            4,790                       4,796             -0.01%

Uber nit, the percent change should be -0.10%

> GALOG entries                              8117                         169              4702%
> ----------------------------------------------------------------------------------------------
> 
> 
>                           VCPUS = 64, Jobs per NVME = 16
> ==============================================================================================
>                                          V2                         V1          Percent change
> ----------------------------------------------------------------------------------------------
> Guest Nvme interrupts              102,394,358                   99,800,056             2.00% 
> IOPS (in kilo)                           4,796                        4,798            -0.04% 
> GALOG entries                           19,057                       11,923            59.83%
> ----------------------------------------------------------------------------------------------
> 
> 
>                          VCPUS = 192, Jobs per NVME = 48
> ==============================================================================================
>                                          V2                         V1          Percent change
> ----------------------------------------------------------------------------------------------
> Guest Nvme interrupts               68,363,232                  78,066,512             -12.42%
> IOPS (in kilo)                           4,751                       4,749              -0.04%

Uber nit #2, percent change should be postive 0.04%?  4,751 > 4,749.

> GALOG entries                           62,768                      56,215              11.66%
> ----------------------------------------------------------------------------------------------
> 
> Thanks
> Sairaj
