Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B599199244
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965576; cv=none; b=ePDkP5rMpxAX+JqNxX5/7uy86ylfuMV1hyfpL9RHuo805zoi0TzkV2Ij9WmnIk0Dk4af6LAk5W4mJ1O6/hPIGozQVbyFrWoI4cb0SsDsAx4aDeLo+7qaWv7DLasfk1NvnTJMglcr6TU7cQa9D/2KskDWm7DxcYRMpsnMqBx7cAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965576; c=relaxed/simple;
	bh=d8pDyNbjf/sc3hwzZLrN3llQSuPixQ1BrsZrYCOj9ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Niq3MCEVH8E9vJljgIEHgawugfOr66j+Qi9GJsdiEg1vlSTo5zD5TFm4a9tHWGl5ITZRhPsOl+clkBQpbBZjlNi4u22EbmTJAHwP9EaaTuk0tvT1U7VAB7ISUkX1evHJh8heGYDAfVputuwUM62PBBdh/JNpmLli35W7UhJyx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9pGRPTg; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9pGRPTg"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd43aa1558so1563176d6.0
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 10:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736965573; x=1737570373; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56NS9QFu3nqyt2X92cCfR3Efbv5GWPlnT7v7XAEeafM=;
        b=O9pGRPTgc8revH+vq3ojFrDoLSDdmUDhF3x/CE394ro9rnB8o78MmmJAkSIZ6ukJZG
         2W96XIZ1/r3gixhLvU4pzmrOe5P3S4nhB20HNa7A1wwAMCMeRDDTURJ198HNv8Tysxxf
         c/wgMy6YBOhqDkLXnmwzahr1Hbkg+H2Mn1nc5TfzG9Y7w426EDBkCm/kMEsghq8YIkVc
         6auIjOZcf/VbfXtDJF7CIoCa7B0iK69bRNQSSEZnbm26y9+RqRM3nVZpOk/wzJ3h/Wcu
         Hzo+fZHbcIjj0hriZQStpbcZajuwwhd983ObLpjReM6zHfRw9wzfTU1lPPT0tuR3LWGP
         yKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965573; x=1737570373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56NS9QFu3nqyt2X92cCfR3Efbv5GWPlnT7v7XAEeafM=;
        b=EEbqQ0/oyukvedmmDyvPhEYuy8VgipCOAUKTtxxcwiC/x84kKsONP7UCjhM6Fz/PE3
         Bmj376JftYRRVIJ1FoE/5Z7qcIxBr3LdBSn0+5R/DpZ3SA9WxWcfqi8I4U3+8h9JjHJC
         6IJ7wmZ7Yyg0rIH9iVVl5DO26NaM9/Si9d4JuUuMUJFOh/0C1WG0wPQUZWtlY++iwUyf
         e1lCo3GG1Yyu+D6MSekzxUw56E18jYX5OWusWyITgRF8I5xSiGhiweSeHDcGxcpOoHYs
         sfarmpMAYAQ352pW7Alyyq12Ionr3HnekabXPhcfNPsd0C3bjABd3VM9Ed60k5HOfBoM
         xNhA==
X-Forwarded-Encrypted: i=1; AJvYcCW5r5Qs1ntybekDg4cWJrGAnTDFaE1+rrClj2epDj1o4fIR/S2vbB5HbN/6Yru9Kxm+KUd1MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLo3AGqizjbmDZQG5zrW6qy/PZYvQ6ZahgnIjznUZ4T7KuLN73
	EGk628uX+BrlKsGcaXoGs5KQhzUi978hrkhS1Eo87XwAWAXZIw7iNffcXiH8jXhbK7qntTvGcV8
	yrVae8xgU3YQq8fgX9ni+KSgG5lqk+vceWORAWg==
X-Gm-Gg: ASbGncsH2w/x8S52odmJiTMQmE7h5RDc5EPNSKcaYlZOsXP45imxDRJ99HOBGxJBO/F
	TYkgaAytdBN2HTgs7WqyXRq5URfMsGyyshKXNtQ==
