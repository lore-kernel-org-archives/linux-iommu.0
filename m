Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA251863
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INHAx5/7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-419b53acc11so167161cf.0
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698115735; x=1698720535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9OPik61UyDurBOL+64FsxBkep4eWMce8quGQL9/ReY=;
        b=INHAx5/7gUl3TPBLzJnjQBTE69QM62EOGP5chnQkQd2PLc+fpWOWqmcLPMwpBcA+Gj
         wF0x3hDo5DVX9nJXBFa5wQ8u8xeAnbkZ9HO8HummhLwhsde0CfNelwW42XuaLJ9iuphl
         V1zzlmlKs9kVpHbxrebPpLRL8ddY3TCIEPgiQYmUPYdgkZxLUw6xN1RL0ElNeIwTN6hx
         /F3Dtqd95KpCmN02bvvuLjA7QNCtoiUbujCdWsgb/V4ABhiM5BUgo282AYgcWXlayfPY
         bX5ImK3of4kOWWu+xk7tyBVS8sElnOxPi+ABUHO1o7wuyZdtP1L2bcq+IE/N5CRg7qo4
         49Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698115735; x=1698720535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9OPik61UyDurBOL+64FsxBkep4eWMce8quGQL9/ReY=;
        b=AXFMP1QzLs4HVc64W25wikg6Ub/6fLJ38GNtYXZUycr5RozdhQ5bhVxVec0F003gcp
         kxTYwSbCxGu4bRazBJkrrhN+qernakc0/hNT68peJRwUQCgem2985FB4HCsNCjUwk89+
         VEWZE3DeXwownRb1dw/9+m8JdV9+qy2J5gp3j9pw0Kx9ByMzkC88NNhTNfkxG2/BBtoJ
         /kL9pxA5y7oAG5VQYiV29sUZOaBoAsbjoiEixxpYP9dnj8Rap6Yn+GoR3BCcKobxXkPj
         /PHlvR/GEOc9d+VsshW9IHsHXVBSahxf76VUQKBJx027lvqh/frUORsE8wctI+ML7jkX
         o4AQ==
X-Gm-Message-State: AOJu0YzriFbguJqrs2edqsbeY3AqW4IYdbqqmg57dOV9i6T6Z4fPjptx
	CRtoVXjOgl4nZ6mapcq57sJmG4bNnQdrGItSVVxGKA==
X-Google-Smtp-Source: AGHT+IFbO+7EGvbcDydIrh0DiBnInNo3hYhlZvt/YCf6NNaurzK8tMz/iflxV3umCHqHJXD4glyKccI/G+tTiqTxAKo=
X-Received: by 2002:a05:622a:6a45:b0:41e:2984:6dba with SMTP id
 ig5-20020a05622a6a4500b0041e29846dbamr70793qtb.3.1698115734781; Mon, 23 Oct
 2023 19:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <9-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV25tgz6AE_pB46-8WeN78q+gXnjXB-4MEE_cpqVV7xSLcA@mail.gmail.com>
In-Reply-To: <CAKHBV25tgz6AE_pB46-8WeN78q+gXnjXB-4MEE_cpqVV7xSLcA@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 24 Oct 2023 10:48:18 +0800
Message-ID: <CAKHBV263CZaUOLi_q5sPE6kb_Uzd_NvHp-d8vOS_bPsC+cjh4A@mail.gmail.com>
Subject: Re: [PATCH 09/19] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during
 all of attach_dev
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:44=E2=80=AFAM Michael Shavit <mshavit@google.com=
> wrote:
>
> On Wed, Oct 11, 2023 at 8:33=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > The BTM support wants to be able to change the ASID of any smmu_domain.
> > When it goes to do this it holds the arm_smmu_asid_lock and iterates ov=
er
> > the target domain's devices list.
> >
> > During attach of a S1 domain we must ensure that the devices list and
> > CD are in sync, otherwise we could miss CD updates or a parallel CD upd=
ate
> > could push an out of date CD.
> >
> > This is pretty complicated, and works today because arm_smmu_detach_dev=
()
> > remove the CD table from the STE before working on the CD entries.
> >
> > The next patch will allow the CD table to remain in the STE so solve th=
is
> > racy by holding the lock for a longer period. The lock covers both of t=
he
> > changes to the device list and the CD table entries.
> >
> > Move arm_smmu_detach_dev() till after we have initialized the domain so
> > the lock can be held for less time.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++++++++---------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 2c06d3e3abe2b1..a29421f133a3c0 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2535,8 +2535,6 @@ static int arm_smmu_attach_dev(struct iommu_domai=
n *domain, struct device *dev)
> >                 return -EBUSY;
> >         }
> >
> > -       arm_smmu_detach_dev(master);
> > -
> >         mutex_lock(&smmu_domain->init_mutex);
> >
> >         if (!smmu_domain->smmu) {
> > @@ -2549,7 +2547,17 @@ static int arm_smmu_attach_dev(struct iommu_doma=
in *domain, struct device *dev)
> >
> >         mutex_unlock(&smmu_domain->init_mutex);
> >         if (ret)
> > -               return ret;
> > +               goto out_unlock;
>
> Oh, missed this earlier but on a second look the asid_lock isn't
> grabbed here yet so this should stay as return ret.
>
Guess you must have noticed it too since it's fixed in patch 09 of the
second series :) .
