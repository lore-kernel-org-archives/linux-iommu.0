Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C98C10
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 08:54:11 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-407db3e9669so175101cf.1
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692694451; x=1693299251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYH3dUSDs9v17pTi1zWcJ78xVX1MVU0RCa4MT/4Yxs0=;
        b=dTMvSSoIZ6kCkSkQgwlYvjOKZYbVKzTROd6wTJyMbhG2TMp03D98PMAghcvl/h+hHu
         v84CG1UiYIIc2LyzEHkyxizjc0xn/ADi2RZTWcuCbRpjG4a/kGRuNquQxe4yi+iWSf5O
         sf+EwEdak5IHHYB/Md6PNeo8AVtGHoAlpjYsnyhPFexkqzXCkG8lfVSbhjA7GiRCmsgu
         iJFBBGmZ2EPddQtqHsVE6HTZTgVJlQKO+k91RFDlDTL5yR9M5fU+GGa6x5K8RKKivopp
         2AogkOOr2NHy5NvG0P1U6V8Va6rp0/WTfOeq/UpeykDQZ81xCpHvEwc21SWdJ+0evg/U
         vfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692694451; x=1693299251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYH3dUSDs9v17pTi1zWcJ78xVX1MVU0RCa4MT/4Yxs0=;
        b=Jw2TuM+RCZn2iBqJtJJ85DB9W/e72CUSm7a2dIGAubQq5jqrZiadDJEO74xtagtAEe
         1bLwlHX9oGcC8CZebAN91cK34FLhczJZ+ev3NbjBiksA/KWdeLE/uXuqeapIbQhGRtRn
         8jgaMObKe5zpwEy9/y7t8zMx9covaA75X9Pffz5tfciLV74OUTFUPEIOU9R0uKbhe9Ll
         Y96NDJao3akI6X9BcKE5aq2Uwo4HerjIGfab3Mcx4DJUDpm8/yAUeA8IHWi9Lx/pRP/3
         YKRBChznGo6qyWmCg1gB5FsFomSELzwpqwqV81kze8wWAsO6yiXfJwgGpA7oK9MaKbPQ
         2yAA==
X-Gm-Message-State: AOJu0Yz38uNJi3VbnAn2rJZ8vrplLlDLyADlACHY5bta3N9dRoDZjOU7
	cy/3+ycgLNEkO5+fhzAW2bIZ0Oj5fBo54PQk0eDrDQyqB/2Zk68hq0A=
X-Google-Smtp-Source: AGHT+IHPkk75C1bdYvP+EuL7CdVDVQ8If+W8vM2KpDrVG9bYqoQnKM8zJlD52OebVy67O9zqx96hbGEcbRh8shKmECs=
X-Received: by 2002:a05:622a:144a:b0:3f2:2c89:f1ef with SMTP id
 v10-20020a05622a144a00b003f22c89f1efmr115447qtx.5.1692694450838; Tue, 22 Aug
 2023 01:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com> <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com> <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
 <ZONrkVX6kZjX/wus@nvidia.com> <CAKHBV27PL=2jxOd0BoYdoBMTu_0rm4z_JP6iG+SVi5Ag7w2kWw@mail.gmail.com>
 <ZON0E3KV46EEPw/p@nvidia.com> <CAKHBV25P9kNGkM7f5Xc-HsozK362XzMz+NnLa8FcWiu3FFr13g@mail.gmail.com>
 <ZON7Dt4Hkf8iwaDC@nvidia.com>
In-Reply-To: <ZON7Dt4Hkf8iwaDC@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 22 Aug 2023 16:53:33 +0800
Message-ID: <CAKHBV24qFgbw4uBY7qQkPeWowZ=F9d6YW-WeqsTG7Y_z0Yw85g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com, 
	tina.zhang@intel.com, jean-philippe@linaro.org, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 10:56=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Mon, Aug 21, 2023 at 10:39:14PM +0800, Michael Shavit wrote:
> > > > > > (on a loop over every smmu the domain in arm_smmu_mmu_notifier_=
get is
> > > > > > attached to, which just at a glance looks headache inducing bec=
ause of
> > > > > > sva's piggybacking on the rid domain.)
> > > > >
> > > > > Not every smmu, just the one you are *currently* attaching to. We
> > > > > don't care if the *other* smmu's have different ASIDs, maybe they=
 are
> > > > > not using BTM, or won't use SVA.
> > > >
> > > > I mean because the domain in arm_smmu_mmu_notifier_get is the RID
> > > > domain (not the SVA domain, same issue we discussed in previous
> > > > thread) , which can be attached to multiple SMMUs.
> > >
> > > Oh that is totally nonsensical. I expect you will need to fix that
> > > sooner than later. Once the CD table is moved and there is a proper
> > > way to track the PASID it should not be needed. It shouldn't fall int=
o
> > > the decision making about where to put the ASID xarray.
> >
> > Right I got a bit of a chicken and egg problem with all these series.
>
> Yes, I'm not surprised to hear this
>
> Still, it would nice to move forward without going in a weird
> direction too much.
>
> Once the CD table is moved to the master what do you think is blocking
> fixing up the SVA stuff to not rely on a RID domain?

These aren't necessarily strict dependencies, but ideally I'd like to:
1. Natively support PASID attachments in the smmu domain (patch(es)
from the set_dev_pasid series)
2. Support attaching a domain to multiple SMMUs (this series)
3. SVA framework support for allocating a single SVA domain per MM
struct (Tina's series)

SVA can then directly attach an sva domain to a master in its
set_dev_pasid call, without having to do any sort of sharing of
smmu_notifiers or CDs across domains. The SVA domain allocated would
directly be attached to the master.
