Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416D4E1CC
	for <iommu@lists.linux.dev>; Sat,  3 Feb 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706947388; cv=none; b=EBAqu8c/+5MT9zL9Wupw9upfAuxMx8Vjv8vvlXX86wNs8HVZkaYKyIlqi62vgWL7Fww2zefqVL35IjMNJotlpk2hORRPjcs//s4FiAcfwCkyz55xquwRx3u63+8h8XCXQMXb3JPamSv/uRifIIyQYCfMfahtokInRstei7wYb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706947388; c=relaxed/simple;
	bh=gMNtRuHZqlVs+gCeHOZVKhPIIpO1M/J3dQ6bl+NLLDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuaPcV2sY9JMK4eUExxs2bA18N9/J88ipReQofSVWf6pcgrfXZ2eg3O7u1Qiq05pV5on98100IRMSwDv29lpEYfAPj3vvjtIZOzj9sa8fMxW9HFUt5uS6DIvuGKxZCo54855M4F74HAzoVJ7vx0vqYPz1kEqFTx1j7iaX6hG9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zbkcuNM5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zbkcuNM5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-428405a0205so119921cf.1
        for <iommu@lists.linux.dev>; Sat, 03 Feb 2024 00:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706947386; x=1707552186; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/dKz562DcsjiONFxvINgo9+ddlFuG5fjQGhpUN1sHw=;
        b=zbkcuNM5vfMwsV0d4cCuTne4dAq1HToCTL/Z2qP/9CKbPN9md1xob+aRhy8FkSiSfJ
         zpE65yxFM1uIIS6WUpxEbhL6W01jrldh9+ybMxD0cH+kiRCl7Q3/mOENxy6vaE39O625
         R4yN3Liaev3p385Z5Yuhh3NINPBXOrAyRJl8fZCHgbQUPcNpJDkFigQqMeC4GqDDIxYG
         4scgvfRqEpFCzzQ4FZi4sVH7jZMMk5lVjkgk3mDW3NIB/AA2i4qmPFJ0XPqJbfzE3X0C
         b77aXj27AD3M6d7fXC1+sHJLYlTcG8mLhOfv0dhK3NoWkJjTxdlloh+w7kDcOux+tjNw
         VROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706947386; x=1707552186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/dKz562DcsjiONFxvINgo9+ddlFuG5fjQGhpUN1sHw=;
        b=LzpLZxyPoo/1IcoE+IwUpvwiyHA3GvMG/VsZgJDh9jmyl+lVhXyRTBUuMXTtmtb0Cy
         4q6tceXv8IyO4cISbc+HVBIvV1wJvRNfXfNC+U4NvMUIybpghjeglU147K4j7wUpfBL1
         zi7TKeJX/TNtEwQVktUUfOAKCotxIUaJcoo7OcwY/xZX3HC30tmGL6zxHJtWkF0OAUPk
         yq3uHT/2cGOxorRcWkvrAo3fa2frLUnxen+HH6vYfe1scOUiqFt8MbSt+kYrYe6dcG3R
         ZwVXzYue5EThH9rd+yJFLTTGFYuTbbxwocAtSm508GxijLB99utnom2FwZFVlIZhnCAm
         PSOQ==
X-Gm-Message-State: AOJu0YzhQKEdbkbPH0OP9ab1IaI9LEZYf0TrI3DYpkUcaPmWgPlyk4l1
	c+hLXSPJ0f8xveJomJFZGkHUO8X38jq2i8HExKA8l9dMrU2F3CrwfeNQyY1FemChnI1d0041Ev0
	+iNXA7hsUKLZyXOmsTFXrNGwMHSMlITzsrvrc
X-Google-Smtp-Source: AGHT+IFVxbTLizVpQyjE3c1v4sTHH5c7GSmRCOFZoBqNZS5svcZLQO5eo3wRmOmqUdiaeIL6uWdD31Y1YV0EScyGAzI=
X-Received: by 2002:ac8:5c56:0:b0:42b:f0dc:2048 with SMTP id
 j22-20020ac85c56000000b0042bf0dc2048mr125390qtj.18.1706947385486; Sat, 03 Feb
 2024 00:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-210234560de7+69a-smmu_cd_atomic_jgg@nvidia.com>
In-Reply-To: <0-v1-210234560de7+69a-smmu_cd_atomic_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Sat, 3 Feb 2024 17:02:29 +0900
Message-ID: <CAKHBV24xmJqH0NFv3M2pDwbY3fRK1tJxP2=50VHXsPma-PLNHA@mail.gmail.com>
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> If the SMMU is configured to use a two level CD table then
> arm_smmu_write_ctx_desc() allocates a CD table leaf internally using
> GFP_KERNEL. Due to recent changes this is being done under a spinlock to
> iterate over the device list - thus it will trigger a sleeping while
> atomic warning:
>
>   arm_smmu_sva_set_dev_pasid()
>     mutex_lock(&sva_lock);
>     __arm_smmu_sva_bind()
>      arm_smmu_mmu_notifier_get()
>       spin_lock_irqsave()
>       arm_smmu_write_ctx_desc()
>         arm_smmu_get_cd_ptr()
>          arm_smmu_alloc_cd_leaf_table()
>           dmam_alloc_coherent(GFP_KERNEL)
>
> This is a 64K high order allocation and really should not be done
> atomically.
>
> The proper answer is to sequence CD programming in a way that does not
> require the device list or a spinlock. Part two of my lager series does
> this and already solves this bug.
>
> In the mean time we can solve the functional issue by preallocating the C=
D
> entry outside any locking. CD leafs are effectively never freed so this
> guarantees the arm_smmu_write_ctx_desc() inside the lock will not take th=
e
> allocation path.
>
> Fixes: 24503148c545 ("iommu/arm-smmu-v3: Refactor write_ctx_desc")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/4e25d161-0cf8-4050-9aa3-dfa21cd63e56@=
moroto.mountain/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 05722121f00e70..068d60732e6481 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -588,6 +588,11 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_d=
omain *domain,
>  {
>         int ret =3D 0;
>         struct mm_struct *mm =3D domain->mm;
> +       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +
> +       /* Preallocate the required leafs outside locks */
> +       if (!arm_smmu_get_cd_ptr(master, id))
> +               return -ENOMEM;
>
>         mutex_lock(&sva_lock);
>         ret =3D __arm_smmu_sva_bind(dev, mm);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 0ffb1cf17e0b2e..ec2bb8685bb50e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1019,7 +1019,7 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
>         WRITE_ONCE(*dst, cpu_to_le64(val));
>  }
>
> -static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 s=
sid)
> +__le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
>  {
>         __le64 *l1ptr;
>         unsigned int idx;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 65fb388d51734d..fa0eeb3519ef28 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -748,6 +748,8 @@ extern struct xarray arm_smmu_asid_xa;
>  extern struct mutex arm_smmu_asid_lock;
>  extern struct arm_smmu_ctx_desc quiet_cd;
>
> +__le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid);
> +
>  int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssi=
d,
>                             struct arm_smmu_ctx_desc *cd);
>  void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
>
> base-commit: c76c50cd425e574df5a071cd7e1805d0764aabff
> --
> 2.43.0
>

Reviewed-by: Michael Shavit <mshavit@google.com>
