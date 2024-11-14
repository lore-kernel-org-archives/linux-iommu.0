Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5421E47A5
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577069; cv=none; b=tYf0hdQPfbas85zAr1fNSD1AjzguweNANV9ahjG0NygUUCgTWhOS8zLv5hEums1R6TDjoy64hwh2OpsY5NHcRVh6zpjaC3U1pfrMNXsPTUemKz5WHD87limtyTUiHnhduTzB4yPeQvFF9u+K1KUbGu5hYXhvdpZ+EZZ03PomXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577069; c=relaxed/simple;
	bh=cv0g3AgKJuElra233uFKtUzzTjTFK6obx5ix2SzvJQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsasfHySGDDxQ4/RJEL6y82bWBt33bOM6XV5GZKo9G6KunWBB6Jk+MWqcg+YFFIJHgRu8fMCXCdXaIqtnB8rWiIf5/Qhncb4SyRUpPJtoBeL4iDORpvIL4ICZLvvkTOSBuPlsDKP9PwC4Q5w57NbXM7gksK4dns4Sl6sF2LqWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNFmP45Y; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNFmP45Y"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85019a60523so187417241.1
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731577067; x=1732181867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehGB6dTMf4LXNmabx+6xsT2G4N4oRc0A26QJig4YDNQ=;
        b=cNFmP45Yikjm+qG6Er+hSFFXOnYcROwbh4UV9/uwt6c0H36O+0kTFx33cWM2Gv2qla
         d1qQTvEOQIhDiRb6hkdyYRPOMvv3GSuvD+l1nKvWEmQS62pMoqlJl9FGN5oO7Ru4REi9
         PrOqrTehFNNyvEDiHROh0bzx3OpkYtFihDW5B698uCpgmyrTxfgFNwAbNEO3hYzd73bo
         h/elKjdIIJHZe57NfiP+3AgeiMC0nlrbccv5PNTCvtRA7KTUugiNv3yzvVdKHW2KPPeV
         0BOb50XhdW0Jyi5RvX/xBMRPk1RfQKORx3j500LqMm9dkaggd8xwav0xAcOgzB5Lvz0S
         l/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731577067; x=1732181867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehGB6dTMf4LXNmabx+6xsT2G4N4oRc0A26QJig4YDNQ=;
        b=s0zLsZwXxswv8ZsG3eB0GC7RHzyXFuyJtaBjtmEhPIUWn9n4GkxLCL/A8iSLHOqF4d
         kfHs71QAntW+fYG/viNU1+cFW2r72kG5vU53XJ6npmy0Zl6YV1uC+g2THpgrz5tyc8c1
         3HhB/afzJK5MtJlmKd0RbEnIp7+iDGjTNE1kbrS6DUKuObMr69bexJb6CDarah0WMiDW
         O/rsabTLF2NnOxGQ8m9aFJGvJWSz1zmV8wNi3MrH2PmUBWv/ze+Jy40X4ZGGPEsT5MX1
         b6govPkptEhYP8YXLpJXjfESqugqeaqhVStZ0L7YYHCIvJtdIF9sz10SxDAebqvlVsPB
         haPA==
X-Forwarded-Encrypted: i=1; AJvYcCVtOPXMl14M1a1LxOeMClcNEXePIQB7B/6lkH2+MWUNy4tGEGTKmr4XI+XjYewdZZTfYUBT0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvzQws0TW5KsWQO/B4XklTNQha4NQnxXTEtcDc+MjJ3Pvz3Q3h
	QWekZxxvK715ypNv4b17qYYB3r6/0yY/SdvaB0VSi6N2OVigX+Hp3yu/vWbsryY2fOJOPwLZwcP
	B/noAUYMJKvIctKkl/kDgSAoKXXY=
X-Google-Smtp-Source: AGHT+IHI15hqHssAzfGGtyXPf31+1ZqoEAtir3h7D+FOXfOCfYcI4E+WZhvgG1S5uTZEAKfrOixmorXSlStST/rghQ8=
X-Received: by 2002:a05:6102:32cf:b0:4a3:c6f3:89c9 with SMTP id
 ada2fe7eead31-4aae138dcccmr23911356137.11.1731577066793; Thu, 14 Nov 2024
 01:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
In-Reply-To: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 14 Nov 2024 09:37:20 +0000
Message-ID: <CA+V-a8sdSBFin=edpj+p5k4KZU4aen+k0acJVTD35YxTbE1qYQ@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: Save base/size instead of pointer to shared
 DMA pool
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, Rob Herring <robh@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-renesas-soc@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:41=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> On RZ/Five, which is non-coherent, and uses CONFIG_DMA_GLOBAL_POOL=3Dy:
>
>     Oops - store (or AMO) access fault [#1]
>     CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc1-00015-g8a6e=
02d0c00e #201
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __memset+0x60/0x100
>      ra : __dma_alloc_from_coherent+0x150/0x17a
>     epc : ffffffff8062d2bc ra : ffffffff80053a94 sp : ffffffc60000ba20
>      gp : ffffffff812e9938 tp : ffffffd601920000 t0 : ffffffc6000d0000
>      t1 : 0000000000000000 t2 : ffffffffe9600000 s0 : ffffffc60000baa0
>      s1 : ffffffc6000d0000 a0 : ffffffc6000d0000 a1 : 0000000000000000
>      a2 : 0000000000001000 a3 : ffffffc6000d1000 a4 : 0000000000000000
>      a5 : 0000000000000000 a6 : ffffffd601adacc0 a7 : ffffffd601a841a8
>      s2 : ffffffd6018573c0 s3 : 0000000000001000 s4 : ffffffd6019541e0
>      s5 : 0000000200000022 s6 : ffffffd6018f8410 s7 : ffffffd6018573e8
>      s8 : 0000000000000001 s9 : 0000000000000001 s10: 0000000000000010
>      s11: 0000000000000000 t3 : 0000000000000000 t4 : ffffffffdefe62d1
>      t5 : 000000001cd6a3a9 t6 : ffffffd601b2aad6
>     status: 0000000200000120 badaddr: ffffffc6000d0000 cause: 00000000000=
00007
>     [<ffffffff8062d2bc>] __memset+0x60/0x100
>     [<ffffffff80053e1a>] dma_alloc_from_global_coherent+0x1c/0x28
>     [<ffffffff80053056>] dma_direct_alloc+0x98/0x112
>     [<ffffffff8005238c>] dma_alloc_attrs+0x78/0x86
>     [<ffffffff8035fdb4>] rz_dmac_probe+0x3f6/0x50a
>     [<ffffffff803a0694>] platform_probe+0x4c/0x8a
>
> If CONFIG_DMA_GLOBAL_POOL=3Dy, the reserved_mem structure passed to
> rmem_dma_setup() is saved for later use, by saving the passed pointer.
> However, when dma_init_reserved_memory() is called later, the pointer
> has become stale, causing a crash.
>
> E.g. in the RZ/Five case, the referenced memory now contains the
> reserved_mem structure for the "mmode_resv0@30000" node (with base
> 0x30000 and size 0x10000), instead of the correct "pma_resv0@58000000"
> node (with base 0x58000000 and size 0x8000000).
>
> Fix this by saving the needed reserved_mem structure's contents instead.
>
> Fixes: 8a6e02d0c00e7b62 ("of: reserved_mem: Restructure how the reserved =
memory regions are processed")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  kernel/dma/coherent.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar
