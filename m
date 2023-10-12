Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84E1F93C
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFMb7YUn"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-41b19dda4c6so171131cf.1
        for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697101312; x=1697706112; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A44PAPYYjtrqLfYXFZPWXJEElHlls4pq3+YExnMek2A=;
        b=iFMb7YUnIkleCA4du/biV3yQK+XkJdIzoBlu+PMyjrwR0KP4ouy1PBk1VBAVZ8nSwX
         WL2Ndv562d/aB49IgcYJrAvFxPUYdILlIsItlnd/EoJlRUl5ulCSfC6cfgm09fvW/i3q
         VAR/KjR0G1hQGcIjSaXJvRIQQG/vwPMWTXovylp2Q99FpGRfhE97f9mk1Z4cm4ctZ6Zi
         jCL+iabt291P+OenMGMurSIGKhq/zPJjA5LSyCJ15sxM49/fGzPAjh8oVgbd4varr5ZQ
         1FlADZSvFD1G19zNOSeIjpVmAf1D59g3BLLNf17EXr940EXKzNaTIsblt0dg3ZNSvlYI
         mCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101312; x=1697706112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A44PAPYYjtrqLfYXFZPWXJEElHlls4pq3+YExnMek2A=;
        b=t6zISz7MuOL99OEigUwlPDJMMT9SzXZE7/4vwFJYLtDbjRGQr4OJ2Xd6N5txZrkp+2
         FHQjp3/4+YuVlzWlok/ep0JBBE6icDTFJipvtwZjB/xs0YpuWBHfSbdCb+eWohhRDqai
         yJ3n+op5mTBXzdow22qiFAmgOmEXUPtsQ226Al8hX/GJViYVVivLnfXtPGnwVD7N/Tv7
         TnH8EsUFGGady/uHEBW0zspL+++pc/fvt/JsKKpeGmYUXNI68Xo4pCSOEUQNkfA7zRQy
         v6urvh1VNilqj1lWjWjKFHw7sqken1JBlTVGtIUTNmgXk54Wvce3ShHngYrQglJN4SQs
         zchw==
X-Gm-Message-State: AOJu0YxPa+tzsbSCrvCngVjRa/5yvY2azse0qzhYMvbpJHYoXtnEgLT1
	+QENolq8a3c1mTFzXnc/50ataxupKrBu+Zdszv79wQ==
X-Google-Smtp-Source: AGHT+IF+mccpNTmru66tYixfbI5vaOyYdI1swIQSoe08G8wn2B7ZxlsKYu9BAr2dF4r9YYJfNh/b9plFnTuM/IeKxI0=
X-Received: by 2002:a05:622a:1792:b0:418:1878:5b8c with SMTP id
 s18-20020a05622a179200b0041818785b8cmr483721qtk.25.1697101311909; Thu, 12 Oct
 2023 02:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <12-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <12-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 12 Oct 2023 17:01:16 +0800
Message-ID: <CAKHBV27FimE8Rnv2oaRb+QjRmYw2X27xGZe-UTjUz_ut5ipCeQ@mail.gmail.com>
Subject: Re: [PATCH 12/19] iommu/arm-smmu-v3: Put writing the context
 descriptor in the right order
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 8:33=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> If we are replacing a CD table entry when the STE already points at the C=
D
> entry then we just need to do the make/break sequence.

Do you mean when the STE already points at the CD table? What's the
make/break sequence?


>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct devic=
e *dev)
> @@ -2554,6 +2546,17 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>                                 master->domain =3D NULL;
>                                 goto out_list_del;
>                         }
> +               } else {
> +                       /*
> +                        * arm_smmu_write_ctx_desc() relies on the entry =
being
> +                        * invalid to work, clear any existing entry.
> +                        */
> +                       ret =3D arm_smmu_write_ctx_desc(master, IOMMU_NO_=
PASID,
> +                                                     NULL);
> +                       if (ret) {
> +                               master->domain =3D NULL;
> +                               goto out_list_del;
> +                       }
>                 }
>
>                 ret =3D arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &=
smmu_domain->cd);
> @@ -2563,15 +2566,23 @@ static int arm_smmu_attach_dev(struct iommu_domai=
n *domain, struct device *dev)
>                 }
>
>                 arm_smmu_make_cdtable_ste(&target, master, &master->cd_ta=
ble);
> +               arm_smmu_install_ste_for_dev(master, &target);

Even if it's handled correctly under the hood by clever ste writing
logic, isn't it weird that we don't explicitly check whether the CD
table is already installed and skip arm_smmu_install_ste_for_dev in
that case?
