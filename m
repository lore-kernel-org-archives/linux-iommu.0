Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4BEACE
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691147; cv=none; b=hlrNlyDI6VbwN1n7iuIuEJeXFX1KGGQa9VjqsIPpWA+TnODa7p2r+RrgKAx74VDG2OGcAeDAuahNBtFDDUVRbsel6V9SoO72t1Ubx4pKAz8LUGTxjj7sDh8gmQ2tns6hNX+EvLyZ6i5X4uwUlKdefBBlFwkCFPsqBy6jYjl7EVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691147; c=relaxed/simple;
	bh=dBmQ7ZVzsrxRsdMLl6QUAymnlQw5BhCQ/Hfi6mcSQGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hw8eLZjLW+DwJS6l3ZAicPpB/Uyq6VLB2kGUvn0glmIMrQm7mexckSuZ5zllZ9u597O/U0kBOrwk6bs3b+q0EjwYXo/Ya+ueEiUag1Wb647d0Pp2GW2xHcXkDWIy/pzgEqyNdr4GpwacgjCI+uWzG0BRsEjJe4LfizZV2SiEYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwNL3n2+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwNL3n2+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad560321ed9so250607766b.1
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747691144; x=1748295944; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgwrUkrkaZb0leOIfftTpt2Z9U+8ge4TCRzTvr8HRfg=;
        b=gwNL3n2+zCOvKsRW0/jUjRSEGOOYwh7I6RBgCOY1Dcbl2neDMWFt9gOH04weQhPRUB
         73UiSyuY228AOXXwEo5t43JD1oJ401TT6KUTh5aiMAtpjGk1H4ZGFjilB7BoOvd/tULc
         W6FZB+RuxVyj3Os2gauwHvG6EU1MJid2xn3+veFzqP/vVj8rYnDd9bnDNMcPZgaAxQ8E
         77H4LgXsoIm/XPBKfadKtAm7TpfpRGVGj2G0HLuVagKJW1lLYQjqQ+Oai6R28JkoLAex
         g+VGyLnQg54zgJdXkDsq/OYKRe3GkcvjVF0QSrYw6QI/aeaSe2UT04NSOLQAT+jiAbL9
         xoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691144; x=1748295944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgwrUkrkaZb0leOIfftTpt2Z9U+8ge4TCRzTvr8HRfg=;
        b=Y1sMSrIK0HqTCOgT9uiqZS9fJF+T8uS+3dJ0F5Qsc8/znm99vILiDwfPAWsI/El8cz
         aTd63Pj74OjVjqm/TOS1RzV6u74hlXs241h+yahwmsHz22AWe34jGcVYdfugcv5yyK9L
         GnpAx0lJETnfs+6s6eSEDlV1t6sbMUlPrhRkI/O3B2iHAcMpJdDrJb0OkhF9cNJA56Rk
         +76LQ9MlbuJyWgHUkJlu+zNESo9yG2xHCd/DdTyuBwuOVRExlRPJxBpn5iVQ/NCnJuu8
         U+3nD17DIZ1Z+i/+HE/YeGbSQ0C8E3mhmULC89SJGn/zOnCaw1EMpngLSyr6z2pvg21l
         UATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHKlZYWwoJXeIarkBJF+A6886rL9Kj45LJcb0moZSpHCF6j4y344iVL91BJL+OofuS5vqX5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF7LaFkyOjOs7mBc39ieA7qz7L76n7Glk+e3SjuC++HcW8yG9e
	lUb1WJ5cOmffCFWIansEHUfQlJH1L8O+LVnFk8zwaVZ4qUOEsZor3GHVdUe/cXaw+gktzOyS5x5
	jBmpA873v73OaIVK06lYFNPdoseq2Mig=
X-Gm-Gg: ASbGncu0ZlhHANhqiiUs7y75CadU4ECTqRRPAQyAZlWox4gdCFbMkPr6cNXcMRWeyoW
	mFlSiYgzQap4iS6E4ozJQaykxDz++oDbDr/DM/0TShzIUcKIPIEpSQp/Y+BIetEDv28bR+EEXlQ
	ZVin8P7pjIpzweGWeCNn8JVRjB3qCUhOY=
