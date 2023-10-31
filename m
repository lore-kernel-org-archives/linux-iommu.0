Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A210A28
	for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VvcGfdS8"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so4783644276.0
        for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698738883; x=1699343683; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imGUTfdIv1UEQvIw5qZ3sOkWlbHODvlpW7n7ZTnXfW4=;
        b=VvcGfdS8Mp/Imqsa4g7butxwepjx81yod4xANXc0kIa7mmnGUoKRRfxddEs0Jf6XF/
         mRoXkWQ7JTPVDOeFhslTABsoPQKxsvBo9kHSiidB3oxFaD5s4Kp2THXALKcGy3akQ0UR
         Hq+nxjtSsFxQSoO6Ar8di7OeR5D4Kq/Wk6rY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698738883; x=1699343683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imGUTfdIv1UEQvIw5qZ3sOkWlbHODvlpW7n7ZTnXfW4=;
        b=tOqzFPXNSxcTNi6m3etQUlkc8B4FPvD8NoHB20E4prob53O2pHtSHZiTgKZiDxqiVw
         V4GuvAzsEA0L3Pd92UhF3tEQ8zuqMNSYglTqkKyZ70e8ETq7O/PBxqJkkn7r7cG1oFPx
         k4WCQg39KJ9muO+0ZHGQM6k0l3x3WMwYp7mDsSgwf29U7xzMRiVSYfA++yBWZAMhsWiY
         ca5WYX5LVQp9/KSqZtP10lr5PBzOf/T+b6ShuVcx0RhRNHUbgEdWqRx8gwzqlJdRxaln
         vh3FSPSOgqM1gAth+FCiJnTZMbaVh3fq1prZnPqb+R0uS8cWk0UQEylvroWTc3rbeZvt
         gq/Q==
X-Gm-Message-State: AOJu0YwSwiY7rGXXDzr2WqU6PLeZWSIN8/7pnO5FBkpoPahvzvGQkVit
	1MdWT1yIUEvTLOtMLFWhFvQZQ2QGPRH6IpyHO38hUg==
X-Google-Smtp-Source: AGHT+IGuq0HOWs5OUTkDduu4V89OJcaIxGppI4qyD54zITZougK0zbZNP1p83UdXtqz7X/Iv55M353/8oTA/1gDd+B8=
X-Received: by 2002:a25:aa27:0:b0:da0:3c22:8374 with SMTP id
 s36-20020a25aa27000000b00da03c228374mr12109008ybi.5.1698738883370; Tue, 31
 Oct 2023 00:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231025110140.2034650-1-dario.binacchi@amarulasolutions.com>
 <1acd75d0-67a7-4a17-99c7-707cca305f37@linux.intel.com> <ZT_MKDVkqMECiv4I@orome.fritz.box>
In-Reply-To: <ZT_MKDVkqMECiv4I@orome.fritz.box>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 31 Oct 2023 08:54:31 +0100
Message-ID: <CABGWkvrG8OWKpkY3g46XEje196zSXZ5rfekMRRDWMtp-uMrw-g@mail.gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: fix error checking for debugfs_create_dir()
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krishna Reddy <vdumpa@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Oct 30, 2023 at 4:30=E2=80=AFPM Thierry Reding <thierry.reding@gmai=
l.com> wrote:
>
> On Wed, Oct 25, 2023 at 07:25:50PM +0800, Baolu Lu wrote:
> > On 2023/10/25 19:01, Dario Binacchi wrote:
> > > The return value of debugfs_create_dir() should be checked using the
> > > IS_ERR() function.
> > >
> > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > > ---
> > >
> > >   drivers/iommu/tegra-smmu.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > > index e445f80d0226..cd1d80c4c673 100644
> > > --- a/drivers/iommu/tegra-smmu.c
> > > +++ b/drivers/iommu/tegra-smmu.c
> > > @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
> > >   static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
> > >   {
> > >     smmu->debugfs =3D debugfs_create_dir("smmu", NULL);
> > > -   if (!smmu->debugfs)
> > > +   if (IS_ERR(smmu->debugfs))
> > >             return;
> >
> > This check can be removed, as debugfs_create_file() can handle the case
> > where @parent is an error pointer.
>
> A patch for this has been in linux-next for a few weeks, see:
>
> commit f7da9c081517daba70f9f9342e09d7a6322ba323
> Author: Jinjie Ruan <ruanjinjie@huawei.com>
> Date:   Fri Sep 1 15:30:56 2023 +0800
>
>     iommu/tegra-smmu: Drop unnecessary error check for for debugfs_create=
_dir()
>
>     The debugfs_create_dir() function returns error pointers.
>     It never returns NULL.
>
>     As Baolu suggested, this patch removes the error checking for
>     debugfs_create_dir in tegra-smmu.c. This is because the DebugFS kerne=
l API
>     is developed in a way that the caller can safely ignore the errors th=
at
>     occur during the creation of DebugFS nodes. The debugfs APIs have
>     a IS_ERR() judge in start_creating() which can handle it gracefully. =
So
>     these checks are unnecessary.
>
>     Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
>     Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>     Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
>     Acked-by: Thierry Reding <treding@nvidia.com>
>     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>     Link: https://lore.kernel.org/r/20230901073056.1364755-1-ruanjinjie@h=
uawei.com
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
>

Thanks for the explanation,
regards
Dario

> Thierry



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
