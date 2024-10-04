Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CD1339B1
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076483; cv=none; b=dBnFgdl+Wts17/FBGVRVjdP7tNwy3UbEmApv7jjBLB0dCJxJewrbEJR//NSe07RKzQpTdhu08DgswYZv3K7RkNH6SUpRmanSsZ6pPctnP/e0ZeDTMIUhG8bsT4DkLbPtzek0BeBq1B8Ts35gbtTVyAnY/nN5QN/eQs1nFudUJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076483; c=relaxed/simple;
	bh=AMSCQYpuDJW7b9njqvI89iAgglL5LwrjRT4hBrKZsDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPsbSC578HF3ciWTk0v4TNJzN6LISgak0tdPGGmaL6eD/ilJdSoUpmAt/aGMoGlj4NGPMCQp9eo261Rnxah1laXfDig7v6qwnGnjLCl0McO5nOIZc0+hqHa4GaDQgjlVQAOz513aSSx2UqJSWfbFzGe9SXiOz1n6uQxlNHnPq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6TnkEk0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6TnkEk0"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398cc8773dso7318e87.0
        for <iommu@lists.linux.dev>; Fri, 04 Oct 2024 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728076480; x=1728681280; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpSzFA0idugtn5xRJRxYzNrmK1BG08Xyqc6JA7sOzg0=;
        b=t6TnkEk0aVFEXvH/5ghgpdQuInMHh70IP+UnjKUWtvmony5sUbbhsTwjaTbPUU/MNA
         kb7v06En3SWQFy6+NBFmItimAZPxSCGq14U815fRhNJB4LBJVgcYAow1CqWIiDNev1iI
         GDBFiSMvqAzjoumbIk+SvzShU5L3Q2I5qkiqt8IhZXWn26OQ+shgci0ncq4jDX2LQRpU
         zE2pUmNHurnmDtTeT07SRlfAp/bnx9tFUSNX2XF+4uxkduWhv4S0nNFMMYkTuD7J68Tp
         gEmsztxi5rjskYTaThS13Y5QVWrmxwgjEpHZwuf7lHDKnLX8UDHgP83Gn6Uas6CmVx6H
         JGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728076480; x=1728681280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpSzFA0idugtn5xRJRxYzNrmK1BG08Xyqc6JA7sOzg0=;
        b=tS9YdBrdtQLY37+dq56d4YIwX1M1Injy7pfY0FEu0iz1XgoU/Pf2Mpnl2u1okdO533
         /zlXyw3HbCE6vfFoT6AVSeWYhQ5PI7kNzICsRlBVzvuWPqvFtkJI1H1HmoqRrfoD/2dl
         5uW37PS9zQ1g6NpwJ8fQsxbh3fmbmIHO2xiHaD9mXhBjSObbkDT9gDOQZnZvHakoR0IM
         ItA+CS52RcdfpoNFuLWX5HR3erdLxtIGnTq3NVm7sr6QNL+eojXD/fgwb2fu0zuz0cET
         7A1kl+Ip+bi5vnXnOkoKVWY7VIqSpQ/4pjQuGvpXAHlxNFxH5T2UCB1DQd0Jq3ePVKCq
         Wb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZqg9bQyof73YkwKM8Ww27c3R8qLmB7GT4LuIcLHOq7pw0KVYjH32j3okbtx303yR8zmIOUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyD8L90hpPI67iFzafc7Itltbl+jFwVXQjdDJzi01Fnn0QWvl5+
	ulnwpdVCHNBdvA3iGOp7/8wLBFPI5rSLsnGELr9KIeuS3U/p6VEPdcf44q3uIvckoygBR8gFNar
	JTJs2aEgKIA5WmHyqkzEEn4qYNho1Y44ckx6x
X-Google-Smtp-Source: AGHT+IFOeWVleQi6mz54rMySufvSmJUb/qqPeoKDzRHHn4+5H8YGGYkP/iidPh+hM/W92QifNVcnGSW0RMGzbEWLPsA=
X-Received: by 2002:a05:6512:401d:b0:52e:8a42:f152 with SMTP id
 2adb3069b0e04-539b13aefc9mr21668e87.5.1728076479635; Fri, 04 Oct 2024
 14:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
In-Reply-To: <20241004180405.555194-1-yang@os.amperecomputing.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 4 Oct 2024 14:14:25 -0700
Message-ID: <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Yang Shi <yang@os.amperecomputing.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org, 
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:04=E2=80=AFAM Yang Shi <yang@os.amperecomputing.c=
om> wrote:
>  static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  {
> -       u32 size;
> +       u64 size;
>         struct arm_smmu_strtab_cfg *cfg =3D &smmu->strtab_cfg;
> +       u64 num_sids =3D arm_smmu_strtab_num_sids(smmu);
> +
> +       size =3D num_sids * sizeof(struct arm_smmu_ste);
> +       /* The max size for dmam_alloc_coherent() is 32-bit */

I'd remove this comment. I assume the intent here was to say that the
maximum size is 4GB (not 32 bit). I also can't find any reference to
this limitation. Where does dmam_alloc_coherent() limit the size of an
allocation to 4GB? Also, this comment might not be applicable to 64
bit platforms.

> +       if (size > SIZE_MAX)
> +               return -EINVAL;

I'm assuming this is for platforms where the range of a u64 is larger
than that of a size_t type? If we're printing an error message if an
allocation fails (i.e. "failed to allocate linear stream table (%llu
bytes)\n"), then we might also want to print an error message here.

> -       cfg->linear.num_ents =3D 1 << smmu->sid_bits;
> +       cfg->linear.num_ents =3D num_sids;

If you're worried about 32 bit platforms, then I'm wondering if this
also needs some attention. cfg->linear.num_ents is defined as an
unsigned int and num_sids could potentially be outside the range of an
unsigned int on 32 bit platforms.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 1e9952ca989f..c8ceddc5e8ef 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
>         ioasid_t ssid;
>  };
>
> +static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu)
> +{
> +       return (1ULL << smmu->sid_bits);
> +}
> +

I'm wondering if it makes sense to move this up and put it right
before arm_smmu_strtab_l1_idx(). That way, all the arm_smmu_strtab_*
functions are in one place.

On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
tables. I'm thinking it would make sense to limit the size of linear
stream tables for the same reasons.
