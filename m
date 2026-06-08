Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAF330D4C
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934691; cv=pass; b=Tq6ZLWDN/Xj86dDvOY1DuBXthUYUd2GQxFP1CzlFohOpe73S2WPXqiMJmfOlBKD6+MHOMywEjYH4NJjfxl9V9ToQD61wnaL9CTEAgjiSzIm2NFS82Cwmbt9miYOsP9olaIxD6OZO3O9sJXea46SDsmjgDdpSp4xHlhyKYZbR43o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934691; c=relaxed/simple;
	bh=itDKg5VHTo1QlVDvtR/ptqkY/rb9iX9OeM5STd1MO0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdMjpOcJesz6rma+PZRzht+PkSE/iwqNWecb+X1qsIPBur5L2ntMQ0U7GCpMsJyG5QEZ1cL2Hitft0LXFmr4GafHeoWio1D81sCJLwWoAu5AgyHYR4Srb56QP4WrjJsjX4CstGqqfdv8qgB3FVHDKsYi85PNLIJEg6bI7e+1h/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rX9KEJPl; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rX9KEJPl"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso227715e9.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 09:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934688; cv=none;
        d=google.com; s=arc-20240605;
        b=cMpirz8zzEXOFjzkQ4iJ2sF2vmVkfqcFtEFFZzauGwL5+YjfPwyR5meXDPt2uCBAVp
         92XTo4IK7kDiqThzYS6KzdUQnv2s8sqbe3KVo5/ocPvBusmpSyScQ6RoawdkxEcF+Irz
         CE82BI3U4fLy0qaSx+h+Ll7YnxV/8HcjMbh/F5iixbwsbDpD/59Bb8pmdH3tetd+qzIk
         hmwv6DcdaG/tr4Nc1x7lU07yH/j/GqqKDJlQ/OcqeEuRzHH5+/SdsFoqZ6wQpcYbPUGg
         3W27sEYckkPfFT5ZfH/6gchiTL6dl7JCgloYDQ+p+1dxeNeZd7ZhXF6MC/J4xeR+7/DQ
         KxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        fh=Ljef0Hr17A7VlD2YGv8+Wh2pTNaJohj4wuSD2gEOPy8=;
        b=KiLq+TUsMj933InB6VK7+8o2gy3PSOFhiCQFjp2GqXkN4U0cMb/XY/eBOGAnfGY3oO
         OTy9nvGfYHpugMp4WqEDBh9LWphMvcDUflamrlH+PG7WO8AwvtvQUe7SpXmxQ0E53/m/
         Wjbdo6lUUSQzJjRizJ6l6b1HgdZRBlF8cu35kOxiUQ/N7rDdDFrd9zGMUacdfWXKvUcn
         3N/WypzQVfTlDvwRduplHwtyhs3UMqRyKbVk7z5/GnYFRhWMRhS9BtyPIRTfl3c1mQaH
         fhArG+uZnquGbiiIrGaTVyi28vEZwOGTyAYgPsFWECn5tAs5oE1O/4TYTlbM1FqswtSh
         xkNw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780934688; x=1781539488; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        b=rX9KEJPl+TseWXrAEVZYR7EGLY8PYczlSSfIrhGnscXfRRcGTzLq5tlt0uGlSMhpbo
         ads8NgUbxCTyMLOkweA9BX9zdomtz8WdlChgvEri+R6nR/s5WotNWH8tfxdAMRq7M0Ds
         E86ZqMBNUaoy4KuuBwFJ27XNX44VcbOjdCFwUAK3xWtW5LnPzW+fAUgc4yLUH+Pb3tlt
         QGsldt2/XCU2vb/aXi7FHuOogqGmf32iGGHICxjEN9WUHLAi96jevf7225oLzLUmAL0G
         94gaoGwp5mnLvrpl8pRgM90Sv36Z03AMhizlNkMOHMta+7ijLRp3azA1ck0gt6uT3U1W
         8dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934688; x=1781539488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        b=TglKqftTbF6xKOVnVcOS51zKU8XvyDb5aA3uYAUkdMbXqFylaaSV8BxwKMwzcwIJFX
         oVdTd6vloArbMuaon3IporBO26W9RFb4QGdjhxyvlhlw77LnzH5VU4ccuD5n8po/iQjk
         Kb8lNhdav4tpTlKtEeodbj9IkSu/XhyCoIqp1NA89761aZf8IPKUS4+DnwJhl4eFbNoE
         R59JwqggxVg6LTldQs6P98qJTWtnBoeiRS6uu40KwaNahiU1G1YW7bqyJiwwnNc6681B
         56FiqjuVaq+0t1eb2wO9B9rzIFU6qd6oevBsN9k6xzIXmR7s+Ba4JXH4CekJB/wVanM+
         s6ag==
