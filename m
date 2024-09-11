Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB661547CF
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053177; cv=none; b=BesWXDpE5wZ2LCHxcH0/DNpLzXhSIPYnwi492skIesz3mQqCYchHqWbyM/Jz0SplLfKsFrkeye6kkMW/lo7AELKoNxvhubObnakwy+9/lAyO6YDg7dLMAxRelcB/ntwco+mn+Fc7PKQcvlvU5LHA15dA6L/6CFknhwQmWL317RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053177; c=relaxed/simple;
	bh=BP4GHUP1ZwTseeoJTLMOIx06gueTKby1CtIKw/ccRWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/qqurf/NjJNwSL4K7aKQ03DxG/NzUEb48Pfb6kEG/oZC7896URI82V7WQWLlqfQ+/IxokuF2eY9h471B1759Q2O5gve1uGpKvfI8SONc4xTEql1G3/0NkgTDOPWhYUB8k1HC7g2EXv/LXc1D9ltckh0Ksn37R1kaRAMV14gsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=LjqeKxur; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="LjqeKxur"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82aad6c83ecso178037139f.3
        for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1726053174; x=1726657974; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfKqpT6gMHu6yKs0bohCo1aZwLC/RRj8ZGqLiNhs4jw=;
        b=LjqeKxurIdZ+obOR9IXWYFXFoL/du2ZsN06spzFLD2Mm9Y4AK0+YfSkR7wngSpxAgv
         9OJrlFUsGAkczsR0crPqnt9BCEuooqUWjodXMHkLH74XLMdijOJQIlVzO4tO8BgbJJKS
         2PU0X6Eu6QYnIBFQ83mrM2CoUP/4qHOukTuJ6CZSrXOtpcQOCUYzPEfYB8B1Va6uHogk
         mdacZ6ZKcu/wug8re1pKPnzJ3NkGzQeLFz0LQxuUtCbrefb4fV+i5DPCWh7vkqwp7G8Q
         Hx85/upKWrNuhOBciI3Zx7j5wJk5kHkLk5RIUr0rGeVuOhAlMgo7vH3Q7QbESvIZ3/gE
         eZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726053174; x=1726657974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfKqpT6gMHu6yKs0bohCo1aZwLC/RRj8ZGqLiNhs4jw=;
        b=UALwqE05gOJ18/C/G9jWsqCxXsIbyo4CPd/mBkTJaIklpZiJ6Yskg0KU/R816sHE5L
         OUvOeBy6NR3ULZkJZbEPcZqUUXrw44bt7AB0VMnqSaHhf4qDeb8oBek3bAhLBZTJbwfC
         DHvyZL+Oe5ADhoBsMvmErd3E9aUWoEwZJ+Al0n9qPQR749j99XC3JyKa6agI+znryIKe
         65b6JX9rS5pQPAQjoWR08F7g3Eeh0ZobI9nbthOKOWgTh7T+TxzTWep5wdIWueqiaHaq
         czwN7D0pFI49R+buOFpeM8jlt7UQhnJThmPMDhhHdgRUjZJWJ68nDBVr5aEOl+x4xa2B
         b9EA==
X-Forwarded-Encrypted: i=1; AJvYcCVMS3Y6F69sS9Z4cQ+V6ROa1/SXHYJgwIRHkiWh/Q+qe/KQZqnnaxmj23sdWX52AmWFIKvqTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9bCsMXaAxe+TUtYKTZ0dGea85zY+uKVAhrniJjNR97v0wrOwl
	6mCEzHDDaW0K3zO9mzPkaOJOQ7AcGtHqfwh5Q68nwOLojSY99liIbQHHk0v6eX8etxughAuo1fG
	RluCFj3aR
X-Google-Smtp-Source: AGHT+IGoROMNsr+Bf8c41ck7GPpCYoJ5KYW2C/C1G2a1h5lgwsMuJ2gCob47F2FHNbB7jukOtPSXtg==
X-Received: by 2002:a05:6e02:1a4a:b0:39e:68f8:43e5 with SMTP id e9e14a558f8ab-3a04f0731fbmr186407765ab.9.1726053174315;
        Wed, 11 Sep 2024 04:12:54 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09464b4c3sm2124262173.144.2024.09.11.04.12.54
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 04:12:54 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso236103039f.2
        for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 04:12:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUGKIxZOEIGY9etL634KJcm4Mpjg40G0NbQ+qd3jO2ovGs2Q1IGcgyBZqW/JwH8hPezYPpdg==@lists.linux.dev
X-Received: by 2002:a05:6902:2004:b0:e1a:4082:e8f2 with SMTP id
 3f1490d57ef6-e1d348a15d7mr19851736276.4.1726052845474; Wed, 11 Sep 2024
 04:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
 <20240612-6-10-rocket-v1-2-060e48eea250@tomeuvizoso.net> <ffviz6ak6qsn2reg5y35aerzy7wxfx6fzix6xjyminbhfcguus@clszdjakdcjd>
 <CAAObsKCx+r5UuESnrPem1Rb1-BF4i8FVwu6uozWhABOWoq+M4Q@mail.gmail.com>
 <CAAObsKChaBZ2C5ezWsiZ_LoN6R2HFhFA9=UNSRYB6cyeo-jreg@mail.gmail.com>
 <vmgk4wmlxbsb7lphq2ep3xnxx3mbv6e6lecihtftxoyp5lidvy@mectcwirrlek> <3516994c-7b06-4409-b9a9-975b9f7a60eb@arm.com>