X-Google-Smtp-Source: AGHT+IFZ7LDpCgk+/ixdVgpNuaVhVLnP72hjhsHZcggTnKpcAZNiZOdxIC0i/Y0rcAWUWwUH/WEMoeQpL02BdxVsSe4=
X-Received: by 2002:a05:6214:5bc2:b0:6d8:a730:110d with SMTP id
 6a1803df08f44-6df9b0eea41mr464717506d6.0.1736965573650; Wed, 15 Jan 2025
 10:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
 <0cac0b13-128c-4d8b-b235-09d7b440ad8e@vates.tech>
In-Reply-To: <0cac0b13-128c-4d8b-b235-09d7b440ad8e@vates.tech>
From: =?UTF-8?B?TWlsYW4gxJBva2nEhw==?= <milandjokic1995@gmail.com>
Date: Wed, 15 Jan 2025 19:26:03 +0100
X-Gm-Features: AbW1kvamvNb2xBNlt0NnBIzllhDKyUtK5Hh8vPP6WZ7rdE4FF79WjPfZk5asYMA
Message-ID: <CAKp59VHBLtpxk7MD3StO8v8M5vdqbWU7AZaoxukzYPFCmSF91w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-V
To: Teddy Astie <teddy.astie@vates.tech>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	Slavisa.Petrovic@rt-rk.com, Milan.Djokic@rt-rk.com, 
	rafael.j.wysocki@intel.com, sunilvl@ventanamicro.com, takakura@valinux.co.jp, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Teddy,

On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Teddy Astie <teddy.astie@vates.tech=
> wrote:
>
> Le 14/01/2025 =C3=A0 17:13, Milan Djokic a =C3=A9crit :
> > diff --git a/test.txt b/test.txt
> > new file mode 100644
> > index 000000000000..e54267998982
> > --- /dev/null
> > +++ b/test.txt
> > @@ -0,0 +1,21 @@
> > +WARNING: added, moved or deleted file(s), does MAINTAINERS need updati=
ng?
> > +#120:
> > +new file mode 100644
> > +
> > +WARNING: do not add new typedefs
> > +#808: FILE: include/xen/riscv/interface.h:15:
> > ++    typedef struct { union { type * p; uint64_aligned_t q; }; }  \
> > +
> > +WARNING: please, no spaces at the start of a line
> > +#1006: FILE: include/xen/riscv/swiotlb-xen.h:10:
> > ++    return 0;$
> > +
> > +total: 0 errors, 3 warnings, 810 lines checked
> > +
> > +NOTE: For some of the reported defects, checkpatch may be able to
> > +      mechanically convert to the typical style using --fix or --fix-i=
nplace.
> > +
> > +0001-riscv-Add-initial-Xen-guest-support-for-RISC-V.patch has style pr=
oblems, please review.
> > +
> > +NOTE: If any of the errors are false positives, please report
> > +      them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> I am not sure you want this here.
>
Sorry, this one is added by accident. Will be removed.

>  > diff --git a/arch/riscv/include/asm/hypervisor.h
> b/arch/riscv/include/> asm/hypervisor.h
>  > new file mode 100644
>  > index 000000000000..3a117afe57f0
>  > --- /dev/null
>  > +++ b/arch/riscv/include/asm/hypervisor.h
>  > @@ -0,0 +1,9 @@
>  > +/* SPDX-License-Identifier: GPL-2.0 */
>  > +#ifndef _ASM_RISCV_HYPERVISOR_H
>  > +#define _ASM_RISCV_HYPERVISOR_H
>  > +
>  > +#include <asm/xen/hypervisor.h>
>  > +
>  > +void kvm_init_hyp_services(void);
>  > +
>  > +#endif
>
> kvm_init_hyp_services seems KVM-specific and doesn't seem to exist (yet)
> for RISC-V.
>
Yes, we'll remove it in the next revision.

BR,
Milan
