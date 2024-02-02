Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DDDF513
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848875; cv=none; b=tP4+WupibppTKSBdszLVkBY71Ru0EO+X72XwTTVZggXRewCfCrKit65/C/k5gfp+tuuf+aqUeDNMCeA8Tvh6xBh5qLy+E51t4JQUc6Yfth3g5GxwbQSIg4rrJqD4JIJ5gI8p2rKsWniQ7iyxeEWeW+5Z2kATPQAaoN0xINID5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848875; c=relaxed/simple;
	bh=/pB71NBkTE0MT14Da9dzFzR+degq732UxHP/HWHbMgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7oU4kL6MSp+GX1YHT29DmXHFDJCkVqLaE5RZPy5AUG++2RnuWERJqI2zWmKJ36IdEndgO7HEG8cYVJQWlg7KHNNyhf9oxAhm8eInk23+WoF38dx2u2hiAXb3YRvNFURnkOzqqCoAFWi9N924Vp5eZqtv2Jx0RWqzJaj6kMvnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBQH5Dfd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBQH5Dfd"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a35b32bd055so216624166b.2
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 20:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706848872; x=1707453672; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRhBf4Bx7DrVWvh5cmLuWZexlCXbaWG6blbF9sDghb8=;
        b=GBQH5Dfd3XLDnmvKlS2Zw3XCJNrNVfxao8LDJg7fp75ewP0IKt81sW4MwuyeQBIoU3
         IzhWgAOrzcdXSb1gwEXcY954y6chobWTEKH1mRi1/DmZyz4PE4Us+WHdLMhJWbHNC5Ab
         GwSuIWdwL7cYihqV3QrMXh5Wy/kV13I5b+V7cV2l1NGnE6aNpV4aRltjN1sZIj8xWCLp
         YM9RlVkOgVQ/qssey9+SX1bshMND9yWjgBr4YE+aqECFr6GCsh3jsBPO8vUkHdhQwvUo
         onUAyQDt5UezRSwmPRKrEKtCfcvLgCT3nb3dE12eJ+/FwHiDqB3/mFF57ACvgoHlm3dP
         d4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706848872; x=1707453672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRhBf4Bx7DrVWvh5cmLuWZexlCXbaWG6blbF9sDghb8=;
        b=FYSxT8q25Hq9EF9KYsQJYjJy8IUFbZWqqa3kgIGr09zR4/sf4dJAG+a5T87k5JY8fL
         IT7mp3WhHXll1mAoM6eBPSTW8LgttHwaByofuMcQ2VHGXrSHicH7LCgHYxtWB06GoTXx
         saiF1DFxPAdingwAw7cnJ1lRiq4llhAjNzLTQ1RyRQQal0CVjN0485Qz0YPAinBcN4f5
         WfmKEkWA3XCJyZmXiL4UiBd3NxQm/qtE5ML3Y3RL5YxZAKeIM4TJ+KBpquC9xo6O3r2i
         /2UwaFassvaPp/GWsGQ3yVYeb6ghbFq486u3JeIF68SJSF+UNKSZzysFabwQD0g+UlhG
         jrtQ==
X-Gm-Message-State: AOJu0YzJV+7P/t6lT8ggyUCu/cCK8da3wB4LWZajL5VegiR1/giFj43y
	J1cA/YV2ws+lx7NyO0Adz0KnnC9QWPVZJEZ6FcpfG8OOKUiu1jwCH89IVXaRRtZb4liyLjO3zoA
	Q/KlCDBIbwkffwWpp0KiS6C87l+TefmrJYDgi
X-Google-Smtp-Source: AGHT+IEVE5Y3uH5AqP3V6QPyHqLgJU0azKUT5CeTH/HmRivo8ARRLcdrlEqfII1PGFRkUc05mpeJSMRCMT6FSFjC8i8=
X-Received: by 2002:a17:906:30c5:b0:a35:cbf1:c254 with SMTP id
 b5-20020a17090630c500b00a35cbf1c254mr625339ejb.11.1706848871298; Thu, 01 Feb
 2024 20:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-4-vannapurve@google.com>
 <0fda610f-a8ae-4133-a9d5-e9084c88ba7b@linux.microsoft.com>
In-Reply-To: <0fda610f-a8ae-4133-a9d5-e9084c88ba7b@linux.microsoft.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 2 Feb 2024 10:10:56 +0530
Message-ID: <CAGtprH_Kr+PfK5MxcoYB3fhQZ7S4uaxQz7Lr+ZN-nbshViG4hg@mail.gmail.com>
Subject: Re: [RFC V1 3/5] x86: CVMs: Enable dynamic swiotlb by default for CVMs
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, kirill@shutemov.name, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:50=E2=80=AFPM Jeremi Piotrowski
<jpiotrowski@linux.microsoft.com> wrote:
>
> On 12/01/2024 06:52, Vishal Annapurve wrote:
> > CVMs used SWIOTLB for non-trusted IO using dma_map_* APIs. This series
> > will ensure that dma_alloc_* API to also allocate from SWIOTLB pools.
> > Initial size of SWIOTLB pool is decided using heuristics and has been
> > working with CVM usecases so far.
> >
> > It's better to allow SWIOTLB to scale up on demand rather than keeping
> > the size fixed to avoid failures with possibly increased usage of
> > SWIOTLB with dma_alloc_* APIs allocating from SWIOTLB pools. This shoul=
d
> > also help in future with more devices getting used from CVMs for
> > non-trusted IO.
> >
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  arch/x86/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 1566748f16c4..035c8a022c4c 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
> >       select X86_MEM_ENCRYPT
> >       select X86_MCE
> >       select UNACCEPTED_MEMORY
> > +     select SWIOTLB_DYNAMIC
> >       help
> >         Support running as a guest under Intel TDX.  Without this suppo=
rt,
> >         the guest kernel can not boot or run under TDX.
> > @@ -1534,6 +1535,7 @@ config AMD_MEM_ENCRYPT
> >       select ARCH_HAS_CC_PLATFORM
> >       select X86_MEM_ENCRYPT
> >       select UNACCEPTED_MEMORY
> > +     select SWIOTLB_DYNAMIC
> >       help
> >         Say yes to enable support for the encryption of system memory.
> >         This requires an AMD processor that supports Secure Memory
>
> What this does is unconditionally enable SWIOTLB_DYNAMIC for every kernel=
 compiled
> to support memory encryption, regardless of whether it runs inside a conf=
idential guest.
> I don't think that is what you intended.
>

Right, I will have to add a way to toggle this support dynamically in
addition to having the support built in, based on more discussion
around 2M allocations and dynamic scaling.

> Best wishes,
> Jeremi
>
>
