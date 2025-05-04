Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B10187332
	for <iommu@lists.linux.dev>; Sun,  4 May 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746390560; cv=none; b=dcHdZy+ulfXVKkg0j+tRlYeTVhZJawLD+CqQX47VMzpL+J4wWZzdOJvAP3u+FajGTqq2vowjKjksQjaE561xovl20iZJ55Gr9v8aotl6KFqg1UpE660DWihW9Y4pZgi/6bgp0znAz6zcokVEdcFkZSOkYn40YTQUM1n9aEFADUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746390560; c=relaxed/simple;
	bh=LOPBuF4+fwFulqQS2WISEOK8jsK/ta/3aeAPHhEu0l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyVsFK641IYZ3WqqWsH7FbWxNh0fEtbkLmqTc0J+thtSqRCRQfrwIiM/02ZXUpf3wKVR5mgmVl/f043nBkn/0dLdFFFWkwALSHFEjJa/vaFqB81HPP5060WmXaMs7ij4opf7L3Qau45548x0x0n10Mh+LLQ2GHUuloHtlB+KCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtgI0Gxi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtgI0Gxi"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso6428a12.1
        for <iommu@lists.linux.dev>; Sun, 04 May 2025 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746390555; x=1746995355; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib3LMsmt3AVtxQI51XzNWetUbhFa87CqDoNcMRqYPjo=;
        b=AtgI0Gxi+xZBpIq4/hL4QgHC0MXupJQNTyZvDpdN16N5Ld93A5qVMCNuIWTplRkvHh
         rkx0vdTjWG/5h0KEjh61TkUd11Rv7Imw+QCNGTeM4ENMz7M1JFN2Wvxd0/rzylDI2ABD
         Z6ZlHZPKvitCRm+R3mBpdLCCMJvj5atOILe5SH3I3Fh3AEYId35ZavupKKf0mPGCCmXg
         QZEhlbsw9KhmYDNNYLYPgowwZNyVQ9q85vBsPdPiits22U507oCy57/nSGBQZz/K9JLn
         pl2Lu2N4ahTq6Gm7ioCoiCZakzZiux7aPYbkbV80IdIBZ78YEmHgPlMEA9pyzhUYq5iA
         X63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746390555; x=1746995355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib3LMsmt3AVtxQI51XzNWetUbhFa87CqDoNcMRqYPjo=;
        b=ZlQCWrFtS3p2n4R/7VoHxqBuSvkAmm8IwRGCCCnntU05fcMny8uevC5KsaWR0rD7Km
         Q+RFHbkzQIWWPHoHxGySJ6f7rz4i0GyUners0StzId+ZJ/QHTxRiQWzg7ZU0xBPU4peV
         Etz6LfT7+zqZIvCtiI7ff1xJ4OfpvSV+Sq3fiGjgBw9Uirk8ffHxUxb3ZxBfFiXVqGOH
         vfEc7Bz1BTJVvY01zeNkUfCgeUHjrjzp2AryFRuQhDPUqN1cVuZ1SOnOT6BW7YeXk4gT
         oX029LUfYtWjF8L/QNQWTRiZaN07Bc75xVZf8EIOBj637nX/5ztAneYBc4qpmU+/U2W2
         GRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqFVosVCD8XlI4GJD7VqLJG9LEga9Hb0oaRgZWHUhWYjpAEN+AJLdXtWQzJHEvjHmThu3Yrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6KhLIn7KdzAsp6mDcZpqXH1bMDop1mOVZmNzRcfHsDVGNG9Ov
	88Xdalg2ztc62sBgJS+9snPukOJ21mM5DOA/x8v3IkaWdd0Tpc2kzCesJwx+YCCSGX4+VreLcPY
	nBcsTLSDIs/khU0ZV2TkGlkxEm4Mo1w/eJ+PO
X-Gm-Gg: ASbGncvDeJI64/IVXThMZ3cD/9nZoQwIFYH1HS8hy3ucnh7tuz0leRB3VFnqWeTKdZz
	HhC8fCQ2Tthve94Py1ncH9HReU5tlyn+NRqYd3Z63hUd/KrrSTXsjbc66ENR8d6SYdt+cKDwSKG
	Q5tjdLalZxBIWEO8wUuEo=
X-Google-Smtp-Source: AGHT+IEfueZvZ7kGI4Z7M9/38HPOgywtdm7n1vUQOsgi9BWPSmTeVZV2WPsIxy6mjBsAOwYclcJ4L3VoGzxPnsGEJq8=
X-Received: by 2002:aa7:dcc6:0:b0:5f8:3633:9dae with SMTP id
 4fb4d7f45d1cf-5faaa1fec39mr91150a12.5.1746390555252; Sun, 04 May 2025
 13:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com> <20250418233409.3926715-11-praan@google.com>
In-Reply-To: <20250418233409.3926715-11-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 4 May 2025 13:29:04 -0700
X-Gm-Features: ATxdqUHoQG2zng9XLrRlbiy3inmOzcByfOvNmlKHYOh99ci2SyYQjmpni8-5dCI
Message-ID: <CAE2F3rDKZpUGHc1oUm6zAJfb=XW7HOjs7vodgt_CDgWsDWUS2g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/10] iommu/arm-smmu-v3: Invoke pm_runtime before
 hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 4:35=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> @@ -139,6 +147,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_do=
main *domain,
>                 .old_domain =3D iommu_get_domain_for_dev(dev),
>                 .ssid =3D IOMMU_NO_PASID,
>         };
> +       struct arm_smmu_device *smmu =3D master->smmu;

Appears unused.

> @@ -130,10 +130,10 @@ static int arm_smmu_rpm_get_if_active(struct arm_sm=
mu_device *smmu)
>         if (pm_runtime_enabled(smmu->dev))
>                 return pm_runtime_get_if_in_use(smmu->dev);
>
> -       return 0;
> +       return 1;

Can we fix this in the commit that added this function?

> @@ -2365,6 +2437,10 @@ static void __arm_smmu_tlb_inv_range(struct arm_sm=
mu_cmdq_ent *cmd,
>         if (!size)
>                 return;
>
> +       /* No need to invalidate TLBs if smmu is suspended */

The code doesn't check if the SMMU is suspended but rather whether the
usage count is zero which is different. I'm concerned about the
following sequence of events:

 * usage count drops to 0
 * TLB invalidations are elided, stale TLB entries remain
 * usage count becomes non-zero

This would result in stale TLB entries staying permanently. I propose
adding a new member like "is_suspended" to struct arm_smmu_device that
stores whether the SMMU device is suspended. If this value reads true
(i.e. SMMU is suspended) then you can rely on the driver issuing
TLBI_NSNH_ALL before re-enabling SMMU. Use proper acquire and release
semantics when accessing this variable.
