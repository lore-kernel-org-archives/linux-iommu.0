Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5F2236EB
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245041; cv=none; b=qVySW5n7rt91Ap2KW/iPyq4/HbYatd0LO69vGWhxw164jZHbTXZXi7z4EiKD0qarZlLLk33Hzq9q64bvVivS8Nfbvg0aN1a7KZpxtAXveiQwWM63UoAC4HPRIe5htYHeaSuLrxAheCtbUc8gEgNCVbN5pjG2nztshGRPbsznt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245041; c=relaxed/simple;
	bh=/oRJeb7DGkI5trDZKieCsAvs0tLoEkJKE9QVEtLyRXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFDpZNzYRBZilGZwCGTM9C3XUMN6airL8M8m1WPZaRWyhdl2OLRvJWdL85iGJPHA8sGntT86LDqyg0uo/GpXwuYFfSsCVFJ3fA9HW3ypOa/dliBm2OUPae3AUNeVPTTOWvjyYb+TY2QDKBKqv/Gunrk1Ll3WvEt0K5O79Y06HtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=EeiVyU1I; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EeiVyU1I"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4db0b56f6e7so51715471cf.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759245038; x=1759849838; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1xb6a+2PpfbKKBMnFwliVMTG3PqkR2AO+nTXR03sac=;
        b=EeiVyU1If3010s58/eVPsAuRvXTOpwpQKFKk5p+kUBd8PvmgR3RZ3+/Iy/qA1i0kOJ
         VSwWU6i2D/pxEEiFh3c4bMzQvBZiLvbYaZ2MxgDjJCnWTZQwrKu9eR4u6MaTpVnSm+2e
         TiO0dknxlkJsJZLGS6SbgBYaP0Sw8AubRaM6C8x7UPu4z9Qesavbhoyhz8QQ0bYTIMcg
         PcI1nD909Bq2AifaM1aiCtUB+w1Z6qyi2zh3oO6mICuEBlSVMDfF5IJ8rUaeQrOtDDsH
         GlI6/2KajBAeEKwC8kE7tfqa3xrQjvnlh7Zxxnm01h8Yn/0B/lyRvNLSCw//5/DE5c9A
         zyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245038; x=1759849838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1xb6a+2PpfbKKBMnFwliVMTG3PqkR2AO+nTXR03sac=;
        b=WyJqFgCWGxr84igbPjMjXIXQN8UObO4SvQGbq5kXr/9S/v3B9vaHkZ9ErbJSe19teV
         P3xOmj40MVdjMsFaQtx3PPfn1iSD7i4MFdHjWkpF3YIzZ64Kw5Bc3ydAFx2hjO7lD5kY
         +N9UcYsSbqtFeSXdKeSOqegEIm64QLthGDK0tEJcNol9FOeBLKpK6Zu8r6IkZsG4XFfS
         LbOvNJ/+FYJpaJMfT1D3SZUf3Mk61Fh5z8HbvUVWWYwsHmlEh0ICIKddqSLMLByr4dCN
         6+2lFq7w2G6/6ZjOFgl+K5IWhTIjiuT9qg+rc0bbM8CQH/inaWjnnzI7VnTDEdXpQZod
         yPRg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Lu81R1wCBgVUmcTVI0H4Tbc7Eyo1AJFT8GGuF0l+ikS3Pvu9VatBKyJwL6QoRIQQpVElCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFoLqpH87Zj29fHcRhdnQsvjik4/6zDt40mLphDXDw3BKx+7d+
	8j1ErAtBOzuYOXyQQ1AeIm+dfkfYOhcfXQA9M40gxdYZH0sf1JtnkBbv/CCZyzGqZdIP6OtSxV4
	hhs4P2FuAOFqt8CmMp3HnZG/fcPxTEkw+yIDtn1aGZA==
X-Gm-Gg: ASbGncui5RiF8N/7lkEyawIBUNmJ/kN1FZPojzp3fbI5pO+L9fLzUaeJBF8BAmQGx1A
	pl3J7hpnSU9zjLnIaKXdalK6eE8Jbm4mvsWcaQ31noW16WX9i8G78lfG8UkcPxlvSakQQtmHqtP
	Sl3bCrd0Yfu2iS9Cl4uLbybhMJOxohhSeTGPqGkBypxPvAXSkUkUlas5ShkAFb3/LhfjoAuECnf
	rwiDnrXg3amSNE/QmxIyDJgVpPt
X-Google-Smtp-Source: AGHT+IGiV3j5LpiB9kffux66sQ9Mdg2TUQqos6qaVH2bgGa+tmWH25t6LFAZuJa6A12b7cKlewiqaB+wKEcJg4qlmLk=
X-Received: by 2002:a05:622a:2512:b0:4cf:6b60:8813 with SMTP id
 d75a77b69052e-4e4046b4c5amr3806051cf.2.1759245038318; Tue, 30 Sep 2025
 08:10:38 -0700 (PDT)
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
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 11:09:59 -0400
X-Gm-Features: AS18NWCblimmsvYOgaNy7fesTvLr6J5LauXbqD7JnLPAapSwlA-9Rw_VkQ7GVVI
Message-ID: <CA+CK2bAtChLRVyQftBMN18SKt2o7FcV0q-YUcPS9ZKn2qD87mg@mail.gmail.com>
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

On Tue, Sep 30, 2025 at 9:59=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
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

The way LUOv4 is implemented, "LUO sessions" are always participating
LU. Once a user adds file descriptors to a session, that session and
its contents are automatically carried across multiple consecutive
live updates. The user only needs to act if they explicitly want to
remove an FD and opt-out of preservation, or close session. This is
consistent and convenient for long-running VM that should survive by
default.

I was hoping for a similar "preserve by default" or "opt-in-once"
model for iommufd objects that are put into the LUO session to avoid a
flurry of IOCTLs to re-register before every single live update.

On the other hand, userspace still has to issue IOCTLs after retrieval
to bring the restored FDs and associated objects back to a workable
state. Perhaps, we could do something like "Yes, I'm actively using
this object again, so please preserve it if another live update
happens." ?

Pasha
