Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83291C32
	for <iommu@lists.linux.dev>; Tue, 16 Aug 2022 05:21:05 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id t3so364614ply.2
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 22:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0p+K0qLqxOzyQ3M+oE6bJ773iu7oRhxO3HE/oVHQgeI=;
        b=Q84XFhLhci9sMypF2Qq1P+Ztgp7ErAQco5AR0ZLZ1SEHo124YaVRL+lvNOVVysf9P/
         ZGF/F5dvUD2T0R9cWO2XGG+02LCY2H7kF8FIzLRGPbSlG9R2C505ZbCwcn5DzkLOWjRL
         3p1X5J1tWUwurowbXOZLG3WRTdUFHeZfr8rkV2xAa+bMYYpcETYi2cC+WhxeuOXxew5G
         baoTzvF5eOCA5H7vq/9nWJ9QOHqw7sAisXUVflIRBcW8FLd/SXkDdnfT4QxoNueaj7NU
         VFVpGTw8IzYb2C+1KFeKd4zgF08vW3uA4pb/QYznp9Wbo13qfYrlhpzdMr7wkwq8wOHt
         fAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0p+K0qLqxOzyQ3M+oE6bJ773iu7oRhxO3HE/oVHQgeI=;
        b=adYTXhlpIjZ/UDVyr2SQHnjWjUhoNtwD9ypritJViiLciONBWprdTPIRcZk2iBwS0D
         9a0FZbRpeKv93UiI1hgoerF3YByJiU2s6R9wolNUTQ77ip0KJ03WUEKDy9woswsWQS7k
         50flmaCj+tFfvHCGZ+jta2iGZ6i+jW+vfOt9N/jIRI2y85r/q/rSUwDhRkbEw8cvVcUK
         C8gHz4KT/554QkaXMa6cjArzyc+oP0IPw8co6HMycfDbK8g2SWhtkV5+2fw7YwZz1rnJ
         QNQL+mCk3+KYAZK/yIzoKMPUINqyVgFugGBKjkfxXMl9lHrC41inaCOPZjYdovI2Rbld
         +jDg==
X-Gm-Message-State: ACgBeo11K9udMvM1g+LUzSnK42VzbJWXIIxPAcWa4YzyS1Y12Adqlqnm
	T9ruQ0h/6vhA6Yx3iPjPTDuPiw==
X-Google-Smtp-Source: AA6agR6chfmdgtWHQp2MitjNlKme1+yXKlKet9gzMaudy3FfMj/Cbfy8IiOC63TSrhs1532tAhnnBQ==
X-Received: by 2002:a17:90b:1b49:b0:1f5:4203:2e4e with SMTP id nv9-20020a17090b1b4900b001f542032e4emr31106602pjb.143.1660627265141;
        Mon, 15 Aug 2022 22:21:05 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0016eecdf8978sm8012796plg.106.2022.08.15.22.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 22:21:04 -0700 (PDT)
Date: Tue, 16 Aug 2022 10:51:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@chromium.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
	Sibi Sankar <sibis@codeaurora.org>,
	Adam Skladowski <a_skl39@protonmail.com>
Subject: Re: [PATCH 4/7] cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
Message-ID: <20220816052102.jdonvyxkix5n34u5@vireshk-i7>
References: <20220815100952.23795-1-a39.skl@gmail.com>
 <20220815100952.23795-5-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815100952.23795-5-a39.skl@gmail.com>

On 15-08-22, 12:09, Adam Skladowski wrote:
> The Qualcomm SM6115 platform uses the
> qcom-cpufreq-hw driver, so add it to the cpufreq-dt-platdev driver's
> blocklist.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 2c96de3f2d83..6ac3800db450 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -146,6 +146,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sc8180x", },
>  	{ .compatible = "qcom,sc8280xp", },
>  	{ .compatible = "qcom,sdm845", },
> +	{ .compatible = "qcom,sm6115", },
>  	{ .compatible = "qcom,sm6350", },
>  	{ .compatible = "qcom,sm8150", },
>  	{ .compatible = "qcom,sm8250", },

Applied. Thanks.

-- 
viresh
