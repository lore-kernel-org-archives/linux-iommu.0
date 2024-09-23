Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A927464
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727064436; cv=none; b=Or2ZhSPLbnmt9X7bw2vjuxtxZJPejr0Mo5VWclBJhzOStNZzG+5o6GPbMk5F6l0ogclBQwW8l+LZkrMwMn2cAizj89+3UBowbnF+P6jLFKEXrCmm2i0oe/pBlMPviUNmcRabiCUbSNC8zpFi31+aX/kSV7GjQzfayaNH1oKky6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727064436; c=relaxed/simple;
	bh=Av2HP2d4DuN93WBim/lcOKrhpB1D2CCO93sIb+MJz28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxd5CqPN3J6BeeJca/bGwC4NUF+Wc/9WWnVgghydpyu6S+kENJxQ68n63b+QCLwfC38bFKVuxHv+385Col3hKMYw8CejcrZXARb2H0YJreJFCCb0CvjzIUELLHzoJKqVNcA4QgSWXaSwlnIgUXXsjGJUE8d+Y4Tji8SdTMA4F9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+SwY+iB; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+SwY+iB"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-502c8f50c5dso988839e0c.0
        for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 21:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727064433; x=1727669233; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fk1em3RkwauI4SHHUi/ClfolM0H5W//ioGctZ2qyuY=;
        b=Z+SwY+iBkEg29e5eYI8JHMMrSkaxJQ455+WZx65+5fczQT9zjfUGPOLHqZ8HvObKIh
         t7kWJ2pUHD+jkZZItQAbWgA7a+VEMETq+o3/ibaTHM+N9kGgSm28tHTCnYDBSGTQLgXF
         Jg40hPoGAeo1uG8dRKAYB6Q+jAQYL94nQ9n6NK7RkXhTJUbnAkKMg9Qo9TigAsTKMp6v
         IDyvobc0XIUTjD7lVOQk04thF7DNRWD4g6nB2mLvoxOyYfvO2kDyCcRrWSBKZNzKTP1/
         7qH4VsxcXMjTvfASUvKZ2t1zDrhbsNy2bfr6sVCuJInR6KruyvUJzm9xso/OrB4yn9Y7
         ZmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727064433; x=1727669233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Fk1em3RkwauI4SHHUi/ClfolM0H5W//ioGctZ2qyuY=;
        b=BNBxCNuEN8Q2HMdCNBvHxKSPiLEUEynQKV8T2H4DGtZoFDOb6cU+vnueU9z7oOtOBc
         hCdRZ+diFTGzV/mRiWnw+3sivT6hkDn127qqdJBNgxfEfZz/P/N1muuu9/cskDdfGJo8
         j80B+DeW8OJuXGipWdXUl0DZj6UaNkh5LMy8oTJiP6G3HsQP6yf00iAEP+KLOV9TqYak
         IEUO1/Fn60yt79XZAq8NhYzBtLdMLpBqciLwYw2XoPqatu2RXA+vEMwt/2Xj+NiqnizR
         s52FcI1XrBpeQ6UcuM1iHPt0dHE97/0Hw/w8iP7SRD6j+yCaPjCNBFlIr1UIWxEJPNKI
         iyzw==
X-Forwarded-Encrypted: i=1; AJvYcCUJpyT+ZFKV0bDq3xXv06kh6ANgT9vMZSDG3gPnk189LFXUb4tIOLpMjjeOU6rXoVNJaKoFWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3udNIxGtPC4LAq6cBJCMwpWlyrTbbgFh4bK06YmMkRU4XEjZB
	pam5eRuzmlHHdJKBQYBqhhVPvdSzsUOzfmuZ5m138VUx4kAHLeH9EJNYArM0YeXLvRuafqRQc87
	kowWdpoNzuAuPFLq4m30rqy7n72o=
X-Google-Smtp-Source: AGHT+IEM5gItLQ6kZT+yJF478APHV3QMsyQ1g9Rz3IpI/U7uM7hSN+HlUs49wUj4AnjuLNSZ6kuSJG6kiXzwtDHBiZw=
X-Received: by 2002:a05:6122:d8e:b0:4fc:edb4:3386 with SMTP id
 71dfb90a1353d-503e40d23b3mr5333144e0c.6.1727064433277; Sun, 22 Sep 2024
 21:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240922155621.49432-1-kdipendra88@gmail.com> <ZvDcEFXhpMo3K-Zd@google.com>
In-Reply-To: <ZvDcEFXhpMo3K-Zd@google.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 09:52:02 +0545
Message-ID: <CAEKBCKMqe1_ijAygn4n-oy8=WoaN-CoDBK_wgDJNEMTgJPG7gw@mail.gmail.com>
Subject: Re: [PATCH] Staging: iommu: Replace null pointer check with IS_ERR in arm_smmu_domain_alloc_user()
To: Pranjal Shrivastava <praan@google.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pranjal,

On Mon, 23 Sept 2024 at 08:55, Pranjal Shrivastava <praan@google.com> wrote:
>
> On Sun, Sep 22, 2024 at 03:56:20PM +0000, Dipendra Khadka wrote:
> > The smatch reported following:
> > '''
> > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3065 arm_smmu_domain_alloc_user() warn: 'smmu_domain' is an error pointer or valid
> > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3068 arm_smmu_domain_alloc_user() error: 'smmu_domain' dereferencing possible ERR_PTR()
> > '''
> >
> > The function arm_smmu_domain_alloc() handles the null pointer after
> > kzalloc and returns ERR_PTR(-ENOMEM).
> >
> > Replacing condition check !smmu_domain with IS_ERR(smmu_domain) and
> > returning smmu_domain.
>
> Hi Dipendra,
>
> Thanks for looking into the code. However, I think this was fixed last
> month by Dan's patch [1] and has been merged in the master branch.
> Please pull the latest. :)
>
> [1]
>  https://lore.kernel.org/linux-arm-kernel/172381875518.1794999.1134549433569030700.b4-ty@kernel.org/T/
>

I just checked on the staging-next. I will make sure to check on this
tree as well.

> >
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a31460f9f3d4..19c53c6f7578 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
> >               return ERR_PTR(-EOPNOTSUPP);
> >
> >       smmu_domain = arm_smmu_domain_alloc();
> > -     if (!smmu_domain)
> > -             return ERR_PTR(-ENOMEM);
> > +     if (IS_ERR(smmu_domain))
> > +             return smmu_domain;
>
> Quick note, using something like `ERR_CAST` is better in such cases.
>

Thanks a lot for the knowledge.

> >
> >       smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
> >       smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> > --
> > 2.43.0
> >
> >
>
> Thanks,
> Pranjal

Thanks,
Dipendra Khadka
