Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E91ADE8
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 17:04:20 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-40c72caec5cso10691cf.0
        for <iommu@lists.linux.dev>; Tue, 01 Aug 2023 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690909459; x=1691514259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtiZ/2g+uRWOlvdf02o01d3yF2A6nxZGDaY/kcHLaKU=;
        b=DBSMzQ6mgKsgt1hDGi5ZVgF0h9BEm3p0wT9fus6WIGe4OHTavNXlngjdTRVLBTlswk
         8lNX8Bm5BQJtReLn1ylzH/1DHl5n7KsFnv2KPv7oGw38xOff4QHynk1DJfBKOKJW5h0O
         0qUaLecNno+Fg7EJ1wX0DRCHNlE2DGOVRDqCsI/CIBOCURh+g6/DWLprnsuobBhnuaEz
         PfTol6v95rg03T0UAsyJopKOaNmzNXA3rPlnzSAU3Ii6+QasrWUw/+soO7bnx6JBxN6x
         Hh25Rz1pQ486Be2zEVjQvNIKc0MVVtXWxfEuMbiycY65XBDlURXrYoV7jtH3sTONXVid
         RA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909459; x=1691514259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtiZ/2g+uRWOlvdf02o01d3yF2A6nxZGDaY/kcHLaKU=;
        b=C5jjkM8gwslUNsGKtlrCh29wgJwbMN0hp6rNcSonTA3+MRystjdS3YXzNaGI7X7hzz
         trX8HDc6i+imM2u1EysPqE/ALS6gyFVxdA802fPAvDjvXEepTiFNHidb98rLAR5RP+sb
         icEpCS9ioBanGkxwlChYJ8zxHLWrfL7fHDlPw6nCCA8dhPC1PCQWGol91yvFaBmDJzTc
         YowtMVOKC0V6HMaw8tnabISLoKjbfd2qCYTwGvWeWJyden7qtMRmEuIfpPp1cc6jU2cV
         kioOtr6raVTPW2REpvm4tz9qavAuFcuTgn1bXfx+WvJSoidCIfQpkqSrr3jSBHQCixkq
         hD+g==
X-Gm-Message-State: ABy/qLYzC2yzu9wM6kX6EbONpRso6j5WZ2zlMbZmBYpsTD+a0L4atxqi
	bQp5OsAiHlWR6jzdMIA2VBK3cMy7asw5ELySOemqQw==
X-Google-Smtp-Source: APBJJlHpos92MVcMyqsUnxl06UQwzPlCnyYB0wP5AYGPjD0cWyAYOalszh5XhLejGTaOSoVqUGELBqR5Gp8/iCbcYNc=
X-Received: by 2002:ac8:7e87:0:b0:40e:332b:ba30 with SMTP id
 w7-20020ac87e87000000b0040e332bba30mr552428qtj.23.1690909458906; Tue, 01 Aug
 2023 10:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com> <20230731184817.v2.6.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <ZMkULTvwIIE3zo5+@nvidia.com>
In-Reply-To: <ZMkULTvwIIE3zo5+@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 2 Aug 2023 01:03:42 +0800
Message-ID: <CAKHBV25W_UTdhaL2L4ezP60TxgvP86sa_1-8L-aOiyjz64Fkug@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 1, 2023 at 10:18=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> You know, you should try to keep the function instead of duplicating
> these
>
> arm_smmu_write_ctx_desc_devices()
>
> And put the four lines in there?

Urhhh yes, I thought I had a reason for this but probably just a lapse
of judgement. Done.

> -     ret =3D arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> +     spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +     list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +             ret =3D arm_smmu_write_ctx_desc(master, mm->pasid, cd);
> +     }
> +     spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

Just noticed that this is problematic; we may not notice a failure if
it occurs on an earlier iteration of the loop. Will fix.

>
> > @@ -987,19 +985,14 @@ static void arm_smmu_sync_cd(struct arm_smmu_doma=
in *smmu_domain,
> >               },
> >       };
> >
> > -     if (!smmu_domain->cd_table.installed)
> > +     if (!master->domain->cd_table.installed)
> >               return;
>
> BTW, do you have locking for this? I didn't check carefully

This is one of the reasons I wanted to take this as a parameter to the
function. This relies on callers guaranteeing that the cd table not be
attached/detached while this call is in progress. This works now
because:
1. No domain may be attached/detached while SVA is enabled, which is
most of the calls that lead to arm_smmu_sync_cd
2. The other call to arm_smmu_write_ctx_desc in arm-smmu-v3.c is more
obviously serialized with operations that detach/attach the cd table.

Maybe this should at least be a comment on arm_smmu_write_ctx_desc, if
not a lock?


Speaking of.... I should probably flip this bit to false in patch 5
when the cd table is detached.
