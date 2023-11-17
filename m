Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7BCA63
	for <iommu@lists.linux.dev>; Fri, 17 Nov 2023 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuB4em/w"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-421ae866bc2so161741cf.0
        for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 20:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700194537; x=1700799337; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnlrFTaQ1JfoVTTR1NXHSAnpdgT8biukh3l3bEluWvc=;
        b=CuB4em/wVafe2MineoxjhnKY3MLnLPCqm7Ed/K+DD9sVJWiCxvZ+1hb6nKcD3th6GG
         nGhcyeKJ2GJXD6plAnJVQ/JU4so/vT3E46nE9yzeq3utahZllXCKeJCTR8B3tQjBrS1W
         b7waytbqeLgE86AobmTW+vFBx2ZmmUjd1TrQHjH/Cpkopo9o8STdAwrRHrVsthzA/I2C
         j3+MavKP0gq3AU1Q6AEkZGVPbysURWnv+Dieugf9ahXLt/j/f9xSZuFHJOMLavdDCyRK
         hoxh5Z71G/ndsZ2n9uwg+q1gmJDGytzvYsNMseYph9ttP7sxRerB81unUu+ddqAS7qfo
         0jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700194537; x=1700799337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnlrFTaQ1JfoVTTR1NXHSAnpdgT8biukh3l3bEluWvc=;
        b=iyGF+8VQZe5RkvfvP7Pe3x/4rJCmRvc0mgTPXNh0YCbojC517qbb/0rCQDXQ0iwgXV
         5DZYPCMHD5bVN5uhAnfQ6xPkvcQYJKy8sxvCujJ7VaPPgYKjeQpvrmP2xRVhcDwwnGUO
         qoWQMcCWHkgGi6g87MnN/7TtOJOY5BIqeaIyNVbv+ugJUMxyIkwhq0NO+ad4O78ZXIvT
         Rb8VRjl9KI54sXKBE4v98tarXhYtRV3t83tksrOBLrYe896cOGdxGLbIPHbshs0es0fA
         yzY1Nt4WrbnF9YVGtzPCnWhKKheNAEtMRyKNWHFKxyhcSjGEDTlBdSdz9+IJnlhJoXBN
         wlVg==
X-Gm-Message-State: AOJu0Yx1ig6Sb0zKmWyV7TDmOwMd5z+3DYrlZISnHjTDV8RKICObKn+m
	l5w1XRwZhK7xRAMVbyIJNh/WAOyB3CPEYg3Iu8xERg==
X-Google-Smtp-Source: AGHT+IHkT6Fj31VaKEiO1ujKdmZQOqp+fdL0L58iqjFAtUMRbFhYPcd8w3UBVmO1oEwux2HInuAkZyoJhw8/Ckb2e0s=
X-Received: by 2002:a05:622a:719a:b0:41c:e10b:a3ff with SMTP id
 jd26-20020a05622a719a00b0041ce10ba3ffmr105434qtb.3.1700194537158; Thu, 16 Nov
 2023 20:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <12-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV25W3JoJ9CnX0+SWjtYauSznSx35KKu43X_9V0MWkBJC0w@mail.gmail.com>
 <ZVZHgbbey+zao0Jv@nvidia.com>
In-Reply-To: <ZVZHgbbey+zao0Jv@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 17 Nov 2023 12:14:59 +0800
Message-ID: <CAKHBV27V9Unx5yiLLbuSGs6OGB7NHM=Ac84oGxAVmzt5OewjTw@mail.gmail.com>
Subject: Re: [PATCH v2 12/19] iommu/arm-smmu-v3: Put writing the context
 descriptor in the right order
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 12:47=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Wed, Nov 15, 2023 at 11:32:28PM +0800, Michael Shavit wrote:
>
> > > Lift this code out of arm_smmu_detach_dev() so it can all be sequence=
d
> > > properly. The only other caller is arm_smmu_release_device() and it i=
s
> > > going to free the cdtable anyhow, so it doesn't matter what is in it.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Michael Shavit <mshavit@google.com>
> >
> > This patch might be a better fit before the previous one. When going
> > from S1 to S2 or bypass:
> > Pre-both patches, attach_dev() installs a NULL STE, then clears the
> > now unused CDE, then installs a new STE.
> > After the previous patch, attach_dev() clears the *still used* CDE,
> > and then replaces the STE.
> > After this patch, attach_dev() replaces the STE, and then clears the CD=
E
> >
> > Reordering the two patches removes the scenario where we could hit a
> > NULL-ed CDE.
>
> NULLed =3D non-valid
>
> I see what you mean, but I haven't thought carefully about a different
> order so I'd rather leave it..
Ack; it's probably too subtle to matter much anyhow.
>
> Regardless of order the two prior patches will have cases that hit
> non-valid/abort STE/CDEs, each step removes a few cases.
>
> Thanks,
> Jason

On Fri, Nov 17, 2023 at 12:47=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Wed, Nov 15, 2023 at 11:32:28PM +0800, Michael Shavit wrote:
>
> > > Lift this code out of arm_smmu_detach_dev() so it can all be sequence=
d
> > > properly. The only other caller is arm_smmu_release_device() and it i=
s
> > > going to free the cdtable anyhow, so it doesn't matter what is in it.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Michael Shavit <mshavit@google.com>
> >
> > This patch might be a better fit before the previous one. When going
> > from S1 to S2 or bypass:
> > Pre-both patches, attach_dev() installs a NULL STE, then clears the
> > now unused CDE, then installs a new STE.
> > After the previous patch, attach_dev() clears the *still used* CDE,
> > and then replaces the STE.
> > After this patch, attach_dev() replaces the STE, and then clears the CD=
E
> >
> > Reordering the two patches removes the scenario where we could hit a
> > NULL-ed CDE.
>
> NULLed =3D non-valid
>
> I see what you mean, but I haven't thought carefully about a different
> order so I'd rather leave it..
>
> Regardless of order the two prior patches will have cases that hit
> non-valid/abort STE/CDEs, each step removes a few cases.
>
> Thanks,
> Jason
