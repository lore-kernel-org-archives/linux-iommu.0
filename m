Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9425A655
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262568; cv=none; b=b+X608Inb1BK+uS5371dNUGDegeOaKNI270XKOiacCHLEX/dKjyq/u3xfI/ybUJF3H3yQnVu0tx7n6lvNQ7N8msufKUj4dHxsuyW4o+ManL8SsXk5cB4OBR5YoOaHN6Z8+ZZ+veGfkW+ZWwaztw/2eBDYnH3Frlr/6lKOZ4H8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262568; c=relaxed/simple;
	bh=b4Yne0Qw6q2ZXPRXF3jBjLK4x5kjmQpjIHFFtEPHqCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0vKaxNUnaLG9/MLhBzMTyy6jW+nEn9ibYX15qbJJmvdtJHOO8iMGux56nVebFhAT5nTYpwPXkC8X4qCKozjBC71UJf4tLDOYbv5EilwYbdABbyqyqVimhrizQ+bXWSYakV40fE+Lk5olIQ7lkX9BiRETSCWJFwfSR4G5aUX+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBCoWzyi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBCoWzyi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d67abd215so52375ad.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759262566; x=1759867366; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmjWU3TtlONkR58FzLBdx1M37tT6PGpX+MejoGqz+FU=;
        b=bBCoWzyiE3BB9Ho30LVhe1La0h/kxKJnG23yCcGoCL6U8O9mOAoAhU5EdfjkmIAmH/
         ef/LqSYsbZ2uVirEvug5WNkPezhYxLdD53HpX4dDHQ/PWzIETrIMW8IlzGV24GlFkFna
         wHQP7W3EYdkxY0SqASCm7lje1HKbJYmGDIxoE2IS+jsspCpRI/ml+5RSK4VoRYGNfKb9
         3eytksj2f0SS2qnztTvMVsCdfMLvRwMVcyBKrdXJ5LKF+775mBWNAal3XsLHUgbbGYTe
         /zACh3mBXJByFJzlGfJQyjnREJWUW+hWBljTx/ZmgVA+e38XNSzm6u3NAwGALaelgQ4l
         TxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262566; x=1759867366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmjWU3TtlONkR58FzLBdx1M37tT6PGpX+MejoGqz+FU=;
        b=LeWE+Imt2L7V7KS/EO0hz4OP/H6KBEuy8Tg2zTprX5MUrzDRspzDJVSXJObP5JqdAa
         ZQJDUVCRLjJ2ucVb7b0KF5elJBeMA88p1OAArkX06gGzYTKl1MQ/jNuNLC0yV2xepc/r
         YsTqhwoMilUpwAMueZz9NkKEbGPnsUsyuNf0QaWt3WFjGlU4WvWmQz0pl2GHoXqmYiQg
         dOsRpD6bzWjtz4a0AcZl0rfNtxLBWT7ZdI153NC4x4JHJGnUkf6+nVzNLGEJkPLi4QJ+
         BGsuyS8LLhki8DLEJYzpYt4RpD5nNnIha02xa9ELo0PpHEil3B153WUeybgV9IJChiwT
         6ksg==
X-Forwarded-Encrypted: i=1; AJvYcCUAvJmQr4lZzGAOolzTWKaM4bbYkDLWFLrwFYNeLA3xlpps8D2LLsUZ0K6pVnvnI5lLR/8c2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTb1q5daAajdAhJUOzSL3DZ0xUIHZPfzmUB7NzW6Vk/X0fkua4
	liGRxHoYhkDkkB6GNpeYwMCRb3QBn0PDwtJu/c4gspOst6J1X2/U1EwsyZGHCS5IPt7aq4OC/OA
	JkBVWmk8nEK8QESGjvdBcM29AYkvKTXaq4x/MLmEs
