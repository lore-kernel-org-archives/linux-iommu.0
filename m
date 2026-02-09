Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0F2DEA89
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770607202; cv=pass; b=qlUZY1XI0s9UUiO8ZHIBQYIMryDhpq0MukYpP5fKHes4BrFp8iq/rTBZ5x3kJPN7srF/ylxa09pSpwlViBVpTo9w7deibbp7w9MInTSnEy7KvhDR3VOCgZRDbUl5sp8r3D+iwswb8aeIpUGlSTEmPEcsNKmTLngqdpZst0OtiDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770607202; c=relaxed/simple;
	bh=Smwhyg4YBNedQzdY5sUMXwnEeUZt/97AQz5HDdbDHNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRx/yph+yVHxnmy507PMN2Wdo9y1fteYSrq+vdZHuyuM60qB09ZLF3DcD3NR8wOlM37YyG86qiI2kq8KHDNlf5dKhVPMdJnv5UyPFU2ZxCVh6cTb0FzHXfNEeJVQBbP4f1w5WtcPTNfp7YHNROFsGzhgZFHIBH3qflDE29Q/uVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=N8d7OIQd; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N8d7OIQd"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b87677a8abeso599031866b.1
        for <iommu@lists.linux.dev>; Sun, 08 Feb 2026 19:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770607200; cv=none;
        d=google.com; s=arc-20240605;
        b=C/37FZDMVvJk9vLHyjKCi/YmbscHDZ71QrmpZyPb4OswBkTWrRjgMOV0XXzoW5FqyB
         IbjS6dqbjoxtRWC0Ny1qWjdXApLYN4/v+YCHmlbRCgZLovn6ke6TC2jtZ5Td6r0SSLwo
         glWjD/NYYuxZNQ1VmZ2+4wx5B/tALktwt/DsxeY63i5TKNbfbEnsp1dpHXdvguoKwBS9
         pTjsBnxaMMu3AHDi1zqnJkY3eAF7SQOjcRkwTDSY3FLElNkTGxUZ+PwppP1tkPwZd5yh
         lelabOLV70pNJzk2ff7ySHdTGw5j/gVia0xfXiiGDPsXEwbpzID1ApislBTcuSQOo4vn
         JF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QTpZ3dQhsPCIcIyPizxNOmCsub1MA47o2XGIfp+wVqw=;
        fh=WqjnE5dtm1vtYRj+vxrZZdBrE+SrMDYj/fRH0VUhvWA=;
        b=e/GPDI985/Gjb0gtWO2GQxdQPXJaXbA3/nQ93WbenYlaweMiPof+6LLmVOkiWK8HVb
         NakRJVaxzpta/8JGcDTCPCok5OmJUnyKfwb20V91pA6gwE0EkLJsu0nq+G7zywpZcAo0
         +Exvo/rJdXHbtE0y8nMA7FhJ4hufgCC8CyeFyJhIEKbPwnRW+aOEWYUlms1dBDyoHwgQ
         EE1pZC06UCvy57lpskoRFg+vTlLjNVrQfCT+YD6CwWqaLchaR88WQ/g9onh0LHNZgHPS
         fPUbqRDixywB5Ha7tnZ2/g0dItRUfJj+yVezvalNY0oWa/4k5TEiwu+mwJC2isq341lQ
         KlLw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770607200; x=1771212000; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTpZ3dQhsPCIcIyPizxNOmCsub1MA47o2XGIfp+wVqw=;
        b=N8d7OIQdq4pwG9/+ht8TNSoN2Ilpv/ASgkjkZNumhGNH18T8rUGeoTudHSTqhrPToH
         IFvVNEXkKmtk0r8rSghsM+/4vpt/LUuzcdUEqpD53S8zgaPuylxr0fivZZ9nmMRh22i+
         Ptvusey9KZxSz/XCnWQEsJDMgYse1X63rCotwy29cuZKJgFfyILxq2UaY5SWE3Io/JaT
         ljDH1YLV7s9J4ceGyxF4QcBUA55AZLtogUss6foXeSREeqbj0tToF+hZPtlNI7FX9bJe
         MH/jpSenQOYY0kGCKukHaQk3NYqi2DUM990VcGaXl87b5IzKljgdVLRzKv1gqPKrqWcC
         HBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770607200; x=1771212000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTpZ3dQhsPCIcIyPizxNOmCsub1MA47o2XGIfp+wVqw=;
        b=lwey3K3HqCi/JzRgWfmNTZiWPWgXGCxf9KU+q2nMWNF2Ky3WBkLNZzI2fYfy71qY5N
         BU2tsXPZUupLcmc0+qasn5AWHVeAdvSHrBkFdwR07GPfjnNDsFh6hULwVZz2/Ej6fqia
         YS+gezFhetmTfx89MlbUOn+9jurcmHA0zYr4rGK0ra5USOifEPoyXxb/WMNmbaJ0EfB9
         NmyvHPEEJvVTK0IE5C6vlALUIp1b5rNJjtSypogX9mOr3Zm6uGYtqv9smNYvNsmHWHca
         7oJ56IRQjsS5NYct8VVdQZk7driwKNElzl+5hf5z0Rda6/FlRUrGT7X/a0b3o2D2vHcH
         yEpA==
X-Forwarded-Encrypted: i=1; AJvYcCXyZt6wcKMVGBrKjYcQE4iQeCpGwZtVScNUNhnsGsVs6epZz5cyyP+aeBdb1SOiJWfrpSddPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHzKAvBCE+H94+1pZOVODINDVYd3SDVZ5LIE6sOWmIlncWvs+H
	p6ig8YEk0ZnHOK3yyytFPrEMKbf5kv+UmRsi5VYCjSjs4rAxjRRSPxD5kUgHOWSALi4tb+9qzsa
	Go/4cLtodaTP/yMMWqPyH2APtikrVY9k+Zj8dJf3PVw==
