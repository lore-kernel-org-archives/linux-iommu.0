Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E184A5A
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032842; cv=none; b=JSvcmBSOVxhYAEMNzCDzhLuv+NCbtR45nWRZ6fNyJNnjKGETzOYaGb0s797qWhdLVG00uwlbth5BbYaaBsYZIX+pUu1fYWJIPvOktzHnsuHGhohAvXTyqXp/OE+3j+hU/Gj6tzQ4g3bGpwIURyGOAdEp+w0N32Pyqw/funeI6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032842; c=relaxed/simple;
	bh=wXVoGZMVV1FLSxmwZZOaxe/qW+LgC5NIbg/as8Mz7wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4L1wiJWo/SzyMcC1yn/3uiW29s+vY+OvGEbi9kZJQh8sXGcnL4JQ3jqZ2YNVXmKu5lsGVQYKXKKavAKYXo1eQ5ScabwlOAfk9Ga21LWT/pS6LZWOoZHBh3Nklxe81WRVO/wftJj2V501kIPxGXutP1OT124aS5g1FheMAlkOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XH/i/HPu; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XH/i/HPu"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so324791cf.1
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711032839; x=1711637639; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+t9rzqkymfB/yIV1Yg5wvAl3xePzQFl2rsHELNKaPY=;
        b=XH/i/HPubuSpjBn8F5tukKJwsrey4RI0M+fzFMj8KTwcEytxDK8jnF7AM6bqK4nYza
         OMKRO9r8ryngIIjKnZ2W1gQWTlDTvMDbf+DDqiUsUfvbg5RjqjyGi4vOYv+KEBW4VoOv
         9E8A8L/ZnI6Hu1VdeE2pt5WN4pLpzT7vle5w9fG0dqJNDN3t6PNIGI3oic3YTA8JK/nQ
         9M+Q2ePKC1qkT28HP+1/hjs6xGRRvJY957iq394ApqMRCB/wwEgcMevRVC0ewo3n6kdO
         HgA1sdK+pBE/gpY+s7TSuCiyYe8qFfVLlNMyAeF0lIPFnutNb6HEbaUpg3Gn8c+b4cA2
         Xv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032839; x=1711637639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+t9rzqkymfB/yIV1Yg5wvAl3xePzQFl2rsHELNKaPY=;
        b=mDioHCpnAatVhkMHwYw5u4+kPu4Gst9QLC4bDQAs7IeMSbH8NZwBFkOCbFBs6xIRm1
         5Z9TLtjuLEjvxKR48QMmkgX6R02iZoJpRLzaJjINixcj567PX1MOl8npIoa+VXeEXxoD
         p619hX0JEp9iOCTB+uJkyKLberGzgZeHpewW4H/xKX++VCy+9oBNWLWQE2ysOwrg+kkS
         M7YIudPdTQ18MGbhT1alI9TdA4vBYPFzMEiC3kcHP1qHfW/F+JgQPLsi+BMp2lB2El9E
         sixqbftf8zpla43cAelVL+9duJB0xjUDrpw4EmIYN/EccHGjVhIS1oogJG0qMRABaaB3
         dI+g==
X-Gm-Message-State: AOJu0YxF0FhH6TfQOw5BYnifhN3MeUYmDBQ7ecUbR3FdTbTxA2jbl5Ec
	xkqO/3zDqsr989iiHj7R9oueNo95pIJxHD41HnXpq8Mozo2RsVKAsBcKwtacIIk3RQpKkjyy2jJ
	f/PxcM6wheAX43zoNEb0iGnqK5YUgyRljTELN
X-Google-Smtp-Source: AGHT+IF36U+vzLo/9jdcf7tT2+tNY3pm3GGpOiqSCnz8djDsrpodSINe7ph+7uvLJN/lX4jEPWYtzEDWHJiqZ9iwc9U=
X-Received: by 2002:a05:622a:30a:b0:430:f049:49a1 with SMTP id
 q10-20020a05622a030a00b00430f04949a1mr318009qtw.4.1711032839194; Thu, 21 Mar
 2024 07:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <14-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com> <CAKHBV25xx51EuDXK91-o9BnFq5TZ66TAPuZ4YEdJ1UPq8sr7ZQ@mail.gmail.com>
 <20240321132839.GK1044235@nvidia.com>
In-Reply-To: <20240321132839.GK1044235@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 21 Mar 2024 22:53:20 +0800
Message-ID: <CAKHBV26dSY+Gy-x9HTWVCcNMyAkB1g+Y+dv-Lg+-furpu9bnSw@mail.gmail.com>
Subject: Re: [PATCH v5 14/27] iommu/arm-smmu-v3: Make changing domains be
 hitless for ATS
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 9:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Mar 21, 2024 at 08:26:43PM +0800, Michael Shavit wrote:
> > Overall I think the patch works, but it took me a while to really
> > digest the big picture. Just to make sure I fully understand:
> >
> > We're trying to satisfy the following invariants for correctness:
> > 1. Devices cannot get translations from a domain that was detached
> > after arm_smmu_attach_dev() returns.
>
> Yes, regardless of ATS this is the API requirement.
>
> > 2. Devices cannot get cached translations from a domain after
> > arm_smmu_atc_inv_domain() returns, regardless of whether the domain is
> > simultaneously being attached/detached from a device.
>
> There is no simultaneously here since the group lock is held by the
> core code.

I meant a call to arm_smmu_attach_dev concurrent with
arm_smmu_atc_inv_domain (through tlb_flush_all).

>
> > Apart from note point 2. above, the behaviour of translations while in
> > the middle of an arm_smmu_attach_dev doesn't have well defined
> > requirements:
> > 1. Before this patch, devices may get translations belonging to the
> > old domain, then aborts or identity translations, and then the new
> > domain while arm_smmu_attach_dev() is in progress.
>
> Yes
>
> > 2. Ater this patch, devices may get an arbitrary mix of translations
> > belonging to the old domain and the new domain while
> > arm_smmu_attach_dev() is in progress.
>
> Yes, but no aborts.
>
> > While disabling and re-enabling ATS inside arm_smmu_attach_dev() would
> > meet the same requirements as this patch, it's not optimal since the
> > device may still have traffic on other pasids than the one being
> > manipulated.
>
> Yes, we can't just disable ATS due to the PASIDs. A SVA PASID might be
> present and disabling ATS to change the RID domain would completely
> wreck it. Today this scenario is prevented by sva_enable, which is
> removed in following patches.

What do you mean by wrecking? We might slow it down to a crawl but we
wouldn't be corrupting or destroying anything by disabling ATS while
SVA is running would we?
Oh does disabling ATS abort all transactions rather than making it transpar=
ent?

>
> I added this note for context to the commit message:
>
>  This is part of the bigger picture to allow changing the RID domain whil=
e
>  a PASID is in use. If a SVA PASID is relying on ATS to function then
>  changing the RID domain cannot just temporarily toggle ATS off without
>  also wrecking the SVA PASID. The new infrastructure here is organized so
>  that the PASID attach/detach flows will make use of it as well in
>  following patches.
>
> Thanks,
> Jason
