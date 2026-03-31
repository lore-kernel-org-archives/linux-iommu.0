Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F96364025
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936543; cv=none; b=nl7XgDfvOEUgNVOm9N5H6nswOduldUjIun4+tVuoB2Oh71Hvv3xZwwxiRxRJnaW++JO0UUCDoQ4zBieEqYnDPIxKILx0TuZiJha/dyCwEkXPfc/8RnJQqfU2LHGSpEMxfiiHn5yLicGRpEO10IkDCrhYxvXLeHtUODuapt4THLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936543; c=relaxed/simple;
	bh=Us3p7gsh3vgmiFwekh/N5fLl7d4FgE11q029LGFnB84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RNkSSLWVJ9Fo9j2tpEeYI1IP+5LtlGqcrMfUDWF6Mao00IdUME2iPYVi4/Se2G+AvBG2z+Xnw9W65y3GVGebv7OYZmzvRMOtO14yYuG/37iP1J/YkssStKFgYUodEv6/gnswieYqx0mgeJwBcewcJJzyxJsqcIDpLl7Smp2pXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDpuJdUW; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDpuJdUW"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128e8ac314eso1171287c88.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774936541; x=1775541341; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYSGInLTZLFG+/28natEtFPklhZk/pthoTi7nrdmuJM=;
        b=eDpuJdUWbEVZyDFG/dMk2rfUjZ0rngDcHMov9mrhsI5wIl4mxU6USN/ErouKLAkpS+
         aqOSo8RxZTnH22WVQGhZ9UskKJTf0JjXXhGwAB29eLJ+Ti+gYLSDbNqDPGbUICEG4xIW
         TFF9pe59O1T8ugqdVbr2lpHGVfwz7aGFlF9mIR3HF4JO85aHmMvmCToCn0LdJJ8ZOko4
         JRm8+Pbtjix+3PNi7UIs3NG8OdkWIV4qStCn18HISxUiQcZMqmQxIOreUSXAyI6EEZdi
         CUVRfoIUaaZEwT/UrZURm6PPFmeqsJOqi8NjmCr/Uuhe8AeivZpdV6V8RhTJt8iedf3a
         oTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936541; x=1775541341;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kYSGInLTZLFG+/28natEtFPklhZk/pthoTi7nrdmuJM=;
        b=DroZgSG5JRezP1GvYY8rsqhG3QU0r1hx7ezp4LAITcsxxi5eLrxrYFhhdL2Zr7iCE/
         N46buw+sycGydf7RQOGAnKokDOelj2iKt0plQpYujuTlWwD/Hvl+C6c/g7bRoAEZoo2l
         nSib9S8SUokGAAC3zGwNoOw//GtXQwts4MnZQAZcfTPxZhDisy0ulee2F1SUtQYiwOXK
         POR+wXmB9vzb9bvJF1qAR46RzC/sHy7FyzAeviCdmUkqaBfFFD/siTDO0elYlCVScgWC
         HjEIl6pqhx+BdWTflRpxhk9tQTj0Pg9EZkPIMippCxBhgpqP8XMhv6MhoJQpT8TpSD3a
         LEdA==
X-Forwarded-Encrypted: i=1; AJvYcCWUedtwYJRXiasrjQS08lnMgPwEU8bM+kuZ3yMNcYX6/OtD7N4Kt7HPB116ZVwrB17bZaURGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjDQWljkXrRQ4M4hZEvyWQdZvrPseeoDs5Qt+GnqVlhjAq2Jxp
	rwZyes722LvQa4cuimNrfcEpBMAVUwqpUBuaqksDGXQ8CvoW30w8j+Ibi82MzUH6Wqpr8vyPWHt
	rqA==
X-Received: from dled11-n1.prod.google.com ([2002:a05:701b:42cb:10b0:12a:c265:1a7c])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62b:b0:128:d1c9:3633
 with SMTP id a92af1059eb24-12ab287d5ecmr7468853c88.13.1774936541122; Mon, 30
 Mar 2026 22:55:41 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:55:39 +0000
In-Reply-To: <20260330084206.9251-8-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330084206.9251-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331055539.4026383-1-wnliu@google.com>
Subject: Re: [PATCH 07/22] iommu/amd: Add support for AMD vIOMMU VF MMIO region
From: Weinan Liu <wnliu@google.com>
To: suravee.suthikulpanit@amd.com
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev, 
	jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org, 
	kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com, 
	vasant.hegde@amd.com, wnliu@google.com, wvw@google.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Mon, Mar 30, 2026 at 1:43=E2=80=AFAM Suravee Suthikulpanit <suravee.suth=
ikulpanit@amd.com> wrote:
>
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 6fba5d9b1310..5dcd3fc3ba99 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -66,11 +69,21 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *vi=
ommu, struct iommu_domain *
>                 return aviommu->gid;
>         pr_debug("%s: gid=3D%#x", __func__, aviommu->gid);
>
> +       page_base =3D amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
According to the below implementation and prototype, amd_viommu_get_vfmmio_=
addr() won't return negative value.

> +       if (page_base <=3D 0)
> +               return -ENODEV;
goto err_out here as well  to avoid leaking the gid allocated above.


> +
> +       ret =3D iommufd_viommu_alloc_mmap(&aviommu->core,
> +                                       page_base, SZ_4K,
> +                                       (unsigned long *)&data.out_vfmmio=
_mmap_offset);
> +       if (ret)
> +               goto err_out;
> +
>         ret =3D iommu_copy_struct_to_user(user_data, &data,
>                                         IOMMU_VIOMMU_TYPE_AMD,
>                                         reserved);
>         if (ret)
> -               goto err_out;
> +               goto free_mmap;
>
>         viommu->ops =3D &amd_viommu_ops;
>
> @@ -79,6 +92,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viom=
mu, struct iommu_domain *
>         spin_unlock_irqrestore(&pdom->lock, flags);
>
>         return 0;
> +free_mmap:
> +       iommufd_viommu_destroy_mmap(&aviommu->core, data.out_vfmmio_mmap_=
offset);
>  err_out:
>         amd_iommu_gid_free(aviommu->gid);
>         return ret;
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c

>
> +/*
> + * Returns VF MMIO BAR offset for the give guest ID which will be
> + * mapped to guest vIOMMU 3rd 4K MMIO address
> + */
> +u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
> +{
> +       /* TODO: Add check for sVIOMMU and set gid[bit 15] */
> +       return iommu->vf_base_phys + gid * VIOMMU_VF_MMIO_ENTRY_SIZE;
> +}
> +EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