X-Forwarded-Encrypted: i=1; AFNElJ9SCqpWO6tsAcyEyP9EuvFE4XUk78c9BXZb1CqcRFMYCwdfnRgkdkVTG4tb9sTAaTE2BiRnGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaDYDjt5+YYAL2oBJz2/vk19R52biKhyF2DcKp6ztImj0O008h
	uSxASNyS/bceSuwu5x9/nteSpWwIGy0DZ9Iep/Tn+UN4XXeta7ci6NpPHd5Qn59GzBWV8GV0wcF
	ip2lJgOqaouMlna7/eHqyaTXy25r9pKu/97vobJjX
X-Gm-Gg: Acq92OG7AHrmmj9uKHDfRvb0XTNWDWsQn5UPur385fc+zGtAMue+1+DAMKOerz7izPL
	mk0nev+9DUu9EHAZavgDtqzzJqD3VN+BYUkjmPlXPbIEr7wjky3D5N/sf8ks94jExn3pweMerxZ
	hepb2Vc48EYFS384Ibj9di+IGKr3cqn32W0+mqALKXnLm28YEEUH1DEBkryTWPvrFn/ypelaBo+
	vtxhH0jxdIIiG2tPS44SC5rI7VRA/510fwSFP3ng5zOvrrs3s5+HeZbl+aRidJxjaobSsSbxvpu
	uHC8T+jLHgcP7lifjvG+CKYY6c+p4RkdgKtYwnmycfYSWuIk
X-Received: by 2002:a05:600c:3495:b0:490:b0f1:3422 with SMTP id
 5b1f17b1804b1-490c2ca21f1mr5078185e9.10.1780934688036; Mon, 08 Jun 2026
 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca> <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
 <20260608152743.GD2764304@ziepe.ca>
In-Reply-To: <20260608152743.GD2764304@ziepe.ca>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 8 Jun 2026 09:04:35 -0700
X-Gm-Features: AVVi8CdkX2dlLd8iv_kbStMI93TXdDT01BqcU1-TGKHekXSJtH26ENHtm_IhVVA
Message-ID: <CABdmKX18EXsL48Cv1Kxrp0g6bVndZfU9b5pfeGgQyvMREk5PSA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>, 
	Maxime Ripard <mripard@kernel.org>, Christoph Hellwig <hch@infradead.org>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:27=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Jun 08, 2026 at 08:47:15PM +0530, Sumit Semwal wrote:
> > Hi Jason,
> >
> > On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
> > >
> > > > Given that Christoph's objection is not really about the modules pa=
rt,
> > > > but that the set_memory_{encrypted,decrypted} should not be used he=
re,
> > > > one option is to revert 78b30c50a7ac until that issue is sorted out=
?
> > >
> > > Please no, we have stuff already using this so it would be a
> > > functional regression. Revert making heaps into a module since that
> > > doesn't have a functional regression.
> >
> > Thanks for your comments.
> >
> > To me, it looks like while system and system_cc_shared heaps share a
> > lot of code, their user bases have different needs. It's apparent that
> > system_cc_heap users don't care about it being a module while system
> > heap users would very much like so.
> >
> > I also discussed this with Arnd, and he suggested we could rearrange
> > the code so that system_heap_cc_shared_priv depends on a new Kconfig
> > symbol like
> >
> > config DMABUF_HEAPS_CC_SYSTEM
> >         bool "DMA-BUF System Heap for memory encryption"
> >         depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=3Dy
> >
> > This allows building both into the kernel or leave encryption choice
> > up to the consumers of the system heap.
> >
> > If this is agreeable to everyone, I can post Arnd's patch.
>
> Yeah, that's fine for me for now
>
> Jason

+1 SGTM

Thanks,
T.J.
