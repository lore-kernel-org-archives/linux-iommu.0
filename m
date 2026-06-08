Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21E3EFD31
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931849; cv=pass; b=WurGFjgzTm4uOFXtTCkDz2c5dXoSV5lcGHaG2Tait1JY0Gs8w8gH+Fgc0ny/EI3ohjb9lDD8wXNrswLITRCzRUcjJyv7IXaWLAwEVBC0Z4H0rFWVOqC1dfCbXlBktuUUv1xx0k2R6c6OwCkJG4uWWE8vE+z/91O/mipvYqYJVfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931849; c=relaxed/simple;
	bh=xNi8/se+D6WaUt0MaPlNhEUr89OFCgbXcuKuMyyUBIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHdvxYb12KkVRYO9mP/guHFnkZRW3SUYUT4o0cX/9wilqWJb4ioxNyM0EJDV57Ic26q8gQnMnuRAn+pkeX7kAkxyuby+Hdslx15FoJZ0BU6CJ0NvmJEnKeRgINF9MuU03vqWOuG83yVl3T3usFlfZPCcnqdLs5s2jKmyfEtg4zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EvlSYh5g; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvlSYh5g"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bf1141c26ecso560481366b.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 08:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931847; cv=none;
        d=google.com; s=arc-20240605;
        b=bvZKQVNFst/HZMb8lGZ2U7/AhYrwPnw24QNNKI9XXaKcotI4xBkeeBHe+TiX5FqHBB
         dpl7R2va3dcZRRpW17quEMIjdDOhxEygC30V+PwUC2flgUrhLjFp7xXMdxSYpKbrRRkS
         u+MyQcZeULEd9e4+s/Te/8tTF63g6foQAh1i15ChviyP5mgWW7x1ECIpCut4Zcmf0Ipx
         QGVwpkc/ctSETbXboZkk7ASCdkPBG2NhBnjxnBnOJEliTj9C8cVLdrZZHwQdQ8zgwbC0
         RbGsJUv+MDDSacBbkOFeIcnDzEPzQ27uLxGYyC6bjXbh2Ofz0OVE/NA1F2RO6/2Z0Snd
         qbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        fh=N0jN1dLOB0ea2C9Fsg6rIF/Bf73tEmtgBAHuemklPsY=;
        b=QrKlSu74m61Fa9j2zMFArKnuzzpuUXkjS7ETq8sWuWfFShwVdh3xWbV6Gptltj9UJX
         R00wA3nwXzP1WUj25W/TqZsDPOdmgjd4nhlBYVVfg+97xDrUdS9fdFKJTZHwiVbf5dEd
         hQ+GtKYexpD/nkPsfxPzpBTcVQTsvjDOhyVJtuMckVssHj5Aeo4pUzFhAU8c65+9vdqz
         wqv6rMi5dOU4E3DMcplxyVec1K0ZLL24F74BfF9HcUs9f7Wm36ezRmbZj9hivnl/X4bB
         msJDLDEjlX/su0n5bVVaseDfaMvXtopgBB9drqSPj29eWBp3Fe/zCPFVi1SmQ25GUaDN
         WLVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780931847; x=1781536647; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        b=EvlSYh5gYs0fl5qxB8cCzHIrgiUQFuv2AOnkGS+ngT7v7YsMJC6aUnof+64Z25kvPG
         wv18jm41Vj0xcXoS8+nssofeOJyAKow/WaheZ6Xt33LbTb6OgDNNpEECr5mR0VhN7/eI
         3yD1QRmIyFxThSFC+5ENQeOgFieQgE2CsjFQXjFwS4rDiqQ1glWu1XGR3lhbe/8ZqLt3
         Awy2z00nWiZJRtruuMRjMQeE7CwXBix3fjJiYX8gCV5fzteNLJGVJfjHv4fHC0NFmH4V
         i2IaPHipJeBUIllvhKVlCTqeBMgsG7cNo6GXaLDO/vAHNMuyrVj198aST6ibFJlkYhvj
         k26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931847; x=1781536647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        b=Sjufa7kCOk4BlaQUqH4OGKcC08RuqV49bwusp9iKannac+/uJoDkjbVqakrkwKaghk
         8fjI95VFsSWrK/Vjb+UxIJlMjYDFDu5Dn4nKX0uos3dg8escO19Z/YfWFn7O+nsPBS5x
         3jVEnHtaxMMASivWwEw2y/mlaTZQ+bOxMl744xCbtkIJlH3Hc4h5exK7YPM3aoADCZoN
         mCFtLVm9La6F5XVBDmi3oFrojTpXEooURCaZypOqUf9abtOy5TW1JYEpC/MjYcbbhZjg
         4w+6AZ/L3lG5RQ65cwuPj13e5PovRtnd6DWVNpK9NqoMUzD1h7chqOH+BdaV9eiLvM6Y
         Z4gw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ec/TnP+76yot2vpPItUbeTHSPR/y8+dDnwSDpwf3ZoqI3q6yc+JXsr1g4izmAN1VIP2lPAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfmBu7I66OWDpAKScV6cEhgyRK8PMZ5uBI72HWKigpKvE+MJ/5
	ebPewoiWMtyMi18jvDAQWPDjcIRPXOa6RxMoR7OwK7eztG9SYLfX50t6sUTe/2sWGVjsVK7iWq8
	9bIpUJMlvcAitOadbZ5bY0nMq8yaDTUaArTkgOjBtYg==
