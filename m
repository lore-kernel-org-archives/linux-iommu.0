Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1B2A1C5
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378980; cv=none; b=rHbAPvwpiHMt/ZE6Dw6yL8BYTATLfc7gWzhNOdTORO1ouSlpCvioUFahXeMk6QrM0i8Iydp0i786A4O4mLzKyWh829BiVOHRGXlWKBsL0mojCbzREiQ377OufJFGff1Snmd8M3bke7FOh3wIFW6KYwLXwe+xcUoYqv5bcjR0jUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378980; c=relaxed/simple;
	bh=Mzgy4Zfk7DBRAXkLZqlzskQY/R1zzzcOZXHvCA6PQXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQwDYpDxkAnGzvcaLjMkfVg7QeUOKrq+As4tK4I+Bk/jUZoiB/+JptwQnkfswNMckTTtNqiEAqlR5vHugBNPVcww5KcyqsijGVqcE6QQ6Du1FG3mcL3Q93ShnlzvSZ7Xpb4QmI4TZHcAcyptpEM844nCQS8XAKDQJGA/+jaXX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dupU4j2f; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dupU4j2f"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d8859d6e9dso3377117a91.1
        for <iommu@lists.linux.dev>; Tue, 03 Sep 2024 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725378978; x=1725983778; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWzaB2zVBiJq7ajI0wtzRO85aFP0qg9gF2s4BJREzmU=;
        b=dupU4j2fSjbuRPhcSIPlTG6y39f9Ks5/5xHvFw5evc1o4wnPZKH4kucF9MaEuov7a/
         RAu2dv/elaH+iBDQ/NBk/XOdE/J5wEqo1sPpZhNJQhieC20RQqq7RsOfjiDxMgoblhAA
         4VZmwIUvW6eyigz9Ki81A2rRn7XFnqcmplP2rbjDlfpc9GNvbXH/uYJ+uV9gl2vP5Ssc
         1ZZ7U5X4C4dprj8sCpB4eTARXWxoWi8a9JcWa2WBkDeXgNUi1fwXGYDLuhK1y+t+UYq7
         9F8a6hW4wOLwjg4/lrTZqEl1vlxXH1LBrXVwJZy6m/7yIY7R4v4VuzapUNXGu7suRSou
         AlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378978; x=1725983778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWzaB2zVBiJq7ajI0wtzRO85aFP0qg9gF2s4BJREzmU=;
        b=wzlTH+sjZEN8tsc/nZNxhpHaa3/SRssnb1lkZnp243lN6cCITXMqizugpDGxB9Lv+m
         b8ors3sRpnEZNI5ob0nxlb7ac1U6cLKk7pJxToKCXsVa+xDwGP3NS2CI+KNPw7K0cKT8
         C8WWfopxHBvFnvxHETWylUt9fb5wLJRTzTTxTSRDDrHX3BKQoCO4k7IXiGEVA5U9HZLR
         dPxYM4AeMae70z53wYzWTk9jKcgjL1OwAq0ViptHgJlLcIgAZZ7ZnW1eWr8WxwOgTNaR
         lCTeH/u3dD8CXnL95e72yWDmOiJmBVqogO1nU1vPj7x6o+FVgOeFI7RAqS1uC9aMOW6j
         TjXg==
X-Forwarded-Encrypted: i=1; AJvYcCVw9ykRTfPAyZn6+TarN0HpOVhsi1f5Tl144tzY1vsiOvtOfPNFhlCg0a3qoB0uxr2XF/tW8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsIPg7ZUpYt/g/74goZCloKNLunQr2L5D/XK2s8//jSyFn40S7
	r32m/dLR8NBu5432iytalXr+jR4fhPzfUB2m+azF06tMjrBE89tfRIvvTDi/KUtF7cHDB78D9Rq
	4bw==
X-Google-Smtp-Source: AGHT+IEU1849ih3tqcS05odvzRPeJyVpF9Fkthp9R0njzfPmkPWPuM+m0PM+Icyr5mRhgGWG26r/jNAQht0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3013:b0:2d8:9dd1:d9aa with SMTP id
 98e67ed59e1d1-2d89dd1da1emr23806a91.8.1725378977841; Tue, 03 Sep 2024
 08:56:17 -0700 (PDT)
Date: Tue, 3 Sep 2024 08:56:16 -0700
In-Reply-To: <20240823132137.336874-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240823132137.336874-1-aik@amd.com>
Message-ID: <ZtcxoPl302h77pb9@google.com>
Subject: Re: [RFC PATCH 00/21] Secure VFIO, TDISP, SEV TIO
From: Sean Christopherson <seanjc@google.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Dan Williams <dan.j.williams@intel.com>, 
	pratikrajesh.sampat@amd.com, michael.day@amd.com, david.kaplan@amd.com, 
	dhaval.giani@amd.com, Santosh Shukla <santosh.shukla@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Alexander Graf <agraf@suse.de>, Nikunj A Dadhania <nikunj@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 23, 2024, Alexey Kardashevskiy wrote:
> Hi everyone,
> 
> Here are some patches to enable SEV-TIO (aka TDISP, aka secure VFIO)
> on AMD Turin.
> 
> The basic idea is to allow DMA to/from encrypted memory of SNP VMs and
> secure MMIO in SNP VMs (i.e. with Cbit set) as well.
> 
> These include both guest and host support. QEMU also requires
> some patches, links below.
> 
> The patches are organized as:
> 01..06 - preparing the host OS;
> 07 - new TSM module;
> 08 - add PSP SEV TIO ABI (IDE should start working at this point);
> 09..14 - add KVM support (TDI binding, MMIO faulting, etc);
> 15..19 - guest changes (the rest of SEV TIO ABI, DMA, secure MMIO).
> 20, 21 - some helpers for guest OS to use encrypted MMIO
> 
> This is based on a merge of
> ee3248f9f8d6 Lukas Wunner spdm: Allow control of next requester nonce
> through sysfs
> 85ef1ac03941 (AMDESE/snp-host-latest) 4 days ago Michael Roth [TEMP] KVM: guest_memfd: Update gmem_prep are hook to handle partially-allocated folios
> 
> 
> Please comment. Thanks.

1. Use scripts/get_maintainer.pl
2. Fix your MUA to wrap closer to 80 chars
3. Explain the core design, e.g. roles and responsibilities, coordination between
   KVM, VFIO/IOMMUFD, userspace, etc.
