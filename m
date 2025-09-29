Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE626ACC
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166515; cv=none; b=NdqoMgVQumERn/t5o7eSD6RaoHproUri+9KsIwSKTCVrsxWzTtEd7fialKwg3JG7F1xLMJOdPNj3+zjE8ZGhCh2yvhJQzlgG46cwmDHfHXQ+lOee5833CQnt4A4lq0/ziKzBv9N1eHmqpkpD1DdJo2rxl62Bx8O53aQs/Q9ywzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166515; c=relaxed/simple;
	bh=muqLx+ZkQE73ymU6ZJlhOW6yJMNLyerOcTjnN0fXCfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU8+WcgKOwbQrRy9cHb/LRUbOVkYjLT4oaysglspT5g6WMwCSxTuKpEX5ISdJheePUs5AeXQEdaFzi4drsHJg7DBvatucdKddmz2YxTP2YkkhIimTw21jpwYL/RCIAKzaiZfab0RCyg9BncQdyD+JirrovbqWLd/dasx7hsTagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTjbPgdw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTjbPgdw"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso13841cf.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759166512; x=1759771312; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVa+tDyppWrdzqK7fB53mlf91vynfNxyCklwvd1eLkI=;
        b=vTjbPgdwYRV45V1LJJ7VKPfqJbXM+lmNg9uM/2NH7v7pNGrc7i7S50w8WeKl/lhsLB
         uKe7ZNnXP8AFW1CDQA8RBYxn2BHyojz0wbknDo5Udpb1/geBW93NATVCPXyDCBTAiU4y
         EE1IKwojw8ye9ednGX8PRVtZ4sim/jN43c5u2c0mIb+tZbFmEwkhIjFsJsCOKrW5cCLA
         0RGr7fIodnmDyXwpvB5VIM8gmGIocnWOSJrt0lhG+D7sb0Gx2bd1sq+2fcn71E2OIp0f
         odREaiWlCGsyKE2homg77WRaC5MzUPm55iONJFqjm13p3cT4XdaFZW7INUskOZCkAtuv
         7MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166512; x=1759771312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVa+tDyppWrdzqK7fB53mlf91vynfNxyCklwvd1eLkI=;
        b=fm59qOLfYAxsFp+t94wOQd3sJUb7X0Sefb51gl22YxZh4GhG/eK0FXkdXm7fLGgUg2
         M4LnGDuAMoC6pSLIv+uIpZa+Pv/LnTt4iOyB3TsvzT7ZNBOV60wXEzrkKVU5n2jd8qSC
         eJPJL/O6Km3MUjRSeLio0rt/zbDvf1jWEgJBPKMTMuN3u8yK/2YUPiRPFl6too7H1u7/
         S2JgBUfFQqR62o/qi9X9UfrvPrHq3sleNciPOi3tAChqaPwXsS0DeLpoZo1UG2cecLH2
         KJcHXm4FSZ1MnQtOXXNNRaLBYdfmw/w0kSPqJQJLbHLEf5n59bLctDivIFSyQdI4s7vt
         6iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyBMXiFi4nfOrEZ3zJlTSF0uCPvatepcdE//MoX/SxcKQKa39SKJGgPayn+ZNgxxs2Cgmdxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjYaZdiCvES1ZC5YL/LVEQrX2IKsVi7BZXu8KEy7Cdfd73XMMD
	Ma8EXzQdwn62QwGcA9U/FFjLCzmEy2A7GzwRo18PtBHsGukuxzmwwEbDHSyovFNZxuLw2xoRkzS
	JDDEQzAlcGMOgl15xxciFLUj8+NfF8Blhzt70i2AF
X-Gm-Gg: ASbGncunOqUU7N9DrLWuOokqxzoLdXFEd8J6CzsHJ44Q2fbW22WLR7DptSQaNOoguDy
	mMXRNbOb6l0FMFvE3viHyKs+hT3ApyEmrPcIFnhDKLrNTo8YRHx48Ql3ewJCgHyFWujYCvzZTvP
	AlsCDesp+3Es6nr0TOxVREnB1nS1/KTBAgyLXeJKo80F7/rkLDDWRKKFWp51t+q+TKfkQPKCWxT
	s7U5l30D/7Bds+XFZsayNlcEjL1qGFeBjST+D7jQ9cH9dyTUAJF4oDoQo1sAYqK2A==
X-Google-Smtp-Source: AGHT+IEjdFHycw2DxP3B7hAIpxlRtDVL8V3otAzvB1xjUNsgkfac7OeJzDzf67jwLTAOE6fUWugAWyCiIRZjKDwHBxQ=
X-Received: by 2002:a05:622a:1aa1:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4e2d014282bmr482371cf.10.1759166511654; Mon, 29 Sep 2025
 10:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-4-skhawaja@google.com>
 <20250929155123.GC2695987@ziepe.ca>
In-Reply-To: <20250929155123.GC2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 29 Sep 2025 10:21:39 -0700
X-Gm-Features: AS18NWDlYoSUXVy2eQshj89NVOvmF60-kHeNYJ-dUJk0Eds8zwKuAzVWnth5PVc
Message-ID: <CAAywjhRy=BHiQgErfkdt+KWcP_ovEF2cAjMT3euHKiJX7Qfp4g@mail.gmail.com>
Subject: Re: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update
 state is not normal
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:51=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Sun, Sep 28, 2025 at 07:06:11PM +0000, Samiullah Khawaja wrote:
> > Hotplugs should not be allowed when the live update state is not normal=
.
> > This means either we have preserved the state of IOMMU hardware units o=
r
> > restoring the preserved state.
> >
> > The live update semaphore read lock should be taken before checking the
> > live update state.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  drivers/iommu/intel/dmar.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index ec975c73cfe6..248bc7e9b035 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/dmi.h>
> >  #include <linux/slab.h>
> >  #include <linux/iommu.h>
> > +#include <linux/liveupdate.h>
> >  #include <linux/numa.h>
> >  #include <linux/limits.h>
> >  #include <asm/irq_remapping.h>
> > @@ -2357,6 +2358,10 @@ static int dmar_device_hotplug(acpi_handle handl=
e, bool insert)
> >       if (tmp =3D=3D NULL)
> >               return 0;
> >
> > +     guard_liveupdate_state_read();
> > +     if (!liveupdate_state_normal())
> > +             return -EBUSY;
>
> Pasha, this is madness!
>
> Exactly why I said we should not have these crazy globals, people are
> just going to sprinkle them randomly everywhere with no possible way
> of ever understanding why or what they even are supposed to protect!
>
> There is no reason to block hotplug. Do the locking and state tracking
> properly so you only manage the instances that need to participate in
> luo because they are linked to already plugged devices that are also
> participating in luo.
Agreed.

I'll rework this and do proper state tracking once I rebase on top of
LUOv4 for next revision.
>
> Jason
