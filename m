Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386417996
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811624; cv=none; b=b9Qk9l7vOZdx/qLzzi3zYUW3RG3Jkf+pbchQXG5+k2nZxuZGAuRXebRVj8+ezqiY8K2+Um8XhCaQJRe0hNFIM3aEujAWa0lDoNt2TENlcyRDbn6VRcTIWzHUpq+dWlppM9L6KpaIqTr7kXsv2TSDn/ubgnWPZWGv0+Iy5bLnXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811624; c=relaxed/simple;
	bh=TMO98LmTeFWaooCAosxSAV4g4gfDcC8Mxcbv1f1b7yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9rOaY66ydAjrfXbKturauksT+THziVU0xBjjTW6lwrVbL6vxD9T7TR1iOYSelxEUW9TT/NQTMSkGmJ4UHetuZs8V2ZO67Dt0Ow0bGSUdoa4wiGQGWbu44Ax4jtyWWuNSwdJtzukiy+V3rtcLqvezyFyqVVK+R5BtEzYJXxmfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4pnrb1C; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4pnrb1C"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc660ce7a2so494410276.1
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 00:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707811622; x=1708416422; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LoE7SaCuCYZTXnO1AQekF/KrLmOVDpMhP6b6ysce880=;
        b=Z4pnrb1CsIj5cGB3nsxBs+vxnTU4h5DRg4A2AcinxSXpLnT/wi4GOCNrbKGlOlrdfO
         tag2eUU6Tci2Q2SUol5Cnpc6IAZ8cfGC8eJfZ513QaBeVi45dHOoN6Acb5rI1KAOcSHj
         fVvsXECxS52AMY0+c4dL5gwcbwOB04eQjEVEUY1XcC9iqozZhuS8FqXEx5R7wNSk6RFq
         78jfUCtqBqKreByV/BTG7ltKoINesOTj/KMPLemRqr08cmx0aMjNx0RTcW5a7DEUBn47
         oSZAhbt6ytoAVC/yh1sN7W9NJ7klNsdvLjhawZs2pAOCecWsW5p/cjJYpQiPDGJsirqm
         jI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707811622; x=1708416422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoE7SaCuCYZTXnO1AQekF/KrLmOVDpMhP6b6ysce880=;
        b=c5RH1uNjPwGOz04fsZABz1mhdKOsQ4VrE0k1WGy/IrtiabbT2N+r1RpZqbaGD3E9SJ
         j42I2KaiPHOEXSVFcqimw9u5r4GypYKIk/ssfMwOI+T2W5qtDVgasXWUxyHJ1JTjvMrm
         hiK5pGrW1BogcbUWASLbsG0R+gwxYaV6e1wpXoCUXBsugYwj40zJC42Scrk7i73kUR6H
         KVA8PIBjDb2TW6RlYVwKXMlme2ueZzxLcdQkbmLegm2h74FVD7wk2s8qTtfDdqOtJI+X
         ZomKJBGlPtAIKy5G6InlLhXdoRtGtttkJddI5bNOQU7gQda4aDk/098eHwNQnpDm2ugS
         OOhg==
X-Forwarded-Encrypted: i=1; AJvYcCUaJdu5cESDwS8r72zpl/1NKf+yTqyZYzQXXdsjdCZnzmxUhzT+DBSYMkyAl7xgT97LySsba3WdTaJ9ucaFbFXbE6BaX+M=
X-Gm-Message-State: AOJu0YxUp+zaGqWc8jbD2euJUhlpLRYFVPopwgWGocGJ/8XWoNh053QK
	rSE82bYNpNNYnVcyzVrqRUqtCdF5+Zxay6bBOfX93Xkltc2NORwehtYmJJjUT1Ix3id2nHrYqb9
	/k/PfOeJtOf5sqWviBM7KF42QWbUeXZzh6Oj2czUfp9rRwjPW
X-Google-Smtp-Source: AGHT+IFJmNGwqkSI7VGiPpEbPYK61g9bG8fKHxYPKHEEFuP3n+/ab1e0w0YV5rg3cP19wA3QJhBHdbAVAxvLdL0n29I=
X-Received: by 2002:a5b:18e:0:b0:dc7:4564:fe6b with SMTP id
 r14-20020a5b018e000000b00dc74564fe6bmr6581471ybl.60.1707811621907; Tue, 13
 Feb 2024 00:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201210529.7728-4-quic_c_gdjako@quicinc.com> <20240213062608.13018-1-quic_pbrahma@quicinc.com>
In-Reply-To: <20240213062608.13018-1-quic_pbrahma@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 10:06:51 +0200
Message-ID: <CAA8EJpoh-m_fzt9WcUXOkTxVZRQMDf-WrgqqoM0C_-qzjgDm1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: Fix use-after-free issue in qcom_smmu_create()
To: Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: quic_c_gdjako@quicinc.com, andersson@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, djakov@kernel.org, iommu@lists.linux.dev, 
	joro@8bytes.org, konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cgoldswo@quicinc.com, 
	quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com, quic_sukadev@quicinc.com, 
	robdclark@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 08:27, Pratyush Brahma <quic_pbrahma@quicinc.com> wrote:
>
> Currently, during arm smmu probe, struct arm_smmu_device pointer
> is allocated. The pointer is reallocated to a new struct qcom_smmu in
> qcom_smmu_create() with devm_krealloc() which frees the smmu device
> after copying the data into the new pointer.
>
> The freed pointer is then passed again in devm_of_platform_populate()
> inside qcom_smmu_create() which causes a use-after-free issue.
>
> Fix the use-after-free issue by reassigning the old pointer to
> the new pointer where the struct was copied by devm_krealloc().
>
> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>

Missing Fixes tag.

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index ed5ed5da7740..49eaeed6a91c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -710,6 +710,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>         qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), GFP_KERNEL);
>         if (!qsmmu)
>                 return ERR_PTR(-ENOMEM);
> +       smmu = &qsmmu->smmu;
>
>         qsmmu->smmu.impl = impl;
>         qsmmu->data = data;
> @@ -719,7 +720,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>         if (ret)
>                 return ERR_PTR(ret);

What is the tree that you have been developing this against? I don't
see this part of the code in the linux-next.

>
> -       return &qsmmu->smmu;
> +       return smmu;
>  }
>
>  /* Implementation Defined Register Space 0 register offsets */
> --
> 2.17.1
>
>


-- 
With best wishes
Dmitry