X-Google-Smtp-Source: AGHT+IGi6092BG38fgC8XNqiOOL5230Qmrls9fUA/vdLAMqijhah9L16wARI5KlQBQHVpTG9u4i5MttpQIJ/uhwrqx8=
X-Received: by 2002:a17:907:3342:b0:ad5:465d:8855 with SMTP id
 a640c23a62f3a-ad5465d9f5amr870659766b.36.1747691143715; Mon, 19 May 2025
 14:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250519175348.11924-1-robdclark@gmail.com> <CAPM=9tw183FMOT8uUacqegnb5CREAyr8KbXxO2mCuFK-SmUB1A@mail.gmail.com>
 <CAF6AEGuDTGVq7sw4oVuHb+cOE_DuKbEPO956oddVcsV2boieoQ@mail.gmail.com>
In-Reply-To: <CAF6AEGuDTGVq7sw4oVuHb+cOE_DuKbEPO956oddVcsV2boieoQ@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 20 May 2025 07:45:31 +1000
X-Gm-Features: AX0GCFtlQu6thz2-DodB9_hvAiBP83MybA9d3wKL9euWSYgx05ywhuPOmKRAvxs
Message-ID: <CAPM=9twuSfvQ0_NUdRmp0_VtTE_Br7GAysRw+XOoX7BTxUBGYQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v5 00/40] drm/msm: sparse / "VM_BIND" support
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, 
	Christopher Snowhill <chris@kode54.net>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Eugene Lepshy <fekz115@gmail.com>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Jonathan Marek <jonathan@marek.ca>, Jun Nie <jun.nie@linaro.org>, 
	Kevin Tian <kevin.tian@intel.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" <linaro-mm-sig@lists.linaro.org>, 
	"m oderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" <linux-media@vger.kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 at 07:25, Rob Clark <robdclark@gmail.com> wrote:
>
> On Mon, May 19, 2025 at 2:15=E2=80=AFPM Dave Airlie <airlied@gmail.com> w=
rote:
> >
> > On Tue, 20 May 2025 at 03:54, Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Conversion to DRM GPU VA Manager[1], and adding support for Vulkan Sp=
arse
> > > Memory[2] in the form of:
> > >
> > > 1. A new VM_BIND submitqueue type for executing VM MSM_SUBMIT_BO_OP_M=
AP/
> > >    MAP_NULL/UNMAP commands
> > >
> > > 2. A new VM_BIND ioctl to allow submitting batches of one or more
> > >    MAP/MAP_NULL/UNMAP commands to a VM_BIND submitqueue
> > >
> > > I did not implement support for synchronous VM_BIND commands.  Since
> > > userspace could just immediately wait for the `SUBMIT` to complete, I=
 don't
> > > think we need this extra complexity in the kernel.  Synchronous/immed=
iate
> > > VM_BIND operations could be implemented with a 2nd VM_BIND submitqueu=
e.
> >
> > This seems suboptimal for Vulkan userspaces. non-sparse binds are all
> > synchronous, you are adding an extra ioctl to wait, or do you manage
> > these via a different mechanism?
>
> Normally it's just an extra in-fence for the SUBMIT ioctl to ensure
> the binds happen before cmd execution
>
> When it comes to UAPI, it's easier to add something later, than to
> take something away, so I don't see a problem adding synchronous binds
> later if that proves to be needed.  But I don't think it is.

I'm not 100% sure that is conformant behaviour to the vulkan spec,

Two questions come to mind:
1. where is this out fence stored? vulkan being explicit with no
guarantee of threads doing things, seems like you'd need to use a lock
in the vulkan driver to store it, esp if multiple threads bind memory.

2. If it's fine to lazy bind on the hw side, do you also handle the
case where something is bound and immediately freed, where does the
fence go then, do you wait for the fence before destroying things?

Dave.


Dave.
