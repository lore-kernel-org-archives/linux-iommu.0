Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02138A715
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545311; cv=none; b=Unrq7RH0P1xlf5Odyz4gh8tmKNI/g7iNKdFODZ6c9qkpWKLPlBKFWsJQJWToWHmzgn2g7Eg7bqeDtUihxqQFDcAL6c8wgYgvHOlmAXC1UXX0qPgHB4PL7NLkRGLTROlo2jJDmBDuSEZVPix1lVQnvPZA3SrJPSiSidP+SV8J6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545311; c=relaxed/simple;
	bh=LgMDXZ4GK4gUbkGIBcd9NILffyv+J3lpYgdlg9rdSws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NrpFX0E1gP7HDHHMxxSj7Ck71wRZn1jyUxozckQkK9/e5dLdApWjn+wpe3gkDjz7cc/vbh6Z3USOGXmpeRjSyjD+aHjYFXQAoy6GnI6mT8p31jfPRy+XrGDpePA8I2xfpHcWgzqHmlGrTh9rXXDlBEWJje7FYgjNpr4L7sYwkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0+71yqq; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0+71yqq"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12bf9974587so21212465c88.0
        for <iommu@lists.linux.dev>; Tue, 07 Apr 2026 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775545309; x=1776150109; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUkEmaMr7BpHU4t93vCaBp7W3akZnYAFHA0KA5khyIM=;
        b=X0+71yqq2F7zOjyhe5cZFQFgPKx+ne31ENsEu9YCXqdvOQ16Ko3r0M3+Tw2ztB9MwC
         uoO33rZKbbmnK3zfxQH/amsziQSX4iwCEcTr46kao/E+v/i2FbMoW+3tTvgmzoEhoqZv
         QULvogLwXaSz6HR7MLk2j9XgSs1BzF3Yy6ULypuoILOCA7v+CgLiHDNJDJw07e+DdRYh
         PXL0gUFOllUQMaFPJqWXhSfmBd8pD/Il4J60LIqoYoc7bSjmO/5itoQjnnPfsctJSitU
         TFnDAWdWslnEUSXBnpO+dkGBmfTg1wwnnYXErSCW7sGwGjPeZLVkmUaXiznZse/cr5co
         H1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545309; x=1776150109;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hUkEmaMr7BpHU4t93vCaBp7W3akZnYAFHA0KA5khyIM=;
        b=N5Fxt4+dOLpPrx6NkAuh5GqeOMPkIxXLYPi3G5uz3BVdN4smdsRDlkTqYwXYYU9X5P
         IqLOe9Cvx6zewKfIjkzW/DkixJZk6dsyJJUjvQbLtvz4wAQAmuwyBXQ6mG/KhflJwTcB
         0ofeo906zhunwX7Z/KehwCJzKrPKDhaBecB6zaNXNKtztDK8gvClnqQfaz2dokStM0A9
         2HvgF2s6/TqzrhRoPXYSrmtfSfv2mh49sATmfXahrbn1SczdxS5IYpf8gFLmlGv9RIHw
         gr+pqVjPsD04cMRO9pTrPORgKlk1NWbKlzZb3XGxAXZVQ7bPW6VXY+XgBlZdoaRceR48
         SNIA==
X-Forwarded-Encrypted: i=1; AJvYcCXEG0c0f5Crx+WeWnCdem8XOYf044/NjvfmsXNuT1QdY/N2EH6JAYLwS/AvQl2T3rSzQ7yYpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgHjrUdcSc+w/vOKlLUvc/2DHk81gg8Q5rFhKA/pDIo7hijne6
	1q2nNVXbdcLvzTvJK9y6OJu79gyp5KZvMPeKAAICjajt2CPDTYHEh7XdKuYAc2yK4uDn2m0YSq0
	nBA==
X-Received: from dlbtp9.prod.google.com ([2002:a05:7022:3b89:b0:128:ee08:8c14])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:12b:ebb8:e421
 with SMTP id a92af1059eb24-12bfb777fc2mr7760400c88.35.1775545308935; Tue, 07
 Apr 2026 00:01:48 -0700 (PDT)
Date: Tue,  7 Apr 2026 07:01:46 +0000
In-Reply-To: <20260330084206.9251-6-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330084206.9251-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407070147.623349-1-wnliu@google.com>
Subject: Re: [PATCH 05/22] iommu/amd: Introduce vIOMMU Guest-ID (GID)
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

> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index e7ffa7e8915b..6fba5d9b1310 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -43,13 +43,35 @@ size_t amd_iommufd_get_viommu_size(struct device *dev=
, enum iommu_viommu_type vi
> =C2=A0int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct i=
ommu_domain *parent,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const struct iommu_user_data *user_data)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 aviommu->gid =3D amd_iommu_gid_alloc();
Since the gid is defined as a u16, the return value from amd_iommu_gid_allo=
c()  will cast any negative
error  codes to a large positive value.
> + =C2=A0 =C2=A0 =C2=A0 if (aviommu->gid < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return aviommu->gid;
