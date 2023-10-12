Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7C168AA
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPUYUlPz"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-419b53acc11so222841cf.0
        for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697098286; x=1697703086; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlIYLcLwLECGIAnaXaWKIQbKBw6E1nzMX1dRyzza4gc=;
        b=RPUYUlPzXcOtcCoHqhT9vuMQI7dPEDUcIPPb1Ocds/XBx8s0z7aVWAe3Vy054U18dz
         /1hzsEHpDq99DT27GmlXhTs4g1em5s7ALsir0B/NfnMscpxSN3r0uEp8xWlMdSWLqjzK
         yDRN4on3GDfq53dnNma3FEiq4ptZHtka1GupGed4jsbiB56j3NdAPe+kiyHxNVNeij4j
         mHWlqExgvfiaM2dJgKHGcm2rXBxefq/ZDG8QNitSvSWkevzWBQKgAsbkjLLccnU/wSrY
         O/KwLLrKscmWamBHoJSirYpWEYx6BBIf8P4ONpGkOmdU6eeScmddwQ2njX2vG/KqnkTW
         do2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697098286; x=1697703086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlIYLcLwLECGIAnaXaWKIQbKBw6E1nzMX1dRyzza4gc=;
        b=Xgc5+MBIcokwbmQktNBqCYBUzQG/Q3vgvmeuOVdr6wvn7NOr1BY6BggxOl08VBsXdH
         /6YtIJ1LH2KCN4zBgA0UTzNilYAhQF/0qQLq1o9FhyREqe3yltEYcRoOIBJcZ8VNYteI
         c7CwpNk5WiEEXF2Vr9goaYFA4SXDgYmP+OsgIhNt5WGTkMWk01bX/k/aSc6MDdTdbrpF
         F1vlJkBXxgKhWxy6VOV4XtzvLSzUFKYoGakJUaSHiWEipQY9Yey5CiABpUlZElVEeUhY
         Q8qRL3Uz22I310YF7hCfeefECaVos7rEbA/9ZPjTjNJbQMEyunydakaN5paMwsPQkrwS
         Dktw==
X-Gm-Message-State: AOJu0Yx3aFrnMqKtbzDCx45CWuHWk7HdZc6W30/Z2sNFZUvkDKEYVfU5
	TipaekmwkdBT02H8owr7sTDz16BvpJBauflim+OKRg==
X-Google-Smtp-Source: AGHT+IF4JB6iUbpc+bHMk55Z6HkdE60MY1PLmF6rCBvKLaqDe8TyBmZ7tqMjVF10t1FCNqNR7zcnmtFAcFP4g5H933U=
X-Received: by 2002:a05:622a:1ba9:b0:419:6a24:efb6 with SMTP id
 bp41-20020a05622a1ba900b004196a24efb6mr473651qtb.21.1697098286479; Thu, 12
 Oct 2023 01:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 12 Oct 2023 16:10:50 +0800
Message-ID: <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 8:33=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> As the comment in arm_smmu_write_strtab_ent() explains, this routine has
> been limited to only work correctly in certain scenarios that the caller
> must ensure. Generally the caller must put the STE into ABORT or BYPASS
> before attempting to program it to something else.
>
> The next patches/series are going to start removing some of this logic
> from the callers, and add more complex state combinations than currently.
>
> Thus, consolidate all the complexity here. Callers do not have to care
> about what STE transition they are doing, this function will handle
> everything optimally.
>
> Revise arm_smmu_write_strtab_ent() so it algorithmically computes the
> required programming sequence to avoid creating an incoherent 'torn' STE
> in the HW caches. The update algorithm follows the same design that the
> driver already uses: it is safe to change bits that HW doesn't currently
> use and then do a single 64 bit update, with sync's in between.
>
> The basic idea is to express in a bitmask what bits the HW is actually
> using based on the V and CFG bits. Based on that mask we know what STE
> changes are safe and which are disruptive. We can count how many 64 bit
> QWORDS need a disruptive update and know if a step with V=3D0 is required=
.
>
> This gives two basic flows through the algorithm.
>
> If only a single 64 bit quantity needs disruptive replacement:
>  - Write the target value into all currently unused bits
>  - Write the single 64 bit quantity
>  - Zero the remaining different bits
>
> If multiple 64 bit quantities need disruptive replacement then do:
>  - Write V=3D0 to QWORD 0
>  - Write the entire STE except QWORD 0
>  - Write QWORD 0
>
> With HW flushes at each step, that can be skipped if the STE didn't chang=
e
> in that step.

This sounds pretty complicated....Is this complexity really required here?
Specifically, can we start with a naive version that always first
nukes `V=3D0` before writing the STE? This still allows you to remove
requirements that callers must have first set the STE to abort
(supposedly to get rid of the arm_smmu_detach_dev call currently made
from arm_smmu_attach_dev) while being easier to digest.
The more sophisticated version can then be closer in the series to the
patch that requires it (supposedly this is to support replacing a
fully blocking/bypass STE with one that uses
STRTAB_STE_1_S1DSS_TERMINATE/STRTAB_STE_1_S1DSS_BYPASS when a pasid
domain is first attached?) at which point it's easier to reason about
its benefits and alternatives.

> @@ -1365,23 +1490,17 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
>                          STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
>                          STRTAB_STE_2_S2R);
>
> -               dst->data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3=
_S2TTB_MASK);
> +               target.data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE=
_3_S2TTB_MASK);
>
>                 val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2=
_TRANS);
>         }
>
>         if (master->ats_enabled)
> -               dst->data[1] |=3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EAT=
S,
> +               target.data[1] |=3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_E=
ATS,
>                                                  STRTAB_STE_1_EATS_TRANS)=
);
>
> -       arm_smmu_sync_ste_for_sid(smmu, sid);
> -       /* See comment in arm_smmu_write_ctx_desc() */
> -       WRITE_ONCE(dst->data[0], cpu_to_le64(val));
> -       arm_smmu_sync_ste_for_sid(smmu, sid);
> -
> -       /* It's likely that we'll want to use the new STE soon */
> -       if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH))
> -               arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
> +       target.data[0] =3D cpu_to_le64(val);

Can we get rid of this line and use target.data[0] everywhere above?
'val' isn't exactly a great name to describe the first word of the STE
and there's no need to defer writing data[0] anymore since this isn't
directly writing to the register.
(Feel free to ignore this if it's already addressed by subsequent patches)
