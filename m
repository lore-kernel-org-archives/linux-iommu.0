Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9E5102F
	for <iommu@lists.linux.dev>; Mon, 25 Dec 2023 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOz3N9Hb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3e4637853so333665ad.0
        for <iommu@lists.linux.dev>; Mon, 25 Dec 2023 04:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703506671; x=1704111471; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJq0ueoan8+jTtCMkmozG7lx5bMr0Ur9qGULfGVdoTQ=;
        b=mOz3N9Hb7JXVHtTT4Zuywuz7EAHi9TxkuZggNkhVuv8JPgLIEaBDtOLTGgs6Epsmiu
         kl34Dn0n01AGhRsLHq2/kaP5fMIq5cMgHQ3uOr6356iEP5riD7cg8HfttK9cU3ppWn1J
         /Zz+yp62TVWW2+OIDCeEvxNs7ckCjIXBfVUWfaoBiOD3bbVuOv8ZAkvp/o4NWh6NtVoq
         R3JeK11Nt39pqlHl9zcfVJ20xNC45W9ELmYz7cZaPqzO2hm0fEEWSgCWEqugY+hDfUF1
         XB2ZGWYYHMOLB7Xl9j/1IOOxV3oWghLmY4Hgo1QQYd5BIHaPyyhey61LTyXQPg+L76kO
         iXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703506671; x=1704111471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJq0ueoan8+jTtCMkmozG7lx5bMr0Ur9qGULfGVdoTQ=;
        b=KlZbmvLC5xSihGHbCBy316LMK63BsSs7mvnAegAnA9kNGLPrWHzxXE0nXNRWdszkJu
         5FY9jXuiRN2scTpYjf258SekQhZqfN5vxHJL8k7es88sFYRLGmTq+KBc+wMKALuxsmfl
         kBfNr0V0Xn/xJLGmSeocFKrhuvhmfdAwM1pdimKKEJ71GftA5j3p2rxW7hpVAJ8jFwD/
         xyYcQblD3VdgoiW8G0hcwXIMs2Rk4tUlEHFIetSFrdB5L6P3Cobm44Q2Yl1Kgq6jtnmX
         Z1bv9W3EkfVxAsE6VZj2tXS8foAeB0v6tFkVd7k2de6kDO0DYqxLXiRH0hV96txlx278
         0/pA==
X-Gm-Message-State: AOJu0YymT3Z61GGCh4nhOMO5PbiB7ak8UvjeeAXMQJ+9/E7Dgaa9Z7N3
	JX1Goafmqsbk9kqn/wvL5YFmSoTQOHVGIwYijNSGwY4BkuTW
X-Google-Smtp-Source: AGHT+IH6Yu7xyWTTgTWNJ+ozoKuXSDJaoAdDo9YbfZAb1g9MzE3hLfXUOUtdNY4VXKju7USdXMK46Ofp0UaLzOo9YQQ=
X-Received: by 2002:a17:903:1ce:b0:1d3:b085:5e4b with SMTP id
 e14-20020a17090301ce00b001d3b0855e4bmr330480plh.16.1703506670966; Mon, 25 Dec
 2023 04:17:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com> <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
In-Reply-To: <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 25 Dec 2023 20:17:14 +0800
Message-ID: <CAKHBV24ApTjc3hy-kbMD9Y7wVdb5OPTb8bU6AkZdCQPg+LWDSg@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:42=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
>
> +static void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer,
> +                                __le64 *cur, const __le64 *target,
> +                                __le64 *staging_entry)
> +{
> +       bool cleanup_sync_required =3D false;
> +       u8 entry_qwords_used_diff =3D 0;
> +       int i =3D 0;
> +
> +       entry_qwords_used_diff =3D
> +               writer->ops.get_used_qword_diff_indexes(cur, target);
> +       if (WARN_ON_ONCE(entry_qwords_used_diff =3D=3D 0))
> +               return;
> +
> +       if (hweight8(entry_qwords_used_diff) > 1) {
> +               /*
> +                * If transitioning to the target entry with a single qwo=
rd
> +                * write isn't possible, then we must first transition to=
 an
> +                * intermediate entry. The intermediate entry may either =
be an
> +                * entry that melds bits of the target entry into the cur=
rent
> +                * entry without disrupting the hardware, or a breaking e=
ntry if
> +                * a hitless transition to the target is impossible.
> +                */
> +
> +               /*
> +                * Compute a staging entry that has all the bits currentl=
y
> +                * unused by HW set to their target values, such that com=
itting
> +                * it to the entry table woudn't disrupt the hardware.
> +                */
> +               memcpy(staging_entry, cur, writer->entry_length);

This should be `memcpy(staging_entry, cur, writer->entry_length *
sizeof(cur[0]));`

>
> +               writer->ops.set_unused_bits(staging_entry, target);
> +
> +               entry_qwords_used_diff =3D
> +                       writer->ops.get_used_qword_diff_indexes(staging_e=
ntry,
> +                                                               target);
> +               if (hweight8(entry_qwords_used_diff) > 1) {
> +                       /*
> +                        * More than 1 qword is mismatched between the st=
aging
> +                        * and target entry. A hitless transition to the =
target
> +                        * entry is not possible. Set the staging entry t=
o be
> +                        * equal to the target entry, apart from the V bi=
t's
> +                        * qword. As long as the V bit is cleared first t=
hen
> +                        * writes to the subsequent qwords will not furth=
er
> +                        * disrupt the hardware.
> +                        */
> +                       memcpy(staging_entry, target, writer->entry_lengt=
h);

 ditto, this should be `memcpy(staging_entry, target,
writer->entry_length * sizeof(target[0]));`
