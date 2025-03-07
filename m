Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657D1917F9
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326506; cv=none; b=YgWbWxUM8zIhHKTIBu94Ttujf6rkkTaclmxpjgltWc+/bevKC1SvW6IcBAe6/xjOGeuZoSm936vS+21ApRQSZrivpOHqAnZ7KM7x2phUJheT69bRKlN3nnfJm/4zt8EQzwZeC25UgyTA/8znCFTg76yFxHAWMsp6I9SCpxvzxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326506; c=relaxed/simple;
	bh=7xvEUPrOQT15JKJTO/aintccF5IU0wvr211Eyg0HZ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWv7buu906sfd9ki/goKNMM6ek9MnrhM0aV3PYQLazJNMyTQaVGS8RhI5RcaNyTrM95SUvMY3eJiD2ngXm+vrO6om/ngpuWEft7P8FIJHyUmnMjtGd/Q7SVR1ZZc4l+Hy8r9DrqBg2ibiMEKNFhco0cgbphbPi5fJdjzJ9gSTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CuHzGys9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuHzGys9"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so15117221fa.1
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326501; x=1741931301; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBJJ6mH3Lq4uasqO2w/mLpbOX1gw+uVajo1XywdLac4=;
        b=CuHzGys9oMthqkWBueSeyOz2vdKkohNS9IcXDmF7z+WbPglhgjzRiIpxVWAuqW7dNH
         ol7FeakTZ/7wrAvYk93loONqR+qp5P6mPjrpwzUcNzace6c7SXqifIT0sibOACCP2OPo
         GBNflbeMqhKYlEvzyUuQTGy5kNfRTueKotwjAKwDzxTBWrWJQuKLL+fgJeECBVaxXw1V
         SEbio5IFBCh4278Q9WFZ0x2Ev1zXR/MzvKMy9OWahmc4gB/Prxz5dEaVo2Elp5+7Qhhq
         KDCfVXLEV7U+sXqqY3bSxx5ZNJosJa8jdGweLiBs0sWZdFhNu3f+CEciQ+h2cE8eqQgN
         5IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326501; x=1741931301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBJJ6mH3Lq4uasqO2w/mLpbOX1gw+uVajo1XywdLac4=;
        b=a9SJZDy7euJ55Qc5Y3RZ2adfkymriFTnCyJXYI44ChGtNiWXYHC9S7KAiVRvLLsnMR
         sGoXeRnbNHNHtxlVat/2AznHYxHFr8UbJZORn5f5nHWWcU9VIZgAFPAw3Jfxyd4R39uL
         VbwKApP4kda+OBrmrjYSHmpj7k3HunoLMAdD37+gsEek7hl6Zie9rDzLNCbEWhNsjExH
         V/cK10GHi0+8Pi6iKoXVQhQNKAOiTDfhw5V0RvcORfiNknAne4Hh8E79j/kroF3JQQXo
         ruKRn5H/tGSqFkp0TY4Ay78AG6qawFUkaR587ZHei1PSXyW9jfT52Re6teMKgF9Jp9dw
         WQIw==
X-Forwarded-Encrypted: i=1; AJvYcCUG3q9CYzKOb1ydB2qH5JOWOUwdBwKi68L/Lxhygk4E5L0gSwzsUywDLvGP/h0ClkNMSylL/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAzdTBKV0+EDwR5FUMzknM0ciI/r7v9TOWMHoE/b26yvIcZ7OA
	p0/qPc0r9clv1ED13/YoHsjsS5gJuWdN6Akg7yPS9ajlEMZ5F/ijeAUEFo/75tw=
X-Gm-Gg: ASbGncu0E5y2PkpiVuKNf2XByDZp4SpGwWvXpJ+5AfjYdYUwtBJ/PqFqI9o1x0ehq5k
	9o6CRoatNKsJ25lTqM6uyAbYtvzt4JAls3D6M0TD19dwL1yBRbBeU6axRi7fiP/XAqwRmPAHM74
	DbGRxDR9NkBz2J7Sqrfg5wtEbUlGK9KOR5YX9RiBWcLFt+CI7XugUqzQjLiANJZZWZ8+KwsNnrj
	Ep6qa9jkKynX/bWFIbcuiGkrsx+i8EGy6OZpHXq15I+QkGACTkwq99EzhHWVghk2Nd1PPp139ry
	gHUJQKEQfkwKMWEcjCiEXOSzLLpQD90OU6Q7Bsway4K8V0iH7Gyy1MtOoz7+TIQXXsnUyHH8msq
	w8qToQGD4dKSxthy8r+/i2uYn
X-Google-Smtp-Source: AGHT+IGmsERqhfZqLPyNL7GHC82EoyeyaDNDfDa4E87aEDrWxyBlXoZ/5KIqAbmzZjDQsHi6vMCl1w==
X-Received: by 2002:a05:6512:3d8f:b0:548:de7f:b3be with SMTP id 2adb3069b0e04-54990e5e265mr590371e87.21.1741326501038;
        Thu, 06 Mar 2025 21:48:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae579a3sm380848e87.53.2025.03.06.21.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:48:20 -0800 (PST)
Date: Fri, 7 Mar 2025 07:48:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Robert Foss <rfoss@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rohit Agarwal <quic_rohiagar@quicinc.com>, 
	Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: msm8916: Fix KPSS ACC compatible
Message-ID: <5e3i5p4er7hcqsm55nf2qjvegmoozntq2aqrpk4lvw43ydlvcl@xsgxgx4fj6zx>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-4-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-4-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:16PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The current compatible has been used with no corresponding
> documentation. Replace it with one that has been documented.

qcom,msm8916-kpss-acc is also not documented. Most likely you meant
qcom,kpss-acc-v2

> 
> This has no functional effect, as these nodes' resources are only
> consumed through a phandle reference, anyway.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 8f35c9af18782aa1da7089988692e6588c4b7c5d..33a28f8163dda0e53f4176d61738ce175efc096c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -2574,7 +2574,7 @@ frame@b028000 {
>  		};
>  
>  		cpu0_acc: power-manager@b088000 {
> -			compatible = "qcom,msm8916-acc";
> +			compatible = "qcom,msm8916-kpss-acc";
>  			reg = <0x0b088000 0x1000>;
>  			status = "reserved"; /* Controlled by PSCI firmware */
>  		};
> @@ -2586,7 +2586,7 @@ cpu0_saw: power-manager@b089000 {
>  		};
>  
>  		cpu1_acc: power-manager@b098000 {
> -			compatible = "qcom,msm8916-acc";
> +			compatible = "qcom,msm8916-kpss-acc";
>  			reg = <0x0b098000 0x1000>;
>  			status = "reserved"; /* Controlled by PSCI firmware */
>  		};
> @@ -2598,7 +2598,7 @@ cpu1_saw: power-manager@b099000 {
>  		};
>  
>  		cpu2_acc: power-manager@b0a8000 {
> -			compatible = "qcom,msm8916-acc";
> +			compatible = "qcom,msm8916-kpss-acc";
>  			reg = <0x0b0a8000 0x1000>;
>  			status = "reserved"; /* Controlled by PSCI firmware */
>  		};
> @@ -2610,7 +2610,7 @@ cpu2_saw: power-manager@b0a9000 {
>  		};
>  
>  		cpu3_acc: power-manager@b0b8000 {
> -			compatible = "qcom,msm8916-acc";
> +			compatible = "qcom,msm8916-kpss-acc";
>  			reg = <0x0b0b8000 0x1000>;
>  			status = "reserved"; /* Controlled by PSCI firmware */
>  		};
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry
