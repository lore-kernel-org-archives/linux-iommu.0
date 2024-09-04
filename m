Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF001D0148
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447341; cv=none; b=PnAjfyoc/hJnvvorEbv++bNJuysGL7xURrnJjRWzvK9m0IBv2SpT35wsHBtE3LTV4L9THS9R5Aqa6QFu6SWXmGI2MDhCBnMZ3F3aFyc/qYkNS0uds0jUtfWYb32em59C9wzSHafzRsom2Hx+N9n/JqPMiNK0vGY3KjeXCMq+pTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447341; c=relaxed/simple;
	bh=cOKW7NUKZZI6Wp4SVULd/68D6NarWm5qu7B4EWb1yQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1CDXha4Ss1+u+YX7GvtJdKUWZZ271Togs3VFtK83J9l6FzM1vF0gzRTc0Xv9WJI8mmjvcoNHbWZi4DSi2Ih7BisaHzFeau2Ince+9u1EvZukMwiVCMiZHzCOSZhF5lun1gODKZ4hfSVb69pGGO0wLPcm0zE4Rk+HnbucU0ccac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9j/N1+2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9j/N1+2"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f4f2868621so69022861fa.0
        for <iommu@lists.linux.dev>; Wed, 04 Sep 2024 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725447338; x=1726052138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+7OAyLujGbFYszTADm1Fbnglj5tVVPCg8cnH8d6UNw=;
        b=Y9j/N1+2vT4I/eLIngzF8ZfFDWfv8ezztIh2jXD4cku/jcAoOrvGwBePBo1pYHghQM
         9e2q4s5wcb4WHs2IoKrAiH0refq7nGbAk/mHC4a3T1PfpoqDYr1p6K1HfiYNDH6HRxwX
         kMHQoHcHmBetobszsuXqmWVyg57OyfyJFBIwEEtCit+6HW0DWLL9cti0IjQhPGKP5dro
         VmTh8qfxyTZEQQj7LAXc4vXh1zSzI7zKf5y2TZWEDJD1Wvx3hyTuFmus8PRalatVR4Dz
         2Av6seRpp6C+J5sb35wyFcX474epLk7A9gKXE++k+CroorPcGtw2zn8vTf7gbEoq8bFk
         2rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725447338; x=1726052138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+7OAyLujGbFYszTADm1Fbnglj5tVVPCg8cnH8d6UNw=;
        b=Efirp388+P9dFn+6Qzqx0NU1+cfh/cv4wR+w+T2yhCeab94+1UECbDUIF0qWJTfadX
         +X8jXidUhaWVy/EQk6f5nW5KhyuVImxWNkpHtyfq8gy7Jr4Di0Zrzf0kTrCSePC1Zyje
         ATHsnFxCkJZx+7jdEVHToWfFnjKdckTxx8elRUvdZO7EGQQztfjlLrFJ/83ulSXG0wpu
         HQWi7Sf2ddEV0l+7YaDjrQBKgYXH/ZgTF/KOItin3YnW0XDg6GNwCEtjaIG7FfgFHEOp
         g3os5gfWiwj0pMhbEk1RDtRktW1foeeC5ol4gv3u2HL3o4vAjmFfXrUeM9ig0OulWa1i
         3/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXHRWeuAqHiTNDPx/2jo4A8QTyjg8WzFOvzCozOb18unTb8NTYsgIMVvgV/8H8uzgulmecD4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUKo6HQvGsR1RvY0Rkmpt9pr/Flzdzs4mOZELvUFPJPgJy4i1H
	JY83L9joTdVi7A0RlLu100aJKBmXOeHX+QbJJ/wZSJM9dEn6uMzU/1URkwON4B4=
X-Google-Smtp-Source: AGHT+IFE66IwvXATV2zxxNEOIEdbkl9lbKAFhzct/n7RvYANLBHuO6JOsOi5ySMCjoe65faREHS88Q==
X-Received: by 2002:a05:651c:220a:b0:2f0:20cd:35fc with SMTP id 38308e7fff4ca-2f62902e264mr101506221fa.7.1725447336786;
        Wed, 04 Sep 2024 03:55:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f6151881dcsm25498841fa.124.2024.09.04.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:55:36 -0700 (PDT)
Date: Wed, 4 Sep 2024 13:55:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	Xin Liu <quic_liuxin@quicinc.com>
Subject: Re: [PATCH 03/19] dt-bindings: phy: Add QMP UFS PHY comptible for
 QCS8300
Message-ID: <e7qsuk3xoqgywubrkejoy3dztae2comlfn3mu6t226mvfvpfof@mlnj5s2xcsjf>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-3-d0ea9afdc007@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-qcs8300_initial_dtsi-v1-3-d0ea9afdc007@quicinc.com>

On Wed, Sep 04, 2024 at 04:33:44PM GMT, Jingyi Wang wrote:
> From: Xin Liu <quic_liuxin@quicinc.com>
> 
> Document the QMP UFS PHY compatible for QCS8300 to support physical
> layer functionality for USB found on the SoC.

So this is talking about USB, but the patch changes UFS. Please adjust.

> 
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> index f9cfbd0b2de6..a3540f7a8ef8 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,msm8996-qmp-ufs-phy
>        - qcom,msm8998-qmp-ufs-phy
> +      - qcom,qcs8300-qmp-ufs-phy
>        - qcom,sa8775p-qmp-ufs-phy
>        - qcom,sc7180-qmp-ufs-phy
>        - qcom,sc7280-qmp-ufs-phy
> @@ -85,6 +86,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,msm8998-qmp-ufs-phy
> +              - qcom,qcs8300-qmp-ufs-phy
>                - qcom,sa8775p-qmp-ufs-phy
>                - qcom,sc7180-qmp-ufs-phy
>                - qcom,sc7280-qmp-ufs-phy
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry
