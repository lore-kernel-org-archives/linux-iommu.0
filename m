Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F521DFF0
	for <iommu@lists.linux.dev>; Sat, 30 May 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173850; cv=none; b=OVhJT1/cMySXprI+jNP/9PNtYgbjnIyMw64wZ76YotE/mEhyA6KnfCYEuDzmYGHRsg1IcldlRWeX1vJ3iju87P/shfd6JT+FUYnu3CioY3YC5UY2jRBBwebWQj90ON2Aob7kFUk4iU5w3J0mugvzVMayFyVdT6quiTmJoXvniuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173850; c=relaxed/simple;
	bh=LI2N6DhAF4cWYQbU1hA9nfoLMmZJwBfeUmpXKjK+ons=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qXzd/t0hi1ZigWWdYYNXrmJcPgCqeLK+mbB7VHSRuyDC1MMU3yGp7YuH0BOeue/trSo18xSdUm5kulZVrS8VaGmkoWfL9RzI1hdJuxun/UgYu2i68bvUKil5m9sZ2sSVTT6jB5+lVO3NgV3F9Iv09WLU11AE8y7w6nb/jiTCnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/AjyR5P; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/AjyR5P"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137731eae44so11710706c88.0
        for <iommu@lists.linux.dev>; Sat, 30 May 2026 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780173848; x=1780778648; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c8iwXysjou1uiYhNQmPGoQNB8sBZpJc56AO9jQd4l0=;
        b=G/AjyR5PDufXho6FX8XjDQuNzi+gcV28pDuTDKM2c/vb9iXBo9jRuyZWIKnvkND4d0
         aV0C53Vr3K9nwhHAvxDtBtKGsA2OzBlOsKzcOU7YuLjq8Lb77JVX8PW3GGXo0ANtB+Nv
         HAn/X5Y8zoQ98rb8lTHyc5x/IFSmwGJ0ejeStYMpUUyLcI0hbYCx9gWjT/gc7dnU8AMn
         ZBFFYnyddi5KvJvbOA0KPLwxY+PdBiqRRAgUQXmtsBBpOUZhPVesSK0bP0Yx6c3r+nXe
         vNDrTnGMebaDdHpxpDglcFKT3cjTJKVmvc+hZ5b5CS2yhNxMc32aOCYcjahi6PZrTwzS
         ybQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780173848; x=1780778648;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/c8iwXysjou1uiYhNQmPGoQNB8sBZpJc56AO9jQd4l0=;
        b=I1AqtEjCXIxehoDdJZCpmOPXqxGs+FuRIArGC1euiWym6SMhc6xbOa8jbOBy7CXKVZ
         hXXUh8GChQOx4i+azWNMo3FgbkFvFErmNbBvPP5I64UmSqu/hmVbDWJ3Ed7mljyBu/41
         1F8BIXlOpCjYg0M4iF6R/VSN4CrQnwHRQGkL/RO5b2EC1TmLTlVkACn3JKI2S6SHFqXu
         wEOJmJnVj3IjiCRr39DaXHRQW+J48FyHX/XmwoqOSAfJQincUbWxg6R0uODGAk26n70m
         HnHFkngCIWC/dCb5LA5C4aAOXGbR+kHIe1dCAuHy7hMKufja7V24xKSYW5ONpsDewtPX
         t26w==
X-Forwarded-Encrypted: i=1; AFNElJ9lhxucDk8zuSWNlq7RWdYSmtzX5jVnUbmrC62YxiK/yfYnPtr4ZkQoqIIHtzCrgIZgKC7mXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaNp5ufm+1g8sDyMdR35+4oavQFvL6x9w63AZWzH5FEb0/QBdv
	DqSFRYIGjITJmR9dhgXLAXe1OjYWnZzkGAH2+4slDUOMQ9FuQlw97zaZf61CXVcaSD0rPH6a2xt
	CZw==
X-Received: from dlee16.prod.google.com ([2002:a05:7022:6290:b0:136:3f5e:fe1c])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:429:b0:137:1ae1:bc01
 with SMTP id a92af1059eb24-137d4026936mr2275329c88.8.1780173847871; Sat, 30
 May 2026 13:44:07 -0700 (PDT)
Date: Sat, 30 May 2026 20:44:05 +0000
In-Reply-To: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260530204407.3017798-1-wnliu@google.com>
Subject: Re: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map helpers
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
>
> +static void __maybe_unused free_private_vm_region(struct amd_iommu *iomm=
u, u64 **entry,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 u64 base, size_t size, u16 gid)
> +{
> + =C2=A0 =C2=A0 =C2=A0 size_t unmapped;
> + =C2=A0 =C2=A0 =C2=A0 u64 addr =3D base + (gid * size);
> +
> + =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: entry=3D%#llx(%#llx), base=3D%#llx, =
addr=3D%#llx, size=3D%#lx\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__, (unsig=
ned long =C2=A0long)*entry,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_virt_to_ph=
ys(*entry), base, addr, size);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!iommu || !iommu->viommu_pdom)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;

Should check if the page pointer *entry is non-NULL before operating on it.
*entry  will be  NULL if the caller encounters an error during alloc_privat=
e_vm_region(),
it may attempt to unmap and free a NULL pointer below:


> +
> + =C2=A0 =C2=A0 =C2=A0 unmapped =3D iommu_unmap(&iommu->viommu_pdom->doma=
in, addr, size);
> + =C2=A0 =C2=A0 =C2=A0 if (unmapped !=3D size)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("%s: unmapped =
%#zx of %#lx at %#llx\n", __func__, unmapped, size, addr);
> +
> + =C2=A0 =C2=A0 =C2=A0 set_memory_wb((unsigned long)*entry, size >> PAGE_=
SHIFT);
> + =C2=A0 =C2=A0 =C2=A0 iommu_free_pages(*entry);
> + =C2=A0 =C2=A0 =C2=A0 *entry =3D NULL;
> +}
