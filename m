Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013221764F
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436916; cv=none; b=tvReGIvw2H7d6rlCldigjXcJkUE4g8FphAZgV5mpD47IZ3ba+3ZDSfjaWty/f9xlEnm58+K88i9ipOZffkMGn0lleGdJ61sBed0lt8usICurZ1VGphRkfXq4RM8WvM2cpItNc8dh6mRsA3+t3CujFG7Z6Ga/IsvD4iA8WgwytmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436916; c=relaxed/simple;
	bh=41iyxx13QSoZL0ljBLNHJfFzk4RIgV1Y3g7Lpg/buaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3BqsrP7Gm8Ov0wHRxxKMBMiYEd1kG3B30cExRlElJ5q7ZvKKgFINY/QpSolWop3cciX4yFtqutK85TGXOTSBg+5S4Z5NbwiVKzyl3utEAfXGyhnyM3dgHu8/SrQIO129oh9VcCmFP1oXmU4nY4fnud5x/p57fn+5VM3mbsHTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e34339d41bso52497287b3.0
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 10:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731436912; x=1732041712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve2ZVPRXNdhaGzT7UXBp48t6+paKDDEaJf51GwqASjo=;
        b=RczJA3NXChqMFjL7syBz0tjIoEW941N8bOzTSG8xtkzX0DvXU3qhOT1J8FGmLeq5qO
         6n7GpbIy1jl3gG9o0o5KUBHT2bHATJJcHuIkkl5jxNJnX3Wq5VA2OHFKuNqcja3ltbb+
         fPyKiDh3pzhgN4ymmeIK9CHwDpezXSfstQTOLmEdlHcV//UbyK4QXCmehqc6BjDFpMqD
         Cqi+c2QKPmuTbS2mscnk4ibmGcyXFWh4byi9iGfGayLihnm9SKtgKFIy8GjnEeMKRSEE
         T2Kc+JFt4/eE8XANR3Uop//3R0svs8Kxp3mEXpSC1M4OggRyvwjyl+pwbBWRXL54+MFs
         7Kxw==
X-Forwarded-Encrypted: i=1; AJvYcCXV+Nb+YTC6LJZMnegcoY3czfKGhl/i9COI/aFW4tTplF7cm6/Zc9621ErnLYDsFmuMlmfGwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMhJwF6bqK18la0Y7GPO8Dg0OVeqtiUacxLQ2sAmL7edIrBsG7
	/kXl6zFvT6M8xSDJ5LDvghGHjHpsgakGuQxpnLOPD+UAbVIL9MJRV3PjiEmv
X-Google-Smtp-Source: AGHT+IHYSH3R+Cf96C6/2PWDs9wDQmCBQOWAglmcL8/HzssOU+gsbktbdo4Ao5jNUvCffTTn6ELUMw==
X-Received: by 2002:a05:690c:891:b0:6ea:408a:3aca with SMTP id 00721157ae682-6eaddd97022mr162121947b3.12.1731436911980;
        Tue, 12 Nov 2024 10:41:51 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb6563bsm26587077b3.77.2024.11.12.10.41.49
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 10:41:49 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e30eca40c44so5608186276.2
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 10:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBOfOvGJiBsUrYkB5SltMMDGf6zdU3+X8yB1zUgNC99QBaVQXeRZPUD9eUCZPJSZU4lRCgOQ==@lists.linux.dev
X-Received: by 2002:a05:6902:2482:b0:e30:e5b3:390a with SMTP id
 3f1490d57ef6-e337f85a8e2mr16935363276.20.1731436909730; Tue, 12 Nov 2024
 10:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com> <CAMuHMdUXj4QiSKdhf61xdDeu94=Hv0BXuCxykDpQwdY81_h2vw@mail.gmail.com>
 <8c987a26-d499-4ceb-905e-750bb24fcb08@quicinc.com> <CAMuHMdW050DuwkLuosiiz2Yt7d0Lq+C8jFO0+O0qbwsjmyf3hA@mail.gmail.com>
In-Reply-To: <CAMuHMdW050DuwkLuosiiz2Yt7d0Lq+C8jFO0+O0qbwsjmyf3hA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Nov 2024 19:41:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUjpyZEvwKpY1oQtqiqbXYcbZBh4-7pa3jacrFaCfKF=Q@mail.gmail.com>
Message-ID: <CAMuHMdUjpyZEvwKpY1oQtqiqbXYcbZBh4-7pa3jacrFaCfKF=Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, aisheng.dong@nxp.com, andy@black.fi.intel.com, 
	catalin.marinas@arm.com, devicetree@vger.kernel.org, hch@lst.de, 
	iommu@lists.linux.dev, kernel@quicinc.com, klarasmodin@gmail.com, 
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, 
	quic_ninanaik@quicinc.com, robin.murphy@arm.com, saravanak@google.com, 
	will@kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oreoluwa,

