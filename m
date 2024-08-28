Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C41ACE03
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878117; cv=none; b=XA+ElJwsBy992/NisYzhlvQW+UJELHQXcbAcfD0JAGbYxD9UuAmfEad0JMyervD9UCNWuuLyqKcQuYGFezjsL+va56NfLLpSIRPatYy9tIHPBmL2KbXrZVLX1p7JqDDvFRo+5MUkW94qPyS/TQ9GSo9ULorxZmbyA2YnCRa5qZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878117; c=relaxed/simple;
	bh=mWtLZVmxV1cL27U/O9IqvxtL6Ujyj7wOyW+QqP25l+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b68nq9yCt2vOJOv6XpbLib+8NyD1Da6RUfdDefZa8+p6mFbNS9j0VoGI2wROUZUcLhlxjHo7a/gHHF29lSH4pgM6cRLvZkvfo9BZdwHURGRsXKbu2B/m+JzprPRo+nTgHKoZ+2nNg4Ri1oKGfWI3k3hE0LE4SlE9hDMoIZOfSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aGGXV7nW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGGXV7nW"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533463f6b16so8461097e87.1
        for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724878114; x=1725482914; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzBlgscRo4qLIY/HPizE/St9vcbsZemW12ICbFPgg74=;
        b=aGGXV7nWqIgMix9TtE68HpM8HtQzRnCFAueIeY71I45TQzwKaSAZFNbA/RH/B4oGEd
         47HP0oOcWiwS55+9EOXIgy+wGnGQGi6DsKLbUUiDow3z2xbaXhLSdPpTVvpQ9izgqY5g
         /xzcTkKn8eEUjeLHu/fzHYJnryFgAB2cKZcmPyF2VlP2DUmIH+2LqM1dz7n87gZtpyQ4
         E4sJCOBcoxo25Yl5nRh8md9Eu3EZUG5xOxviJsCtWL6dIq1h/qTbKnbdAA2HiU8F/s/x
         H/7geXix2CvrR0kF/C3usEQ8xqurpgxroBlF5oiPaGNGLvbsu4dGw8vGuBtVrjFKERnS
         T9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878114; x=1725482914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzBlgscRo4qLIY/HPizE/St9vcbsZemW12ICbFPgg74=;
        b=N1LDwbKZtlOoGf7sTZVAR1TOG1oM2U0KfZHbWG6VfSi8J3utZH4jCTJAs6cQttIXHG
         7Je/mY9Pkg0wWWNb4kZzuLSuWi5ak4wDQA+h9R2W+egkoxbiLLUrEQwz+AzMvjQ9Eb36
         y6acQPVv/DF1H9T573pn/vWON5AwRr5HgNaio5bEFiAZ9wJxovFflgADR5wF+QTmxVoI
         PJHTiTFJuixpyBMOmTOTyIkieNCqp8guXkEFqM0nyMGzhCNf0/en70F5O08k/nd8EiIr
         hU7Ou+UbV2HPiaDYzSYUPSoRU28siUnTO3zjE9A6KOt7snTIlPKbhvDTXRMzZ6+tKA/P
         +8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsC058EDNszEBpLX1jpojwnzTu+eEItIUR1JBLJxTe95CV7LBM6HSyxjL+5MmnDuWfEb+Fng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb9B4s5vvHWtTKoQ6fZRT/6SGE31BJl+5wLe79wWyaeUXP7cq1
	8pNLpcNRSrwVzaUy2H4Xz6ypHiltDEcj+nZdb34z+4QZejJPQLqtqPvAVKeFTUA=
X-Google-Smtp-Source: AGHT+IEWLxH8aizXRyTRgoMCFNNl0fWj6ZZLIUOy0gldXquj9BCL3ipA7VZggNVVXZZkfsb8RS0PNA==
X-Received: by 2002:a05:6512:3b14:b0:52c:80f6:d384 with SMTP id 2adb3069b0e04-5353e546424mr304172e87.3.1724878113708;
        Wed, 28 Aug 2024 13:48:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5da8asm2344128e87.215.2024.08.28.13.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:48:33 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:48:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnaud Vrac <avrac@freebox.fr>, Pierre-Hugues Husson <phhusson@freebox.fr>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8998: add
 qcom,msm8998-lpass-smmu compatible
Message-ID: <xjrzsagzcqorynvhp5o6p32a7f7gkz42wgrgrgdnok5332nkv2@w2amrqa327rr>
References: <20240819-smmu-v1-0-bce6e4738825@freebox.fr>
 <20240819-smmu-v1-2-bce6e4738825@freebox.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-smmu-v1-2-bce6e4738825@freebox.fr>

On Mon, Aug 19, 2024 at 02:59:36PM GMT, Marc Gonzalez wrote:
> The msm8998 LPASS SMMU requires special treatment, because FW reserves
> the last context bank for its own use.
> 
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 1537e42fa03ca..f169f2dd281c3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -1616,7 +1616,7 @@ gpucc: clock-controller@5065000 {
>  		};
>  
>  		lpass_q6_smmu: iommu@5100000 {
> -			compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
> +			compatible = "qcom,msm8998-lpass-smmu", "qcom,msm8998-smmu-v2", "qcom,smmu-v2";

Please also update the bindings.

>  			reg = <0x05100000 0x40000>;
>  			clocks = <&gcc HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
>  			clock-names = "iface";
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
