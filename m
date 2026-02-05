Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F9231A41
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263239; cv=pass; b=iRsXV6KlY78GdRbv9yg+3QVdt3nBIh84qabXMkr1qjlZldvm+XZAXpbsIjJw9SAnBO0/KLQO++jQFpKQjvfamrNyx5pmP4nOxiayNkZLQHZDvH2nRKrZuV1voYtcS4yIYOEzNkLWxL36FdVTE68h1V60+Hg+1jxuhZ2UI+KvNrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263239; c=relaxed/simple;
	bh=U1uxpilUx2DxGX0pxECF9QK743XJ04lwD+hGq3RgaM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smRxdmk8GRr7/AqJiEdLyMMxBaiZ037CJ9XqYRlZCHfJSWUcWtkzHI38xA2uKTmc2lkjrfbmmanEcthMM0MLeabdQBQ/KSO0Szx7cRSgLXNemzqEfYOJDVqGJmbbo91dpi8LUJ7BGr9DgGtwvVnU4spHGhUD4FUnDMplwLQ1x/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OsLg/zV3; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OsLg/zV3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so524291a12.0
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 19:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770263238; cv=none;
        d=google.com; s=arc-20240605;
        b=f4HhEYLa3j6EbHVbsqhHmXug2yd6gqriRtMdLBLjXp8o9yc1Pm5FwnS0Lm/n8eVJGh
         OvCoOKRfNz68u1MbHExNrc5rJPljakNRLJ8a+jzbmvA4Ked6TfswpOLyxffRPpu6Qp1a
         AcirL524OWc5a+u2rSlBYDh6fHfZ428rNYPqwuNHmJmM8n6NlfgoRH6g06NI/xqyykON
         S4VweGbBKs9DOIYkE5eUCAhRDi3/mwSty6WJw4j9R+pM1Vmytn3B68kJoknxVWwntFm8
         LDcG8R80QYqBfJfVjYYz7O8S+MxxdEMxpxSrq1SvxfRsM1rucxFsB4ETPHtIADN31Mlm
         Pb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWzU3QUTkSaGp/URwdKcUANl9SeI3h8kqMKRyxrmMQw=;
        fh=zWowIhrejijBoy04nN09GNXHtEpw6rPFdpS0shtANVQ=;
        b=HlrChRm0AOTu2p5wEg95L6LYDWOReIfDjCspdFNYub38M5CSmEIz1Qro+mUQhVhH4J
         0ae338/Q9LrNtZoC5ankc3/dhYBIPHTmLjTnrr9eNoOzyogP7gTnCvVXTmaCig28Db9Y
         A5FcR/HcZWBq1qiGRAqJUBxkxCJByei4aITWQb02CZnY6tRMZpLNqI6oSoPcXV8wVO2w
         0Vy9VBETxxnFoXeqH8Wp0f9EDgL1sztFTkZ0G99Y6dJ3i8je+AjZdn1l+FkHBbjGpLLi
         9mGTy8GIes7A9C4r5MlLd2oI/4T0BRTW9CvncWJAjNB5xBo+7B9QzxTksTB6Hao8QKl2
         V6zg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770263238; x=1770868038; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWzU3QUTkSaGp/URwdKcUANl9SeI3h8kqMKRyxrmMQw=;
        b=OsLg/zV3CH/rvMQkRUuhyUZ7q42xWK8ll7Qwb9P3ieb1H94tj8zzCZfy7GMJm2Mnkk
         i5c/EvxNS/iuTEHfe1rw7drlNtVwZCmaZw92BaVka0LqMFZIKb+vFTU5u9txDymFiwkZ
         Yx/S8L9AMkzS1bx47ZflXGukylcH5g/XQBoV7Qnn/4DOHXhyfuxhoELFZPCT2Fj6sE2Y
         LVLyxzVpEzfv1FLP8mb1C2QzVEfof4iX2jal9vm0phuBhm/TJyUNluLnRd4tEPlLDLxL
         nQiDeyZcoxiagGvKVdxs1g8jLsNjSGdjUkidOntZBbE53G0hEOx9JTAxv5l4VGr3Ir8G
         Qdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263238; x=1770868038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWzU3QUTkSaGp/URwdKcUANl9SeI3h8kqMKRyxrmMQw=;
        b=garNqVjvSahL7f2bz4tzzdor6LfYj7DV0aOJoyN/SNmd2OKykx5xSbwxvZrtpffCDS
         UamB2En2qk0OuNyibDjEWA2Lq5/8vX45X36ha9vIuXRqcu2fQiSj/sPqerR8xi2pAdg0
         9BxmE26qYoqAQKfZZv1ryAO84UFMkbrRuiPtm27QKLA7Cqf3CioFgo1I5egu2cxKuGrc
         QzUYbcyLbp7surCXNZPGqeXRj/Ake5h/WHC9OhbFr4O9sfZPXoexojJW5kGNpcmXsHYK
         nS2aHJqiDmtWT6pFaofxlJKw7d6DSsUAxAY97kRHyXu7fDDyMTkdQ/PosVLjuc30Y69f
         raTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxWUM0+rfCN0dyU0F1c/r8YiQAxEkKVLbyHrZ9RmFz6ERCu0Ph9kbajZuRe8DYgqVKXltMIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkyXhwPe3xsFemf7xgUNPtjBFNx3QXpHa3sNDLHf4nchSzAOFH
	R8zjj+FXOBwvPVLp4+qWuWgWuj0SSZmZU6iPqsiTxwEl6UTkjG/pvS8zp1gSGUcAXhUL4XqrPw3
	iZ/An3898YG73jP1IvgmyE05sSegaIUZViaHHwTEPzg==
