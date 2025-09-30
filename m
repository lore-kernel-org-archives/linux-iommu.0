Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3B273F9
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237709; cv=none; b=oAUnTtl46zHj6kL8WBk/WQQ+udTmVZceDMU7LA2wIiZSrXFlEYr8sgXnwq/t7GYa+kHI1bk3U5hiGSoHmse1+6INsOgZofJz1VXTM/lJq57n2PIHmzLJEJ7gt90U4D66fS6f7D51n8RKTkUtmr1yUoxQ3xH6G0ZDBwWy8h7sOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237709; c=relaxed/simple;
	bh=QMo/NLhsSftlgF3+wcn015ZLW7Keu0wGP7s46oyS4Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJN9FIFWlUOirdVeXguQoVSyg2Xi6tmYbCDOjY+16QKedVuQguFYWqQO6/2IMdUiBfYUVPep0Od6ELhMvZ85ZpcwfVMBIwUArF9cqHzczEv59sxuGwgL/C++c0qaAvsxvHUvaqyxY80+qq8s8tPF9NQpAQ8cr8+RcnXEfvFOK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fg3ROPnf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fg3ROPnf"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4dce9229787so53360361cf.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759237707; x=1759842507; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRcDoRpxowwRXdHrfG07NYS9MxX7g9BwMVASN54W7s8=;
        b=fg3ROPnfy8WfBrLykUucYwBylzzExJ2By8yhCkIEo2A2p44ntVh6T6zZUeRPA4k+PH
         KLYghcV+n98J4vlNOttEgixVd2Jp5jf5N8gYGj0/uQbz9ilrGqhX47dmd4KMR8/Qeh8G
         mPCZMoHWTT0J+Iv9KwTRcYNEwiTu9jJbGL1UeTwZPd2uht15ud8QcTWm7cyGkrHqNMum
         Z7/0xJG25YJL5hN47WE24korPghTTufp/xGwhSjrmFmjWqAU0ablm+r5LCeDWwRjSXiO
         p2yyv78OQy2A6V1C1d1IxB2CvULrTQfm7Iq+90SqoiVm6auNjCoLDq+QyWkaQ0clvyz7
         c/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759237707; x=1759842507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRcDoRpxowwRXdHrfG07NYS9MxX7g9BwMVASN54W7s8=;
        b=guO3wR30JtQn6AwgmDqd47OPcSZAXaoxUglr2UwcpmJBc7dYZ8+8klLdhuvibL7Dsf
         UyCzNnwUWLRxl+tOFCXHwhN781YLtk7aIr+iPdeAyFpntSHiu8538I78NJ3PcdY5SrO4
         3imzj2uuJRhH1/Q9wtuelUAFZK6SrNFg5fBIW8Hujzi+Bp0gMbgeihOD2W1vnm8KBa29
         HZnuDeFCzXxUl7Ld49gtutLpgs0Ml5YditoTc5ZCKmcTzVdy5hEcXHRm7cWXhlliqpas
         0eC39J/TTW20lmHiRnuJ1j2KwalQoQ3y4yvaoSk3J6S3RBSJpobUBhGHkYOREHnxfzji
         4YDw==
X-Forwarded-Encrypted: i=1; AJvYcCVj2R/Vu6sjJB6aw/MDHWQNLI3avucKo9AN8AJbEahljyYaJZviaG5e1T5lRv+JJjZcn3KwUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ9u42BS45801ao1ck6hiAX+O2FQPnI7TpGYy671uNaUH6CNuK
	06WxP6GL5EaSGb9xzSJJrhIw4GMf2dipN/KEJuBRuIFHS5bOti1XD3LxyUOxosWgYaiFN7i7PYd
	1M95N10USk0HZ3ZxM8v8Da+TBEJmiCe8xJ06SgI2Hfg==
X-Gm-Gg: ASbGnctVVc357YaQVr9qzpk/6X5Oc1Uc5yiyDiS74XOjaoJMm7yIcBeQ72GvmxbmxFA
	rzNK2z9lYyPo/XPxUuXtsacNk0vCiBVbq975b8voTPg8joX4Ka8yuKaKjVUP7s25HDhe3Oa/fpq
	FsfJLmH+Ci7w+4e2hBqZbu7WLC26tPlTz3lhfRn74BXNRClm7qGOUoh/NMsr7Dtp615aPweIP9r
	BZBuD/XlEOejCKzXuWm5aAil4HaEeFEYkya6lCcG7dlKk8Blg==
X-Google-Smtp-Source: AGHT+IFcMihqlPG0r/0rax5NoPUqvU2KK1RnwmX3J74Q6jm2qArxP58LY1QIdRkFSghRH0CiBSZeHf0F2FZ3n2h/HKU=
X-Received: by 2002:a05:622a:212:b0:4b7:a8ce:a419 with SMTP id
 d75a77b69052e-4da486b7062mr313238641cf.26.1759237706520; Tue, 30 Sep 2025
 06:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
In-Reply-To: <20250929160034.GG2695987@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 09:07:48 -0400
X-Gm-Features: AS18NWAN9frLXrJzwwTE-jqpam-hhSqeSv7aVqzTjHPfUwbIPaE3h_RH3XbXIJo
Message-ID: <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:00=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > +                          struct iommufd_lu *iommufd_lu)
> > +{
> > +     struct iommufd_hwpt_paging *hwpt_paging;
> > +     struct iommufd_ioas *ioas =3D NULL;
> > +     struct iommufd_object *obj;
> > +     unsigned long index;
> > +     int rc;
> > +
> > +     /* Iterate each ioas. */
> > +     xa_for_each(&ictx->objects, index, obj) {
> > +             if (obj->type !=3D IOMMUFD_OBJ_IOAS)
> > +                     continue;
>
> Wrong locking
>
> > +
> > +             ioas =3D (struct iommufd_ioas *)obj;
> > +             mutex_lock(&ioas->mutex);
> > +
> > +             /*
> > +              * TODO: Iterate over each device of this iommufd and onl=
y save
> > +              * hwpt/domain if the device is persisted.
> > +              */
> > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_i=
tem) {
> > +                     if (!hwpt_paging->common.domain)
> > +                             continue;
>
> I don't think this should be automatic. The user should directly
> serialize/unserialize HWPTs by ID.

Why not?  Live Updated uAPI is handled through FDs, and both iommufd
and vfiofd have to be preserved; I assume we can automatically
determine the hwpt to be preserved through dependencies. Why would we
delegate this to the user?

Pasha
