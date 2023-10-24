Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBA15E92
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1JKnH8k"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-41cb7720579so167281cf.1
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698134983; x=1698739783; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z0eL9ukZmzz7IBl08620WP55SDEJScJRx3X9+4VHPQ=;
        b=g1JKnH8k6nMbcUIY3Q1GrV8hldzbI1tgg1tYHVsQd4VnMpJMipj1HwdRlDlBdmAj0B
         imKVga2mnE/N0MtgN1AbulgepiUAxl4e79mFWJcyjD/pciBKNgCXb/VnHvHhcNG8e1Rj
         4bMK3R0gMtzCavvXiS2vnpqJjEzGvtSfAQCnSaVKCI0Km0WyANz25x+T8hZTjByTuEiC
         s34rUxzU6N/r7feRrA/mM3i//ToAHEyA/dYvdY0yD7sp6+766/oxdnxn2N+90Jxm5oG3
         rnPKGYnidafbJCdtOE7SSdPb7F0nhyPWZdtlMPTFr4cJGuVHY/Cjo5yw2qGQJfrDeYk9
         SWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134983; x=1698739783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z0eL9ukZmzz7IBl08620WP55SDEJScJRx3X9+4VHPQ=;
        b=cf1Y/4SeEE41mNlN0TvuRXSI+BX5uoX4Lq5OMnJZAZrn3jrcRpz2HvvmpR6+bRAorS
         fo8vI7XttWxo+nB7HtbZ3x2VX9bIh/HffsNgfNnxumZ7jyPBw90uvGgz6IWSNTek1lND
         mej/4RmHCh9WzsgiH6GPgprHGLO0BPU1MutxopujlpA2yNhebdg5j5eRkH5yzCWrRaai
         OVY5D6g7k09mhaHXVf1HqYtciHNoumbgaVFAsGSsNroTYx1H48DPHHwxeuN+HpA78fZK
         y6IMm5yrPmBt0BUMJMjW48yE+zMreLnCHeAxQt7mgynEvEOD5zqgy79xBfnKXQ8qJxHT
         MewA==
X-Gm-Message-State: AOJu0Yz6wrhzCtcAQgsT9O5ZnizCns5tCx5TTmM3vyHFmMDe4McZ8RC8
	tzSpi5PJ3cE2Ajm2TvMtE3Kc8aezpxI+i9rcPw15/xRP8GUSwuvKHbp7pax2
X-Google-Smtp-Source: AGHT+IGn9x5xFX3u/1sjR/4Rn7F/cjyemkZzzAL1u4NgXX9jGQWAd+CgM4YH4uUPVvFoqlkgVz+kU1zJ/0uzlI6yudk=
X-Received: by 2002:ac8:620f:0:b0:41e:2948:f396 with SMTP id
 ks15-20020ac8620f000000b0041e2948f396mr136423qtb.10.1698134983017; Tue, 24
 Oct 2023 01:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com> <14-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <14-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 24 Oct 2023 16:09:06 +0800
Message-ID: <CAKHBV248yjmRUi+MyJXuDY8V1OKa0WF-eP7GYfthpGE5CFsMCQ@mail.gmail.com>
Subject: Re: [PATCH 14/27] iommu/arm-smmu-v3: Make changing domains be hitless
 for ATS
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 7:26=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
[...]
> +struct attach_state {
> +       bool existing_master_domain : 1;
> +       bool want_ats : 1;
> +};
> +
> +/*
> + * Prepare to attach a domain to a master. This always goes in the direc=
tion of
> + * enabling the ATS.
> + */
> +static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
> +                                  struct arm_smmu_domain *smmu_domain,
> +                                  struct attach_state *state)
> +{
> +       struct arm_smmu_master_domain *cur_master_domain;
> +       struct arm_smmu_master_domain *master_domain;
> +       unsigned long flags;
> +
> +       /*
> +        * arm_smmu_share_asid() must not see two domains pointing to the=
 same
> +        * arm_smmu_master_domain contents otherwise it could randomly wr=
ite one
> +        * or the other to the CD.
> +        */
> +       lockdep_assert_held(&arm_smmu_asid_lock);
> +
> +       master_domain =3D kzalloc(sizeof(*master_domain), GFP_KERNEL);
> +       if (!master_domain)
> +               return -ENOMEM;
> +       master_domain->master =3D master;
> +
> +       state->want_ats =3D arm_smmu_ats_supported(master);
> +
> +       /*
> +        * During prepare we want the current smmu_domain and new smmu_do=
main to
> +        * be in the devices list before we change any HW. This ensures t=
hat
> +        * both domains will send ATS invalidations to the master until w=
e are
> +        * done.
> +        *
> +        * It is tempting to make this list only track masters that are u=
sing
> +        * ATS, but arm_smmu_share_asid() also uses this to change the AS=
ID of a
> +        * domain, unrelated to ATS.
> +        */
> +       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +       cur_master_domain =3D arm_smmu_find_master_domain(smmu_domain, ma=
ster);
> +       if (cur_master_domain) {
> +               kfree(master_domain);
> +               state->existing_master_domain =3D true;

I'm confused, why would we expect to find that the domain is already
attached to the master??? If the iommu core really allows such
attach() calls, can we check for that earlier and simply return early
from attach_dev()?
