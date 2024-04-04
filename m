Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8848665A
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252240; cv=none; b=mtVzlJ3dTnC1QJJ25wGFEoP9/cys8U56vBD5z5kH4QTJsBWK4rgWUCUY4VK+oROwVdDjwZm7D/cvzaqiwTZbY3jirSLweX4Ty3atrWSv8bhRT9aHXsVxgt1xMMlcnl6XRyfAaq7zYySxZO/MgYK6MkRp0cSJn1mlRBZHWgpHhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252240; c=relaxed/simple;
	bh=qNxmB9dvz4cGF0PgT9uMqcRVLK8IoGpeK+milK+2GFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1kcbCmqhyF4vGErjknkVht3e7QYmN5j9Cfdo8qAhKysUekrvnZcOOrtbWeq5DSE4kOkcpjne7frFhkQcxOGYlxlUnAvyU8xka6H7zLewYj51wj+A4I+nPjCFtu5r/IGSoO1jnfpdvlYcOw8jn+H3i9pg5jTY4c7LA/LOolTmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RrBFxG/O; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RrBFxG/O"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a28b11db68so827524a91.2
        for <iommu@lists.linux.dev>; Thu, 04 Apr 2024 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712252236; x=1712857036; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0YGAbo5VsMRKNvr6HUFHGXg4ydusoh6NcFGvWhqL/0=;
        b=RrBFxG/OIow28PUr6ZYTdGT/KlfdAkEvR+6SyidvaYMAEoi1pcq6/Xgd4l0IuRdFAe
         KqJa3g05DSD9c1wzLUFVV5+2+oRZNnI+E+RlTKHp0mE8jFwx5YdgXWsJAzAiUp6H60pq
         oK89SY2b5O9wlmDxQTElPjFA/TsQv+QVNovcGU6+vKGKstbavYX3+hnuqtzZvsiaxXg+
         rs1FM0HgHMUJ3P80cxFrP6/mY5v9ixhBxMKu+xICQJZS8ZXY5J0VKFTAt+dsIDC9Wmbg
         J5/zdymCdxRP9+pd2NzsRWElpscGPNtF9zpmonZmaMMKesmDIcuT92Wv04ep2CRpOI1X
         wMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252236; x=1712857036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0YGAbo5VsMRKNvr6HUFHGXg4ydusoh6NcFGvWhqL/0=;
        b=Jcoj/Enst364KpCREbV4H3cYz7PVOW+rInJDxfKnXNLRs5Kz7HWD++O+CsQuBM0m98
         m82dGhI9m1MUJLa8UT0cHklJPGYHfLOYzRXPp0EPZQ8+lVhbNrzRsvjaOdy3lOcPc9U9
         YRWIQcoTUximODLAoOKyROwWBSjYarrqjKVL364y7ehMjuOC1MxGnuA5nAdje5qpAlxr
         /gFq5yf1wyBGAmA0Myh/or8EtKPRBIrTaAZxfEnTDuKgWURkT02PFp/ryhSKglgdxm65
         gpdEki7PrTcc2Du+L9XUtF4H+pclMO6tfzGdxyEXT6WOKwSZKm/j3h5DybgjC8FhNlqC
         80pA==
X-Forwarded-Encrypted: i=1; AJvYcCU54sV7ao2eazq1NTK/7oIPGWXoMFwa7k6lC0dAsbx+BjWvq7jkgUIMSL+blNYPrh3i1qMyyn+HEOX2JFRR2j2v3eI0q8U=
X-Gm-Message-State: AOJu0YzXtbFEzkBaDryeG1ZZi49Lt9a1zco+V0fnKxQHG327SdgK6g3E
	ySrnrQjFiM3Pn707SvFl64vh3d2asH3SqvqYYrGEDQpQfIxR38s5QyzReEQtiNJyTTtHUH0fx+a
	Pec2aAh2duQseNLGcDiv37JlkxN4lPK7XZfFoDg==
X-Google-Smtp-Source: AGHT+IE0DwpVP9FvdgUiEaX9DyIxnkxvkjXoN3ggf7SGLxyoGEAQiYNn0vs3zY4qK/tte6bUofAXx0ODGxiK9gbQHcs=
X-Received: by 2002:a17:90a:34c9:b0:2a2:bc66:1ead with SMTP id
 m9-20020a17090a34c900b002a2bc661eadmr3184921pjf.38.1712252236354; Thu, 04 Apr
 2024 10:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <CAHCEehJKYu3-GSX2L6L4_VVvYt1MagRgPJvYTbqekrjPw3ZSkA@mail.gmail.com>
 <CANXhq0qsZS7sB-npPKdnFaWi2+yUc_dROCsVXZDHo07-a34wcw@mail.gmail.com>
In-Reply-To: <CANXhq0qsZS7sB-npPKdnFaWi2+yUc_dROCsVXZDHo07-a34wcw@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 4 Apr 2024 10:37:05 -0700
Message-ID: <CAH2o1u6seMkt5stxkpr4JCdmU3ZXDid5gDL7+9abNg=zPqdFdQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Linux RISC-V IOMMU Support
To: Zong Li <zong.li@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Greentime Hu <greentime.hu@sifive.com>, linux@rivosinc.com, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Nick Kossifidis <mick@ics.forth.gr>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 6:04=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> >
> > The RISC-V IOMMU specification is now ratified as-per the RISC-V intern=
ational
> > process [1]. The latest frozen specifcation can be found at:
> > https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/ris=
cv-iommu.pdf
> >
> > At a high-level, the RISC-V IOMMU specification defines:
> > 1) Memory-mapped programming interface
> >    - Mandatory and optional registers layout and description.
> >    - Software guidelines for device initialization and capabilities dis=
covery.
> > 2) In-memory queue interface
> >    - A command-queue used by software to queue commands to the IOMMU.
> >    - A fault/event queue used to bring faults and events to software=E2=
=80=99s attention.
> >    - A page-request queue used to report =E2=80=9CPage Request=E2=80=9D=
 messages received from
