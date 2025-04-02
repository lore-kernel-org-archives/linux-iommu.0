Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D76237706
	for <iommu@lists.linux.dev>; Wed,  2 Apr 2025 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595132; cv=none; b=tdqwRi9/BS8AJcPzu7QaVL6CC+l74kf6jqR0VNmQ/AMO6+XrhfQOsqBmxrCXENn14mTQOJ+rAbvar0zM7qvWu9E2km49RttwdQfUAsbbp4UOuR3Jf6CUTv+kkdiZgdIZj3eZcrR8oYWWAahoiyxL7I/4eEw0Wrb+EqC3e6EVz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595132; c=relaxed/simple;
	bh=yz2g4VlGJxKRTtOW8OVXla1bJm6KVYLvKyCbxgeOuKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6Les5/wbXde430Xx0oSHlkX94EglmgNFlE960e5sCaqi9BL/lmcpl3Vp1Mgil22U3he4kyVKwXv4+bVucAMRCzr1kZnbz4Y55sqsPlDeLSn+HfK/jBEgOugHDd7JUTW5KYkVDrKHU04jkQpQCLLPdjagR2nrx3m6R1aTjq8KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TAwyMLMk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TAwyMLMk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-aee79a0f192so21149a12.3
        for <iommu@lists.linux.dev>; Wed, 02 Apr 2025 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1743595130; x=1744199930; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpOpISsK92nzP8u+mrCrBVvlHehBgWb2S+ejZtPgHRk=;
        b=TAwyMLMkOKvFKumjiKIdDchC6z1fHBP7xmjiKJWLx8PP+q2ackO+jpX1Oz4iOSJXFM
         CcKXIbwXE7gA1DB+De3PW/fIJ0QVMVXZB/b/uf3YUYL9kULomkEQgEcQu7SwJmAFce5x
         2gIDTUcccSr8FDyEYmm7r69m2mztIY6eb37jVp79cwSSixO2MGZqVPDkH7Bxz89eMpik
         jSwDfFRPxjy2gT8jnks9jVZtw26iQK26GZdZd1Qg+kPUvFV+xFPNN2gI5pP4hdrgZj+y
         UKGqU4ohM/VopaLm2X+48vLv2d1JUwLYDwAYuy2Aa4ttZsIUHiMPv724mp/kib1odmJD
         6mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743595130; x=1744199930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpOpISsK92nzP8u+mrCrBVvlHehBgWb2S+ejZtPgHRk=;
        b=YE7tPLZzNe/zFfAq4w/dAdkbyfnDU6AbQZCboJ5SLX8JXGsawACQ6ReZJAD6MMK6t2
         50Kx9rFfz+tXVM6cz2DEo/uoY7lmwRhZBIGx5Wo+S1sa5gAoyhcmV9lsGOiejZevmnhs
         Bk6kauZkAUmNBBDOnm3BAMWksWyIbHS+4ygxKR/biPSdZaxUCME6RV8RGz76R2o5gxbe
         H7JyYxTG4N2bBh8Zq8oLmBJCSNiL8EED4AR616T9zlWGIEco0Tm+WRnqIrFl9NUBmrba
         3bRD3pf8Iq2rGQw2FcQB2rusdEwQI0xyBSr1ZqIvb31C3rZTZ0zHXE9Z6TI1/D6lQXeQ
         Nhbg==
X-Forwarded-Encrypted: i=1; AJvYcCUdU6uv2llXQbJzJlcHD5V1JPbCfp4k/hOqjbJtehYeK+tYTdbFi/PbN5779oePz7CY8uKAlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcDcZ/arbDfMJnkAkjK1INWalySOwMLhuas3rRexBMIMIP5ywX
	UeZJ/j9HtWAg+Y/gSwhlaaWi7xOhKO/j2bYhJOLz3/I5PevsruaxX6HH82gz/Q5jqU8pJWwucJB
	fpAeeT4QkH/+7rBR839ZWbpV2R9i7SbAk+JlVRg==
X-Gm-Gg: ASbGncurb7zJreFrJGw51AMOesuoQmIq9X1QQ8FuQcH+QfIIl+pNuBlHyIUqzT1UXX8
	nMY0lphxatjA1dYq8SVvK0U39KKC2rWGqK4Gl2SdEfDLZH8E+NKFMEwlGVmbAxJ9NxUhyys9Bn1
	FB/inzgMjppSXiRU/w8yuSEzNtRFKppXxS2u1AdhI=
X-Google-Smtp-Source: AGHT+IF3cEFgXzdw0KASyYJbIgo8CjfwnxgRulQ8O3ZcGZVY1greNWnfIf6SArRocnrBaky8kBjQ3GFF0cDB7r4EhsM=
X-Received: by 2002:a17:90b:2711:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-3056ef08027mr3048369a91.28.1743595129770; Wed, 02 Apr 2025
 04:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250325144252.27403-1-luxu.kernel@bytedance.com> <8cfe938f-5eff-483e-95a1-c4029993e287@arm.com>
