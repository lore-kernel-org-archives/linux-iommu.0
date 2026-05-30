Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1A375ADD
	for <iommu@lists.linux.dev>; Sat, 30 May 2026 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780176376; cv=none; b=I8pcbCBjjY2nZWEbK+LzfF2JJmeb/pbO46Q+2nL1rHWs2k1u0DLElIIAV6oTNaMMaw1XGCwqNl27r0nOuhj0EocHKORxszFxzg3V8kjA2+OpIoXayIBV5XCXz1PNI+kC6t+LyS3s3LOkqIvg3TCNAUZr6LN8Dfu/WhRBmSC6ths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780176376; c=relaxed/simple;
	bh=FKeXBMG4Cj7Cyt3ypaR9eRSU6jdrCpJQcLrE7d8WCyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJ6LYJRAPVKJPLtKFLlqK45nlSp0y7HUfJo8KX06RKqjXQAVCz0BjcMFKYFuMpwPnl955Qhcc1YqDviMe2QK8tvvhnHPqJ65sHnU1+rK03REyO57P50HeHkWS0m9ZMS9mZ1h1pwtFa13Phbjz9KIw4qCLipel7aW0KawnQMdmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRN8cSJK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRN8cSJK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so2584690eec.1
        for <iommu@lists.linux.dev>; Sat, 30 May 2026 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780176374; x=1780781174; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKeXBMG4Cj7Cyt3ypaR9eRSU6jdrCpJQcLrE7d8WCyk=;
        b=qRN8cSJKKm6gCFwpI2hkrABmzBgxMpdXZfYrauh2Dw0Lu/2FZ9CIZ7Ee+MwMHxKsOR
         H1KZMBAvLYs6f5B7lEk3xoaFJtVEaN2MLnPVu2+VNazxpZyHSDjM49mRWjHj4naW4QsX
         t1JBI7MCwol3BL+sl+QSLP7thRqPx7/AaBnDk/SguXNt+LARcHDyd0MMGfSmweXWnuE0
         o00MMPOCk612jsOVxKZLAlR46xACqKp4ERHe4sE9iG7bQEmrMUUHUmMq3xA54g2iANfw
         Tspoux5Jprse3KII0YoyaY2sfT1r9JAY27G8tt4JG3Ed6nGnnTdyHfsDgltdD0GmW0KZ
         dWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780176374; x=1780781174;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKeXBMG4Cj7Cyt3ypaR9eRSU6jdrCpJQcLrE7d8WCyk=;
        b=ip2ZzfFHvH/GAa+8rOVDWVMC6vZJB3iiGrFXQjWv+346aiN+y7SDP35dY+f2bvOrTe
         53DudX1GYZQhjM21IlVjw/sDrumFTiMjjjtMp9G0lw4nLEx1juN1141AFcdeY90cOG+H
         /R49aKH+jr8l7pmWMF7fbeb7cbC8pZRHZpjuFj4B8pbur1mhARCdxstTP5JV6AfEa1LI
         p7vdDWG9/0Z/9lcCOxkHtgAvFW+pXoch5IMy7Klto1ILngiIXbrC5MklcAZnBYTzBEq5
         TwBvl+SOV+KkMZZyfrjSJGnxi0cDZAG5pXRZ3mLW3nF5Mjb4qIcDWKaa54tCq4+t6SdI
         MJTA==
X-Forwarded-Encrypted: i=1; AFNElJ/j809o0AWhgUa/TxwPjH4GWPgVGIRZapZF1SlWLQDvHe8zO7zMYQdveLH0SAQ06SMr7RnIBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO2cPmVNEPtYksUa8gojks5Fib1fJ+HlLO6eOZjO7cAt5pKA+D
	MVVRe7N3KMSf9r4dHakvKpEOCv2Ym5zlArQKQnMibyk8rSaMI+fulPuIiwEz/yjtfVZgHJ/6O2l
	rmA==
X-Received: from dybts9.prod.google.com ([2002:a05:7300:f589:b0:303:9bd4:479a])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:290b:b0:2ed:e12:3769
 with SMTP id 5a478bee46e88-304fa6b6007mr2483916eec.31.1780176373775; Sat, 30
 May 2026 14:26:13 -0700 (PDT)
Date: Sat, 30 May 2026 21:26:12 +0000
In-Reply-To: <20260528051738.596013-14-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528051738.596013-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260530212613.3060363-1-wnliu@google.com>
Subject: Re: [PATCH v2 13/26] iommu/amd: Add helper functions to manage DevID
 / DomID mapping tables
From: Weinan Liu <wnliu@google.com>
To: suravee.suthikulpanit@amd.com
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev, 
	jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org, 
	kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com, 
	vasant.hegde@amd.com, wnliu@google.com, wvw@google.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:19=E2=80=AFPM Suravee Suthikulpanit <suravee.sut=
hikulpanit@amd.com> wrote:

> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 42307ae71b24..efa9e1f49550 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -83,6 +83,10 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *vio=
mmu, struct iommu_domain *
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reset vIOMMU MMIOs to initialize the vIOMM=
U */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 iommu_reset_vmmio(iommu, aviommu->gid);
>
> + =C2=A0 =C2=A0 =C2=A0 ret =3D amd_viommu_init_one(iommu, aviommu);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_init;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D iommu_copy_struct_to_user(user_data, =
&data,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IOMMU_VI=
OMMU_TYPE_AMD,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reserved=
);
> @@ -120,6 +124,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd=
_viommu *viommu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (aviommu->vfmmio_mmap_offset)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iommufd_viommu_de=
stroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 amd_iommu_gid_free(iommu, aviommu->gid);
> + =C2=A0 =C2=A0 =C2=A0 amd_viommu_uninit_one(iommu, aviommu);
> =C2=A0}
>
The finalization order should be the reverse of the initialization order.

If amd_iommu_gid_free() is called before amd_viommu_uninit_one(), the gid c=
ould be reallocated to a new
vIOMMU instance before the cleanup is complete.
Please consider moving amd_viommu_uninit_one() before the GID free call.


> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 6dcb02b12a28..3636093732ce 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> +
[...]
> +void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_vio=
mmu *aviommu)
> +{
> + =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: gid=3D%u\n", __func__, aviommu->gid)=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 free_private_vm_region(iommu, &aviommu->devid_tabl=
e,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIOMMU_DEVID_MAPPING_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aviommu->gid);
> + =C2=A0 =C2=A0 =C2=A0 free_private_vm_region(iommu, &aviommu->domid_tabl=
e,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIOMMU_DOMID_MAPPING_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aviommu->gid);
> +}
> +
