Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20515BD
	for <iommu@lists.linux.dev>; Sun, 30 Jul 2023 11:25:06 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4036bd4fff1so293111cf.0
        for <iommu@lists.linux.dev>; Sun, 30 Jul 2023 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690716305; x=1691321105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5Nr6dlI8F3llvlegcjiyeAhHSBiDt0NzvpUEp9xHLA=;
        b=XXyrIdn+Bpd4H5IkEuuJhXO849uxRMOnvX6C0Iaz9kJxqLm46WIBdYyoRNcALHM2Bn
         9LNyUHteq6SYwZ/7/4iZgD1ifBCkCJyXYoeHU25cY7UDdfa21cWUpIzNyO6z5Fag2MBm
         c6wzPcPDnaJPA99+Y6q1UdR7vjr1AOTIP+NUlczb1blEx6ulvRqWZFA2tvHpdW8ZmYSI
         GpA3OHehm3xboj3LmBmYTmsTgESdfeb1ha7gtr2NAg3RpITD3SeAssFrywN2+iovrBtL
         kLKT8hNEN677Nyk8Z9C/9mummztFzKuKc8HXMDnOBrgetG/i62OBKguwRTUZ94ZgXw7k
         GMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690716305; x=1691321105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5Nr6dlI8F3llvlegcjiyeAhHSBiDt0NzvpUEp9xHLA=;
        b=gAyYyS0oaufmOEKoerYSOaQzDM2H/P4/RroqX/At4LC2WKqthFjmVXXVtp9A5ZsKcN
         juuBAFaAkBFG+1HUQXBPJhkRfdtTCVVhc6HwNfupsDlFL6Cl1nv3yRI/6clElb12rNZt
         +mITtRmajSNCR18KXrPhJ5kSUaKd5rBrZWzb47DHtn7tA6rD+Yt8BkB8dmtPGHqBM+r/
         3192mcZCBMChxm79LaLknfKk80IEY/a8N8RBVSwMh9zDGLO/6r3oTN06s1/sZRryHfgF
         xZPzhOwl2WhnaROvXXWcd/q0+WXeZHBwSGkNL2VDrhyGHplnNPt5CSt5GwDFGgSdprWe
         QdCA==
X-Gm-Message-State: ABy/qLbdoNkq3vEEgT3XkXI6cu2TmPwc9dWr69EmQl4RQf0qkapdpGsF
	1+fP31oPCqmn+sQOOJUorRZY2xBnWqyeXBwyjHDKGA==
X-Google-Smtp-Source: APBJJlHwemhYYDY5qu+ZyE+91u/RXTQOw4aWyxcEaN9DeyLP5fRBy1ICRGNWyDhoEaXLxgqmoiLHYCh4ZemQwLyKDeQ=
X-Received: by 2002:ac8:5b45:0:b0:3fa:45ab:22a5 with SMTP id
 n5-20020ac85b45000000b003fa45ab22a5mr279468qtw.27.1690716304854; Sun, 30 Jul
 2023 04:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia> <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
 <ZMOzHJO23ZakRs8b@nvidia.com> <ZMQL1qjHT3NE9FR2@Asurada-Nvidia> <ZMQO0iLDkgaDe7ZT@nvidia.com>
In-Reply-To: <ZMQO0iLDkgaDe7ZT@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Sun, 30 Jul 2023 19:24:28 +0800
Message-ID: <CAKHBV26d16Y2zWiSe2FuMgqGQW3vz9hk9vb=G=h373YN8X9Zgw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with ctx_desc_cfg
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2023 at 2:54=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> > Still, it would be odd to have "cdcfg" and "cd_table" at the same
> > time. If we have to be conservative, perhaps we should just align
> > with the old naming: "struct arm_smmu_ctx_desc_cfg *cdcfg;"...
>
> Yeah, I think changing to cd_table in the places touched makes alot of
> sense

A bit confused by the "Yeah" reply given the quote... Are we ok
keeping the v1 version of this patch w.r.t. to cd_table/cdcfg and
struct naming?
