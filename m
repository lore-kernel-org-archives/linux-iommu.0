Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A71B2ED9
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028338; cv=none; b=pojh4TmfDXYgaKf84TpsOUIwyk9/wnRF9f1RuUi0J21cP8X1t2YON0h8WqQTKP94aS17WotzE2iBQye6qnnAX08BMvljsyWzPFGDKt3Qxek9Jq5KHuci0eWfA7v4IAUMAkntxVBMOP42EZd8/uKnGp+N7nAtiyfH1wdVsu3PLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028338; c=relaxed/simple;
	bh=gn1r6Kl82bYEcmmeYzFY7WR8tPd7NOokxC5RStEMEBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbNruWyaX2OpqLkIlMmCq4zEycpISpmEclulUrwc1jrjFe7gU2cYY2LRsTNfKXnVwS22sklDRI29KGThgxGTK9kk5PSdJL+QasTJgeAQ4tc9w3BjPF9Xae0lz0irc4JH2gOvTf8YeUxCchtsZTpA0lEkyTSuYogqh4t9muKtbNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXva8yKF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXva8yKF"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45680233930so10738681cf.3
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725028336; x=1725633136; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV9KRMlNGyvcppnTBVsTcozYBeJqYoCFTmaDKQHvbac=;
        b=GXva8yKFcDX3Wh40z6DrWj6e0o6KQ0SlckcM5E35I3wvods1sO7at/fFooh9E1pSYd
         F0G3nAPMVO7Knbfdt4Auy0hjFx4hdjb8sVt9VxEgU4I3H8fNxlNlaLnUnO4OkyFBS/vQ
         qxdn49wVOg5cLkuUJceXe5CSevSmo5AuY0xoFouQGlxBo5II2/u/8lEsZmEzv/AcJeRE
         tZuIM6d4yzMwal/gAiuDijzlwd3NdZevDOCvFc49VEz+/cOBeoTs3nMCYuf+3ycGdCHr
         pt8cCZezo+0+R6ezirYkoZ2v7S41ep/nawwh+TNm9oUpd+XP0Hf3HHVhQRinFDrjBYfK
         uwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725028336; x=1725633136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HV9KRMlNGyvcppnTBVsTcozYBeJqYoCFTmaDKQHvbac=;
        b=ZkIs6iV+y/qDXMOYi4fLK4t39B65JJVJQygKcKsCe/C35xov2Xdvy+gfGO2XGSxwDo
         tENN32WPBhayfEq+LmRYPfI/8NgXKdZCmFlx+zQlKU4zBJ2u4XiHbKlZpOTcw88Iy0Iu
         Buq8Vyasc0rNbMwpwg/UqufydOMgKMaWZ83nPtNVrk62/xTcGhoP4eNyC7tNaF37NZ8+
         RokAt7xwRF0VvzzR5Y3BaEQ1uF1E1DzcunSpArfBEesVO/ZYU/+dMAe8T0/Fvbjjm5Rs
         M1f/jcAVKoEgQq1lwIMv8JzsIM5UD/877zRncAH/XmyAZd8w9g3w51OpNGnCAV3xLbpc
         fyuw==
X-Gm-Message-State: AOJu0YwfbJ/0rIZ7fdg9EnblERzgKRgA26nW0IBGyhPo1H04q4SADnbU
	aJkxVXuhZnHOBSltd6buqUN1AwjUpHOxCCwJaKk0g/BeuYUU7kaXCIGBhUGpH80qUVUz3E4YrQ1
	hRl6EDAA+xD7zP7xtkunqKuGU8Dk=
X-Google-Smtp-Source: AGHT+IEhen+eT2CxbDrVJBf7xHsy41tp3FjD+CISR2JujX0jEK8QsaJcEM0g3oP6DwVm3H8SM9tmPZCR+bAeV3+9Exc=
X-Received: by 2002:a05:622a:114e:b0:456:45d8:2f08 with SMTP id
 d75a77b69052e-4567f6d3c9bmr72722331cf.46.1725028335922; Fri, 30 Aug 2024
 07:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827181717.187245-1-robdclark@gmail.com> <20240827181717.187245-4-robdclark@gmail.com>
 <20240830132009.GB8615@willie-the-truck>
In-Reply-To: <20240830132009.GB8615@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 30 Aug 2024 07:32:02 -0700
Message-ID: <CAF6AEGuLFsGtE1LQNge_WRxdYwYnHAgkbcL5Xh4HUxx2XuzNLQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>, 
	Steven Price <steven.price@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 6:20=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Aug 27, 2024 at 11:17:11AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add an io-pgtable method to walk the pgtable returning the raw PTEs tha=
t
> > would be traversed for a given iova access.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
> >  include/linux/io-pgtable.h     | 15 +++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index efed8e519111..11af49119f37 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -759,6 +759,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io=
_pgtable_ops *ops,
> >       return iopte_to_paddr(d.pte, data) | iova;
> >  }
> >
> > +static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, =
int lvl,
> > +                           arm_lpae_iopte *ptep, size_t size)
> > +{
> > +     struct arm_lpae_io_pgtable_walk_data *data =3D walk_data->data;
> > +     data->ptes[data->level++] =3D *ptep;
> > +     return 0;
> > +}
>
> I'm struggling to see how this works given that the ->visit() callback
> is only called for leaf entries in the page-table. What am I missing?

Yeah, we should just go back to my v6 before I tried to re-use the
arm_lpae_read_and_clear_dirty() walker.. addressing review comments is
just making it worse since then

BR,
-R
