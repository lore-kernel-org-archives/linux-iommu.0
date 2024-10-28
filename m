Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1D1E103C
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150006; cv=none; b=uJkWfCM6ys0wU4GfZSwBvqqVbiQSkCtOf8LcULpCz+cecGLCWUFuI2Y8kKBh5T7X6z/X1yXb0LllgWPt/tdcrTfnc6Cd5rdW7xr3VpbSzUjex4sAxfzygnIcACHKYlhzEfvXrPcI8DkP79/PUCUnqPidmUXGRAiARM91Zu1ymsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150006; c=relaxed/simple;
	bh=d5BFcXNUqFTM8OurXCjOwxs5acS94lCrZaglLt2fauQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCHQY3TKf763d8JYxhHNk1QyG8rDCERRe7HTZ95ttc1jCKBiatZsH0jRzJno3HkGqz8GPxpPklXa+E1lznEp7xOBE/f0O++eiYZLHG8fcvxpBVUWm9FqIATT+SghvplCTSZq//i4efGdBvNRsz0jHfO2cYRCtMl1Ywrc5So6rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxfZQjEe; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxfZQjEe"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e40a1d7eso12734385ab.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730150004; x=1730754804; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGj4nvrYi+UV4BMXSEK74nk2UvFueWrFMbcWim1QgII=;
        b=LxfZQjEemm05JAbO4Wez7msIpk5aPJcZzHNGLY0JDP+eu4K22e0gndNLIRiuvOXCKi
         FxgD30z02WNRjM0rnfJLzh+exjkDEDijZSewXR3NmoZnXZokS80bh78L/NZlS8vfQWX7
         tK1hUPVMQLHIid6NX3/Oo9llwZlPbWuY30D0rAkKQMlPpjiA+39oHKW2+gVEZZCyJ23E
         ZbV4sEI551430rkhP2VD0i7+U/M05d6G5a2kLGxZWIFaina6C4lVmO0RgMsdQzucVEX7
         5+rTsD/hQjK6mV8lr4dmzZUxQqHqCtqZSCw76/4s0NeER3xdWfJpzWyNbZVFt2juMNGk
         oiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730150004; x=1730754804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGj4nvrYi+UV4BMXSEK74nk2UvFueWrFMbcWim1QgII=;
        b=tPqm6saGMKTaucxf2kV9pptg0EeCtUrwWbQiRTc/1yO7NpWICSQcMGFUC421Kjhc4X
         QCcQypoOq51csIXHZlliQFYOCMrM74Z4nQj+CpS3Cn9n5B6sW7EoNbe/Y3wEKYfzT67Q
         CRKhUqnp9+wZvm0pKnAoqkCCDhswXDUVNI+Hw12WLcAQZzm2KTKK4ECk6BLUn7uI3j3O
         21ebBitRopn2lqoxQx9PjjmmYEyOXeyNB3ZbOUALLFAWI7Aw7LWX5sNO4MrTYbbutL2c
         6zlSkGXj94hA+6NywUBi34kUHWCANWEbx+oxPSG5BAEjoQUEKfZj7Qp8mE/yyUxOJPfK
         yI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0SjrpbS1+UkD/Iyho/wHTZBwSsV6QcHWXhEHUaegk7EOU0OceVtdslC7bqkc2GQvTaxjeOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4jeGM5tqNMOUGPiE/Kdy9wdimbWoNZjAYfw3/LuoBA9U5+7Fn
	hi3xuBolKhajigw4LMLCEQH1Gp0WH3iM2qR6FqSt/8JKfNs/+oyz1EDjWtLHzZpkdg3qromNj0h
	adD07BsBUT0n5apxQyIcBJGKQJzY=
X-Google-Smtp-Source: AGHT+IHkAip3QtvMIsGAcSCjbt25YJnHoEeUIt+TrlK362ycmT+j63k00KWrpG0VJyorocPL41G3lK8a2TaMD61ih3E=
X-Received: by 2002:a92:ca4a:0:b0:3a4:e308:2f5 with SMTP id
 e9e14a558f8ab-3a4ed1ba8camr91673605ab.0.1730150004074; Mon, 28 Oct 2024
 14:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com> <20241008125410.3422512-3-quic_bibekkum@quicinc.com>
In-Reply-To: <20241008125410.3422512-3-quic_bibekkum@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 28 Oct 2024 14:13:12 -0700
Message-ID: <CAF6AEGt6xNe5VpHq=fiz03M1_m+psn8ouX_uuRgRV6=kthfF+w@mail.gmail.com>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: refactor qcom_smmu structure to
 include single pointer
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:54=E2=80=AFAM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> qcom_smmu_match_data is static and constant so refactor qcom_smmu
> to store single pointer to qcom_smmu_match_data instead of
> replicating multiple child members of the same and handle the further
> dereferences in the places that want them.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/i=
ommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> index 548783f3f8e8..d03b2239baad 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> @@ -73,7 +73,7 @@ void qcom_smmu_tlb_sync_debug(struct arm_smmu_device *s=
mmu)
>         if (__ratelimit(&rs)) {
>                 dev_err(smmu->dev, "TLB sync timed out -- SMMU may be dea=
dlocked\n");
>
> -               cfg =3D qsmmu->cfg;
> +               cfg =3D qsmmu->data->cfg;
>                 if (!cfg)
>                         return;
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 0cb10b354802..6e0a2a43e45a 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -534,7 +534,7 @@ static struct arm_smmu_device *qcom_smmu_create(struc=
t arm_smmu_device *smmu,
>                 return ERR_PTR(-ENOMEM);
>
>         qsmmu->smmu.impl =3D impl;
> -       qsmmu->cfg =3D data->cfg;
> +       qsmmu->data =3D data;
>
>         return &qsmmu->smmu;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.h
> index 3c134d1a6277..b55cd3e3ae48 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -8,7 +8,7 @@
>
>  struct qcom_smmu {
>         struct arm_smmu_device smmu;
> -       const struct qcom_smmu_config *cfg;
> +       const struct qcom_smmu_match_data *data;
>         bool bypass_quirk;
>         u8 bypass_cbndx;
>         u32 stall_enabled;
> --
> 2.34.1
>
