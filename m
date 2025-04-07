Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638E23ED5F
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027753; cv=none; b=gu4Vv0R2tk9GxO9sf0h4nMu1Uv3ER0bCg6nOrLzfRYfMQgl58fM5+X8Ic4vdR3PN0VdpEbJBOlUUuFHC7u+QjKgx8GOx785X8tREhxeH9uspxVDeEBAIFCsvmH1iFhtOSek/2QF8RYjRjHLpyy26lP+sGkzAp93PHZTMase67cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027753; c=relaxed/simple;
	bh=sBCQHBDcAUpG17ddyItmIuUCIWSKR3D3zFJjSYLtoVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQyrvv0p/pArBw649w6MankpkfQ0SwEWY5U5fziBteozEOE8w4lpmace/kKDYTFkpPZfNgAh/UYqLAk5+uHIJLl+Ip62MGbVX4M+/ORMohX2EfTl1eq0JAifD9PZjffme+zTxrtdBF9YZ2Q443d8vG6Wn3tUgjA0t3JTBoMUOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C2RVR8Sr; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2RVR8Sr"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so41102381fa.1
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744027749; x=1744632549; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/LHFPsYBw0bwDf6dVcpDSJnHybANIimgmPtryFgNPA=;
        b=C2RVR8SrbNQ+fE0PozX/DoFhUwLBuyMH/ErECJz+JJ/llnu2TF702c9+LFor0yfTzB
         NtkHh2HkegccaT4r1uigII3y4Pp+ATZQAabaxHAoLtBWoOtJijF6QIOHWEc2cfKeWZDP
         fwdX+jdU0OB6RbP2OqA6kX9mV1DNc7w52os/0c41wGkWnWAmrB/Z2Bgy3MUUjFsebxR7
         XGHU83i10hwrHS65DfcSsorDf9Clp39m4wV8nZgWngZUE6GtlrhPRZ4d0xhP05SSM5b5
         tqX76/ce2wVx4Hmy4OpxLEGO7iD7e7cKbAmJinHgoSM8cp2JajemevtY6TSs/wZjige3
         jpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744027749; x=1744632549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/LHFPsYBw0bwDf6dVcpDSJnHybANIimgmPtryFgNPA=;
        b=wescGnIP91Qp+56PfaMao0X8ZIQY8gJqqFbuytuapO86bIcs10Me31XUxjUSBhHQBI
         GgkJYUz6k/q+GfYoPccbBMXKAFxgHIVx+hMD14meDlj5wzoABy9Zbcr90SquLBKETNW0
         PQcxRacBtNamONLfEwfavuNSpxg3cVORq0XT4LkCxnkpO5rb98rnQ0CTgM2OmYJiXBaW
         8iIDmh5c5GtlhnOU0N48/YOohfBradPrLuo/B8ufbyzR8Gxv1Z+Bg/KUV54TaC7lTKFf
         tEPKa/GRieaht6nqMQ2oAHj1sXvxiILAjR+LIgag0CxnU11CJZlC/0ZMP7b4ZLN37BXs
         HxVw==
X-Forwarded-Encrypted: i=1; AJvYcCWUZHJg02HYs4RKrhQq6tV7wMpm3k+iLFPqQEc7vqyzlYWiCiE+B9XxrzllAnzY1mjSmcsIWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8aP3d6O9jesYAoWo7pYseG+zLC3t+f5CFGCzFTvJUyn33gBbq
	mrkLgnPnCNhEzcU81WqJJNxuqs4vBZfWKty7hwFwyczrOwVHNLrVVpMtBEGbzQYE/9/Jn2gxfPG
	dXfdUS1v/NrMYJW2bpcnJv2Xcv6Ie7ut0F/gZ7A==
X-Gm-Gg: ASbGnctBqTpOv3BTuERvbxqSEM24zjkOvoLHeLYaGch/JN2O+bYPhR6b2ybYSW09cOD
	+dlWWy8k+4vV/rAF/96v8DboCpViVXK6R8GZA9m2SOF0lHl49iZIXoV4fKUUX9ZfvtY41WVslrg
	KNpqcNkBRPR3p3Y/BclynTBFkDRFy0AZbyweHHPRMhJg==
X-Google-Smtp-Source: AGHT+IE7avfocEmD5lqNIyS63JcSTkkwf3BvTJpAGhR9l+oQoFSuLjrFiN2oMnoA2mOmJOAmlfiARgKB+FZMo6LuuCU=
X-Received: by 2002:a2e:bc1b:0:b0:308:f580:729e with SMTP id
 38308e7fff4ca-30f0a180dd0mr35506541fa.27.1744027749231; Mon, 07 Apr 2025
 05:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1740504232.git.nicolinc@nvidia.com> <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
In-Reply-To: <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 7 Apr 2025 20:08:57 +0800
X-Gm-Features: ATxdqUE-WE2mGG2qPqESoLiVUp7LnTlD7II4G1YhfYdYp1Eq06d5HdYvjf8h2-k
Message-ID: <CABQgh9Fuh2HdBH7pyAteawZBpa55ZzfR9dv2K4RF=Ps4yhREbw@mail.gmail.com>
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, 
	joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org, 
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com, smostafa@google.com, 
	ddutile@redhat.com, yi.l.liu@intel.com, praan@google.com, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi, Nico

On Wed, 26 Feb 2025 at 01:35, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> be the first use case. Since the vsid reader will be the eventq handler
> that already holds a streams_mutex, reuse that to fenche the vmaster too.
>
> Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
> or unset the master->vmaster point. Put these helpers inside the existing
> arm_smmu_attach_prepare/commit().
>
> For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
> add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

>
> +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +                                   struct arm_smmu_nested_domain *nested_domain)
> +{
> +       struct arm_smmu_vmaster *vmaster;
> +       unsigned long vsid;
> +       int ret;
> +
> +       iommu_group_mutex_assert(state->master->dev);
> +
> +       /* Skip invalid vSTE */
> +       if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +               return 0;

Why this is removed in v9 and 6.15-rc1?

I tested 6.15-rc1 the qemu failed to boot with qemu branch:
for_iommufd_veventq-v8
"failed to attach the bypass pagetable"

After adding this "skip check" back, the qemu works again.

Do we need to add this back?

Thanks
