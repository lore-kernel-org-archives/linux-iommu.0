Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479B15855E
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167979; cv=none; b=R6jt6MyHIQYPvJRlL6X8NgATpurHfcp4gdZNQUM7ToydTRpI3EGQwMNRbTJZ7bzaduWGCohN8yOjULJgQRN45IgMnPoRWhBQEISTiMM2WBIeK7U1vn9GMbquvqn/iL+REii1FETIP/qHZYtCa4sOm7lhlFF47SkWHdtrJiw6K9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167979; c=relaxed/simple;
	bh=eXmObNrvqTREabEVoaPfipK3nhi82p1Oorr9WTbWpS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urKreDperbTSmyh2qmrM0K/ckzU7ZoQwTFPI/7ZLgieuDOMKmsXez/smcdMZr1qscOv5GOOxwNnSDhFLqOlIZ3CiqWgrmTZ1GG22se0Ouj7xXvNksaRtY3PbAwVBW1E2ffR/ajwmZfUHcaKO44U0kmuqn4tWcFBMG6Ca7S5u1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Cxgs6wpx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Cxgs6wpx"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d9f7a34daaso43000181cf.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759167975; x=1759772775; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp5nx4TC/38dVlnjuJTLG0gnQNJPQsJ2h6t5725+5tw=;
        b=Cxgs6wpxTGOcu6AK7Lv2fdqNwmoALQ3x0elknlfAACEXJpA44LZ+X4eOw4RZ+Bq2lB
         H7jCYabPdXHUPQXHo1il1m/jEIWB1fUrI1+qGijLZX2NXVyY4n1O2QPCBbUH9Ajz7jsC
         7Bdx44rEXLLzVzaa3463ZwfzJXnw+rrVXoB3O2kdYQcyQaytGmDgg9e+kFRiRtdF4t2t
         58t3gCS6NjcSXCRL2zAwGUwdtai6mB01YXW5lyU5an9j07pkv6WGPkIvISxziiWLGp8K
         F5nOQRR4MPJU3UXQQA1Mdxza01d/PslpwMPT6vr7efxlQFz/2vbdRZG4ODuWoOzVhAZ+
         GSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167975; x=1759772775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp5nx4TC/38dVlnjuJTLG0gnQNJPQsJ2h6t5725+5tw=;
        b=jLc/5Q/FCDGIYXgjgHKAtqBUFTzorx4t4WycNF5i7pOJ4gD5O5VKwt/ZUuw1JSk0ZF
         CxLiJJnuLWQdU0vFEfq+gvcw0cDY2IU1TQ+44HlAITnYrBJ6pdZXlAqlcnD71yxjnvwL
         Y6jOaicGvxgp5/Ral7aXs0R/YXU8AhjEdDDU3+CZae3nYmApVuO0xRSi0AQEBaqrvO4F
         epF2excAfPqwQt3M14jeP9a7wsp9nBYn4+RnFuUhdYeo/kRpGpuxc+IY+meddX5AxaI5
         j1EhgTE30xMh4TlOcr1K8L+haCwav/7rSRm+ruHY+zWBpfIver5bVRqeoSORx8iBd3h5
         9f4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUp5u7DyG4kz4zLigD/XoQtoRYwy8WAxQoP7/aaXniSRnzJownz2gLPiksUcU5kxw++ifu0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIpAHpmB0rRIXAaDOpn7FD09cnZWasuNJ9rrrj7dRGk9CNj7DL
	R6ex+yOTWg75zwR/Mzf/1gcYrsakCtNBDI0I2H/9WQ13xI4a2eTSZBlObY4eMqtyTgITrZ+GPYI
	hbLzGMfn6+cga6t9vT0aDKYphS4zHcL1GDFebWvm9ZQ==
X-Gm-Gg: ASbGncsHRRCxBIgVen39Tj3a224Dcw2GeQYEDR/oTWuzKQsoc8/J4TOtRX7dU+J9577
	cRg/UHtY8v8gijV1DEHij+3c2r7PWbrGt/SQ9Mhy6f0++4Cf/hwRo3dxwIrUs15fbmTCJ+GWVDr
	0spFszF8SvOC+gU9C6L6aK+SHzMtN769a1RP372MWcY4MM0c0HZnWCW60hY7/Blu1jWg6tf9xib
	To+s2WKWjRcHuw=
X-Google-Smtp-Source: AGHT+IGOnelXZkDUZzjTRtovwRCe00xrTA+7vjG5Tw/7+5pwFeMcBzkyq8GKQCfm3J+xlHW1Nz5fVVpGOss9mnAfAYg=
X-Received: by 2002:ac8:5d56:0:b0:4cf:1eba:f30e with SMTP id
 d75a77b69052e-4da482d41d6mr58945371cf.24.1759167975081; Mon, 29 Sep 2025
 10:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
In-Reply-To: <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 29 Sep 2025 13:45:37 -0400
X-Gm-Features: AS18NWBt_WgC2Y8Hsnai8qifkqT_eI5rwr_YhDjsltDobqYe3Ir-FVVNbB0ht3U
Message-ID: <CA+CK2bA7LK2i-AOyTwx1KNUoF5fUWEWBA49i8T_wYXBApKkUBw@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
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

On Mon, Sep 29, 2025 at 1:32=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Mon, Sep 29, 2025 at 9:00=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > +                          struct iommufd_lu *iommufd_lu)
> > > +{
> > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > +     struct iommufd_ioas *ioas =3D NULL;
> > > +     struct iommufd_object *obj;
> > > +     unsigned long index;
> > > +     int rc;
> > > +
> > > +     /* Iterate each ioas. */
> > > +     xa_for_each(&ictx->objects, index, obj) {
> > > +             if (obj->type !=3D IOMMUFD_OBJ_IOAS)
> > > +                     continue;
> >
> > Wrong locking
> >
> > > +
> > > +             ioas =3D (struct iommufd_ioas *)obj;
> > > +             mutex_lock(&ioas->mutex);
> > > +
> > > +             /*
> > > +              * TODO: Iterate over each device of this iommufd and o=
nly save
> > > +              * hwpt/domain if the device is persisted.
> > > +              */
> > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt=
_item) {
> > > +                     if (!hwpt_paging->common.domain)
> > > +                             continue;
> >
> > I don't think this should be automatic. The user should directly
> > serialize/unserialize HWPTs by ID.
> Interesting. So the user should be able to serialize/unserialize HWPTs
> before the Live Update PREPARE event? But what if a device was marked
> for preservation but the user never serialized the attached HWPT,
> would that be considered an error during LUO PREPARE or should iommufd
> serialize the remaining HWPTs here?

Users ~can~ serialize their sessions before system-wide prepare event.
During prepare event all unserialized sessions and their FDs are going
to be serialized anyways.

Pasha

> >
> > Jason