On Fri, Nov 1, 2024 at 1:45=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> On Thu, Oct 31, 2024 at 10:06=E2=80=AFPM Oreoluwa Babatunde
> <quic_obabatun@quicinc.com> wrote:
> > On 10/29/2024 5:41 AM, Geert Uytterhoeven wrote:
> > > On Wed, Oct 9, 2024 at 12:08=E2=80=AFAM Oreoluwa Babatunde
> > > <quic_obabatun@quicinc.com> wrote:
> > >> Reserved memory regions defined in the devicetree can be broken up i=
nto
> > >> two groups:
> > >> i) Statically-placed reserved memory regions
> > >> i.e. regions defined with a static start address and size using the
> > >>      "reg" property.
> > >> ii) Dynamically-placed reserved memory regions.
> > >> i.e. regions defined by specifying an address range where they can b=
e
> > >>      placed in memory using the "alloc_ranges" and "size" properties=
.

[...]

> > >> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> > > Thanks for your patch, which is now commit 8a6e02d0c00e7b62
> > > ("of: reserved_mem: Restructure how the reserved memory regions
> > > are processed") in dt-rh/for-next.
> > >
> > > I have bisected a boot issue on RZ/Five to this commit.
> > > With "earlycon keep_bootcon" (else there is no output):
> > >
> > >     Oops - store (or AMO) access fault [#1]
> > >     CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted
> > > 6.12.0-rc1-00015-g8a6e02d0c00e #201
> > >     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> > >     epc : __memset+0x60/0x100
> > >      ra : __dma_alloc_from_coherent+0x150/0x17a
> > >     epc : ffffffff8062d2bc ra : ffffffff80053a94 sp : ffffffc60000ba2=
0
> > >      gp : ffffffff812e9938 tp : ffffffd601920000 t0 : ffffffc6000d000=
0
> > >      t1 : 0000000000000000 t2 : ffffffffe9600000 s0 : ffffffc60000baa=
0
> > >      s1 : ffffffc6000d0000 a0 : ffffffc6000d0000 a1 : 000000000000000=
0
> > >      a2 : 0000000000001000 a3 : ffffffc6000d1000 a4 : 000000000000000=
0
> > >      a5 : 0000000000000000 a6 : ffffffd601adacc0 a7 : ffffffd601a841a=
8
> > >      s2 : ffffffd6018573c0 s3 : 0000000000001000 s4 : ffffffd6019541e=
0
> > >      s5 : 0000000200000022 s6 : ffffffd6018f8410 s7 : ffffffd6018573e=
8
> > >      s8 : 0000000000000001 s9 : 0000000000000001 s10: 000000000000001=
0
> > >      s11: 0000000000000000 t3 : 0000000000000000 t4 : ffffffffdefe62d=
1
> > >      t5 : 000000001cd6a3a9 t6 : ffffffd601b2aad6
> > >     status: 0000000200000120 badaddr: ffffffc6000d0000 cause: 0000000=
000000007
> > >     [<ffffffff8062d2bc>] __memset+0x60/0x100
> > >     [<ffffffff80053e1a>] dma_alloc_from_global_coherent+0x1c/0x28
> > >     [<ffffffff80053056>] dma_direct_alloc+0x98/0x112
> > >     [<ffffffff8005238c>] dma_alloc_attrs+0x78/0x86
> > >     [<ffffffff8035fdb4>] rz_dmac_probe+0x3f6/0x50a

> > Please can you provide reproduction steps? I tried booting up
> > risc-v arch with qemu but did not run into the issue you are
> > seeing.
>
> It indeed doesn't happen on other RISC-V platforms (tried MPFS/Icicle).
> RZ/Five is special in that it is DMA non-coherent, and the crash
> happens in dma_alloc_from_global_coherent().
> According to the logs, the DMA pool at 0x58000000 is still being created.
> I'll try to debug this further next week...

I found the issue, and have sent a fix
https://lore.kernel.org/r/f8cef6845a6141f0277e31a71fe153612daae776.17314366=
31.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