> >      PCIe devices.
> >    - Message-signalled and wire-signaled interrupt mechanism.
> > 3) In-memory data structures
> >    - Device-context: used to associate a device with an address space a=
nd to hold
> >      other per-device parameters used by the IOMMU to perform address t=
ranslations.
> >    - Process-contexts: used to associate a different virtual address sp=
ace based on
> >      device provided process identification number.
> >    - MSI page table configuration used to direct an MSI to a guest inte=
rrupt file
> >      in an IMSIC. The MSI page table formats are defined by the Advance=
d Interrupt
> >      Architecture specification [2].
> >
> > This series introduces complete single-level translation support, inclu=
ding shared
> > virtual address (SVA), ATS/PRI interfaces in the kernel driver. Patches=
 adding MSI
> > identity remapping and G-Stage translation (GPA to SPA) are added only =
to excercise
> > hardware interfaces, to be complemented with AIA/KVM bindings in follow=
-up series.
> >
> > This series is a logical regrouping of series of incremental patches ba=
sed on
> > RISC-V International IOMMU Task Group discussions and specification dev=
elopment
> > process. Original series can be found at the maintainer's repository br=
anch [3].
> >
> > These patches can also be found in the riscv_iommu_v1 branch at:
> > https://github.com/tjeznach/linux/tree/riscv_iommu_v1
> >
> > To test this series, use QEMU/OpenSBI with RISC-V IOMMU implementation =
available in
> > the riscv_iommu_v1 branch at:
> > https://github.com/tjeznach/qemu/tree/riscv_iommu_v1
> >
> > References:
> > [1] - https://wiki.riscv.org/display/HOME/Specification+Status
> > [2] - https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-in=
terrupts-1.0.pdf
> > [3] - https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu-202307=
19
> >
> >
> > Anup Patel (1):
> >   dt-bindings: Add RISC-V IOMMU bindings
> >
> > Tomasz Jeznach (10):
> >   RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
> >   RISC-V: arch/riscv/config: enable RISC-V IOMMU support
> >   MAINTAINERS: Add myself for RISC-V IOMMU driver
> >   RISC-V: drivers/iommu/riscv: Add sysfs interface
> >   RISC-V: drivers/iommu/riscv: Add command, fault, page-req queues
> >   RISC-V: drivers/iommu/riscv: Add device context support
> >   RISC-V: drivers/iommu/riscv: Add page table support
> >   RISC-V: drivers/iommu/riscv: Add SVA with PASID/ATS/PRI support.
> >   RISC-V: drivers/iommu/riscv: Add MSI identity remapping
> >   RISC-V: drivers/iommu/riscv: Add G-Stage translation support
> >
> >  .../bindings/iommu/riscv,iommu.yaml           |  146 ++
> >  MAINTAINERS                                   |    7 +
> >  arch/riscv/configs/defconfig                  |    1 +
> >  drivers/iommu/Kconfig                         |    1 +
> >  drivers/iommu/Makefile                        |    2 +-
> >  drivers/iommu/io-pgtable.c                    |    3 +
> >  drivers/iommu/riscv/Kconfig                   |   22 +
> >  drivers/iommu/riscv/Makefile                  |    1 +
> >  drivers/iommu/riscv/io_pgtable.c              |  266 ++
> >  drivers/iommu/riscv/iommu-bits.h              |  704 ++++++
> >  drivers/iommu/riscv/iommu-pci.c               |  206 ++
> >  drivers/iommu/riscv/iommu-platform.c          |  160 ++
> >  drivers/iommu/riscv/iommu-sysfs.c             |  183 ++
> >  drivers/iommu/riscv/iommu.c                   | 2130 +++++++++++++++++
> >  drivers/iommu/riscv/iommu.h                   |  165 ++
> >  include/linux/io-pgtable.h                    |    2 +
> >  16 files changed, 3998 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu=
.yaml
> >  create mode 100644 drivers/iommu/riscv/Kconfig
> >  create mode 100644 drivers/iommu/riscv/Makefile
> >  create mode 100644 drivers/iommu/riscv/io_pgtable.c
> >  create mode 100644 drivers/iommu/riscv/iommu-bits.h
> >  create mode 100644 drivers/iommu/riscv/iommu-pci.c
> >  create mode 100644 drivers/iommu/riscv/iommu-platform.c
> >  create mode 100644 drivers/iommu/riscv/iommu-sysfs.c
> >  create mode 100644 drivers/iommu/riscv/iommu.c
> >  create mode 100644 drivers/iommu/riscv/iommu.h
> >
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Hi Tomasz,
> Could I know if you have a plan for the next version and if you have
> any estimates for when the v2 patch will be ready? We have some
> patches based on top of your old implementation, and it would be great
> if we can rebase them onto your next version. Thanks.

Hi Zong,

Thank you for your interest. Next version of the iommu/riscv is almost read=
y to
be sent in next few days.
There is a number of bug fixes and design changes based on the testing and
great feedback after v1 was published.
Upcoming patch set will be smaller, with core functionality only, hopefully=
 to
make the review easier. Functionality related to the MSI remapping, shared
virtual addressing, nested translations will be moved to separate patch set=
s.

Complete, up to date revision is always available at
https://github.com/tjeznach/linux/

regards,
- Tomasz