In-Reply-To: <8cfe938f-5eff-483e-95a1-c4029993e287@arm.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 2 Apr 2025 19:58:38 +0800
X-Gm-Features: AQ5f1JrCmdbPvgxjXXBONrqT24lyujGReyf184CCKAQbeGFTcfNc41gd0CSYnb8
Message-ID: <CAPYmKFv_qRmsR+4s3evxCJjzVavtNb6UFRX6+JmepUW23X=ZLg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32
 bit I/O bus platform
To: Robin Murphy <robin.murphy@arm.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, alex@ghiti.fr, 
	lihangjing@bytedance.com, xieyongji@bytedance.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin and Jason,

Thanks for your comments and sorry for the late reply.

The iohpmcycles register is handled specially because unlike the other
IOMMU registers, its effective bits lies in the upper half. I want to
ensure that all effective bits are the last ones to update. For
example, when updating DDTP register, we update the upper half first
which only contains its table PPN, and then update its lower half
which contains the MODE bits which really enable translation. The main
reason is that when software splits an 8-byte write to two 4-byte
writes, the hardware is not aware whether it is an 8-byte write or a
4-byte write when it receives the first write. Thus it will always
make the value effective every time it receives a 4-byte write.

On Wed, Apr 2, 2025 at 7:29=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2025-03-25 2:42 pm, Xu Lu wrote:
> > Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
> > splitting 8-byte access into 4-byte transactions for hardware platform
> > whose I/O bus limits access to 4-byte transfers.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >   drivers/iommu/riscv/Kconfig |  9 +++++++++
> >   drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
> >   2 files changed, 32 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> > index c071816f59a6..b7c9ea22d969 100644
> > --- a/drivers/iommu/riscv/Kconfig
> > +++ b/drivers/iommu/riscv/Kconfig
> > @@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
> >       def_bool y if RISCV_IOMMU && PCI_MSI
> >       help
> >         Support for the PCIe implementation of RISC-V IOMMU architectur=
e.
> > +
> > +config RISCV_IOMMU_32BIT
> > +     bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
> > +     depends on RISCV_IOMMU
> > +     default n
> > +     help
> > +       Support hardware platform whose I/O bus limits access to 4-byte
> > +       transfers. When enabled, all accesses to IOMMU registers will b=
e
> > +       split into 4-byte accesses.
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index 46df79dd5495..0e3552a8142d 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -14,6 +14,10 @@
> >   #include <linux/iommu.h>
> >   #include <linux/types.h>
> >   #include <linux/iopoll.h>
> > +#ifdef CONFIG_RISCV_IOMMU_32BIT
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#endif
> >
> >   #include "iommu-bits.h"
> >
> > @@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu);
> >   #define riscv_iommu_readl(iommu, addr) \
> >       readl_relaxed((iommu)->reg + (addr))
> >
> > -#define riscv_iommu_readq(iommu, addr) \
> > -     readq_relaxed((iommu)->reg + (addr))
> > -
> >   #define riscv_iommu_writel(iommu, addr, val) \
> >       writel_relaxed((val), (iommu)->reg + (addr))
> >
> > +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > +     readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, con=
d, \
> > +                        delay_us, timeout_us)
> > +
> > +#ifndef CONFIG_RISCV_IOMMU_32BIT
> > +#define riscv_iommu_readq(iommu, addr) \
> > +     readq_relaxed((iommu)->reg + (addr))
> > +
> >   #define riscv_iommu_writeq(iommu, addr, val) \
> >       writeq_relaxed((val), (iommu)->reg + (addr))
> >
> >   #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, t=
imeout_us) \
> >       readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, con=
d, \
> >                          delay_us, timeout_us)
> > +#else /* CONFIG_RISCV_IOMMU_32BIT */
> > +#define riscv_iommu_readq(iommu, addr) \
> > +     hi_lo_readq_relaxed((iommu)->reg + (addr))
> >
> > -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > -     readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, con=
d, \
> > +#define riscv_iommu_writeq(iommu, addr, val) \
> > +     ((addr =3D=3D RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> > +      lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> > +      hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
>
> Echoing Jason's comment, what is this even trying to achieve? Nothing in
> the spec suggests that the cycle counter register is functionally
> different from the other PMU counter registers (other than its
> self-contained overflow bit).
>
> It is not, in general, safe to do a split write to a running counter
> either way - low-high vs. high-low just moves the problem around,
> changing *which* combinations of values are problematic and capable of
> overflowing into each other between the writes. If the PMU driver can't
> write counters atomically, it will need to ensure that it only ever
> write them while stopped (at which point the order surely shouldn't
> matter). Conversely, though, reading from running counters is a bit more
> reasonable, but it needs more than just hi_lo_readq to guarantee it's
> not got a torn result.

You are right. It is more appropriate to ensure update iohpmcycles
with cycle counting disabled. I will remove this redundant branch in
the next version.

>
> Thanks,
> Robin.
>
> > +
> > +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > +     readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), va=
l, cond, \
> >                          delay_us, timeout_us)
> > +#endif /* CONFIG_RISCV_IOMMU_32BIT */
> >
> >   #endif
>

Best regards,
Xu Lu
