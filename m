Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5756B8C
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018102; cv=none; b=ch9OZrLCuf7BEgdvTQE4oUmQn8RjDWAZiN0RvWWQXIDs2gifdoYfruZZ4DX+LmUGZd8MdGGvo3BfMFuHnYPTqGre+xmrnBmxgaEkPqxIB0HM8o+4YQXoEJyfwWsgpDBYfRHzlGBaQTzextcPSCpyA/nyHAWoKMBgRUhRLDYpse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018102; c=relaxed/simple;
	bh=0VRNlIb4cHHAp/I7KF2KCkIRjATJM3bShqLVNnDRdhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erUhc7dPxyQ/TezvvKmqC7z6MiQwzH1erNDP68ptACjTuuVvcSI9xqdhA17bbjStjXR8vSfsX9cRLzQUhHWrTe/r7rlbzCKnTKx2cM8vycvTZmscVn087xOhdPARgB79V+6TrqEdK25fquI4vN+oPQY7YAPRg7Ey5gqsUTfUzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtPbXND7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtPbXND7"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-430d3fcc511so162911cf.1
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711018100; x=1711622900; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97pRs/b2V244oQlEZvL/k9UmrLk4PjrQoAgyPy9A1bQ=;
        b=UtPbXND7pQrvFYRrM4z7tMVhEAqS2r0y/Qla/rGvT24U9+2KpM44/hUtVTNJqU8OVs
         AYYxeHBq5XwWtbC4Jk6A7PpxxyCL4Mv1THsm3+2Dcqy+4SEz4K1qiCEJQFWISsKR1cOo
         QEogffkUyasMZmHwk1RQt3hrIWxZ1NaAJp0NHVtyovO7SXqHoey6wWcBfIjfH2i18ITU
         aOSdvCdy2brWViu20rL0dLZvcqxq57P5VAJzhXk2BTDvlf8Xvb9u5S9saRa6kqXNVgUa
         EAozsK/MKiw6kmZ5OvO0k6RTkM9qN2g8CsrUb3ZK6QJLAAiW0w8RcU6uBeMTeBd6AmD2
         y70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711018100; x=1711622900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97pRs/b2V244oQlEZvL/k9UmrLk4PjrQoAgyPy9A1bQ=;
        b=X/4fveh0OKoAI5oJvZH/XHsYiPESAb+fpvJW1YBfxCVLc+JSCRdAsBWC5xTI2tSlvj
         KFw7mSMhcZ6Flex0iB/MOWb4yyzpy1+9gwBlC0owbzG3zOBx0XDytRvbFdo+oyBkIyXx
         jyhft+snYCe9YaZIJcJ2IEIIdnhTQxHma7J8OTRjwMRg8pEl6If7g5PuZM0x8+75V9+R
         ngoEi2yfnre8zK1rP9PRoxfun3Y2NJI9FKaWIGxGkoESinF2EORuOz51CEs2vs7yGdpS
         y4aOz085xpd2Og58yrgE6R8PGPGPQW/8v7sMVWuwFqyMAo1Ezg7LzQZUexkHMcGlsVFB
         lbew==
X-Gm-Message-State: AOJu0YwWPwH5li0GATUiuu+IOnsZia/qtMM51ZbODnIYEywoLD2nmgoK
	4EZv/08Jd05kiCXYgkA/0NnR6lcGESr72wk+j1ma+TrQfAzAlhkU1RI4vYHmwf0quJGVdYv1xmY
	vgGM1e/3mz5whrAmRvxzGe1xVj22yQyqJHOPE
X-Google-Smtp-Source: AGHT+IGaID46B91pcVkEC8xWr5KwgxwFOlCwHllzgXTLv8iEukr9KGJIrJhlUIE8yRtUThENsceZTGYosLnjIS6q9fs=
X-Received: by 2002:a05:622a:1ba3:b0:430:d48f:db4f with SMTP id
 bp35-20020a05622a1ba300b00430d48fdb4fmr189408qtb.29.1711018099674; Thu, 21
 Mar 2024 03:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com> <19-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <19-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 21 Mar 2024 18:47:41 +0800
Message-ID: <CAKHBV26pRuG02Leawej00mm8LZceO27yWUqn9rOwYBTKmtA8UA@mail.gmail.com>
Subject: Re: [PATCH v5 19/27] iommu/arm-smmu-v3: Keep track of
 arm_smmu_master_domain for SVA
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 7:44=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> Currently the smmu_domain->devices list is unused for SVA domains.
> Fill it in with the SSID and master of every arm_smmu_set_pasid()
> using the same logic as the RID attach.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 +++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 2db2b822292a87..6d15fe3a160acf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2603,7 +2603,8 @@ to_smmu_domain_devices(struct iommu_domain *domain)
>         /* The domain can be NULL only when processing the first attach *=
/
>         if (!domain)
>                 return NULL;
> -       if (domain->type & __IOMMU_DOMAIN_PAGING)
> +       if ((domain->type & __IOMMU_DOMAIN_PAGING) ||
> +           domain->type =3D=3D IOMMU_DOMAIN_SVA)
>                 return to_smmu_domain(domain);
>         return NULL;
>  }
> @@ -2813,7 +2814,9 @@ int arm_smmu_set_pasid(struct arm_smmu_master *mast=
er,
>                        struct arm_smmu_domain *smmu_domain, ioasid_t pasi=
d,
>                        const struct arm_smmu_cd *cd)
>  {
> +       struct attach_state state =3D {.ssid =3D pasid};
>         struct arm_smmu_cd *cdptr;
> +       int ret;
>
>         if (!arm_smmu_is_s1_domain(iommu_get_domain_for_dev(master->dev))=
)
>                 return -ENODEV;
> @@ -2821,14 +2824,30 @@ int arm_smmu_set_pasid(struct arm_smmu_master *ma=
ster,
>         cdptr =3D arm_smmu_get_cd_ptr(master, pasid);
>         if (!cdptr)
>                 return -ENOMEM;
> +
> +       mutex_lock(&arm_smmu_asid_lock);
> +       ret =3D arm_smmu_attach_prepare(master, &smmu_domain->domain, &st=
ate);
> +       if (ret)
> +               goto out_unlock;
> +
>         arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
> -       return 0;
> +
> +       arm_smmu_attach_commit(master, &state);
> +
> +out_unlock:
> +       mutex_unlock(&arm_smmu_asid_lock);
> +       return ret;
>  }

arm_smmu_attach_commit tries to remove the master_domain entry from
the previous domain that this master was attached to. It gets a
pointer to the previous domain from the iommu framework with
iommu_get_domain_for_dev().
But in this path, arm_smmu_attach_prepare is creating a master_domain
entry for the pasid domain, which may be different from the one
returned by iommu_get_domain_for_dev() on the next attach.

I think this ended up being safe in the end because afaict the iommu
framework requires detaching the previous pasid domain before
attaching a new one. But nonetheless this is pretty fragile and
doesn't look intentional.


>
>  void arm_smmu_remove_pasid(struct arm_smmu_master *master,
>                            struct arm_smmu_domain *smmu_domain, ioasid_t =
pasid)
>  {
> +       mutex_lock(&arm_smmu_asid_lock);
>         arm_smmu_clear_cd(master, pasid);
> +       if (master->ats_enabled)
> +               arm_smmu_atc_inv_master(master, pasid);
> +       arm_smmu_remove_master_domain(master, &smmu_domain->domain, pasid=
);
> +       mutex_unlock(&arm_smmu_asid_lock);
>  }
>
>  static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> --
> 2.43.2
>
>
