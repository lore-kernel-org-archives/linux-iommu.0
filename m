Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F91DC9B7
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823614; cv=none; b=FjFKjS+jS5a6ETev1SDKy3ev0eEQaitSi+tRfvN7Px+dQYrGYMOy0fRL3ixuNu7ARDY6bhynxiyhwDiN8PUxm2FVY6zdIwMcBJk9kECqw7svKl4H4XmDy4kprScbKcGL+WqxJ6XdcBMv+R/JJTQVeA4Xf0C2czD9j7eB6pK/zkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823614; c=relaxed/simple;
	bh=U5CjvSU/lG/S/DU7I+Lm1n0fVR2lFtH1NSRTlp5kSIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2GIpt8+rxhSVwGpn09JnUvLLsSemrRQpYOwahWbj3/9jL/AXF+b6AKVpPAXQ+o9YCfIA9cVZiK7zkEV+wu3rLUcJxYP1OVT7q01spIKRV9wQzZem98YEtQJ4YUWg7mNrs9C56qVjwAis1xHqP6jmtHLY2OPvw5gjH3jm5XCcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZUX6NEb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZUX6NEb"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4674c22c4afso157881cf.1
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 01:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733823611; x=1734428411; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FDyzQaVBJmBdWgi+flPumHn5fgNwsPGMW4DJuw0nzM=;
        b=VZUX6NEbmyEYAhfPy6MJfBKGteu78rQhYVbyinqpRG9nWYNl3umjldEb04GIBMHiL0
         Ktdl9JwfcdhU4GU/IRNLUhludjFRFKqJQfAO7P3OS5dfafZlf9iRO945bhWPi4bPBtF3
         JmQKKFeRbHFQ11ccuzSdqNpuwif0FTurFCTXTp4bXI58v0ZLipXGOiwryKceIT8bMJ/+
         t2cC+LcBxK3v/YOP/GmseaVuwjBOfdbqczSEvmuG5/kpCftSnH7kQSz1BKDSdnUvYEU9
         WZNGiqAVUghYuUekUnSMNfHAzTzTJWuuG6Wl1+YU3fOkaPhOKtaQNuPG9/AnI4Z3skWA
         cWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823611; x=1734428411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FDyzQaVBJmBdWgi+flPumHn5fgNwsPGMW4DJuw0nzM=;
        b=DyaUodfpa4S4rRcgkshXbpOaE/A2sqzN0y/9vsXvsI+oDfpUHweBXwEjsAHugNAb4z
         PjjijdDYCttz7mDIRQ9fY4ER7eLJ+FENvqoNoWV/W6kQFaXOT27ab969MacrMHdeJaRB
         kNhGRxUtsWgQjddrkdWG9OtRAT4udHXfyRfWdT8dI9pNKEo0/YO07rCWzieHTM+ecQYh
         VS3cYkFtu9mTyrIfX3+8jipdYBH3PeSXO+JwN7tvg5MwPBDH+DSS3FAiIPCYYCjJBGjR
         Y0dzgs+kxOvRpqv+LDqzYHgfB6Ef3looFyLl7A1BjIpJJ+BH04wMBHNnAQTDjXS0FbJ0
         1LYg==
X-Forwarded-Encrypted: i=1; AJvYcCXDzNZ6JgY+yea0UYwJ9cxk3R77mO5UBqfvi53mC1z2o4x9a2v3s4LuAggGrZmBllGxpm4oVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YywK/YNoPRMiqTMEF6lUEJReu1orROWS6kP7ott34FRPVZH8go0
	iUdvhffVwXI3ULKpY5rySs2jBA+G8YP7Bq4RdNEz1nuv4cpSmiJXoecRU9MdD66CxHtXTi7vaDL
	Nl+TGJ4MKfVkKU9e1y4UAPEnjlUBtJ4NhUofRapV1ws3Q0V8ComiX
X-Gm-Gg: ASbGncsegJrKdcWlqoA2oQy5RJ12NtDygH5kWDhrJ99KyI9Gob96kDx+7gAzqNtpXyh
	mDVloVzgj8ySbL9/CivjxJDQAof0ygmM+qg==
X-Google-Smtp-Source: AGHT+IH7V4UKeLrvjNkOyGEOEUYHbY8QYbuKts1kktkzSbiMR6UVtyJWD2Q0aBvHWwJs5sF1JPgPGTYIeXHNZCK6L4o=
X-Received: by 2002:a05:622a:5186:b0:466:8a29:9de7 with SMTP id
 d75a77b69052e-46776158637mr3576401cf.12.1733823611360; Tue, 10 Dec 2024
 01:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241202140604.422235-1-smostafa@google.com> <20241202140604.422235-2-smostafa@google.com>
 <20241209235804.GA14069@willie-the-truck>
In-Reply-To: <20241209235804.GA14069@willie-the-truck>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 10 Dec 2024 09:40:00 +0000
Message-ID: <CAFgf54peN1fGOpr4Q4eihRTYFi1prT3LaQvH-K5x5KO50gmacw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/io-pgtable-arm: Fix stage-2 concatenation
 with 16K
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:58=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Dec 02, 2024 at 02:06:03PM +0000, Mostafa Saleh wrote:
> > At the moment, io-pgtable-arm uses concatenation only if it is
> > possible at level 0, which misses a case where concatenation is
> > mandatory at level 1 according to R_SRKBC in Arm spec DDI0487 K.a.
> >
> > Also, that means concatenation can be used when not mandated,
> > contradicting the comment on the code. However, these cases can only
> > happen if the SMMUv3 driver is changed to use ias !=3D oas for stage-2.
> >
> > This patch re-writes the code to use concatenation only if mandatory,
> > fixing the missing case for level-1 and granule 16K with PA =3D 40 bits=
.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 45 +++++++++++++++++++++++++---------
> >  1 file changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index 6b9bb58a414f..0055876b3527 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -223,6 +223,33 @@ static inline int arm_lpae_max_entries(int i, stru=
ct arm_lpae_io_pgtable *data)
> >       return ptes_per_table - (i & (ptes_per_table - 1));
> >  }
> >
> > +/*
> > + * Check if concatenated PGDs are mandatory according to Arm DDI0487 (=
K.a)
> > + * 1) R_DXBSH: For 16KB, and 48-bit input size, use level 1 instead of=
 0.
> > + * 2) R_SRKBC: After de-ciphering the table for PA size and valid init=
ial lookup
> > + *   a) 40 bits PA size with 4K: use level 1 instead of level 0 (2 tab=
les for ias =3D oas)
> > + *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 t=
ables for ias =3D oas)
> > + *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tab=
les for ias =3D oas)
> > + *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 ta=
bles for ias =3D oas)
> > + */
> > +static inline bool arm_lpae_concat_mandatory(struct arm_lpae_io_pgtabl=
e *data)
> > +{
> > +     unsigned int ias =3D data->iop.cfg.ias;
> > +     unsigned int oas =3D data->iop.cfg.oas;
> > +
> > +     /* Covers 1  and 2.d */
> > +     if ((ARM_LPAE_GRANULE(data) =3D=3D SZ_16K) && (data->start_level =
=3D=3D 0))
> > +             return (oas =3D=3D 48) || (ias =3D 48);
>
> I'm guessing the second disjunct here should be:
>
>         (ias =3D=3D 48);
>

Ouch, my bad.

> I'll make that change when applying...
>
> Will
