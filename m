Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA187C2E4
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 20:10:50 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so4272317a12.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683317449; x=1685909449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ntx9kUf7coInpGr8/n+akUF1hqzZ8aZiwMO9QZmnpQA=;
        b=UiTt2cXGgNc4ozOmAct2VvdRD/943At/akt3JQrDQQ0Y92EZH5OlYDeN0SG+b6vPNJ
         c52mRmyAfPlRbgejI+ogXfkrIhgPiAofkV+qaIbrW30CZNjLjVZG9Abm8pMG1FK6RUoJ
         7ZV/W4z4PBErA4w8v+c7NGRNmqabvX6TOh+wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683317449; x=1685909449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ntx9kUf7coInpGr8/n+akUF1hqzZ8aZiwMO9QZmnpQA=;
        b=A4EGTPOFSswf58Q3ARSSVG8GqiO+L576ERjIXyKx5veMf7ozM9C4jS7gy9q3e0ESQY
         ljONuHDC21GDGKa3vwBFu+FCMWz8b0noBmRziRoZpvTRwi9btxIKATywW47ruY8H0nu+
         3UbDVRFS3V2OHsNZJ9SbN/TGRYCot78fmseTm1MPSzL8z4TvsBcqZOIDMGQAF0MhRyLG
         Vwd6ul4YiURuUC16x6szDU06cOXB6zxgYKPnl/H1Ygc9JkhoS821fq7togkEIO030vg2
         NvKdoMzoGYJSDIW4iX7oLdYaz+TZ2ZM3NIP0p5wP4RVOaZTxdDScDKlodIhAucr/jqfJ
         uofQ==
X-Gm-Message-State: AC+VfDzeWa7N4jVvltZaFJFUZqZ4YoF6xVU4+daUKR91Su5viA7TlalC
	7ZO8wrWKTmG/caobWkk3vxxVzZFWms4oF5oqkunFZQ==
X-Google-Smtp-Source: ACHHUZ5eUkTpbvsLh2TkVlVGxVzsCCZOKcTEuYTNQeLZlWa82d7SwL+z/9ytr+GhWx7BXg8hetJm5g==
X-Received: by 2002:a05:6402:788:b0:50b:c665:55ea with SMTP id d8-20020a056402078800b0050bc66555eamr2093066edy.3.1683317448739;
        Fri, 05 May 2023 13:10:48 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7c402000000b00501c96564b5sm3227168edq.93.2023.05.05.13.10.48
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 13:10:48 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-95f4c5cb755so392379266b.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 13:10:48 -0700 (PDT)
X-Received: by 2002:a17:907:7e9c:b0:94e:afa6:299f with SMTP id
 qb28-20020a1709077e9c00b0094eafa6299fmr2387046ejc.22.1683317447827; Fri, 05
 May 2023 13:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org> <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
 <ZFUMja5MpRPWCRXw@8bytes.org> <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
 <ZFVfncB76TrB+c4K@ziepe.ca>
In-Reply-To: <ZFVfncB76TrB+c4K@ziepe.ca>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 May 2023 13:10:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvonKjgyY1-Mc9POg1euT68wX3Z5+wqBckN+_j=pOaAw@mail.gmail.com>
Message-ID: <CAHk-=wjvonKjgyY1-Mc9POg1euT68wX3Z5+wqBckN+_j=pOaAw@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 5, 2023 at 12:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> At least with the current situation CONFIG_INTEL_ENQCMD might be an
> appropriate name, split out from the IOMMU kconfig and put in arch
> kconfig?

That would at least somewhat clarify the use. I find IOMMU_SVA to be a
particularly opaque name.

Admittedly I probably find it opaque because I come at it as somebody
much more familiar with the MM side, not from the IOMMU side (and the
_other_ conditional fields there make sense from that standpoint), but
even so I think it would be good to clarify.

Of course, making clear it's architecture-specific would also be an
argument for having an actual architecture-specific part of 'struct
mm_struct' (the same way we have 'struct thread_info' in task_struct),
but with only one single field I suspect that's just not worth it.

And who knows - maybe other architectures will pick something like this up?

But yes, it might be good to really pin down what the rules are. Right
now IOMMU_SVA has *no* real help-text (there's a comment saying "#
Shared Virtual Addressing"), and is also enabled by ARM_SMMU_V3_SVA,
which apparently doesn't actually want pasid support at all.

I dunno. I don't think this is a huge deal, but it did cause some
confusion during the merge.

                 Linus