X-Gm-Gg: ASbGnct3qCaBMWmTjzEmm65hwX4+pr9KtXZEepiWsMYDO8u8vKKNvaIs3McMy33OTOW
	EzBRF1S5zx6aFYK1SNnDWX2KYIcRc3JbK/aud60PErszn0nqcKin1v8+rvRKfqbSlCvwO/5wO3W
	p29wQP0ysTAMbd/zPT8AlQv3OjbTFtYVRAeB5r0l+0RNdTTz1p8glaKN6GjlGpQqUam6U8JlEQl
	dDjz/yuZ1YSLjiwm5g8SW1fRCylE9XtKDHk0Tii//siAU0ffk3WXoiBa+Ktt54FHiw=
X-Google-Smtp-Source: AGHT+IHx+YJ6OoU2Vttd31DlFqYP5qTmJncBxyHWUS5OUKKuJ74sIZfzXDXkPor8ehJoA623CmmYP8vJePvPpHHmT/U=
X-Received: by 2002:a17:902:ce07:b0:266:b8a2:f5d8 with SMTP id
 d9443c01a7336-28e80054fc2mr915285ad.14.1759262565821; Tue, 30 Sep 2025
 13:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
In-Reply-To: <20250930135916.GN2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 30 Sep 2025 13:02:31 -0700
X-Gm-Features: AS18NWDlBEef52YzHXVxaMZeX4cRlUtI0dF5L6bXYHvYPPunK-J_lTtDOKzdu1o
Message-ID: <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
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

On Tue, Sep 30, 2025 at 6:59=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Sep 30, 2025 at 09:07:48AM -0400, Pasha Tatashin wrote:
> > On Mon, Sep 29, 2025 at 12:00=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > > +                          struct iommufd_lu *iommufd_lu)
> > > > +{
> > > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > > +     struct iommufd_ioas *ioas =3D NULL;
> > > > +     struct iommufd_object *obj;
> > > > +     unsigned long index;
> > > > +     int rc;
> > > > +
> > > > +     /* Iterate each ioas. */
> > > > +     xa_for_each(&ictx->objects, index, obj) {
> > > > +             if (obj->type !=3D IOMMUFD_OBJ_IOAS)
> > > > +                     continue;
> > >
> > > Wrong locking
> > >
> > > > +
> > > > +             ioas =3D (struct iommufd_ioas *)obj;
> > > > +             mutex_lock(&ioas->mutex);
> > > > +
> > > > +             /*
> > > > +              * TODO: Iterate over each device of this iommufd and=
 only save
> > > > +              * hwpt/domain if the device is persisted.
> > > > +              */
> > > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hw=
pt_item) {
> > > > +                     if (!hwpt_paging->common.domain)
> > > > +                             continue;
> > >
> > > I don't think this should be automatic. The user should directly
> > > serialize/unserialize HWPTs by ID.
> >
> > Why not?  Live Updated uAPI is handled through FDs, and both iommufd
> > and vfiofd have to be preserved; I assume we can automatically
> > determine the hwpt to be preserved through dependencies. Why would we
> > delegate this to the user?
>
> There are HWPTs outside the IOAS so it is inconsisent.

This makes sense. But if I understand correctly a HWPT should be
associated one way or another to a preserved device or IOAS. Also the
nested ones will have parent HWPT. Can we not look at the dependencies
here and find the HWPTs that need to preserved.
>
> We are not going to reconstruct the IOAS.
>
> The IDR ids of the HWPT may not be available on restore (we cannot
> make this ABI), so without userspace expressly labeling them and
> recovering the new IDR ids it doesn't work.
>
> Finally we expect to discard the preserved HWPTs and replace them we
> rebuilt ones at least as a first step. Userspace needs to sequence all
> of this..

But if we discard the old HWPTs and replace them with the new ones, we
shouldn't need labeling of the old HWPTs? We would definitely need to
sequence the replacement and discard of the old ones, but that can
also be inferred through the dependencies between the new HWPTs?
>
> Jason