In-Reply-To: <3516994c-7b06-4409-b9a9-975b9f7a60eb@arm.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 11 Sep 2024 13:07:14 +0200
X-Gmail-Original-Message-ID: <CAAObsKCGr8EUB747RN_w2BpTqLzGee+Bwm7HWB=xRbSBE2huUg@mail.gmail.com>
Message-ID: <CAAObsKCGr8EUB747RN_w2BpTqLzGee+Bwm7HWB=xRbSBE2huUg@mail.gmail.com>
Subject: Re: [PATCH 2/9] iommu/rockchip: Attach multiple power domains
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:07=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-06-13 10:38 pm, Sebastian Reichel wrote:
> > Hi,
> >
> > On Thu, Jun 13, 2024 at 11:34:02AM GMT, Tomeu Vizoso wrote:
> >> On Thu, Jun 13, 2024 at 11:24=E2=80=AFAM Tomeu Vizoso <tomeu@tomeuvizo=
so.net> wrote:
> >>> On Thu, Jun 13, 2024 at 2:05=E2=80=AFAM Sebastian Reichel
> >>> <sebastian.reichel@collabora.com> wrote:
> >>>> On Wed, Jun 12, 2024 at 03:52:55PM GMT, Tomeu Vizoso wrote:
> >>>>> IOMMUs with multiple base addresses can also have multiple power
> >>>>> domains.
> >>>>>
> >>>>> The base framework only takes care of a single power domain, as som=
e
> >>>>> devices will need for these power domains to be powered on in a spe=
cific
> >>>>> order.
> >>>>>
> >>>>> Use a helper function to stablish links in the order in which they =
are
> >>>>> in the DT.
> >>>>>
> >>>>> This is needed by the IOMMU used by the NPU in the RK3588.
> >>>>>
> >>>>> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> >>>>> ---
> >>>>
> >>>> To me it looks like this is multiple IOMMUs, which should each get
> >>>> their own node. I don't see a good reason for merging these
> >>>> together.
> >>>
> >>> I have made quite a few attempts at splitting the IOMMUs and also the
> >>> cores, but I wasn't able to get things working stably. The TRM is
> >>> really scant about how the 4 IOMMU instances relate to each other, an=
d
> >>> what the fourth one is for.
> >>>
> >>> Given that the vendor driver treats them as a single IOMMU with four
> >>> instances and we don't have any information on them, I resigned mysel=
f
> >>> to just have them as a single device.
> >>>
> >>> I would love to be proved wrong though and find a way fo getting
> >>> things stably as different devices so they can be powered on and off
> >>> as needed. We could save quite some code as well.
> >>
> >> FWIW, here a few ways how I tried to structure the DT nodes, none of
> >> these worked reliably:
> >>
> >> https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple=
-devices-power/arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L=
1163
> >> https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-schema-s=
ubnodes//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1162
> >> https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple=
-devices//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1163
> >> https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple=
-iommus//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L2669
> >>
> >> I can very well imagine I missed some way of getting this to work, but
> >> for every attempt, the domains, iommus and cores were resumed in
> >> different orders that presumably caused problems during concurrent
> >> execution fo workloads.
> >>
> >> So I fell back to what the vendor driver does, which works reliably
> >> (but all cores have to be powered on at the same time).
> >
> > Mh. The "6.10-rocket-multiple-iommus" branch seems wrong. There is
> > only one iommu node in that. I would have expected a test with
> >
> > rknn {
> >      // combined device
> >
> >      iommus =3D <&iommu1>, <&iommu2>, ...;
> > };
> >
> > Otherwise I think I would go with the schema-subnodes variant. The
> > driver can initially walk through the sub-nodes and collect the
> > resources into the main device, so on the driver side nothing would
> > really change. But that has a couple of advantages:
> >
> > 1. DT and DT binding are easier to read
> > 2. It's similar to e.g. CPU cores each having their own node
> > 3. Easy to extend to more cores in the future
> > 4. The kernel can easily switch to proper per-core device model when
> >     the problem has been identified
>
> It also would seem to permit describing and associating the per-core
> IOMMUs individually - apart from core 0's apparent coupling to whatever
> shared "uncore" stuff exists for the whole thing, from the distinct
> clocks, interrupts, power domains etc. lining up with each core I'd
> guess those IOMMUs are not interrelated the same way the ISP's
> read/write IOMMUs are (which was the main justification for adopting the
> multiple-reg design originally vs. distinct DT nodes like Exynos does).
> However, practically that would require the driver to at least populate
> per-core child devices to make DMA API or IOMMU API mappings with, since
> we couldn't spread the "collect the resources" trick into those
> subsystems as well.

They seem to be interrelated in some way, because I need to program
the mappings in all three iommus for things to work, which is also
what the downstream driver does. Unfortunately, the TRM has zero
references to the MMU in the NPU section...

Regards,

Tomeu
