Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A06125B2
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1zsH7oI"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-429d2ebdf05so671811cf.0
        for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705397018; x=1706001818; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVDvc2YdfIW5PTsIFTj5H+ZdE03DaXP+CZ34CLDMbmM=;
        b=c1zsH7oIteHoYsFJeoZUhJSeQxqNM398A+dpq7pITQ3dxS7odHqwT6W7p6/6xQjHla
         /n5RUSZt7/x6LHy0r705vMHGY8HHdZLMELeXR82v/PcWWw8MwLuFnwkrXl7cF65qmagv
         KfcWL1GpntJg1hjs4B0vMKqQ5NTxr4pBYvajXrnhewmLASA4jc9EmRcKdaPu/Oo4oN7M
         Cyk3F9sOTgrnxSh+0YNW4BMXw7ary7wBM/8apC2IgD170yQkHiaJHKizP9F8OxYlvUKe
         3cwZigcC2hjlUCfgZO2SPPPlWT3X4ilMmegIEye3oJIVjspZroWXBs8HcfOkgLgbqrot
         haTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705397018; x=1706001818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVDvc2YdfIW5PTsIFTj5H+ZdE03DaXP+CZ34CLDMbmM=;
        b=pj3kN6rpaHODRyakoztpMBQfJSVkKDJ0F0od5IL5nmyV6sJVSwC3W02ZltmppVpoIY
         SreMfiTSCHVlrCrklhGvEqIXc/g4ElNb8rFb2PWtCXSRwU8V3isYLsAxNjl0WDQnPPmY
         pq0YaAH39HKnHeB/bZxveLieLC8gEU/2TczGAw1gsg4CF00YvsWvlBMxmFj/TMFNg3aq
         H5Cii5eWiYtKxCjmoM/UfBHUhx9MPUfBojbssW/COF73li1vDInX6qCwTSaVrSgoJ+B2
         uKLYqAcvVkCO1ABqyIw8uOh5rgXtrcaYPfeLmzAAucNKeQlXh6HyGn3dU66w7eB10MaG
         fu9g==
X-Gm-Message-State: AOJu0Yz1f69noYEchtDK/jVfSImnjHWlrbSHFCUgfU71r/U8dJEd1TnF
	gwwIZUMiZgAQN1ZwlVa0HneeGQJti1pg0BrtDt2TBdqfIMaN
X-Google-Smtp-Source: AGHT+IF3z/aE5y9g/FprLplZDYlaZbp+EvR1Ntz9NPLb2uz3IxrTBA37o/iYp1LHId8PZJqVNlOVhOkbij+WsOP0EAU=
X-Received: by 2002:a05:622a:4d4:b0:429:bd26:1f6 with SMTP id
 q20-20020a05622a04d400b00429bd2601f6mr1100241qtx.3.1705397018366; Tue, 16 Jan
 2024 01:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240103175043.GS50406@nvidia.com> <20240106083617.1173871-1-mshavit@google.com>
 <20240106083617.1173871-3-mshavit@google.com> <20240112163651.GA815670@nvidia.com>
In-Reply-To: <20240112163651.GA815670@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 16 Jan 2024 17:23:02 +0800
Message-ID: <CAKHBV26mYYZ78MgRvsCk5S3iRu2Bdgn2XwJ0uyj9vE6cpiq3DQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, 
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, will@kernel.org, 
	nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 12:36=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Sat, Jan 06, 2024 at 04:36:16PM +0800, Michael Shavit wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers=
/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > new file mode 100644
> > index 0000000000000..59ffcafb575fb
> > --- /dev/null
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > @@ -0,0 +1,329 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <kunit/test.h>
>
> I added
>
> * Copyright 2024 Google LLC.
>
> Here, let me know if it should be something else

Thanks!

>
> > +     arm_smmu_get_ste_used(ops, ste->data, used_bits.data);
> > +     pr_debug("STE used bits: ");
> > +     print_hex_dump_debug(
> > +             "    ", DUMP_PREFIX_NONE, 16, 8, used_bits.data,
> > +             ARRAY_SIZE(used_bits.data) * sizeof(*used_bits.data), fal=
se);
>
> I fixed up alot of these weird sizeof things all over the three patches
>
> sizeof(struct arm_smmu_ste) is the correct way to get the size of the
> HW structure, no need to peek into data. This is because we use the
> struct as the pointer to an array so the whole struct must be
> correctly sized.
>
> ARRAY_SIZE(x.data)*(sizeof(*x.data)) =3D=3D sizeof(x)
>
> Sadly there is no ARRAY_SIZE_FIELD()

Makes sense.


>
> I also made some hacky patches so smmuv3 would compile on x86 and ran
> this kunit on x86 - looks fine to me
>
> I'm going to put it in part 3, just because it is new and doesn't have
> any RB/TB tags like the rest of part 1.
>
> Thanks,
> Jason
