Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6C16DED3
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862448; cv=none; b=cja1iF0hvWtF3bO+QhRWvFIZ39xTePuycy/QJSARnNU+PSy1LTr37xwsXIwFc4hJdzB3ysrd4cumrX8HHCeJ78z3hCtSqWKIEY57KgzczksVuqH2XGlsCy65sPuNQOMoUwFijZyIWHbv/zGSUPuSjkDeMTBZdd+ENHlEsI5qglc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862448; c=relaxed/simple;
	bh=GqWUmN8vicjOeJLEWfrNOVZ7nMrI1gyKg60+lcC4I1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=if9mayBxRowduauiR0+dPAUMIyqvtajAfJ4gYxewzLC9i3z2BOOmc+0YNKVY5omGaPIpBKWxhNwWBCp0gko2mR+MbgY/SybvWMNbpzT36JuXL/5XZ/ByU5+XaGNNbp68r1IAFs9fVE4SbCgwyA85tkswVz+A5RBkpXpXN3SQDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWF+4U7c; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWF+4U7c"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so10920a12.0
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719862445; x=1720467245; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLv8nBE8MAPhTzu4Pe0VYjku1Tl2AHNOOkQcp9/ZdEI=;
        b=DWF+4U7clcNn6B5G/CFgPnlfWllZOTmNi8xvhGAKKKclOhyYRMTrSxS9DdHIbDQ2DX
         0E41z9BpS91Yrzcm8E5VIe/0t6IwAp7vf8zgM2gSHsuCLxdVuU/JZ7f/BB5iDGArzbkM
         VlNzfRsuart/mNBCUf3Em5JlTZ1YZOC74TR7F83A2HuTSFHDdam4pFXX2LhYSXkd0SB7
         OtItZn2dxrLjrEeFWiBajHkZb9mPNh9P91EM0Vgs4sMPlhLo9q+yrA0dR7LBA1cXr+Lo
         325Eomix3nvwYLKibOlMZ6vDUrPu5VqHl9fAMQOR/O9QXpXFMrJyEYuWDfBM/VBxUx9G
         0g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862445; x=1720467245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLv8nBE8MAPhTzu4Pe0VYjku1Tl2AHNOOkQcp9/ZdEI=;
        b=rZYgb+eXT2HHtVjoHRh2V62EG6R3abirvlOJqbQXrxr9vFTiV1v1ihpRImxPh8Uudk
         OZ2s8Agt7fnPcEwcsfvOq66M4RW7KzKYGnDwWvwxmVUAnC6lxf3F+vRT9cjJwfFDjRAb
         IVwGSxa4jGiOrPYGxvVK5b5uK2G8hAeNcE9anAhcP7tEUutf7hc5KfbxbX1360CeFsTN
         145GIcp6QsAych07/29HR+KtY3DPLF35dvpe7wbT5oNu93EuSS3POzA0oyvgr1A+vkdm
         XCsElAO6f8BHgsMnceyDz928tASOPCbMNMnH/MyvIqkdakJUX/lCbp2v8yBXiRNn7VRg
         KOmQ==
X-Gm-Message-State: AOJu0YzeqtVUW7EeAb612gOO8Q1xvqS25Utn/eL25jalykkPqg61JFLg
	Cw32zjuvEYJMAZjnINNXvgSRO/8319HmW3MvHsxhLbJ+4dSit1+646UO9j+RmzuSmiuS2/JdgvG
	fkvKcCb2xCNv/neBVhd4rakoMXgHniO7xE7+Gbbzcod+VsdbT2V/sQKM=
X-Google-Smtp-Source: AGHT+IHXcfFF7nEh7bzw1aPRlCKzpCzTU07EXQDKT9/pl7Y576hP+SUgYE1Vu8uRmhB5tC6qEWbDsk816Q4QLs3uQtc=
X-Received: by 2002:a50:9308:0:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5872f79a720mr442372a12.6.1719862444542; Mon, 01 Jul 2024
 12:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240701162025.375134-1-robdclark@gmail.com> <20240701162025.375134-3-robdclark@gmail.com>
In-Reply-To: <20240701162025.375134-3-robdclark@gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 2 Jul 2024 01:03:52 +0530
Message-ID: <CAN6iL-TV3OGN4eDx6yG9u9Y-2tEn6NS9B3Vq5ijAoFvJ71PssQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-qcom-debug: Do not print for
 handled faults
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:50=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Handled faults can be "normal", don't spam dmesg about them.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/i=
ommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> index e4ee78fb6a66..681fbdfc325d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> @@ -419,10 +419,6 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *d=
ev)
>         tmp =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
>                                  fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_F=
AULT_WRITE : IOMMU_FAULT_READ);
>         if (!tmp || tmp =3D=3D -EBUSY) {
> -               dev_dbg(smmu->dev,
> -                       "Context fault handled by client: iova=3D0x%08lx,=
 fsr=3D0x%x, fsynr=3D0x%x, cb=3D%d\n",
> -                       iova, fsr, fsynr, idx);
> -               dev_dbg(smmu->dev, "soft iova-to-phys=3D%pa\n", &phys_sof=
t);
>                 ret =3D IRQ_HANDLED;
>                 resume =3D ARM_SMMU_RESUME_TERMINATE;
>         } else {
> --
> 2.45.2
>
Seems consistent with the arm_smmu_context_fault handler.
Reviewed-by: Pranjal Shrivastava <praan@google.com>
