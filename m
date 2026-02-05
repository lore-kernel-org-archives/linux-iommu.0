Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0171D5CDE
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257498; cv=pass; b=TphibfUx8R30LgV7WA9jCjG7oi/pofmVgnnkAFHC2F5dLvzQP8xYZi/h9TrL2DjytYeooGVskYMzzOI3VItG1xfqNLkNFMtRcXhxicvhs2bBfYaQJpk9GripJfCutqE+PQLOcLGWsrHzFkDarWxUnW6OQhO9i3ObEXmcO1OrgMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257498; c=relaxed/simple;
	bh=LzenXCyNDGAV2/s4Mt5xg7gtxO2w2kJ2SKaLgFjq5Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll5t7LvnB2UjvIZK1+bFxaO6ncfo6rw9Wo/EM7Vr7DzBJ4nOTrbtiHshDppVitcDUysssAuWiVVDv6LJ54s2CEMuuN+k+dzHwz8hfbGHlNh1fpwbe3uGnuuXYbQMqP/XgXKGiC8cqA3NLrHHgN+MXg5Dsxm8DMHxnVtshqeS/UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XdnAF2xN; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XdnAF2xN"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8e9c8ada38so60199566b.0
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 18:11:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770257496; cv=none;
        d=google.com; s=arc-20240605;
        b=GmiRgkLDoh0oYLLqxgRnKgLxLU1y+cY3aD15b4zSLa0zM43PAsbqjewWDwE/McuE1y
         c0KGzY3gieJ4CLhLc7Z/5WY2z9hZ4m05ViUnK+kn9jNlufmeA3H06+/SskH3JLXyL455
         El37C2k7yo4obunQ6nkugPz3s+AcLYSBwQAf4PRGtXqxU34xRiKWPu8en21Uuhoo5kEk
         jQU9xuz6q6wW2psxxV+Rp1ueo3sTAgzIx2IefFPL4gGaVRDan54PsszTLHskemfuETN5
         CJrodjz2c0sZEP2aUYPs2iWRt8KHIBVpEEz0yprN2nFFxCIy8OmMRqYEzxkrcWMUcrvQ
         u2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXfwfxqJ3Ud1a18EjbgGs6RmrKLEcJt2awiaooMVBjk=;
        fh=SdHJF4O20kWhQ1scP/whcic7tA34/sB0g1RurMlg+1M=;
        b=IJSFRM1UZI2/6AaLgyxNIojEncrwsCS9RQPRJagq6A/h9Yaz0/inHBpuVuVmj+xVQG
         vcVCmfRVfoUzlggzHDujNVzDrrbG3itdq5O2c9bnlqORU4M5yz2c3qIpsSE1RS8nak9S
         6IjvCETVsQtL3mkd2mnJvEwF6lDvAI4FzvawMglzkAJpE5cwftWp7WEUdWRLeSuSmq+b
         l+Gvfum9tDojl25ygxtwnM2eNpKS1pJFhg426DxQ6vNmoDePVuIwy2jA8T7YpoEbPf+U
         TgMcalz7mteLn5F0TxsdZezGencVDLTeO2xxKSkTtNp1PejY20C2YnODV8y5CmhN+F53
         cBbw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770257496; x=1770862296; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXfwfxqJ3Ud1a18EjbgGs6RmrKLEcJt2awiaooMVBjk=;
        b=XdnAF2xNtFCVDx/hfNoUHeQj963fV/PLeTIprpoohXHuFa3AFrQKg8OT88yrvr+9kc
         qBnuWgOm5UaG9lzJso91a9odnIjO0HL2eiPgSnqkto2VWt1vjx0gtGaGzvZSRqtilLFF
         xlCjUy8K4qaH5jer+DT/6tm5hXhHkNSHOiDNveJYHIZOwy4T00KlkyPAQinmOFrxjXQT
         OJDqqvTnrPuTUTFJIQgctscl0Ddb4kIjFy2VL9kcWSyfINmmhYMPb2nNUVLAiAgnCfbi
         sMKz1KNymB1xuyTFOcyNvsquSkrvKxq3srSaGyjzrB34a48hwj95N2hQcABl0bvvHw00
         dZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770257496; x=1770862296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXfwfxqJ3Ud1a18EjbgGs6RmrKLEcJt2awiaooMVBjk=;
        b=nujX0ERPynkwlamUvr5xy755M/CClvsv0LSeKeSijtQP3EOVVUa6NcNto+4nZ6sM1Y
         JTKkpSw0JfODIlx+DwSSV6kjFxx3fJ/QXUkiTrLd3BKqva9Iwl/FM7rPUp2d+mZ/uIqy
         gjN7hXs6/CkpZiGobXDWeCV3RiiAXLPsAzAA5fSLKpcmLjHbM0D5pYRYGNLSplWwmPEg
         YMYFbQG/DNk8Dz5yoxw5lXK49mUQcytzgk1Q/Pcn2x7JPTdlRzIdiUYlboBgOPpokWou
         D26hGEGrWzUqSdu2nIp7wSQUeZ6DiYb8vnDCnUWqwldDP00ubEZP63qgBJ9BdysSbccB
         5iJg==
