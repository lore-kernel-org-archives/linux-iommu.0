Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646B1E3DDE
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766301; cv=pass; b=eauG/ptPT3vrUmRTmWjbYhRyiMMJ/+Q2JAiPQhJLk94oihlZ1fW/y7p9H6FLDrOqn4a/V1PSqG5tuaoUiSLFNM5B/sdVvjcYvCE0JcVjL+9MAle1jOQaqHVqdlgEtuxBEzHXyBhPrdPMNTHzO2owDVke9qvOOt/7Hr/6FkiC/3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766301; c=relaxed/simple;
	bh=kWEc23GO5qIxiQrzPxnHHaclfVo15f3n3UsjCeW8qhI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/NQMQUVxIiyoH8AmKrK9Xu5bKDXVJnBmAvm3/CsGpR10ujFtkzjd/HJCjffyiGMrNnXh2VFeIM3dSQaQkzQ4uLk3gOG4EpHOXDQQIVJ5iJco+id43aWA4wvtXv7Npu6wjSprHXRUqVmiuSSTgYBFr58LRKKivrWNuv1uzt3kMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvSeMZHW; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvSeMZHW"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso43282a91.0
        for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 17:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784766300; cv=none;
        d=google.com; s=arc-20260327;
        b=oxX+ElxOA9BLL1Y9c5fNZ4coNZkeSidAflreqUxYvXAutLVenskoLOpJopxvQZdLEL
         ThIiXr6iwXyhd/scO5wEIpUI4R99nIvbEwWVn9XmGBNyu8udAaRihFnE58OWnOxxe8Z5
         LLEfHpS37mEicRnDcx/lY+UweWBFFM6Cf0kcDdYSjpF4Pl+wJtmsOVkPi9Fp2XpexLzW
         g8Lm+MENv73gQiCahQIKCMAKUy47K/sH8Lrinz3p/hHU8B+6a3sR6U/IpYPgbxgvw02G
         DNsHkpR1X6DjFpRCaDV2eMfeJep56L4ocIvkZmDjWVojDgQPLf4yshA/DjkW4sU163oA
         rB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
        fh=Os/UELs/r3GXW61hfb4DZpqwQKenLxQxgPY2G6q5iwk=;
        b=kZJchU0sc7Bkipz6RjY3ftlPhHIh1oeIR+cS2OfjLjCnhl4OHRFpOcoyEjfIx7XYRi
         6TZ4Zcrj736g4o7Tiym+bbq/IEz9t11JSnJ1SlRPlnec5cTAJNjiS/CFsdrwZe4MzIwu
         ETnBMwKjOkY4Mfqh9YZreL9Gw/7G8t5fECzda1tMiO5o230Z2auBYZD1qZRRwwBLLf7N
         2rEZ4sM8GepWT27mzUmOytU/f2FGDA4FbWAaUBdEW7rBAz3305sYxEKPGoYfIT8Tmv9u
         RiFQpSkeW/gyc/i+anb/EOvFlkwR4nfSbWRpKQRgazaJUpdAFm0r7iQVGzAfBEgsgd5t
         3g/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784766300; x=1785371100; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
        b=JvSeMZHWvT5KFzFXDsOyftZjeKEC28pFQyM6oQAwjf8IrKsyKdj4Y3tng15876fpn8
         7qMKCldWkzSLIbL4ibF1uUF7eJPN7QKZZqPqzjj0DkroBGH8ZrJpPa4YJZjxHLhN+QTS
         m3lWD4Jl/LfYk3ySmvH8NnyhYuyKgK43xml2+SW7Oee2+rnznDaQ6A255uXg/Nhdn8Fp
         xM6qqxvfNJtGgfQTeCquSH1pK+wSnAjWkUc+1+R4TMuY9b+h+R2u6/7jfiXO9J3w3YbG
         Gfm7nv1EuCgoyDX2omQ455z1ZqNGV/lyfTpJxfjmdfaaw4Pe0cCSc1tkNu5REUykAxRc
         z0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784766300; x=1785371100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
        b=VGTlnk6kzoDYSi5kjfMYkTArjHZHBd0Ip1m2WcRSLqRlFa86xl+FEe3W932cYeRT+7
         ElGyXl2o5dB93u4cYT1JqJXwRdR5NrIPx6wIJxV7R1Mivh5Jss5hPspxb3NKe3FiVuqq
         /8e8jBq1t61v9YGHt4AlGXft/zlNURESQA1R7WPgqEUBc8gLHv138i2qVatwKoPBRboj
         HwAQr1dRoqE98SRUeLxHDoCwWeZa4XJ7LZUzWRCAGAZJYjQzaC1Yh3OQR8W8daRH6T0u
         ndPeBDOxGhOjk8URJPnH1+xeJ1dx41EyOb+MIr5ffwvILxKEM5vA0Q2Rb+hEeW4PWDxI
         g7pw==
X-Forwarded-Encrypted: i=1; AHgh+Rof8t/Xr6XxaL0SIMTDenMwgQoj4mxdNYdPubFiH30S5jOMMf0LiObr/xdwxOFlcGtQzgwq/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMcyyknqS3kVV3rvpweR7Pc0LWK9WEyobJNK5tzh5tHxT9fcee
	ybS8cugvpMtXqldEpHBzwvxyFdT/kGQdMxR9XWYy/uO2z7RAzntuDfNXXD1Bwth2vljbX4/bwBj
	HranPLugOf2cVcO3QaiocvV7q9t3UblMAoZvlwwSY
