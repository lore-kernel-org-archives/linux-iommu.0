Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5336AE4
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822636; cv=none; b=I4bAEV/cy7gRAcjeSrTz9TPo4YkytPX65jOeV3styoale25bmLwXRvVT3uKv3WxwnT9ZXfGX5EPyi9JPp40pSXUpkYy6Ccv8QwA/GaRUUQHxh1mn7awXmwHypdG8h7q2/70up10h+dGyReiSuJOVH3aaK6mpL8WKcbyKF1PoGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822636; c=relaxed/simple;
	bh=2eAjV/lUihpr3cGgOqZVqKcZ9gQn/gUSaz5pZxvAkcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTl8j27NcidLulTl0EEdt1WyfCaus8XVvFXEUwlcj5oCxXHrdi2UpSSAWbGMsFaPV1P8P4Rmzygmd/9RtTUs8HmyMo7bechx30TcmrMzaJ9MUwVCvwjrqLmUyat8yItTM4h2YvkzNDAQbztNQxiL2YXg1omAhqkDg0NEOo5+xxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uL9qdWkC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uL9qdWkC"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3322239276.1
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 03:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707822633; x=1708427433; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ou+rxKAaHbbML85Kt1koJK934V+YLP7xcnMtHJXjmAs=;
        b=uL9qdWkC7ci/R+24tnjoupNd+YMo+ElWibwlySVobZ22LQa6eEID5XHdAeItzjNylw
         qJBeZRFSOzz4Yiml2kX0zyBe15pHlzCjRjOWBfh7KimaKbvVO7uzQTGkEZJVcEyK6DIk
         UvfRKdAQlTYqcg8HHmkh0N4g7Pau+I3JCy9mxjyRZhzhCYt9s2+DF4k3NO5HAHMfGJdq
         DdXSOhnn7blBqMNo7z3u1Ks7lTvWPzz6lhY/W6JVAR+t/ewiafC3JZ2AHpS1V7DjNGzQ
         yFXIsm57rnHdLpUCm8ujkfY9AoACU6wEbygzEP6503kkeAixw4uEF7SiZ3mExG+bCktC
         BZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707822633; x=1708427433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ou+rxKAaHbbML85Kt1koJK934V+YLP7xcnMtHJXjmAs=;
        b=XnGSgRdnDD2LFMtzeNlyYcyTpqlZILlo0oEATnmScp+WMh5tmAIhUVO7K78IdWzXgc
         NkVpE4+l4ohtxOHfqMnTLn9d94KQvSLLCPXGbRuJtgM/i4+TIKYuE/cbV7RpH78k2ti6
         yCWgoqkcXtVO1yY45NP/1h0eGjgxwBooi4W377MfWWCWSZmofVTe4AIEv0yRFYNC7+cr
         1E+CRtCq5ZRNCXLirfNrwHSUw15zdfde9TAzGejwoIZ6SH5HUWKUavjkbrvUplohASjF
         CuWyN8WwBTpg7c2XUcU9sEC5zgG0FmHYeU7+45zATJGm3Kxtca2hjjLB1ig5/TJz0SCP
         gEKg==
X-Forwarded-Encrypted: i=1; AJvYcCWrVcDe9PbvEr9WsjWMDQQ8Efw4tD9UPHO8vPBHXSFowDV261VsZqqPDZFlKtwExEVPJ7ctyoVvLySVqmtn5KxfS5pI8aw=
X-Gm-Message-State: AOJu0Yyge957/T32UXBtH7QYcJSuENmCI7IPZv1NBEbaI1K044vThKlT
	vzRkfjkG5pLqSo4oYTKzzhRw35dAS59jA2Rztvk/uLLuZ4FUo+n00XfgDSiFzZbsYAl4No/2taW
	ezCc2fyTq11t0dFIIcQsAe2xtaqKqnyrUHfV9Uw==
X-Google-Smtp-Source: AGHT+IEeEeSBcZ/sB6u7T/sqmPls2dQZZl/LCtnYYAwE7YzlZ4/C1fbTiGX3NHjTUOn8UG5vNpVHmaaB7Z2L9ykNceE=
X-Received: by 2002:a05:6902:2607:b0:dcc:5b7e:ddfe with SMTP id
 dw7-20020a056902260700b00dcc5b7eddfemr1248774ybb.4.1707822633587; Tue, 13 Feb
 2024 03:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221114170635.1406534-9-dmitry.baryshkov@linaro.org> <a61a3561-0dde-472b-b8a5-451703f6d8ee@quicinc.com>
In-Reply-To: <a61a3561-0dde-472b-b8a5-451703f6d8ee@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 13:10:22 +0200
Message-ID: <CAA8EJpoJUZDUxpA1+LJTEVRaMQJrpZ7iU9_dZ3uQvzPKE_UUfg@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] iommu/arm-smmu-qcom: Merge table from
 arm-smmu-qcom-debug into match data
To: Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: andersson@kernel.org, devicetree@vger.kernel.org, 
	freedreno@lists.freedesktop.org, iommu@lists.linux.dev, joro@8bytes.org, 
	konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	quic_saipraka@quicinc.com, robdclark@gmail.com, robh+dt@kernel.org, 
	robin.murphy@arm.com, vkoul@kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 12:29, Pratyush Brahma <quic_pbrahma@quicinc.com> wrote:
>
> Hi
>
> Patch [1] introduces a use after free bug in the function
> "qcom_smmu_create()" in file: drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> wherein devm_krealloc() frees the old pointer marked by "smmu" but it is
> still being accessed later in qcom_smmu_impl_data() in the same function
> as:
>
> qsmmu->cfg = qcom_smmu_impl_data(smmu);
>
> The current patchset [2] implicitly fixes this issue as it doesn't
> access the freed ptr in the line:
>
> qsmmu->cfg = data->cfg;
>
> Hence, can this patchset[2] be propagated to branches where patchset[1]
> has been propagated already? The bug is currently present in all branches
> that have patchset[1] but do not have patchset[2].
>
> RFC:
>
> This bug would be reintroduced if patchset [3] is accepted. This makes
> the path prone to such errors as it relies on the
> developer's understanding on the internal implementation of devm_krealloc().

realloc is a basic function. Not understanding it is a significant
problem for the developer.

> Hence, a better fix IMO, would be to remove the confusion around the
> freed "smmu" ptr in the following way:

Could you please post a proper patch, which can be reviewed and
accepted or declined?

>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 549ae4dba3a6..6dd142ce75d1 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -463,11 +463,12 @@ static struct arm_smmu_device
> *qcom_smmu_create(struct arm_smmu_device *smmu,
>          qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), GFP_KERNEL);
>          if (!qsmmu)
>                  return ERR_PTR(-ENOMEM);
> +       smmu = &qsmmu->smmu;
>
>          qsmmu->smmu.impl = impl;
>          qsmmu->cfg = data->cfg;
>
> -       return &qsmmu->smmu;
> +       return smmu;
>   }
>
> This is similar to the patch[4] which I've sent in-reply-to patch[3].
> Will send a formal patch if you think this approach is better.
>
> Please let me know your thoughts.

None of the other implementations does this. If you are going to fix
qcom implementation, please fix all implementations. However a better
option might be to change arm-smmu to remove devm_krealloc() usage at
all.



--
With best wishes
Dmitry