X-Gm-Gg: AZuq6aKCcPF5mcaXN/fWy20AKWf1wLp38CB5N0anvmreo3PMl+I9hIa2b2HqWh+8GN4
	lu6eMB79ZymCBGWIh3E5Q7Wn3AkBQ/dDGsXZQPnSYHYLbIl2OdJmnhlFi+hOoFWbe/HLFd9xObD
	dTlk3Uh4pJWvzzXBuC+opWb+iP10FDZK32CVIj1WqPYslFxHl7MCD6m92RF8aGmZ+UBEs/hLesJ
	c1uNvU4IIerxko/cXuDpxI92FL/Y3nUg0Xk1nKpIVKep5RHMXBJ35sULsmmbqgL12UyP6009w==
X-Received: by 2002:a17:906:d542:b0:b8e:d04e:e4fb with SMTP id
 a640c23a62f3a-b8edf376150mr579729666b.48.1770607199749; Sun, 08 Feb 2026
 19:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260208063848.3547817-1-zong.li@sifive.com> <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
In-Reply-To: <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 9 Feb 2026 11:19:48 +0800
X-Gm-Features: AZwV_Qj-9dR3BKTCPrhQdA6_UiWDK2OsF9j8utjRQbwYmgBnYFrxlf2qIsKG7xM
Message-ID: <CANXhq0qmc+vo6uX3ySqqQOPTHxKHJB8t1XC6JuxWs3K5_qoTRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V IOMMU HPM support
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	conor+dt@kernel.org, guoyaxing@bosc.ac.cn, luxu.kernel@bytedance.com, 
	andrew.jones@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, Jingyu Li <joey.li@spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 9:41=E2=80=AFAM Lv Zheng <lv.zheng@linux.spacemit.co=
m> wrote:
>
> On 2/8/2026 2:38 PM, Zong Li wrote:
> > This series implements support for the RISC-V IOMMU hardware performanc=
e
> > monitor.
> >
> > The RISC-V IOMMU PMU driver is implemented as an auxiliary device drive=
r
> > created by the parent RISC-V IOMMU driver. The child driver can obtain
> > resources and information from the parent device, such as the MMIO base
> > address and IRQ number.
> >
> > Custom event support is not included in this series and will be submitt=
ed
> > as a separate series. The idea is that custom events will be defined
> > through the driver data of the auxiliary driver. When the parent IOMMU
> > driver creates the auxiliary device, it should pass a vendor-specific
> > name as the device name in order to match the corresponding auxiliary
> > device ID.
> >
> > After my initial RFC and the v1 patch series were posted, similar patch
> > series also appeared on the mailing list.
> >
> > One was from Yaxing Guo:
> > https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
> >
> > and another from Lv Zheng:
> > https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631-ac=
1c352a469f@linux.spacemit.com/
>
> Please do not forget to Cc:
> Jingyu Li <joey.li@spacemit.com>
> I only provided T100 specific support in the posted series, and the
> new approach of the HPM driver in the same series is composed by her.

Sorry for missing Jingyu. I have looped her in this thread.

>
> >
> > Yaxing has agreed to pause his series, as discussed here:
> > https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc17=
1@bosc.ac.cn/
> >
> > The motivation for sending this v2 version is not only to address the
> > feedback and suggestions from the previous round, but also to introduce
> > a major structural change: the PMU driver has been moved under
> > drivers/perf/, which has been mentioned repeatedly by several people.
> > This results in a different driver structure compared to my earlier
> > version and the other two series, and I'd like to gather feedback and
> > suggestions from the community on this approach. If the community would
> > prefer to go with Lv Zheng=E2=80=99s version instead, I am perfectly fi=
ne with
> > that as well.
>
> We'd like to know if there's any comments related to putting IOMMU HPM
> driver into drivers/perf folder and want to know if this is necessary.
> We also hesitated if riscv iommu hpm should be put into drivers/perf,
> and according to the followings, we finally decided to keep it in
> drivers/iommu:
> 1. drivers/iommu has already a folder maintaining all IOMMU stuffs.
> 2. drivers/iommu has already defined HPM related registers.
> 3. Unlike PMCG of SMMU which is located in a separate namespace, RISC-V
>     IOMMU only defines 5 registers in the same address space as its
>     translation schemes.
> 4. For HPM schemes that is not a standalone device, Intel has put its
>     perf driver under drivers/iommu/intel/perfmon.c.
>

As you mentioned, it=E2=80=99s not strictly required to place the PMU drive=
r
under the drivers/perf/ directory. I think it would also be ok for us
to place the PMU auxiliary driver under drivers/iommu/.

The key point here is to make the IOMMU PMU driver an auxiliary device
driver. Our intention is for the IOMMU PMU driver to behave more like
an independent platform driver, where vendor-specific or
hardware-specific information can be provided through driver data.
Custom events are one example of this. Similarly, if future versions
of the RISC-V IOMMU introduce new hardware features that need to be
distinguished by the driver, we should be able to handle them through
these existing interfaces.

Overall, you might consider this approach as using an auxiliary driver
to prepare for vendor-specific functionality and to allow more
flexibility going forward. If you also agree that this is a reasonable
approach, it seems to me that it might be good for you to add your
T100 support on top of the mechanism provided by this series, and then
append your patch after it.

> Cheers,
> Lv
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