X-Gm-Gg: AR+sD13RvYoHwgDJvPl+Odwk9ZHGwCekzNEfkk7rQDmipVX5RDmG80sPK63ptV8XC8J
	eHYZAujBL9uDA9X2WBxHfN6855iujFGUBbx8vcnfyp7Qdos3SAtWUY1w6LFeyvf5Lcaqk8WkNEM
	g86hFtKCtjfF5baDOHPOXnnCtzR+L/OZ4qjo9NdLDQcenDwrO++e1DZxmldrBl8C8YQRIV7+TPP
	wmoUldIEDnJXP6gSwvjr6CpIiOoiyTDYFTULnDixxnjwPGFZ8GcZ7ZwZxsHJILfIdD/8Vak4C9N
	rMsOS+sYo5AFb/DpvxKGtVq350sH2ik5BhL3nnaGiTdEJPUx
X-Received: by 2002:a17:90b:4c10:b0:381:5bd6:eb19 with SMTP id
 98e67ed59e1d1-38ec652509dmr815476a91.18.1784766299151; Wed, 22 Jul 2026
 17:24:59 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 17:24:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 17:24:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260720111259.122911-1-dwmw2@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 17:24:58 -0700
X-Gm-Features: AUfX_mwUpcRZcR396JGdaH8WFVBtAEhVFxsR1fJihR2mu_ygz-fygFCraN7fXhg
Message-ID: <CAEvNRgG-K2HOJoMmdMSH0gEuLNhgX2tqUAakoRqEx6noNyU3vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] KVM: Allow alternative providers of
 guest_memfd backed by PFNMAP memory
To: David Woodhouse <dwmw2@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, Kees Cook <kees@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Connor Williamson <connordw@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhou Yuhang <zhouyuhang@kylinos.cn>, 
	Zi Li <zi.li@linux.dev>, Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk, graf@amazon.de, 
	fgriffo@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Woodhouse <dwmw2@infradead.org> writes:

> For dedicated hosting environments, there are a few reasons to prefer
> using external PFNMAP memory for guests, rather than kernel-managed
> memory:
>
>  =E2=80=A2 No struct page overheads
>
>  =E2=80=A2 Easily managed in 1GiB pages (or larger chunks); no fragmentat=
ion/THP
>
>  =E2=80=A2 Faster kexec/KHO live update (every millisecond spent faffing =
around
>    with memory management is an extra millisecond of steal time taken
>    from guests)
>

Also, no need to split/merge pages when converting from private to
shared if the host mappings can't depend on the refcounts in struct
pages :).

> Today, there is only one implementation of guest_memfd: the internal
> shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
> for other code to provide "a guest_memfd". This is an early path-
> finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
> guests on x86 and arm64. I'm planning to build a memory-based file
> system which gives files for both guest_memfd as well as memory-based
> storage to allow things like userspace VM and orchestrator state
> to be passed over KHO/kexec.
>

Thanks for raising this, good to know that there is more interest!

Vishal and I have been working on guest_memfd with HugeTLB for a while
now. I'll be restarting upstream work on HugeTLB after the conversions
series merges.

Vishal, Frank and I brought up having guest_memfd with HugeTLB with
VM_PFNMAP mappings at a guest_memfd biweekly meeting a while ago. The
consensus was that guest_memfd HugeTLB must support GUP and so VM_PFNMAP
can't be the only way that guest_memfd supports HugeTLB.

Your proposal is true non-page-struct memory, which has been on the
discussion guest_memfd biweekly discussion backlog for a while
now. Google is definitely also interested in this.

Frank also described some use cases [1] other than HugeTLB and the
regular PAGE_SIZE pages from the buddy that is currently supported.

I submitted a proposal for LPC 2026 to discuss the interface. What I had
in mind was to have the KVM_GUEST_MEMFD_CREATE ioctl take a "template"
fd. guest_memfd will then read off what it needs from the "template" fd
(ops, like you have here), and the "template" fd could be VFIO [2] or
HugeTLB.

You have a provider_fd =3D open("/dev/gmem_provider"), how about passing
that provider_fd to guest_memfd, where /dev/gmem_provider could
represent the page-less memory, like:

  ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE, provider_fd);

It would be cool if the fallback could be set up flexibly, like:

  ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE,
        [provider_fd, fallback_provider_fd, ...]);

I think guest_memfd should be the wrapper around other memory providers
because then the CoCo shared/private logic and special page table
handling for both host and stage 2 page tables is centralized in
guest_memfd, and also, KVM doesn't have to understand other, different
kinds of fds other than guest_memfd.

[1] https://lore.kernel.org/all/CAPTztWajm_JLpp9BjRcX=3Dh72r25ELrXeGkOXVach=
ybBxLJGS=3Dg@mail.gmail.com/
[2] https://lore.kernel.org/all/CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=3D=
D8ky94SCsw@mail.gmail.com/

> This series lifts guest_memfd's operations into a small ops struct and
> converts KVM's own gmem to use it, so it becomes one implementation
> among peers rather than the only game in town.  It also adapts the
> SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
> guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
> provider->KVM revocation primitive that makes overcommit-style reclaim
> possible.
>
> It's largely AI-built at the moment. My main design concerns are around
> how we tell that a given file is "a guest_memfd", and how we plug into
> IOMMUFD. Presenting a dma-buf was the less intrusive choice because that
> path already has support for taking pages away, but I'm less convinced
> that it's the cleaner choice in the long term.
>

IIUC from this series, you're creating a dmabuf fd out of a guest_memfd,
what does "taking pages away" mean, in this case, from where/who?

>
> [...snip...]
>