X-Forwarded-Encrypted: i=1; AJvYcCWfByRvTQMep/8rYNU9ePARkMGtWV5wa4nZuJqL2tuiJlXc5NAl0lH4tVUwit74VeHTeVAG7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkbbKjU0Vy/eeimRDUCXnWvzS1/AvQnaR0W6GiIQ36xMWqjGoa
	wXbUlubOAUZacV55Q/cIOEqOIDJYNtwxCkRCBlApuzIOwNwKVC8nmKTnvWZ6s2EcHJd4JZL847K
	ZkZqIMeKxuVr/S/mVG3u2WtHJha+UP7jIgTdFdWS91w==
X-Gm-Gg: AZuq6aIXi2wurke0XFR7k1Xnq10Bla2z4nNjmsn8sYn9A8dnPXRVof+OxZcUZWBRHcw
	qe7KtNP6dRjSyZmZr9OJnJXa8Wy/L1EkfDCLVnFr5OhpeLKjojWZVdPfWEc4DSUatHk59XeUfZ5
	1/1Tf8IIuQ5jfGSFw6ByAt2wVj+Na0rYBvlRILkQgWOjfgPrX4lxGRwMbjTtLAUB7B9AUu0SZit
	+6hhYIisK912/2y1Ei2bwg4qyfm+i5PaSwevVrpHRLy9Pere0fJkBKiRKJ4EzOZLqV/QpkKqQ==
X-Received: by 2002:a17:907:26c9:b0:b87:892:f43b with SMTP id
 a640c23a62f3a-b8e9f196585mr325916866b.42.1770257496389; Wed, 04 Feb 2026
 18:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
In-Reply-To: <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 5 Feb 2026 10:11:26 +0800
X-Gm-Features: AZwV_QhMZOXglwbGVqgOIj-KY2N0eLcLOg3n2x9z4Uh395TNa1CEOvBa9sxLG3g
Message-ID: <CANXhq0oi9nE7ffLGsz5j8GnC1UDTD-4bE4cantRjW2fXHYrjHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance monitoring
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Lv Zheng <lv.zheng@linux.spacemit.com>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>, 
	Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:39=E2=80=AFAM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> How does this relate to
>
> https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
>
> From a quick skim it looks like there's plenty of overlap.
>
> Thanks,
> drew
>

Hi all,

Thanks Andrew for bringing me here, and sorry for the long delay on
the IOMMU PMU driver series.

I=E2=80=99m currently working on the next version to incorporate the feedba=
ck
from my earlier series. The main goals are to decouple the IOMMU perf
driver from the IOMMU driver itself, and to make it easier to add
custom events.
The implementation is almost done, but I=E2=80=99m still working on binding=
  a
name between the PMU driver with the IOMMU driver on PCIe and ACPI
cases. This part is related to how custom events should be added.
That said, I=E2=80=99m thinking that I could submit the current implementat=
ion
first, and then send a separate patch series later to handle the
custom event support.

Also, I=E2=80=99d like to mention that Yaxing has a similar implementation.=
 We
had some discussion about this last month.
https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@bo=
sc.ac.cn/

I think I should be able to submit this next week.

Thanks,


>
> On Wed, Feb 04, 2026 at 05:09:01PM +0800, Lv Zheng wrote:
> > From: Jingyu Li <joey.li@spacemit.com>
> >
> > Introduces perf-based HPM driver for RISC-V IOMMU, enabling performance
> > monitoring capabilities.
> >
> > Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
> > counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
> > indexes of other HPMEVENTS in order to correctly index into IOHPMEVT an=
d
> > IOHPMCTR registers that have already been defined in the iommu-bits.h.
> > However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-1=
 as
> > the indexes of other HPMEVENTS, thus care should be taken in dealing wi=
th
> > counter indexes between userspace and kernel space.
> >
> > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> > Link: https://github.com/riscv-non-isa/riscv-iommu
> > ---
> >  drivers/iommu/riscv/Kconfig          |   9 +
> >  drivers/iommu/riscv/Makefile         |   1 +
> >  drivers/iommu/riscv/iommu-bits.h     |   6 +
> >  drivers/iommu/riscv/iommu-hpm.c      | 843 +++++++++++++++++++++++++++
> >  drivers/iommu/riscv/iommu-pci.c      |  13 +-
> >  drivers/iommu/riscv/iommu-platform.c |   8 +-
> >  drivers/iommu/riscv/iommu.h          |  42 ++
> >  7 files changed, 919 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/iommu/riscv/iommu-hpm.c
> >
