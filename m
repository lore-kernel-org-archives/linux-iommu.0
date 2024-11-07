Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6A366
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938215; cv=none; b=tfdGDMzbdhRkROIrWfL3XfD320JSswZTSG5KEvd8Tml3jogO8k84xTbBn7i9Pnr5jyC985kXCNeCREr0r2OmZ4t3xCwcW057yI1biVm2lyxg4DMLxZNtP5u17v/CrNvx3wa2wPC0ETW3BPh7LkipgU/c0UkZGilH2iSbl90S9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938215; c=relaxed/simple;
	bh=VoaktRW+fwZWLZXzFtx8nHYFF+YHOpjqu/rfljMWztI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiQEOn08KGCQmYWRQFWHLBqP4yxRO3NUDPNU1wPJjMwneGdqVRGHEt1k6xDHKTy0KumW06Nuj+IDhFZLSgMQid/IbNR2ocmiwYY6ndRW2tYTOKVvf8v/n95PUCOF0X6LK5f1hWQzm7kde8PU7yVLuWpU0jvjQOX8mvjTn/ES6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PeHN7w6l; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeHN7w6l"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so4119a12.1
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 16:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730938212; x=1731543012; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1ZLK91MX2iX/bDcqlXphFlDF+483cfJj4sy75dqlTA=;
        b=PeHN7w6ljdn7caTfIeD1FLUgDvVnr3PBi2nD+1Ebom3Sw0hdWc+GGGm2R8n0B1kcEh
         7yTW9mqdx/h1KbMTm/UsW8XERnr2NkPg+U5Ng+ShG9aTvX5kK9pUWOh750NMqxJVHvj6
         MNLgXirETKiscJGoTaBnTccPng1AtB1pF8Aq0PzyaPW98om2Va/760VOttz+hGM6O0cl
         i5Hk6MsT7J5kKEs6F2NlHGR07rcAfgPouWefyU8uRKNfZ34EVC/llRCiqbEWQUtn6GEY
         SBv/UkFsCbnSlPS0Edt3/p0hTb+m9c1xx9pD64i10eG1zknJPjpitKXyiqsNfNT1OCNx
         weLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730938212; x=1731543012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1ZLK91MX2iX/bDcqlXphFlDF+483cfJj4sy75dqlTA=;
        b=L1O+3eyairU7AywKwmeUhHVlbVTAQgXeK8nH/pRdmYr9rPL6rz5QgGYXmEVBqVr6ij
         cXv+1rnxgKZh4HUWOo8v5hUcWEKXRa1xXBUNT83nYTWVhtmQe97DDxC6Rl3Tj3ElZP2T
         dfF+HZ9RbBw4Q51yEVfXtRTb58f5lET5e/vc5D8i1ctZUGvKp2ROUXUPh/B2S8uaOiTo
         kn4r22qLS+9ahenSrMm+Aia4yuVDsDbe9PIcSmdGjri8LcUB4jNYGMuDLUeukNbY6nci
         S0OINBM076r6hh/2jTGh5/woRQ6SHGhf0LnT1Uw3G4KsnvZz3k/w+DNlL9lmVlu2xiIa
         NJ0w==
X-Forwarded-Encrypted: i=1; AJvYcCVt5iyzUYWuXmDNHK2zPuLDeEP9QTVcn7LoBr5bF8dhizTAUOpuBylKlEknzcHXjz7Ywz97rg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yynj1sng7xCFaEHjlnFbE/FnEUuPd0nxNFpG/4TWbjh1G9uyvIs
	SuSn2vWSumLIAfSxgtnmDwzWGtXLB0wtrKu2j7E/+EqDCphY4HGjuAdQ0oe8Ixqyv6SOkWxdGOF
	3XFsIYKy2rLLncCsynPvoqICFh+ogw1miDsP9
X-Gm-Gg: ASbGncvF+yQuvFPBkmk4Q+3/Mt/bgmbb9N8pBKnDpnKtKGNtNZGnZWNN22sdW7FO5qe
	zeWav97AZdRwggUDiajhvdiSK0OAgS8eN14aiSjzTVR7FJ+iSmWvr/dYTWfNLeA==
X-Google-Smtp-Source: AGHT+IH7XfCVLjzheMXGyAMYy+ANKg35TQ664s/WZ2AsxdoMajIfpOxNlIj6gMdQhxxXaFRJ6idhf3KVhhpYqsp/ONk=
X-Received: by 2002:a50:f69a:0:b0:5cb:7316:2e15 with SMTP id
 4fb4d7f45d1cf-5cefbb03500mr303322a12.0.1730938212046; Wed, 06 Nov 2024
 16:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241018180022.807928-1-praan@google.com> <20241018180022.807928-2-praan@google.com>
 <7c7b905c-ee00-4333-987e-0d0f0e45753f@arm.com> <ZyTu6tNO8gaSqKSy@google.com>
 <CAE2F3rCWV76hfU06SCZoA3HW90YBQZVcXaDD0P-beDtTaJhKGA@mail.gmail.com> <ZyiGa0sC1MfCu17r@google.com>
In-Reply-To: <ZyiGa0sC1MfCu17r@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 6 Nov 2024 16:10:01 -0800
Message-ID: <CAE2F3rCVJgM8q2_k66UkQQf8UpouMdPaEd6V6Lj_O_gM+_ti6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 12:31=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Sun, Nov 03, 2024 at 09:25:52PM -0800, Daniel Mentz wrote:
> > > > >   #define EVT_ID_TRANSLATION_FAULT  0x10
> > > > >   #define EVT_ID_ADDR_SIZE_FAULT            0x11
> > > > >   #define EVT_ID_ACCESS_FAULT               0x12
> > > > > @@ -452,6 +453,7 @@ static inline unsigned int arm_smmu_cdtab_l2_=
idx(unsigned int ssid)
> > > > >   #define EVTQ_1_RnW                        (1UL << 35)
> > > > >   #define EVTQ_1_S2                 (1UL << 39)
> > > > >   #define EVTQ_1_CLASS                      GENMASK_ULL(41, 40)
> > > > > +#define EVTQ_1_CLASS_TT                    0x1
> >
> > Remove this if it's not used anywhere.
> >
>
> We're using it in `arm_smmu_get_event_from_raw` function for TTRnW:
>
> +       if (event->id =3D=3D EVT_ID_PERMISSION_FAULT)
> +               event->ttrnw_valid =3D (event->class =3D=3D EVTQ_1_CLASS_=
TT);
>

The #define for EVTQ_1_CLASS_TT should be added in your second patch
with title "iommu/arm-smmu-v3: Log better event records" where it's
used for the first time.