X-Gm-Gg: AZuq6aLv3zt4QkGY73jPHLFlqrGVM0PdyFmkr41Gegv9ye5MXY3VN378M19/4qYV9pq
	bRfYYKWt8W6dfyjaFzobfZHYqQ0b4rBQtB4LVMEID5FgPMQmm0mRbpjamzq1b5yOGOVQH/PLGa1
	eULPCX3M7UIiMGO4QoyqPpouId77ZFdRivQc5Nzml+rFjTQfphBu7lZmXT/OQWwD1Hmr0t2iu1w
	W+XrK1/uM8A3p9DSZ6N20DRMOCM24m8e23ht5BAgJ8r00Mm3iyuQ5ZQXp4744WslQmHVcryeeQl
	SF8O6lXk
X-Received: by 2002:a17:907:9409:b0:b8e:8874:8384 with SMTP id
 a640c23a62f3a-b8e9ef30487mr317378866b.4.1770263237571; Wed, 04 Feb 2026
 19:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs> <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
In-Reply-To: <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 5 Feb 2026 11:47:07 +0800
X-Gm-Features: AZwV_Qj4QZXbWJXyq8Jiiv-VQvhct2TUKL3kLYYPr0oB9fDJjewtTcIansChXl4
Message-ID: <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance monitoring
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>, iommu@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 11:35=E2=80=AFAM Lv Zheng <lv.zheng@linux.spacemit.c=
om> wrote:
>
> On 2/5/2026 2:39 AM, Andrew Jones wrote:
> > How does this relate to
> >
> > https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> >
> >  From a quick skim it looks like there's plenty of overlap.
>
> We developed the driver in 2024 and demonstrated it in China summit. We
> didn't notice that a patch is on-going now in the community.
>
> Now it looks our approach solved more issues, and we'll check and update
> if there are any community concerns still not addressed in this patchset.
>
> We can add Reviewed-by/Tested-by and Signed-off-by of Zong Li to this
> patch if he wishes.
>
> Thanks,
> Lv
>

Perhaps I can first post my next revision to the mailing list (hope it
won't waste the community resource), so that you could have a chance
to review it and see whether that version is architecturally closer to
what the community is looking for, while also addressing your issue.
If you also feel that my next revision meets your needs, perhaps you
could append your additional implementations on top of it.

Of course, if the community would prefer to go your version, I=E2=80=99m
perfectly fine with that as well.

> >
> > Thanks,
> > drew
> >
> >
> > On Wed, Feb 04, 2026 at 05:09:01PM +0800, Lv Zheng wrote:
> >> From: Jingyu Li <joey.li@spacemit.com>
> >>
> >> Introduces perf-based HPM driver for RISC-V IOMMU, enabling performanc=
e
> >> monitoring capabilities.
> >>
> >> Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
> >> counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
> >> indexes of other HPMEVENTS in order to correctly index into IOHPMEVT a=
nd
> >> IOHPMCTR registers that have already been defined in the iommu-bits.h.
> >> However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-=
1 as
> >> the indexes of other HPMEVENTS, thus care should be taken in dealing w=
ith
> >> counter indexes between userspace and kernel space.
> >>
> >> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> >> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> >> Link: https://github.com/riscv-non-isa/riscv-iommu
> >> ---
> >>   drivers/iommu/riscv/Kconfig          |   9 +
> >>   drivers/iommu/riscv/Makefile         |   1 +
> >>   drivers/iommu/riscv/iommu-bits.h     |   6 +
> >>   drivers/iommu/riscv/iommu-hpm.c      | 843 +++++++++++++++++++++++++=
++
> >>   drivers/iommu/riscv/iommu-pci.c      |  13 +-
> >>   drivers/iommu/riscv/iommu-platform.c |   8 +-
> >>   drivers/iommu/riscv/iommu.h          |  42 ++
> >>   7 files changed, 919 insertions(+), 3 deletions(-)
> >>   create mode 100644 drivers/iommu/riscv/iommu-hpm.c
> >>
> >
>
