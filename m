Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F517D6
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754329; cv=none; b=aBw7S6WfSkPMVNuSBAdhrmED+IIQZLtXw4MJ0NX043DkZHr2f05YQYtEg9xfOugiD3rdaE5o34t8wYBoY5Zjn5+LF8rsLWG9P51HBiph0tIpV1wtlr5dqFduk+EGM9oq1gxCDJk0bDt3S18TDuzhsAQL9W1M2eNPxXKJV0CLuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754329; c=relaxed/simple;
	bh=8Op7rbc84uL2wnhSbqYQH6YdsUeXtPCC4NTBIAenp+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHWgTens9/m8UyEADHiJVbvvdiQKoQwGEwlPu9mOfW83NAQxBo3LsNAVoSiepVFx0V5ASCnEGNcNeT+/FDJ1F1C4uZRH7lbtrm9QMycpxVf1YhMoynBUeSBju4MtXMfyAMm2FLCxGKDTFeRpR5LkuIN5+/Al7nTDDnn6eZd6xSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNNX+u4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNNX+u4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7952E1F00A3E
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 03:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781754328;
	bh=8Op7rbc84uL2wnhSbqYQH6YdsUeXtPCC4NTBIAenp+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BNNX+u4dhnDJLmn2Dw7VTze4GSltFarsAgRxyXy8r72uQCieWSdEtbTWaI2kzfyg4
	 ne7+u9n/u0IiLYDHreyunN0SlGvw2TK3DEBYVWs2He3Vm75vGUGPMob+4ouqGxLxRR
	 MNp3Ps3OPUTarZMoKc/miVE4ZohTIBLborea3VwmPCS+EY6lXJxpWCQ9B2/aUfI1HA
	 AlL/wSRIOUuYFr0BIj85yYH2P/APaTSJ9PBEDRohPuZxlxCu9+ELy890IVbAzaoB/e
	 aGQOdED4aWFtJXCo3PPXPGt1Xx9eE9kQHhMbsp391VqYkyy/RgYqY9+6IN+kjoFm7n
	 A54+yn7foOVxQ==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4619990ca5fso314305f8f.1
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 20:45:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8v7/OmADm6OfZSqubJAoNt5HxhH25onY6FouysX5cV6bDoWpxCe0MWlj2bIHorxuVUM7GLXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyki1hHVHA4QJOhZwxU7Sa9+FBmfZ5VHBP2U0vbzP3+JHSP1zFX
	Y6YS3WrbqIfJ0aL/diFnCXJRcZErvXbD0Mp8QG+jP/ObjgyV+o+7/K30NA1VHih9Y0wxB6Gj/G/
	oRGtXYPGObKYsmDcHLXz5bcx4vjtY+Ag=
X-Received: by 2002:a05:600c:548e:b0:490:e196:e8df with SMTP id
 5b1f17b1804b1-4923821becfmr29334925e9.23.1781754327175; Wed, 17 Jun 2026
 20:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
In-Reply-To: <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 18 Jun 2026 11:45:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
X-Gm-Features: AVVi8CfWRFYTKPYCg8iVarn6CtPCXnAOdCb6y_53sU4cq8ytAi5YOIPu4cUwK1k
Message-ID: <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 11:20=E2=80=AFAM Vivian Wang <wangruikang@iscas.ac.=
cn> wrote:
>
> On 6/15/26 20:38, Guo Ren wrote:
> > Hi Zhanpeng Zhang,
> >
> > I noticed you posted a similar fix recently. However, I had already
> > submitted a similar solution back in September 2025 [1]. It would be
> > great if you could review it. A few concerns with the current patch:
> >
> > 1. Using spin_lock_irqsave in such a small semantic structure is
> > unnecessary. IRQ protection should be provided by the higher-level
> > IOMMU driver interfaces. Many existing call sites already handle IRQ
> > disabling, so adding it here feels redundant and adds avoidable
> > overhead.
> >
> > 2. More critically, the RISCV_IOMMU_32BIT_ACCESS Kconfig option is
> > problematic. According to the RISC-V IOMMU specification (Software
> > Guidelines, =E2=80=9CReading and writing IOMMU registers=E2=80=9D):
> >
> >> Registers that are 64-bit wide may be accessed using either a 32-bit
> >> or a 64-bit access.
> > This clearly requires that any hardware supporting 64-bit MMIO access
> > must also support 32-bit MMIO access. Therefore, the IOMMU driver shoul=
d
> > be built on a 32-bit access base for maximum hardware compatibility.
>
> I agree that the driver should be build with 32-bit accesses to support
> these hardware. However there's one minor thing that I want to propose
> regarding this, for the sake of clarity:
>
> RISC-V IOMMU implementations that do not support 64-bit accesses are not
> fully compliant with the RISC-V IOMMU specification and should not use
> the standard RISC-V identifiers, namely:
>
> - Devicetree compatible riscv,iommu
> - ACPI HID RSCV0004
>
> This, in my opinion, is not only the right thing to do (not claiming to
> be standard hardware without actually being standard hardware), but also
> saves a lot of trouble for operating system developers (yes, there are
> RISC-V operating systems other than Linux out there), since invalid IO
> accesses usually manifest as mysterious access faults (that would
> usually suggest an incorrect IOMMU address), or worse, system hangs.
>
> I would appreciate if the hardware vendors shipping 32-bit-access-only
> IOMMUs would consider this.
>
> Vivian "dramforever" Wang
>

32-bit MMIO access is explicitly supported by the RISC-V IOMMU
specification and is a valid choice (64-bit MMIO access is optional).
64-bit MMIO access is not "free" =E2=80=94 it consumes additional interconn=
ect
hardware resources.

Could you elaborate on the concrete benefit of using 64-bit MMIO
access in this driver, for these non-PMU registers? A clear
justification would help evaluate whether the trade-off is worthwhile.


--=20
Best Regards
 Guo Ren
