Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E737CA57
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 13:14:47 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-414ba610766so518841cf.0
        for <iommu@lists.linux.dev>; Tue, 05 Sep 2023 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693919686; x=1694524486; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFbNMkBJuPkeEaGJvYM58C6Cd/4ziikLBz9Bfejhs5c=;
        b=LOSlfmzwUJ/nDCqwlcq+RWtyC5W3n33skJHIKQJpFQghTorP7p09lqd2PzaRjXrHwH
         XaNTjPMFaoZ2mTrgkO5ckmbNk0TE7AeYwhYNoY89qxpDVXOC5BB8AirTZfq1z9uFi2dU
         MOIucVfGYG+VK7rNj0U7c53QfqPASWGyFBhcZiiZQ+Ftx9kfUBWOhZJX2QNEhadok28K
         VgZHCMfKyh0xP7RElmsM0EDGAvxkzAzgGOORaB8MzF4499xE4EfzT9F2/tg0sxNi5pnV
         3MEKgB2ySUQWGldvHh9aZS9pRTOPrIq1sqIsBlIALiE7+/DzhBz+iWtc8QsCs80rro+9
         Fljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693919686; x=1694524486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFbNMkBJuPkeEaGJvYM58C6Cd/4ziikLBz9Bfejhs5c=;
        b=e5RB74eBg3K/AG3Nor7rPnezS0fJilyrFbBza1Q3sxTv6zp+uluoLPG/874SSDSKvA
         6CIJzD+EKwTgb1JyX57nNAmKYhU2YOjX841ar/tar3a/XMmkTN+c0FbvzhxuFpKf1Rmn
         sadtGmzifcS7Yk7NPRh81rHLqG+Xj/SDw4CfUYMYgjMaJs8zduSn8C1kBfWvnxUKkcBL
         1Rrvn2hqi3mNfzrgjYLNGot8o8NctiIdZDwWHJe05yo8lITL5+dIzcOAsKK6Opf0tZaT
         uvQa/WOXBvCtXlDgNZ5xKzefoEbAgxKqnusoAaE1Ue/Ejpk5Rr73RkTB7TZky2JZ+cxr
         c3Tg==
X-Gm-Message-State: AOJu0Yx4pl6QtoUcwiFri1f42w8XGAvkQ21eafvJ5xxIeF4D9MiDOiPZ
	cI0hFVImcjtSllF4IM3FtjnORRyzwiixUhJRPD2ofA==
X-Google-Smtp-Source: AGHT+IHAirqfK7qQebYh0aD5L/jpR4HP//Y1iUXxMQOm4eRtAc0UjWRDb1AGmrCxW11OAOyh1V7LgqX5zNgaMqAMc9I=
X-Received: by 2002:ac8:5716:0:b0:403:e1d1:8b63 with SMTP id
 22-20020ac85716000000b00403e1d18b63mr586298qtw.24.1693919685952; Tue, 05 Sep
 2023 06:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com> <20230905194849.v1.3.I211f2ab0ee241f53cdfbc3a8a573f14b8a46fb26@changeid>
 <ZPciLKG2Gi/Biovp@nvidia.com>
In-Reply-To: <ZPciLKG2Gi/Biovp@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 5 Sep 2023 21:14:09 +0800
Message-ID: <CAKHBV27=sTW3jXqqCJCPfMFRq=h8_S4JSrSAx61pfWqKrCak0w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	nicolinc@nvidia.com, jean-philippe@linaro.org, tina.zhang@intel.com, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Tomas Krcka <krckatom@amazon.de>, 
	Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 5, 2023 at 8:42=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Sep 05, 2023 at 07:49:14PM +0800, Michael Shavit wrote:
> > Create a new iommu_domain subclass for SVA iommu domains to hold the
> > data previously stored in the dynamically allocated arm_smmu_bond. Add =
a
> > simple count of attached SVA domains to arm_smmu_master to replace the
> > list of bonds.
> >
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
> >
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 70 +++++++------------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
> >  3 files changed, 26 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/=
iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > index 9fb6907c5e7d4..0342c0f35d55a 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -24,14 +24,13 @@ struct arm_smmu_mmu_notifier {
> >
> >  #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, =
mn)
> >
> > -struct arm_smmu_bond {
> > -     struct mm_struct                *mm;
> > +struct arm_smmu_sva_domain {
> > +     struct iommu_domain             iommu_domain;
> >       struct arm_smmu_mmu_notifier    *smmu_mn;
> > -     struct list_head                list;
> >  };
> >
> > -#define sva_to_bond(handle) \
> > -     container_of(handle, struct arm_smmu_bond, sva)
> > +#define to_sva_domain(domain) \
> > +     container_of(domain, struct arm_smmu_sva_domain, iommu_domain)
>
> I'm not sure about this? This seems like a strange direction
>
> The SVA domain and a UNMANAGED/PAGING domain should be basically the
> same thing. Making a sva_domain a completely different type looks like
> it would stand in the way of that?

Agreed that's the eventual destination of all these re-works, but the
stage isn't fully set for that yet. IMO this is a simpler improvement
to get through for now, and I don't see it being an obstacle in the
future.

> > @@ -545,12 +526,11 @@ static const struct iommu_domain_ops arm_smmu_sva=
_domain_ops =3D {
> >
> >  struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> >  {
> > -     struct iommu_domain *domain;
> > +     struct arm_smmu_sva_domain *sva_domain;
> >
> > -     domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > -     if (!domain)
> > +     sva_domain =3D kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> > +     if (!sva_domain)
> >               return NULL;
> > -     domain->ops =3D &arm_smmu_sva_domain_ops;
> > -
> > -     return domain;
> > +     sva_domain->iommu_domain.ops =3D &arm_smmu_sva_domain_ops;
>
> arm_smmu_sva_domain_free() should container_of before freeing, but
> gross to assume the iommu_domain is the first member.

Oh good catch I missed updating the free.
