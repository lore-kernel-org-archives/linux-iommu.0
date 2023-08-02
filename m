Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144D63AA
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 11:19:49 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-40c72caec5cso196591cf.0
        for <iommu@lists.linux.dev>; Wed, 02 Aug 2023 04:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690975188; x=1691579988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wq8cn2J6sVYRERovJLmedigLkU1hrLj8goBJfFuNds=;
        b=kOrKMge0UoNaRBw0wrdtyfN0q3TJ7HPqJutvDcwc46Gv+XF5TpZpoXcnvFCjJxfscJ
         VOsC3FlmCH9tyKdBBq3osNmeW4/3B2zoAhzNtN3BEL64qq4/6jtMS9Be1jGywd8w5NoY
         +/B6EaWWy5/yo6losZFJsX4goGF41WslK1jcQeFKTrsE8ACj0I28azDJqdMnq2hbj4Hs
         uoD9PFrFYaweFOjuhh4z32GOzFYo6SmU4oWyAH1SjVoSNG4QwzdYgL9L4yhCpno6MYv0
         LyYmS9+Kq+fnYglWOTSIXVoeqPAXDVCae+FRprPd94iMec/HvQtJ/EGd4Pv/4Yc2ddLj
         EYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690975188; x=1691579988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wq8cn2J6sVYRERovJLmedigLkU1hrLj8goBJfFuNds=;
        b=iD8F7S+OwIYks61IJ/2W+Jb6pwjrukk+DH6N7/TDzwoZN6pl8OCyK7MBFNMRozuMbI
         F2I3LNVbL90MO5ByVdvQAcIxH8ZyMO/URnSkbyg7qxhIiXhXxbeON40yQLpyE679IBUV
         dkTpj7xNA6bkfwCLn2aMKenm3KoaQbmvgwjhIGBRNFyMfnIy08VCr9nR8iR5cPvJVV1f
         2UY17cxODn+NYrCUBQMeU11lYFscKE9Q1jc7qW660liH4ch1Txgfm2OpPbIhaMk5/8K0
         ZQCSFZN2kUcqruTYMzXeqrtgR1m6lw6g5Rjvt+UK8w9KDVuvkXo5fZjRw0ztM2HqjXO1
         BU3Q==
X-Gm-Message-State: ABy/qLbX4OJbpI4Vas4SNH7nwWn18zeY8U0aLta1e1ZYPiauVe9aGX7l
	NcZvRmj77tP6JslA9VLqbChFGSObsoH0qt3VI/E95w==
X-Google-Smtp-Source: APBJJlG0I3Dhg+TBORKYrBn9z8NMpsRfeSBGXC1mEccDfQVVS1/uUKsIB++bl54caZq72N8AvPt4aT2zHVUtP/TVO4I=
X-Received: by 2002:a05:622a:130e:b0:3fa:3c8f:3435 with SMTP id
 v14-20020a05622a130e00b003fa3c8f3435mr999983qtk.27.1690975188231; Wed, 02 Aug
 2023 04:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com> <20230802023524.v3.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <ZMma/qk0otN9eyW3@nvidia.com>
In-Reply-To: <ZMma/qk0otN9eyW3@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 2 Aug 2023 19:19:12 +0800
Message-ID: <CAKHBV24e4YAB8J7MP=vuVarn5cVSWrB-NsjO-obH5CZECk0xNg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, 
	jean-philippe@linaro.org, nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 2, 2023 at 7:53=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Wed, Aug 02, 2023 at 02:35:23AM +0800, Michael Shavit wrote:
> > @@ -2465,6 +2440,22 @@ static int arm_smmu_attach_dev(struct iommu_doma=
in *domain, struct device *dev)
> >       if (smmu_domain->stage !=3D ARM_SMMU_DOMAIN_BYPASS)
> >               master->ats_enabled =3D arm_smmu_ats_supported(master);
> >
> > +     if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {
> > +             if (!master->cd_table.cdtab) {
> > +                     ret =3D arm_smmu_alloc_cd_tables(master);
> > +                     if (ret) {
>
> Again, I didn't look very closely at your locking, but what lock is
> being held to protect the read of master->cd_table.cdtab ?

The cd_table is only written into (with write_ctx_desc) when something
attaches or detaches (SVA is a little weird, but it handles locking
internally, and blocks all non-sva attach/detach calls while enabled).
The cd_table itself is allocated on first attach, and freed on release.

Doesn't the iommu framework guarantee that attach_dev (and
release_device) won't have concurrent calls for a given master through
the group lock? I can add an internal lock if relying on the iommu
lock is not OK.

> > +                             master->domain =3D NULL;
> > +                             goto out_unlock;
>
> This is only the domain lock:
>         mutex_unlock(&smmu_domain->init_mutex);
>
> Which is no longer sufficient.

Hmmm yeah that lock looks misleading here. Let me move the unlock
further up so that it more clearly surrounds the section it protects.