X-Gm-Gg: Acq92OFn/TBUVmYd+c+6i0vUwQuZ/pbgBfen0he5I4Sz34YYn2BXG0HjekVp3HkDIrY
	nuOCbfg+vspf4CvllknQoRwzd+VLUORGuqh8grgS1luU8Y+M2yYUdDt/lq4mSc5Z6MFj0tB5PNG
	59SS4J7JfQCTvRrJlkSr5Sz1VJoAf3WbRTslAOVkKZNaO6fNDyHNKH6+zMneKKCyz954STxg6v1
	wRwPuCdnD8MmoG/mDDMwV+EPXhzndgyNWnIiHH1cUlmwPS1U8dw28UzDHbRebYWkCJBD/LAp4F+
	4iqiKCBsSts5n/aTxerTxkpuOIbaSDSUPTmb87FyjKsz9YhpSreNnc/bPnY=
X-Received: by 2002:a17:907:c22:b0:bec:d077:c4e1 with SMTP id
 a640c23a62f3a-bf373ff1dbdmr731904466b.47.1780931846675; Mon, 08 Jun 2026
 08:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com> <20260604135712.GV2487554@ziepe.ca>
In-Reply-To: <20260604135712.GV2487554@ziepe.ca>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Mon, 8 Jun 2026 20:47:15 +0530
X-Gm-Features: AVVi8CdcrMng9NlewA5irjsXERkw9Ix0pSFdV0gf1_HiahCuxCNItaDbqkFH3sQ
Message-ID: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Christoph Hellwig <hch@infradead.org>, "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
>
> > Given that Christoph's objection is not really about the modules part,
> > but that the set_memory_{encrypted,decrypted} should not be used here,
> > one option is to revert 78b30c50a7ac until that issue is sorted out?
>
> Please no, we have stuff already using this so it would be a
> functional regression. Revert making heaps into a module since that
> doesn't have a functional regression.

Thanks for your comments.

To me, it looks like while system and system_cc_shared heaps share a
lot of code, their user bases have different needs. It's apparent that
system_cc_heap users don't care about it being a module while system
heap users would very much like so.

I also discussed this with Arnd, and he suggested we could rearrange
the code so that system_heap_cc_shared_priv depends on a new Kconfig
symbol like

config DMABUF_HEAPS_CC_SYSTEM
        bool "DMA-BUF System Heap for memory encryption"
        depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y

This allows building both into the kernel or leave encryption choice
up to the consumers of the system heap.

If this is agreeable to everyone, I can post Arnd's patch.

>
> Jason


Best,
Sumit.
