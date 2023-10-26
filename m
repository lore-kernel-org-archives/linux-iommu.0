Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A88C15
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2JWeZ5qi"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41cd566d8dfso221731cf.0
        for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698303649; x=1698908449; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/29/a5lUm8kG8B4Dp+T1EptaoOhNI0RBGmgzBy/Hc8=;
        b=2JWeZ5qieFjUL0XFs6zrTJMBAUSfxFkny9D10aQvQb5STm8rIwmT6Blc/GCDijQ6dN
         2PQdd0ZKpyFC3r5p3Q+2Nnth1xqYUck7xsZMwiZyYgJ/kkIrQdI3RaLI+bbaFQYX2jWh
         943beuVoc2O/pVdM9pSUeOki/LUWAr5a2ZYh/QaJ8WP3fiS+kUs6hTv8jirR9FUTdoq9
         qgnchuljxd0OBNgdawzlqdiaXr+G4SPHN9DcaqPvrQCc3CdWWnQTvc3IVNGXxEvuBj+h
         k3d/0T8ZrodQQKbzBCwXgS0kBA2jvJP27uePpZJ0ZFy8Py5zSdOZyHBv7CsfVUbo6DCM
         36SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303649; x=1698908449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/29/a5lUm8kG8B4Dp+T1EptaoOhNI0RBGmgzBy/Hc8=;
        b=Gv1/gJnP6dGyjjAEBKWb3MO2rkZAX6UeEwRudzIaXLQV8PNBdj6u3nJe3vxbZmlgQK
         9nUox/PScYH6VKmwgDv40hFqA1C78oZbjWoa8kOXhS+GURiYwXKZtmlo+qmhPIjM60dd
         2PUBdqXVaHgW7fsWM5cZkGbMjgt9vDen9Fkr71dOu8WJ/PHNRUtaWAXDCqadMGRoqckT
         fV1ANLD38Rnhc817iUr3Vd9ODYpWUVjbd33ayPqyGtGiA7dIX7szWwnH2uS8Q3V/0dA9
         +ufnTtKTWHnZtSApHVsRnGUsUF1t//cHqZKU2ZXpc9S95+chbIpUsbx/ltSsfgUAuymB
         eUrg==
X-Gm-Message-State: AOJu0Yxgn2kNCKcHdn7Y4MXHGRXq9gcqNJvQRgGFQmsnNW1bEA4eUCSD
	Gv1p2iPyW9tXcto3lmThu1nRcbaZNM/Tovw4CjsVlA==
X-Google-Smtp-Source: AGHT+IGJUn1fLp0inr6BaP29gjAgIwUrs/iIOHYmo0OUjhNEUk2/MvecH7l69YFaUnGOHa1re4anLkt4Al22daxDrG0=
X-Received: by 2002:a05:622a:4784:b0:41e:29ad:8b8b with SMTP id
 do4-20020a05622a478400b0041e29ad8b8bmr497040qtb.10.1698303649062; Thu, 26 Oct
 2023 00:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <14-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com> <CAKHBV248yjmRUi+MyJXuDY8V1OKa0WF-eP7GYfthpGE5CFsMCQ@mail.gmail.com>
 <20231024235649.GE911568@nvidia.com>
In-Reply-To: <20231024235649.GE911568@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 26 Oct 2023 15:00:11 +0800
Message-ID: <CAKHBV27tKWzaoVy5BaVJG1VHPR=duU7d08c6J=RvYsO8hiLNcQ@mail.gmail.com>
Subject: Re: [PATCH 14/27] iommu/arm-smmu-v3: Make changing domains be hitless
 for ATS
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 7:56=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Oct 24, 2023 at 04:09:06PM +0800, Michael Shavit wrote:
>
> > > +       /*
> > > +        * During prepare we want the current smmu_domain and new smm=
u_domain to
> > > +        * be in the devices list before we change any HW. This ensur=
es that
> > > +        * both domains will send ATS invalidations to the master unt=
il we are
> > > +        * done.
> > > +        *
> > > +        * It is tempting to make this list only track masters that a=
re using
> > > +        * ATS, but arm_smmu_share_asid() also uses this to change th=
e ASID of a
> > > +        * domain, unrelated to ATS.
> > > +        */
> > > +       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > > +       cur_master_domain =3D arm_smmu_find_master_domain(smmu_domain=
, master);
> > > +       if (cur_master_domain) {
> > > +               kfree(master_domain);
> > > +               state->existing_master_domain =3D true;
> >
> > I'm confused, why would we expect to find that the domain is already
> > attached to the master???
>
> Yes, it can happen, I agree it is
> surprising. __iommu_group_set_domain_internal()'s error handling is
> designed to support the wonky drivers (like smmu before this series)
> which would destroy the domain attachment and then fail
> attach_dev().
>
> To accommodate this the error unwind for
> __iommu_group_set_domain_internal() deliberately resets the correct
> domain again, expecting good drivers to make it into a NOP and wonky
> drivers to restore the attachment they threw away.
>
> > If the iommu core really allows such attach() calls, can we check
> > for that earlier and simply return early from attach_dev()?
>
> We could, but that looked more complex.. We trade an extra if
> under arm_smmu_attach_commit() for an extra if in two callers.
>
> What do you think?

Huh. Can this be checked by calling iommu_get_domain_for_dev() and
comparing against the input iommu_domain parameter, or is
iommu_get_domain_for_dev() cleared in this scenario?
